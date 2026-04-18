# W2 Presentation Script — Petty VMCS on AWS
**Nhóm 10 | Ngày trình bày: 17/04/2026 | Tổng thời gian: 10 phút**

---

## Phân bổ thời gian

| Slide | Nội dung | Thời gian |
|---|---|---|
| 1 | Cover | 20 giây |
| 2 | Architecture Diagram | 2 phút |
| 3 | Storage Design | 1.5 phút |
| 4 | IAM Roles | 2 phút |
| 5 | Security Groups | 1.5 phút |
| 6 | Chi phí | 30 giây |
| 7 | Cảm ơn + Q&A | 10 giây |

---

## Slide 1 — Cover *(20 giây)*

> "Xin chào, các anh mentor và các bạn. Tuần này nhóm 10 tụi em sẽ tiếp tục với hệ thống Petty — hệ thống quản lý phòng khám thú y — và tập trung vào hai câu hỏi cốt lõi đó là : dữ liệu lưu ở đâu, và ai được phép chạm vào nó."

---

## Slide 2 — Architecture Diagram *(2 phút)*

> "Đây là kiến trúc cập nhật của Tuần 2. Em muốn walk through sơ lại luồng người dùng.
>
> Người dùng truy cập qua Route 53 → CloudFront phân phối nội dung, kết nối với S3 Frontend Bucket qua OAC — tức là S3 bucket này không public, chỉ CloudFront mới đọc được.
>
> Phần API đi vào Public ALB → ECS Fargate chạy ở hai Availability Zone để đảm bảo High Availability. ECS kéo environment variables từ S3 Backend Env Bucket, và kéo Docker image từ ECR qua VPC Endpoint — không đi ra ngoài internet.
>
> Database là RDS MariaDB — Primary ở AZ1, Standby ở AZ2 tự động synchronize - real_time. Nếu AZ1 có sự cố, AWS failover tự động sang AZ2.
>
> CI/CD: developer push code lên GitHub → GitHub Actions build image → đẩy lên ECR → deploy lên ECS. Toàn bộ quá trình này dùng OIDC, không có access key nào được lưu trữ."

---

## Slide 3 — Storage Design *(1.5 phút)*

> "Hệ thống tới hiện tại có 3 thành phần lưu trữ chính.
>
> **S3 Frontend Bucket:** Chứa toàn bộ giao diện Vue sau khi build — JS, CSS, HTML. Storage class sẽ là Standard vì được truy cập liên tục. Quan trọng: bucket này không public — chỉ CloudFront với OAC mới đọc được.
>
> **S3 Backend Environment Bucket:** Lưu file .env của backend. Lý do tách ra S3 thay vì hardcode trong image: nếu image bị leak thì credentials không bị lộ.
>
> **ECR:** Lưu Docker image sau mỗi lần build. ECR tự động scan vulnerability cho từng image.
>
> **RDS MariaDB — EBS:** Database chạy trên EBS gp3 do AWS quản lý, encryption at rest bật mặc định. Multi-AZ nên có 2 EBS volume — Primary ở AZ1, Standby ở AZ2 luôn được sync."

---

## Slide 4 — IAM Roles *(2 phút)*

> "Nguyên tắc thiết kế IAM của nhóm em là: quyền tối thiểu — chỉ cấp quyền đúng cho các tác vụ cần thiết. Theo kiến trúc nhóm đang triển khai, sẽ có 2 IAM Role chính:
>
> **ECS Execution Role:** Role này được ECS sử dụng khi khởi tạo container trên Fargate. Role được đính kèm 2 policy: `AmazonECSTaskExecutionRolePolicy` (AWS Managed) để thực thi container cơ bản, và custom policy `ecsTaskExecutionRole-GetSecrets` (Customer Managed) cho phép kéo cấu hình từ Backend Bucket và truy xuất dữ liệu nhạy cảm từ Secret Manager.
>
> **CI/CD Role (qua OIDC):** Role này dành riêng cho luồng deploy tự động từ GitHub Actions. Thay vì cấp quyền tràn lan, role chỉ được gắn 2 policy tự định nghĩa là `S3UploadPolicy` và `ECRUploadPolicy` (Customer Managed) — bảo đảm GitHub Actions chỉ thao tác được với Bucket và ECR nhất định.
>
> Điểm mấu chốt: **Hệ thống phân quyền rạch ròi bằng các policy chuyên biệt, không có file .aws/credentials trên server và không lộ access key nhờ dùng cơ chế OIDC.**"

---

## Slide 5 — Security Groups *(1.5 phút)*

> "Security Group của nhóm em theo nguyên tắc chỉ mở đúng cổng cần thiết, chỉ nhận từ nguồn được phép.
>
> ALB chỉ nhận traffic từ prefix list của CloudFront — tức là không ai bypass CloudFront vào thẳng ALB được.
>
> ECS chỉ nhận từ ALB — container không bao giờ nhận traffic trực tiếp từ internet.
>
> RDS chỉ nhận từ ECS trên port 3306 — database hoàn toàn isolated, không có đường nào vào từ bên ngoài VPC.
>
> VPC Endpoint Security Group nhận từ ECS trên 443 — đây là để ECS gọi các AWS service như S3, ECR mà không đi ra internet, traffic đi trong mạng nội bộ AWS.
>
> Về **encryption in transit**: CloudFront enforce HTTPS với người dùng. ALB terminate TLS. Kết nối ECS đến RDS dùng SSL. Tất cả API call từ ECS đến AWS service đi qua HTTPS qua VPC Endpoint.
>
> Về **phát hiện bucket public**: S3 Block Public Access bật ở cấp account — kể cả nếu ai đó vô tình set bucket policy sai, AWS vẫn chặn. S3 Access Analyzer tự động notify nếu có bucket bị exposed."

---

## Slide 6 — Chi phí *(30 giây)*

> "Slide này là ước tính chi phí vận hành thực tế cho một tháng. Tổng khoảng 150 đô. Đáng chú ý là NAT Gateway chiếm gần 46 đô — đây là chi phí lớn nhất vì traffic ra ngoài internet đều qua đây. Trong production thực tế có thể tối ưu bằng cách dùng VPC Endpoint nhiều hơn để giảm NAT Gateway traffic."

---

## Slide 7 — Cảm ơn *(10 giây)*

> "Cảm ơn thầy và các bạn đã lắng nghe. Nhóm tôi sẵn sàng trả lời câu hỏi."

---

## Câu hỏi Q&A cần chuẩn bị

### Q1: Tại sao dùng OIDC thay vì access key cho GitHub Actions?
> Access key là long-lived credential — nếu bị leak là mất tài khoản AWS. OIDC cấp credentials tạm thời, hết hạn sau mỗi job, không có gì để leak.

### Q2: Multi-AZ RDS có nghĩa là gì, khác Read Replica như thế nào?
> Multi-AZ Standby chỉ dùng để failover tự động, không nhận read traffic. Read Replica thì nhận read traffic nhưng failover phải làm tay. Hệ thống dùng Multi-AZ vì ưu tiên availability tự động.

### Q3: Nếu S3 Backend Env Bucket bị xóa thì sao?
> ECS task đang chạy không bị ảnh hưởng vì đã load env rồi. Nhưng task mới sẽ không khởi động được. Fix bằng cách restore từ S3 versioning — nên bật versioning cho bucket này.

### Q4: Tại sao không dùng EC2 mà dùng Fargate?
> Fargate là serverless container — không cần quản lý OS, không cần patch, không cần quản lý EBS lifecycle. Scale tự động, phù hợp với workload của phòng khám có traffic không đều.

### Q5: Secret Manager trong diagram dùng để làm gì?
> Secret Manager lưu các secrets nhạy cảm như database password, API key của bên thứ ba. Khác với S3 Env Bucket ở chỗ: Secret Manager tự động rotate secret, có audit log mỗi lần truy cập, và tích hợp trực tiếp với RDS để rotate database password tự động.
