# AWS Billing — Tài nguyên nào tính tiền khi nào?

> AWS dùng mô hình **Pay-As-You-Go (PAYG)**: chỉ trả tiền cho những gì dùng.
> Tuy nhiên, "dùng" với mỗi loại resource có nghĩa khác nhau.
> Một số resource tính tiền **ngay khi tồn tại**, một số chỉ tính khi **có traffic/data**.

---

## Nhóm 1 — Tính tiền NGAY khi tạo ra (kể cả không có traffic)

Những resource này chạy đồng hồ tính tiền theo giờ từ thời điểm được tạo,
bất kể có request nào vào hay không.

| Resource | Giá ước tính | Ghi chú |
|---|---|---|
| **NAT Gateway** | ~$0.045/hr/cái | 2 NAT GW = ~$65/tháng. Tạo ra là chạy liền |
| **RDS Instance** | ~$0.017–0.08/hr | Instance ở trạng thái `available` là tính tiền dù không có query |
| **Application Load Balancer (ALB)** | ~$0.008/hr + LCU | Tạo ra là tính tiền, không cần có request |
| **Elastic IP (không gắn vào resource)** | $0.005/hr/cái | Nếu EIP đã tạo nhưng **chưa gắn** vào EC2/NAT → tính tiền. Gắn vào rồi thì miễn phí |
| **VPC Interface Endpoints** | $0.01/hr/endpoint/AZ | 3 endpoints × 2 AZ = $0.06/hr = ~$43/tháng |
| **ECS Fargate Tasks** (đang RUNNING) | ~$0.04/vCPU/hr + $0.004/GB/hr | Tính theo giây khi task đang chạy. Task STOPPED thì không tính |
| **EC2 Instance** (đang RUNNING) | Tùy instance type | `t2.micro` Free Tier 750hr/tháng năm đầu. Sau đó tính tiền |
| **AWS WAF Web ACL** | $5/Web ACL/tháng | Fixed fee khi Web ACL tồn tại, cộng thêm $0.60/1M requests |

---

## Nhóm 2 — Chỉ tính tiền khi có USAGE (data/request)

Những resource này có thể tồn tại mà không tốn tiền (hoặc rất ít) nếu chưa dùng.

| Resource | Tính tiền khi nào | Ghi chú |
|---|---|---|
| **S3** | Khi có data stored (GB) + requests | $0.023/GB/tháng. Bucket rỗng = miễn phí |
| **CloudFront** | Khi có traffic transfer + requests | 1TB/tháng + 10M requests miễn phí (Free Tier) |
| **ECR** | Khi storage > 500MB | Free Tier 500MB/tháng. Sau đó $0.10/GB/tháng |
| **CloudWatch Logs** | Khi có log data ingested | $0.50/GB ingest. Log group rỗng = miễn phí |
| **CloudTrail** | Khi có API calls ghi vào S3 | Management events miễn phí. Data events tính phí |
| **SNS** | Khi có messages published/delivered | 1M requests/tháng miễn phí |
| **Secrets Manager** | Khi secret tồn tại | $0.40/secret/tháng + $0.05/10K API calls. Rẻ nhưng có phí |

---

## Nhóm 3 — Miễn phí hoàn toàn

Những resource này không bao giờ tính tiền, dù tạo ra bao nhiêu.

| Resource | Ghi chú |
|---|---|
| **VPC** | Miễn phí |
| **Subnets** | Miễn phí |
| **Internet Gateway (IGW)** | Miễn phí (chỉ tính data transfer qua nó) |
| **Route Tables** | Miễn phí |
| **Security Groups** | Miễn phí |
| **IAM Users / Roles / Policies** | Miễn phí |
| **ECS Cluster** (không có tasks) | Miễn phí |
| **ACM Certificate** | Miễn phí |
| **VPC Gateway Endpoints (S3, DynamoDB)** | Miễn phí |

---

## Bảng tóm tắt cho kiến trúc Petty

Áp dụng vào project cụ thể — ước tính chi phí/giờ khi chạy full:

| Resource | Trạng thái gây tính tiền | Chi phí/giờ |
|---|---|---|
| NAT Gateway × 2 | Tồn tại | ~$0.09 |
| RDS MySQL db.t3.micro Multi-AZ | `available` | ~$0.034 |
| ALB | Tồn tại | ~$0.008 |
| VPC Interface Endpoints × 3 | Tồn tại | ~$0.06 |
| ECS Fargate 2 tasks (0.5vCPU/1GB) | Tasks `RUNNING` | ~$0.05 |
| WAF Web ACL | Tồn tại | ~$0.007 |
| **Tổng** | | **~$0.25/giờ (~$180/tháng)** |

> **Demo 8 tiếng**: ~$2 — hoàn toàn chấp nhận được.
> **Để chạy 1 tháng**: ~$180–250 — nên teardown ngay sau demo.

---

## Chiến lược tiết kiệm: Tạo đúng thứ tự

```
BƯỚC 1 — Tạo trước, không tốn tiền:
  ✅ VPC, Subnets, Route Tables, IGW
  ✅ Security Groups
  ✅ IAM Roles & Policies
  ✅ ECR Repository
  ✅ S3 Buckets
  ✅ Secrets Manager secrets
  ✅ ACM Certificates
  ✅ ECS Cluster (chưa có tasks)
  ✅ CloudWatch Log Groups

BƯỚC 2 — Chỉ tạo khi SẮP demo (đồng hồ bắt đầu tính tiền):
  ⏰ NAT Gateways (x2)         ← tốn tiền nhất
  ⏰ VPC Interface Endpoints   ← tốn tiền khi có nhiều AZ
  ⏰ RDS Instance              ← tốn tiền ngay
  ⏰ ALB + Target Group
  ⏰ ECS Task Definition + Service (tasks RUNNING)

BƯỚC 3 — Teardown NGAY sau demo:
  🗑️  ECS Service (scale về 0 trước)
  🗑️  RDS Instance
  🗑️  NAT Gateways + Release Elastic IPs  ← ưu tiên xóa trước
  🗑️  ALB
  🗑️  VPC Interface Endpoints
```

---

## Mẹo kiểm soát chi phí

1. **Bật Billing Alarm**: CloudWatch → Alarms → tạo alarm khi `EstimatedCharges > $10`
   để nhận email cảnh báo sớm.

2. **Bật AWS Cost Explorer**: Xem chi phí breakdown theo service theo ngày.

3. **Kiểm tra trước khi ngủ**: Sau demo, vào AWS Console confirm NAT Gateways
   và RDS đã bị xóa — đây là 2 resource dễ quên và tốn tiền nhất.

4. **Elastic IP chưa gắn = tốn tiền**: Sau khi xóa NAT Gateway, nhớ release
   Elastic IPs ngay, nếu không vẫn bị tính $0.005/hr/cái.

5. **RDS Snapshot**: Khi delete RDS, AWS hỏi có muốn tạo final snapshot không.
   Với project demo, có thể bỏ qua để tiết kiệm S3 storage.

---

*Giá tham khảo tại region ap-southeast-1 (Singapore), tháng 4/2026.
Giá có thể thay đổi — kiểm tra tại [aws.amazon.com/pricing](https://aws.amazon.com/pricing).*
