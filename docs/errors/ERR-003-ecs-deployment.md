# Lỗi triển khai ECS (Task 11)

Tài liệu này ghi lại các lỗi gặp phải trong quá trình triển khai hệ thống lên AWS ECS Fargate và cách khắc phục tương ứng.

## 1. Lỗi: Không thể tạo ECS Cluster qua Giao diện AWS Console (Service-linked role error)

**Mô tả lỗi:**
Khi tiến hành tạo ECS Cluster (AWS Fargate) qua giao diện web (AWS Console), xuất hiện thông báo lỗi:
> Resource handler returned message: "Invalid request provided: CreateCluster Invalid Request: Unable to assume the service linked role. Please verify that the ECS service linked role exists. (Service: AmazonECS; Status Code: 400; Error Code: InvalidParameterException; Request ID: ...; Proxy: null)"

**Nguyên nhân:**
- Giao diện AWS Console thỉnh thoảng gặp "glitch" (lỗi hiển thị sai/false positive) khi khởi tạo ECS Cluster trên tài khoản mới.
- Console báo lỗi không thể truy cập `AWSServiceRoleForECS` (Service-Linked Role), nhưng thực tế khi kiểm tra bằng lệnh (`aws iam create-service-linked-role...`), Role này có thể đã tồn tại trong tài khoản.

**Cách khắc phục:**
Sử dụng AWS CloudShell để tạo Cluster trực tiếp thông qua CLI (nhằm vượt qua lỗi giao diện web):

1. Mở **AWS CloudShell** từ góc trên cùng bên phải màn hình AWS Console (biểu tượng terminal `>_`).
2. Chờ khởi động xong, chạy lệnh định danh việc tạo Cluster (thay `petty-cluster` bằng tên cluster của dự án):
   ```bash
   aws ecs create-cluster --cluster-name petty-cluster
   ```
3. Sau khi lệnh thực thi và trả về đoạn phản hồi JSON biểu thị Status `"ACTIVE"`, nhấn `q` để thoát logs và đóng thẻ CloudShell.
4. Tải lại (F5) trang `ECS > Clusters` trên AWS Console web, Cluster bạn tạo sẽ xuất hiện đầy đủ và bình thường.

## 2. Lỗi: ECS Service báo 0 Running, Task liên tục bị Stopped ngay khi khởi động

**Mô tả lỗi:**
Service được tạo thành công với status `Active`, tuy nhiên Tasks luôn có `0 Running`, tab Events báo:
> `service ... failed to launch a task with (error ECS was unable to assume the role 'arn:aws:iam::...:role/petty-ecs-task-role' that was provided for this task)`

**Nguyên nhân:**
- **Trường hợp 1:** Bỏ quên chưa tạo role `petty-ecs-task-role` ở bước trước đó.
- **Trường hợp 2:** Role đã có, nhưng ở tab **Trust relationships**, giá trị Service đã chọn sai thành `ecs.amazonaws.com` thay vì bắt buộc phải là `ecs-tasks.amazonaws.com`.

**Cách khắc phục:**
1. Mở **IAM Console** > **Roles**. Chắc chắn rằng cả 2 role `petty-ecs-task-role` (quyền AmazonSSMReadOnlyAccess) và `petty-ecs-execution-role` (quyền AmazonECSTaskExecutionRolePolicy) đều tồn tại.
2. Vào từng Role, kiểm tra lại tab **Trust relationships** > **Edit trust policy**. Đảm bảo file JSON phải có chính xác nội dung:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```
Sau khi tạo đủ role chuẩn, ECS Service sẽ tự động khởi động (restart) lại Task thành công.
