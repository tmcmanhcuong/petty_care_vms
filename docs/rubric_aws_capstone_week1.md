# Rubric Capstone — AWS Cloud Essentials (Tuần Đầu)

> **"Thiết kế kiến trúc AWS cơ bản cho ứng dụng của tôi"**
>
> Dựa trên: AWS Cloud Practitioner Essentials + AWS Technical Essentials
> Đối tượng: Sinh viên năm 3–4 ngành CNTT | Hình thức: Nhóm 3–4 người | Thời lượng: 1 tuần

---

## Tổng Quan Điểm

| # | Phần đánh giá | Điểm tối đa | Ghi chú |
|---|---------------|-------------|---------|
| A | Giới thiệu ứng dụng | 10đ | Chọn app + mô tả bài toán |
| B | Mapping lên AWS Services | 30đ | Lý giải từng service cơ bản |
| C | Architecture Diagram (Topology) | 30đ | Vẽ sơ đồ kiến trúc cơ bản |
| D | QnA — Hỏi đáp kiến trúc | 30đ | Đánh giá mức hiểu qua hỏi đáp |
| | **TỔNG** | **100đ** | |

---

## A. Giới Thiệu Ứng Dụng — /10đ

Nhóm chọn một ứng dụng bất kỳ: đồ án môn học, app clone, hoặc pattern đơn giản (3-tier web app).

| Tiêu chí | Điểm | Hướng dẫn chấm |
|----------|------|----------------|
| Mô tả rõ ứng dụng: làm gì, phục vụ ai, bài toán gì? | 3đ | Đủ 3 ý: chức năng + đối tượng + bài toán |
| Vẽ sơ đồ mô tả hệ thống hiện tại (use case diagram, ER diagram, sequence diagram...) | 4đ | Có diagram quen thuộc, rõ các thành phần và quan hệ |
| Giải thích lý do chọn ứng dụng này để đưa lên cloud | 3đ | Lý do thuyết phục: scalability, availability, cost... |
| **Tổng Phần A** | **10đ** | |

> Tip: Nhóm chưa có app sẵn → chọn **3-tier web app** (Web – App – DB). Pattern này map trực tiếp nhất với các service đã học.

---

## B. Mapping Lên AWS Services — /30đ

Nhóm giải thích từng thành phần của ứng dụng tương ứng với AWS service nào và **tại sao**.

| Thành phần | AWS Service cần mapping | Điểm | Cách chấm |
|------------|------------------------|------|-----------|
| Compute | EC2 (ưu tiên) hoặc Lambda | 5đ | Chọn đúng + giải thích lý do cơ bản |
| Database | RDS hoặc DynamoDB (chọn 1) | 5đ | Giải thích SQL vs NoSQL phù hợp với app |
| Storage | S3 | 5đ | Dùng để lưu gì, loại dữ liệu nào |
| Network & Entry Point | VPC, Subnet (public/private), Security Group, ELB (nếu có) | 5đ | Phân tầng đúng, hiểu public vs private. Nếu có ELB: giải thích traffic vào qua đâu |
| Security | IAM Roles/Policies, Shared Responsibility | 5đ | Ai có quyền gì, hiểu trách nhiệm AWS vs người dùng |
| Region & AZ | Chọn Region, hiểu Availability Zone | 3đ | Giải thích tại sao chọn Region này (gần user, pricing, compliance). Biết AZ là gì |
| Chi phí cơ bản | Free Tier, ước tính cost đơn giản | 2đ | Biết app có chạy được trong Free Tier không, service nào tốn tiền nhất |
| **Tổng Phần B** | | **30đ** | |

> Tip: Ở tuần đầu, tập trung vào các nhóm service cốt lõi. Chưa cần trade-off phức tạp — chỉ cần giải thích được "tại sao chọn service này cho phần này của app".

---

## C. Architecture Diagram (Topology) — /30đ

Nhóm vẽ **1 diagram** thể hiện kiến trúc AWS cơ bản.

Công cụ gợi ý: **draw.io** (miễn phí) · AWS Architecture Icons

| Tiêu chí | Điểm | Hướng dẫn chấm |
|----------|------|----------------|
| Diagram có đủ các service đã mapping ở Phần B | 12đ | Không thiếu thành phần nào đã cam kết |
| Luồng traffic cơ bản (request đi từ đâu → đến đâu) | 6đ | Vẽ được mũi tên, biết data flow cơ bản |
| Network phân tầng: public / private subnet | 6đ | DB trong private subnet, app trong public |
| Diagram rõ ràng, có label dễ đọc | 6đ | Dùng AWS icons hoặc ký hiệu chuẩn |
| **Tổng Phần C** | **30đ** | |

**Cấu trúc diagram tối thiểu cần thể hiện:**
Simple EC2 + RDS architecture

![simple_architecture](sample-drawio-architecture.png)

Official Oracle E_Business architecture on AWS

![orable_e_business](oracle_e_business.png)

> Tip: Diagram cần thể hiện được: Internet → (ELB) → Public Subnet (App) → Private Subnet (DB). Security Group và IAM gắn với từng thành phần. Ghi rõ Region và AZ đang dùng.

---

## D. QnA — Hỏi Đáp Kiến Trúc — /30đ

Mỗi nhóm trình bày **10 phút** · QnA **10 phút** · Mỗi thành viên cần trả lời ít nhất **1 câu hỏi**.

| Tiêu chí | Điểm | Hướng dẫn chấm |
|----------|------|----------------|
| Trả lời đúng trọng tâm, thể hiện hiểu bản chất | 12đ | Giải thích được "tại sao" chứ không chỉ "cái gì" |
| Xử lý được câu hỏi tình huống đơn giản | 10đ | VD: EC2 bị tắt thì sao, DB ở private subnet connect thế nào |
| Trả lời mạch lạc, tự tin | 8đ | Không lúng túng kéo dài, trả lời có logic |
| **Tổng Phần D** | **30đ** | |

### Câu Hỏi QnA Tham Khảo

Câu hỏi ở mức **cơ bản đến trung bình**, tập trung vào hiểu khái niệm và liên hệ với ứng dụng.

#### Compute (EC2 / Lambda)

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | App của bạn chạy ở đâu trên AWS? Tại sao chọn service đó? | Nêu được service và lý do cơ bản: app cần chạy liên tục → EC2 |
| Cơ bản | EC2 instance là gì? Bạn có thể hình dung nó giống gì mà bạn đã biết? | Giống 1 máy tính/server ảo trên cloud, mình thuê để chạy app |
| Trung bình | Nếu EC2 instance bị tắt đột ngột, chuyện gì xảy ra với app? | App ngừng hoạt động, user không truy cập được |
| Trung bình | Bạn chọn instance size (cấu hình máy) như thế nào? | Chọn theo nhu cầu app, máy lớn = tốn tiền hơn. Bắt đầu nhỏ rồi tăng lên khi cần |

#### Database (RDS / DynamoDB)

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | Database của bạn dùng service nào? Khác gì so với cài database trực tiếp trên EC2? | RDS là managed service — AWS lo backup, update, patching |
| Cơ bản | Dữ liệu quan trọng nhất trong app là gì? Nó được lưu ở đâu? | Chỉ ra được loại dữ liệu chính và service tương ứng |
| Trung bình | Nếu database bị mất dữ liệu, bạn khôi phục bằng cách nào? | RDS có automated backup, có thể restore |
| Trung bình | Database ở private subnet, app server kết nối đến nó bằng cách nào? | Cùng VPC, Security Group cho phép kết nối từ app server |

#### Storage (S3)

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | File upload của user lưu ở đâu? Tại sao không lưu trên EC2? | S3 lưu file riêng, không mất khi EC2 bị xóa/restart |
| Cơ bản | S3 là gì? Bạn dùng nó để lưu loại dữ liệu nào? | Dịch vụ lưu trữ file/object: ảnh, video, file tĩnh, backup |
| Trung bình | S3 và EBS khác nhau thế nào? | EBS gắn với EC2 như ổ cứng, S3 là kho lưu trữ độc lập |

#### Network (VPC / Subnet / Security Group)

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | VPC là gì? Tại sao cần VPC? | Mạng riêng trên AWS, cách ly tài nguyên, kiểm soát truy cập |
| Cơ bản | Tại sao database không để chung chỗ với web server? | Database ở private subnet, không cho truy cập trực tiếp từ internet |
| Trung bình | Public subnet và private subnet khác nhau thế nào? | Public: có đường ra internet. Private: không truy cập trực tiếp từ ngoài |
| Trung bình | Security Group hoạt động như thế nào? | SG như bức tường lửa, chỉ cho phép traffic từ nguồn cụ thể |

#### Security (IAM)

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | IAM là gì? Tại sao cần IAM? | Quản lý ai/cái gì được phép làm gì trên AWS |
| Cơ bản | Trách nhiệm bảo mật giữa bạn và AWS chia thế nào? | AWS lo hạ tầng, mình lo ứng dụng + dữ liệu + quyền truy cập |
| Trung bình | EC2 cần quyền đọc S3, bạn cấp quyền bằng cách nào? | Gắn IAM Role cho EC2, không dùng access key cứng |

#### Entry Point & Traffic (ELB)

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | User truy cập app qua đường nào? Request đi từ đâu đến đâu? | Mô tả được: Internet → (ELB) → App Server → Database |
| Cơ bản | Load Balancer làm gì? Tại sao không cho user truy cập thẳng vào EC2? | Chia traffic đều cho nhiều server, nếu 1 server chết thì chuyển sang server khác |
| Trung bình | Nếu có nhiều người truy cập cùng lúc, kiến trúc cần thay đổi gì? | Thêm nhiều EC2 phía sau Load Balancer, traffic được chia đều |

#### Region & Availability Zone

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | Bạn chọn Region nào để deploy? Tại sao chọn Region đó? | Chọn Region gần user nhất (VD: Singapore cho user VN), hoặc theo yêu cầu compliance/pricing |
| Cơ bản | Availability Zone là gì? Tại sao AWS có nhiều AZ trong 1 Region? | AZ là data center riêng biệt trong cùng Region. Nhiều AZ để đảm bảo nếu 1 AZ gặp sự cố, các AZ khác vẫn hoạt động |
| Trung bình | Nếu data center (AZ) nơi EC2 đang chạy bị mất điện, chuyện gì xảy ra? | App bị ngừng nếu chỉ chạy trên 1 AZ. Nếu deploy trên nhiều AZ thì vẫn hoạt động |

#### Monitoring & Scaling cơ bản (CloudWatch / Auto Scaling)

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | App deploy xong, làm sao bạn biết server có đang hoạt động tốt không? | Dùng CloudWatch để xem metrics: CPU, memory, network. Biết server đang khỏe hay quá tải |
| Cơ bản | CloudWatch là gì? Nó giúp gì cho bạn? | Dịch vụ monitoring của AWS, theo dõi metrics, đặt alarm cảnh báo khi có vấn đề |
| Trung bình | Nếu traffic tăng đột ngột, bạn phải tự tay thêm server à? Có cách nào tự động không? | Auto Scaling Group tự thêm/bớt EC2 theo traffic. Không cần làm tay |
| Trung bình | CloudWatch báo CPU EC2 đang 95%. Bạn nên làm gì? | Kiểm tra nguyên nhân (traffic tăng hay bug). Có thể scale up (đổi instance lớn hơn) hoặc thêm EC2 qua Auto Scaling |

#### Cost

| Mức độ | Câu hỏi mẫu | Điểm cần thấy trong câu trả lời |
|--------|-------------|----------------------------------|
| Cơ bản | Nếu không dùng AWS mà tự mua server, khác gì? | Không cần mua phần cứng, trả theo dùng, scale dễ hơn |
| Cơ bản | Free Tier là gì? App có chạy được trong Free Tier không? | AWS cho dùng miễn phí 1 số service trong 12 tháng |
| Trung bình | Service nào trong kiến trúc tốn tiền nhất? | Thường EC2 hoặc RDS. Tiết kiệm: tắt khi không dùng |

---

## Thang Xếp Loại

| Điểm | Xếp loại | Mô tả |
|------|----------|-------|
| 85–100 | Xuất sắc | Mapping đúng, diagram rõ ràng, QnA trả lời tự tin |
| 70–84 | Tốt | Kiến trúc đúng, diagram đầy đủ, còn lúng túng 1–2 câu |
| 55–69 | Khá | Mapping tạm đủ, diagram còn thiếu chi tiết |
| 40–54 | Trung bình | Hiểu lý thuyết nhưng mapping còn sai/thiếu |
| < 40 | Không đạt | Không có diagram hoặc mapping sai hoàn toàn |

---

## Timeline Gợi Ý (1 Tuần: Thứ 2 → Thứ 6)

> Sinh viên vừa học vừa mapping kiến thức vào đề tài xuyên suốt 3 ngày đầu. Hai ngày cuối dành cho hoàn thiện và trình bày.

| Thời gian | Hoạt động | Ghi chú |
|-----------|-----------|---------|
| Thứ 2 (Ngày 1) | Học AWS Cloud Practitioner Essentials: Cloud concepts, Compute (EC2, Lambda), Global Infrastructure (Region, AZ). **Lập nhóm, chọn app, bắt đầu mapping Compute** | Vừa học vừa áp dụng: học xong Compute → mapping Compute cho app của nhóm |
| Thứ 3 (Ngày 2) | Học tiếp: Networking (VPC, Subnet, SG), Storage (S3, EBS), Database (RDS, DynamoDB). **Mapping Network, Storage, Database** | Mỗi phần học xong → mapping ngay vào app |
| Thứ 4 (Ngày 3) | Học tiếp: Security (IAM, Shared Responsibility), Monitoring (CloudWatch), Cost (Free Tier, Pricing). **Mapping Security, hoàn thiện mapping** | Kết thúc ngày 3: mapping đầy đủ tất cả services |
| Thứ 5 (Ngày 4) | Vẽ Architecture Diagram, hoàn thiện slides | Dùng draw.io / AWS Architecture Icons |
| Thứ 6 (Ngày 5) | **Trình bày (10') + QnA (10') / nhóm** | |

---

## Lưu Ý Cho Giảng Viên

- Phiên bản tuần đầu tập trung vào **hiểu khái niệm cơ bản** và khả năng liên hệ kiến thức với ứng dụng thực tế.
- Rubric đã được thiết kế phủ đúng nội dung 2 khóa: **CPE** (13 modules) và **TE** (6 modules + labs).
- Các chủ đề được đánh giá: Compute, Database, Storage, Network, Security, Entry Point (ELB), Region/AZ, Monitoring (CloudWatch), Auto Scaling, Cost — tất cả đều nằm trong nội dung đã học.
- Không yêu cầu trade-off phức tạp, không yêu cầu deploy thực tế.
- Câu hỏi giới hạn ở mức **cơ bản và trung bình** — không hỏi nâng cao.
- Timeline thiết kế theo mô hình **vừa học vừa làm**: Thứ 2–4 học + mapping song song, Thứ 5 hoàn thiện diagram, Thứ 6 trình bày.
- Đây là bước đánh giá nền tảng trước khi học viên tiến vào phiên bản nâng cao (6 tuần).
