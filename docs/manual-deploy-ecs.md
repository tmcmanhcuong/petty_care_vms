# Hướng Dẫn Deploy Thủ Công Lên AWS ECS (Không Dùng CI/CD)

Tài liệu này hướng dẫn quy trình 4 bước để cập nhật ứng dụng Backend lên Amazon ECS bằng tay khi hệ thống chưa được cấu hình CI/CD (như GitHub Actions).

## Điều Kiện Tiên Quyết (Prerequisites)
- Máy tính đã cài đặt và đang chạy **Docker**.
- Đã cài đặt **AWS CLI** và đã đăng nhập (`aws configure`) bằng IAM User có đủ quyền đẩy image lên ECR và update ECS.

---

## Bước 1: Build Docker Image Mới Tại Local
Sau khi cập nhật xong code backend, mở terminal tại thư mục chứa file `Dockerfile` của backend và chạy lệnh build:

```bash
# Đổi 'tên-image-cua-ban' thành tên dễ nhớ (vd: my-backend)
docker build -t tên-image-cua-ban:latest .
```

## Bước 2: Đăng Nhập Vào AWS ECR
Để máy tính của bạn được phép đẩy file lên kho lưu trữ AWS ECR, chạy lệnh sau (nhớ thay các biến có ngoặc `<>` bằng thông số thật của nhóm):

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
```
*Lưu ý: Nếu thấy dòng chữ `Login Succeeded` nghĩa là bạn đã xác thực thành công.*

## Bước 3: Đánh Tag Và Đẩy Image Lên ECR
Dán nhãn cho image vừa tạo ở bước 1 để nó khớp với đường dẫn repo trên AWS, sau đó tiến hành push.

```bash
# 1. Đánh tag cho image
docker tag tên-image-cua-ban:latest <account-id>.dkr.ecr.<region>.amazonaws.com/<tên-repo-trên-ecr>:latest

# 2. Đẩy image lên ECR
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/<tên-repo-trên-ecr>:latest
```

## Bước 4: Yêu Cầu ECS Cập Nhật (Force New Deployment)
Ở bước 3, image mới chỉ nằm trên kho lưu trữ. Để ECS tải image mới này về và chạy, bạn phải dùng lệnh "Force New Deployment".

Có thể chọn 1 trong 2 cách dưới đây để thực hiện:

### Cách 4A: Dùng Giao Diện AWS Console (Khuyên Dùng)
1. Truy cập trang quản trị AWS, mở dịch vụ **Amazon ECS**.
2. Chọn mục **Clusters** ở menu trái $\rightarrow$ Click vào tên Cluster của dự án.
3. Chuyển sang tab **Services** $\rightarrow$ Tick chọn Service chứa backend của bạn $\rightarrow$ Bấm nút **Update** (ở góc trên bên phải bảng).
4. Tìm và tick chọn ô **Force new deployment** `✅`. (Giữ nguyên toàn bộ cấu hình khác).
5. Cuộn xuống cuối trang và bấm **Update**.
*(ECS sẽ tự động tắt từ từ container cũ và dựng container mới, web không bị gián đoạn).*

### Cách 4B: Dùng Lệnh AWS CLI (Nhanh Gọn)
Nếu không muốn lên web thao tác, chỉ cần chạy đúng 1 lệnh này trên terminal:
```bash
aws ecs update-service --cluster <tên-cluster-của-nhóm> --service <tên-service-của-nhóm> --force-new-deployment
```

---
**Troubleshooting:**
- Nếu ECS không chịu update (Task cứ pending rồi stop), hãy kiểm tra lại **Task Execution Role** (Xem đã cấp đủ quyền S3 hoặc Secrets Manager chưa như đã phân tích).
- Nhớ thay các giá trị `<region>`, `<account-id>`, `<tên-repo-trên-ecr>`, `<tên-cluster-của-nhóm>` bằng các giá trị thực tế của dự án.
