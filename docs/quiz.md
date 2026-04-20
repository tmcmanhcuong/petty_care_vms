Đọc xong. Chấm chi tiết từng câu nhé:

  ---
  📊 Tổng kết trước

  ┌──────────────────┬──────────────┬────────────────────────────────────────────────────┐
  │        Bộ        │     Điểm     │                   Nhận xét tổng                    │
  ├──────────────────┼──────────────┼────────────────────────────────────────────────────┤
  │ Bộ 1 — Cơ bản    │ 41/70 (59%)  │ Nắm được ý chính, thiếu chi tiết                   │
  ├──────────────────┼──────────────┼────────────────────────────────────────────────────┤
  │ Bộ 2 — Trung cấp │ 25/70 (36%)  │ Một số câu hiểu đúng, một số hiểu sai hướng        │
  ├──────────────────┼──────────────┼────────────────────────────────────────────────────┤
  │ Bộ 3 — Nâng cao  │ 8/70 (11%)   │ Hầu hết chưa nắm — bình thường, cần thực hành thêm │
  ├──────────────────┼──────────────┼────────────────────────────────────────────────────┤
  │ Tổng             │ 74/210 (35%) │ Nền tảng có, cần lấp gaps quan trọng               │
  └──────────────────┴──────────────┴────────────────────────────────────────────────────┘

  ---
  🟦 BỘ 1 — CƠ BẢN

  Câu 1 — VPC 6/10
  ✅ Đúng: VPC = Virtual Private Cloud, là "hàng rào" cô lập mạng
  ❌ Thiếu: VPC tự nó không phải firewall — Security Group và NACL mới là firewall. VPC chỉ là private network riêng của bạn
  trên AWS, định nghĩa bởi dải IP (CIDR 10.0.0.0/16). Bên trong VPC bạn mới chia tiếp thành subnets, gắn route tables, SGs...

  ---
  Câu 2 — 3 loại subnet 7.5/10
  ✅ Public → IGW: đúng
  ✅ DB subnet: đúng
  ❌ Private subnet bạn nói sai quan trọng: Private subnet vẫn đi ra internet được (outbound) qua NAT Gateway — ECS task pull
  image từ ECR, gọi API ngoài đều qua NAT. Nó chỉ không nhận inbound từ internet. Đây là điểm cốt lõi bị nhầm.
  ❌ Chưa nêu resource cụ thể: ALB → Public, ECS → Private, RDS → DB subnet

  ---
  Câu 3 — Security Group 5/10
  ✅ Hiểu đúng: inbound/outbound rules
  ❌ Số lượng sai: project tạo 3 SG (petty-alb-sg, petty-ecs-sg, petty-rds-sg), không có SG riêng cho VPC Endpoints
  ❌ Chưa nêu rules quan trọng:
  - petty-alb-sg: inbound 80/443 từ 0.0.0.0/0
  - petty-ecs-sg: inbound 80 từ petty-alb-sg (không phải mọi IP)
  - petty-rds-sg: inbound 3306 từ petty-ecs-sg (chỉ ECS mới vào được)

  ---
  Câu 4 — ECS Fargate 6/10
  ✅ Đúng hướng: ít cấu hình, không quản lý máy chủ
  ❌ Dùng từ "pattern" chưa chuẩn — Fargate là launch type (compute engine), ECS là service quản lý container. Fargate = bạn
  không cần quan tâm OS, patching, EC2 instance — AWS lo phần đó. Bạn chỉ khai báo CPU/RAM cần và container chạy.

  ---
  Câu 5 — S3 + CloudFront 7/10
  ✅ Đúng: Vue = SPA = static files → S3 phù hợp hơn ECS container
  ✅ Đề cập OAC
  ❌ CloudFront không chỉ là "đường dẫn" — nó là CDN (Content Delivery Network): có ~400 edge locations toàn cầu, cache files ở
  edge, request từ Việt Nam không phải đi tới Singapore mới lấy được file. Đây là lý do CloudFront nhanh và rẻ hơn serve thẳng
  từ S3.

  ---
  Câu 6 — Secrets Manager 4/10
  ✅ Đúng: lưu APP_KEY, DB_PASSWORD...
  ❌ Không biết cơ chế inject — đây là điểm quan trọng: trong ECS Task Definition có field secrets, mỗi entry khai báo name (tên
   env var) + valueFrom (ARN của secret). Lúc task start, ECS tự động gọi Secrets Manager, lấy value và inject vào container như
   env var — Laravel đọc env('DB_PASSWORD') là đọc được luôn, không cần code thêm gì.
  ❌ Lý do không dùng .env trực tiếp trong image: nếu hardcode vào image thì secrets nằm trong ECR → ai pull được image là thấy
  secrets.

  ---
  Câu 7 — RDS Multi-AZ 6/10
  ✅ Backup + DR: đúng
  ❌ RDS đặt ở DB subnet, không phải Private subnet — đây là distinction thực tế trong project (tasks 5.2, 9.1 dùng
  petty-subnet-db1-* riêng)
  ❌ Multi-AZ cụ thể hơn: 1 Primary + 1 Standby ở AZ khác, synchronous replication, failover tự động ~60-120s khi primary down.
  Không phải "nhiều database" — vẫn chỉ có 1 DB active tại 1 thời điểm.

  ---
  🟧 BỘ 2 — TRUNG CẤP

  Câu 1 — Mixed Content 3/10
  ❌ Hiểu sai hoàn toàn nguyên nhân. Mixed Content không liên quan đến "internet không vào được trong" — đây là browser security
   policy:

  ▎ Trang được load qua https:// → browser chỉ cho phép gọi resource cũng là https://. Nếu JavaScript trong trang gọi
  ▎ http://alb-dns/api/... (HTTP), browser tự block, không thèm gửi request đi.

  CloudFront reverse proxy fix bằng cách: bạn gọi https://cloudfront-domain/api/... — cùng domain, cùng HTTPS → browser không có
   gì để chặn. CloudFront nhận request HTTPS, rồi nội bộ forward sang ALB HTTP — điều này hoàn toàn OK vì xảy ra
  server-to-server, không qua browser.

  ---
  Câu 2 — NAT vs IGW, VPC Endpoints 8/10
  ✅ Rất tốt — nắm đúng cả 3 điểm
  ❌ Một điểm quan trọng bị miss: VPC Interface Endpoints không hề rẻ hơn NAT trong trường hợp traffic thấp. Trong project này
  chính VPC Endpoints ($0.01/hr × 3 endpoints × 2 AZs = $0.06/hr = ~$4.32 trong 3 ngày) là khoản tốn nhất trong EC2-Other $7.20.
   Nếu traffic thấp (như demo), dùng NAT thay vì Interface Endpoints sẽ rẻ hơn. VPC Endpoints chỉ có lợi khi traffic rất lớn.

  ---
  Câu 3 — OIDC 8/10
  ✅ Nắm điểm chính rất tốt
  ❌ Chưa mô tả flow kỹ hơn: GitHub Actions push code → GitHub tạo JWT token → gửi lên AWS → AWS verify với GitHub OIDC Provider
   (đã đăng ký trước) → issue temporary STS credentials (expire sau job) → GitHub Actions dùng credentials đó để push ECR,
  deploy ECS. Không có secret nào cần lưu trong GitHub Secrets — đây là điểm mạnh nhất của OIDC.

  ---
  Câu 4 — RDS không connect được 1/10
  ❌ Câu trả lời của bạn ("CloudFront không trỏ tới ALB") hoàn toàn không liên quan.

  Nguyên nhân thực sự: Route table của DB subnet không có route 0.0.0.0/0 → IGW. Khi bật "Publicly accessible", RDS nhận public
  IP và DNS resolve ra IP đó — nhưng gói tin từ internet muốn vào public IP của RDS phải đi qua IGW vào subnet. DB subnet chỉ có
   route 0.0.0.0/0 → NAT (chỉ outbound-initiated) và local — không có IGW → gói tin inbound bị drop ở biên VPC, kết quả là
  timeout. Đây chính là lỗi mà chúng ta đã debug thực tế.

  ---
  Câu 5 — ECS Exec 1/10
  Bạn đã dùng ECS Exec để query RDS trong session này nhưng chưa hiểu nó là gì. Đây là điểm cần nhớ:

  ECS Exec = tool cho phép bạn exec vào container đang chạy trong ECS Fargate từ CLI — như SSH nhưng không cần mở port. Hoạt
  động qua AWS Systems Manager (SSM) Session Manager — traffic đi qua AWS API, không qua internet, không cần inbound port nào.

  Cần 3 điều kiện:
  1. IAM task role có policy AmazonSSMManagedInstanceCore
  2. ECS Service bật enableExecuteCommand: true
  3. Máy local cài session-manager-plugin

  Tốt hơn SSH/public access vì: không mở port nào trên SG, không expose resource ra internet, AWS CloudTrail log lại mọi
  session.

  ---
  Câu 6 — Laravel SQLite fallback 0/10
  Đây là lỗi thực tế đã xảy ra trong project. Cần nhớ:

  Laravel config/database.php có:
  'default' => env('DB_CONNECTION', 'sqlite'),
  Trên local, file .env có DB_CONNECTION=mysql → Laravel dùng MySQL → OK.
  Trên production ECS, nếu Secrets Manager không có key DB_CONNECTION, Laravel đọc env('DB_CONNECTION') = null → fallback sqlite
   → tìm file database.sqlite không tồn tại trong container → crash 500.
  Không phát hiện được ở local vì local luôn có .env.

  Fix: đổi default thành mysql trong config/database.php hoặc thêm DB_CONNECTION=mysql vào Secrets Manager.

  ---
  Câu 7 — 3 workflows 4/10
  ✅ build-image: đúng hướng
  ❌ deploy-ecs: không phải "build thành container". Flow thực: tải task definition JSON từ ECS → sed thay image URI mới →
  register new task definition revision → gọi update-service với revision mới → ECS dần dần replace tasks cũ bằng tasks mới
  (rolling update)
  ❌ deploy-fe: không liên quan đến Docker image. Flow: npm ci → npm run build (Vite build Vue → dist/ folder) → aws s3 sync
  dist/ s3://bucket → aws cloudfront create-invalidation (xóa cache CloudFront để user thấy bản mới)

  ---
  🟥 BỘ 3 — NÂNG CAO

  Câu 1 — EC2-Other phân tích 3/10
  ❌ Logic ngược: "dùng VPC Endpoint để tiết kiệm" — nhưng VPC Interface Endpoints chính là nguyên nhân EC2-Other tốn $7.20.

  Breakdown thực tế:
  - VPC Interface Endpoints: 3 endpoints × 2 AZs × $0.01/hr × 72h = ~$4.32
  - NAT data processing: ~$1-2
  - NAT hourly: $0.045 × 72h = $3.24 (nằm trong dòng VPC $1.43 chưa rõ tại sao thấp — có thể mới tạo)

  Tối ưu thực tế: với traffic demo thấp → xóa Interface Endpoints (ECR, Secrets Manager), chỉ giữ S3 Gateway Endpoint (miễn
  phí). ECS task pull image qua NAT thay vì Interface Endpoint. Tiết kiệm ~$4/ngày.

  ---
  Câu 2 — Request flow 5/10
  ✅ Đúng thứ tự
  ❌ Copy từ gợi ý, không thêm chi tiết nào. Câu hỏi này cần giải thích mỗi bước làm gì:
  1. Browser gọi https://cloudfront.net/api/khach-hang/dang-nhap
  2. CloudFront: check path match /api/* → dùng behavior ALB origin, forward request sang http://alb:80
  3. ALB: health check target group → route đến 1 trong 2 ECS task đang healthy
  4. Container Nginx nhận → pass sang PHP-FPM port 9000
  5. PHP-FPM chạy Laravel → routing → middleware Sanctum → Controller → KhachHang::where('email', ...)->first()
  6. Query qua TCP 3306 → RDS Primary trong DB subnet
  7. RDS trả rows → Laravel build JSON response → ngược lại qua từng layer

  Câu 3–7: 0/10 mỗi câu — chấp nhận được với Bộ 3, đây là cấp độ cần kinh nghiệm thực hành thêm.

  ---
  🎯 Kết luận & Việc cần làm

  Nắm chắc (không cần ôn lại):
  - VPC concept, Subnet tiers cơ bản
  - NAT vs IGW, VPC Endpoints
  - OIDC authentication
  - S3 + CloudFront cho SPA

  Cần ôn lại ngay (hay bị hỏi trong interview):
  1. Mixed Content — nguyên nhân HTTPS/HTTP, cách fix
  2. ECS Exec — điều kiện, lệnh cụ thể, tại sao dùng
  3. Secrets Manager inject vào ECS — cơ chế Task Definition secrets field
  4. RDS private subnet + public access — tại sao không connect được
  5. deploy-ecs workflow — rolling update task definition, không phải "build container"
  6. Laravel DB_CONNECTION fallback — bẫy cực kỳ phổ biến