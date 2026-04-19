# Lỗi sau khi Deploy — Verify UI & Data Migration (Task 14)

Tài liệu này ghi lại các lỗi phát sinh sau khi triển khai ECS + CloudFront + RDS xong,
khi thực hiện verify UI trên Production (Task 14.6, 14.7). Mặc dù phần code & hạ tầng
đều đã build/deploy thành công, UI vẫn không hiển thị data — truy vết ra 7 nguyên nhân
độc lập. Ghi chi tiết để lần sau deploy kiến trúc tương tự (CloudFront + ALB + ECS + RDS)
tránh mắc lại.

---

## 1. Mixed Content — HTTPS CloudFront gọi HTTP ALB bị browser chặn

**Mô tả lỗi:**
Mở `https://<cloudfront-domain>/customer/login`, bấm Đăng nhập. Không có request nào
tới được BE. DevTools Console hiện:
```
Mixed Content: The page at 'https://dtu9o3o6awvi4.cloudfront.net/customer/login' was
loaded over HTTPS, but requested an insecure XMLHttpRequest endpoint
'http://petty-alb-xxxx.ap-southeast-1.elb.amazonaws.com/khach-hang/dang-nhap'.
This request has been blocked; the content must be served over HTTPS.
```

**Nguyên nhân:**
- CloudFront cấu hình bắt buộc HTTPS (redirect HTTP → HTTPS).
- ALB chỉ listen HTTP:80 (chưa có ACM cert vì chưa có domain).
- Chrome/Firefox có chính sách bảo mật mặc định: trang HTTPS không được gọi endpoint HTTP
  → request bị chặn ngay trong browser, chưa đi tới server.

**Cách khắc phục:**
Dùng CloudFront làm reverse proxy cho ALB — FE và API cùng domain HTTPS, không cần
mua domain/cert cho ALB.

1. CloudFront Console → Distribution → tab **Origins** → **Create origin**:
   - Origin domain: `<alb-dns>.ap-southeast-1.elb.amazonaws.com`
   - Protocol: HTTP only, port 80
   - Name: `petty-alb-origin`
2. Tab **Behaviors** → **Create behavior**:
   - Path pattern: `/api/*`
   - Origin: `petty-alb-origin`
   - Viewer protocol policy: Redirect HTTP to HTTPS
   - Allowed HTTP methods: **GET, HEAD, OPTIONS, PUT, POST, PATCH, DELETE** (thiếu POST → login chết)
   - Cache policy: **CachingDisabled** (AWS managed)
   - Origin request policy: **AllViewer** (AWS managed) — forward Authorization header
3. Tab **Invalidations** → Create → path `/*`
4. GitHub Secret `VITE_API_BASE_URL` = `https://<cloudfront-domain>/api`
5. Redeploy FE (push empty commit hoặc workflow_dispatch)

**Bài học phòng tránh:**
Từ bước thiết kế architecture, nếu ALB chưa có ACM cert thì **quy hoạch CloudFront làm
proxy cho ALB ngay từ đầu** — không tách thành 2 domain riêng (HTTPS FE + HTTP API) rồi
mới mắc lỗi.

---

## 2. Frontend hardcode `http://127.0.0.1:8000/api` ở 25 file

**Mô tả lỗi:**
Build FE xong deploy lên S3, mở CloudFront URL, mọi AJAX call trong console đều báo
`CONNECTION REFUSED` tới `127.0.0.1:8000` thay vì ALB.

**Nguyên nhân:**
Dev team viết URL trực tiếp trong code Vue thay vì dùng env var. 25 file `.vue` + `.js`
chứa chuỗi `http://127.0.0.1:8000/api` hoặc `http://127.0.0.1:8000/storage`.

**Cách khắc phục:**
Regex thay thế bằng script Python (lưu tại `fix_hardcoded_ips.py`):
- `"http://127.0.0.1:8000/api..."` → `import.meta.env.VITE_API_BASE_URL + "..."`
- `"http://127.0.0.1:8000/storage..."` → `import.meta.env.VITE_API_BASE_URL.replace("/api", "") + "/storage..."`

**Bài học phòng tránh:**
Từ ngày đầu project:
- Mọi API/storage URL trong FE đọc từ `import.meta.env.VITE_API_BASE_URL`
- Tạo file `.env.example` với giá trị mẫu
- ESLint rule cấm hardcode `http://localhost` / `http://127.0.0.1` trong source
- Code review phải reject PR hardcode URL

---

## 3. `VITE_API_BASE_URL` thiếu prefix `/api`

**Mô tả lỗi:**
Sau khi fix Mixed Content, request được gửi nhưng trả 404 Not Found. Path gửi đi là
`/khach-hang/dang-nhap` nhưng Laravel serve tại `/api/khach-hang/dang-nhap`.

**Nguyên nhân:**
Convention trong FE không đồng nhất:
- `utils/api.js` dùng axios baseURL rồi gọi `/lich-hen` → cần baseURL có `/api` ở cuối
- Các file khác gọi trực tiếp `VITE_API_BASE_URL + "/khach-hang/..."` → cũng cần `/api`

GitHub Secret lại set `http://<alb-dns>` (không có `/api`) → tất cả 404.

**Cách khắc phục:**
GitHub Secret `VITE_API_BASE_URL` = `https://<cloudfront-domain>/api` (có `/api` ở cuối).

**Bài học phòng tránh:**
Trong `.env.example` ghi **ví dụ cụ thể** của giá trị `VITE_API_BASE_URL`:
```
VITE_API_BASE_URL=http://localhost:8000/api
```
Và comment rõ: **URL luôn KẾT THÚC bằng `/api`**, không kèm trailing slash.

---

## 4. Laravel default `DB_CONNECTION = sqlite` → fallback khi Secrets thiếu

**Mô tả lỗi:**
Mọi API trên ALB trả HTTP 500. CloudWatch log ECS hiện:
```
SQLSTATE[HY000] [14] unable to open database file
```

**Nguyên nhân:**
Laravel 11 mặc định `config/database.php` có:
```php
'default' => env('DB_CONNECTION', 'sqlite'),
```
Khi Secrets Manager không inject biến `DB_CONNECTION`, Laravel fallback SQLite →
tìm file `/var/www/html/database/database.sqlite` không tồn tại → crash 500.

**Cách khắc phục:**
Sửa `config/database.php`:
```php
'default' => env('DB_CONNECTION', 'mysql'),
```
Hoặc thêm `DB_CONNECTION=mysql` vào Secrets Manager `petty/production/env`.

**Bài học phòng tránh:**
Deploy Laravel lên production cần verify:
- `DB_CONNECTION` có trong Secrets Manager, HOẶC
- `config/database.php` default = `mysql` (an toàn hơn)
- Sau deploy: `php artisan tinker` → `DB::connection()->getName()` — kiểm tra đúng `mysql`

---

## 5. RDS Public Access không đủ để kết nối từ Internet

**Mô tả lỗi:**
Đã Modify RDS → Public access: Yes. Đã add inbound rule `My IP/32:3306` vào
`petty-rds-sg`. DNS resolve ra public IP. Nhưng `nc -zv <rds-endpoint> 3306` vẫn timeout.

**Nguyên nhân:**
RDS nằm trong subnet `petty-subnet-db1-*` — wizard "VPC and more" tạo tier DB là
**private/isolated** subnet. Route table chỉ có:
- `10.0.0.0/16 → local`
- `0.0.0.0/0 → NAT Gateway`

Không có route `0.0.0.0/0 → IGW`. Dù RDS có public IP, gói tin inbound từ internet
không có đường vào subnet (NAT chỉ support outbound-initiated traffic). Traffic bị drop
ở biên VPC → timeout từ phía client.

**Cách khắc phục:**
Không đổi route table (phá vỡ security design). Thay vào đó dùng **ECS Exec** để shell
vào container Laravel đang chạy trong private subnet — container đã có DB credentials
qua env vars, query được trực tiếp:

1. IAM role `petty-ecs-task-role` attach policy `AmazonSSMManagedInstanceCore`
2. ECS Service → Update → **Enable Execute command** + **Force new deployment**
3. Đợi task mới RUNNING (~3 phút)
4. Trên CloudShell (không cần cài session-manager-plugin):
   ```bash
   TASK_ARN=$(aws ecs list-tasks --cluster petty-cluster --service-name <service-name> --region ap-southeast-1 --query 'taskArns[0]' --output text)
   CONTAINER=$(aws ecs describe-tasks --cluster petty-cluster --tasks $TASK_ARN --region ap-southeast-1 --query 'tasks[0].containers[0].name' --output text)
   aws ecs execute-command --cluster petty-cluster --task $TASK_ARN --container $CONTAINER --interactive --command "/bin/sh" --region ap-southeast-1
   ```
5. Trong container: `cd /var/www/html && php artisan tinker` → query `\App\Models\X::count()`

**Bài học phòng tránh:**
Hiểu rõ 3 tầng VPC subnet:
| Tier | Route `0.0.0.0/0` | Accept inbound từ internet? |
|---|---|---|
| Public | → IGW | Có |
| Private | → NAT | Không (chỉ outbound-initiated) |
| DB/Isolated | chỉ local | Không |

Muốn debug RDS từ laptop:
- **Cách đúng chuẩn**: ECS Exec (không mở port, không đụng VPC)
- Cách cũ: Bastion EC2 trong public subnet → SSH vào bastion → `mysql` từ trong VPC
- **Không làm được**: chỉ bật Public Access + SG rule

Nếu vẫn muốn connect từ laptop, phải thêm route `0.0.0.0/0 → IGW` vào route table của
DB subnet — nhưng cách này expose RDS routing-level ra internet, không khuyến nghị
production.

---

## 6. Import data bằng route Laravel public `/run-migration-data` — lỗ hổng bảo mật

**Mô tả lỗi:**
Để import SQL backup lên RDS, đã tạo route:
```php
Route::get('/run-migration-data', function () {
    $sql = file_get_contents(base_path('petty_vms_backup.sql'));
    DB::unprepared($sql);
    return 'Import thành công';
});
```
Deploy xong, curl route → data lên RDS, xoá route → commit. Nhưng trong khoảng thời gian
route tồn tại (~30 phút), bất kỳ ai biết URL đều có thể trigger `DB::unprepared()` với
nội dung bất kỳ nếu thay SQL file trong image.

**Nguyên nhân:**
Không muốn tạo EC2 bastion (tốn phí) để dùng `mysql < backup.sql`. Chọn đường tắt là
public HTTP route không auth.

**Cách khắc phục (cho lần sau):**
Dùng 1 trong 2 cách sau thay vì public route:

**Cách A** — ECS one-off task:
- Tạo task definition `petty-be-migrate-task` riêng, `command` override thành
  `["php", "artisan", "migrate", "--seed"]`
- Chạy: `aws ecs run-task --cluster petty-cluster --task-definition petty-be-migrate-task --launch-type FARGATE --network-configuration ...`
- Task tự stop sau khi migrate xong

**Cách B** — ECS Exec vào task đang chạy:
- Enable Execute command
- Shell vào container: `php artisan migrate --seed`

**Bài học phòng tránh:**
**Tuyệt đối không** tạo route HTTP để chạy lệnh DB trên production. Dù chỉ "tạm thời",
route có thể:
- Bị scanner/bot phát hiện trong vài phút (Shodan, common path brute)
- Quên xoá → vĩnh viễn open backdoor
- Log request đầy đủ → audit trail có URL bất thường

---

## 7. IAM user `github-actions-deployer` quá hẹp cho debug local

**Mô tả lỗi:**
Dùng AWS CLI local với IAM user dành cho CI/CD (OIDC GitHub Actions). Khi cần debug:
- `aws secretsmanager get-secret-value` → `AccessDenied`
- `aws ecs list-tasks` → `AccessDenied`
- `aws iam list-attached-role-policies` → `AccessDenied`

Phải chuyển qua CloudShell (dùng danh tính Console) để làm tiếp.

**Nguyên nhân:**
`github-actions-deployer` theo principle of least privilege chỉ có quyền:
ECR push, ECS register-task-definition + update-service, S3 sync, CloudFront invalidation.
Không có quyền read Secrets Manager, ECS describe, IAM list.

**Cách khắc phục:**
Tách 2 IAM identity ngay từ đầu:
- **`github-actions-deployer`** (IAM role với OIDC trust) — quyền CI/CD tối thiểu, dùng
  cho GitHub Actions
- **IAM user admin/developer** cho chính bạn — quyền rộng hơn (ReadOnlyAccess + ECS Exec +
  SSM session) để debug local

Setup AWS CLI với 2 profile:
```bash
# ~/.aws/credentials
[deployer]
aws_access_key_id = ...
aws_secret_access_key = ...

[admin]
aws_access_key_id = ...
aws_secret_access_key = ...
```

Rồi chạy: `aws --profile admin ecs list-tasks ...`

**Bài học phòng tránh:**
Không bao giờ dùng credential CI cho debug cá nhân. CI credential phải có blast radius
nhỏ nhất có thể (read-write cho đúng resource cần deploy, nothing else).

---

## 8. Password plaintext paste vào AI chat

**Mô tả lỗi:**
Trong quá trình debug, copy lệnh `mysql -p'<password>' ...` nguyên vào chat AI để
nhờ assistant chạy giúp. Password RDS master giờ nằm trong transcript, log của AI
provider, và có thể cả chat history backup.

**Cách khắc phục:**
- Đổi master password RDS ngay lập tức (Modify → New master password → Apply immediately).
  AWS Managed Secret `rds!db-...` tự cập nhật sau ~1 phút, ECS task không cần redeploy.
- Xem lại transcript chat, nếu có tool nào tự save/share thì xoá.

**Bài học phòng tránh:**
- Khi paste command có secret, **thay secret bằng `<PASSWORD>` placeholder**:
  `mysql -h ... -p'<PASSWORD>' ...`
- Chạy lệnh chứa secret tại **terminal local**, chỉ paste output (sau khi đã strip
  phần sensitive) cho AI
- Nếu assistant cần chạy lệnh qua tool, đảm bảo command đọc secret từ env var /
  secret manager, không hardcode.

---

## Tổng kết — Checklist deploy lần sau

Khi deploy kiến trúc tương tự (CloudFront + ALB + ECS + RDS MariaDB), trước khi bắt đầu:

1. [ ] FE: mọi URL đọc từ `import.meta.env.VITE_API_BASE_URL` — **ngày 1**, không để lúc deploy mới fix
2. [ ] `.env.example` ghi rõ convention của `VITE_API_BASE_URL` (có/không `/api`)
3. [ ] Thiết kế: CloudFront làm reverse proxy cho ALB (`/api/*` behavior) → ALB không cần ACM cert
4. [ ] Laravel `config/database.php` default `mysql` + `DB_CONNECTION=mysql` trong Secrets Manager
5. [ ] Tạo 2 IAM identity: deployer (CI OIDC, quyền hẹp) + admin user (quyền rộng, debug local)
6. [ ] Task Definition: `enableExecuteCommand: true` từ đầu
7. [ ] IAM task role attach `AmazonSSMManagedInstanceCore` từ đầu
8. [ ] Kế hoạch migrate data: dùng ECS run-task one-off hoặc ECS Exec, **không** public HTTP route
9. [ ] Healthcheck `/api/health` public no-auth cho ALB target group
10. [ ] Secrets Manager có đủ: APP_KEY, APP_ENV, DB_*, MAIL_*, OAUTH_* trước khi deploy
11. [ ] Never paste secrets vào AI chat — dùng placeholder

Nếu tuân thủ checklist trên, 8 lỗi ghi trong file này sẽ không phát sinh.
