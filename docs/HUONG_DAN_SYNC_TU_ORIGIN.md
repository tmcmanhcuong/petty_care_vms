# Hướng dẫn sync code mới từ repo khoá luận (`origin`) về repo deploy (`old`)

Tài liệu này mô tả workflow kéo code mới nhất từ repo khoá luận về repo deploy AWS mà vẫn giữ được toàn bộ cấu hình production. Áp dụng mỗi khi bên khoá luận push feature mới lên `origin/main`.

---

## 1. Bối cảnh

Project có **2 remote tách biệt**:

| Remote | URL | Vai trò |
|---|---|---|
| `origin` | github.com/KLTN-03-2026/GR58 | Repo khoá luận (team chung). **CHỈ ĐỌC từ phía deploy.** |
| `old` | github.com/tmcmanhcuong/petty_care_vms | Repo thực hành deploy AWS cá nhân. Chứa branch `aws-deploy-synced`. |

Branch chính để deploy: **`aws-deploy-synced`** trên remote `old`.

- Base = `origin/main` (code features mới nhất)
- + các commit AWS-specific (Dockerfile, docker configs, CI/CD workflows, fix hardcoded IP, force mysql, evidence docs...)

---

## 2. Nguyên tắc bất di bất dịch

1. **KHÔNG BAO GIỜ `git push origin`** từ phía deploy. Repo khoá luận phải sạch, không dính config deploy.
2. **KHÔNG force-push** (`git push -f`) lên `old/main` hoặc bất kỳ branch nào người khác đang dùng.
3. **KHÔNG rebase `aws-deploy-synced`** — dùng `merge` để giữ history sync rõ ràng.
4. Mọi thay đổi code production mới (nếu cần) phải commit trực tiếp trên `aws-deploy-synced`, không tạo PR ngược về `origin`.

---

## 3. Quy trình sync chuẩn (làm định kỳ)

Mỗi khi team khoá luận thông báo có feature mới đã merge vào `origin/main`:

```bash
# 1. Về đúng branch
git checkout aws-deploy-synced

# 2. Kéo code mới từ CẢ HAI remote
git fetch origin --prune
git fetch old --prune

# 3. Đảm bảo local aws-deploy-synced đồng bộ với old
git pull old aws-deploy-synced

# 4. Merge code mới từ origin/main vào
git merge origin/main
```

### Trường hợp không có conflict

Merge chạy xong, sinh commit merge tự động. Kiểm tra nhanh rồi push:

```bash
# 5. Kiểm tra build
cd petty_FE && npm install && npm run build && cd ..
cd petty_BE && composer install && cd ..

# 6. Push CHỈ lên remote 'old'
git push old aws-deploy-synced
```

### Trường hợp có conflict

Git sẽ dừng merge và liệt kê các file xung đột. `rerere` đã được bật (xem mục 6) nên các resolution đã làm trước sẽ được áp dụng tự động — giảm nhiều công resolve lặp lại.

```bash
# 1. Xem file nào đang xung đột
git status

# 2. Mở từng file, chọn giữ bên nào (hoặc gộp cả hai)
#    - Marker <<<<<<< HEAD         → phiên bản aws-deploy-synced hiện tại (có fix deploy)
#    - Marker >>>>>>> origin/main  → phiên bản team khoá luận mới push

# 3. Sau khi sửa xong mỗi file:
git add <đường-dẫn-file>

# 4. Khi hết conflict:
git merge --continue

# 5. Test build rồi push
cd petty_FE && npm run build && cd ..
git push old aws-deploy-synced
```

### Nguyên tắc chọn bên khi resolve conflict

| Loại conflict | Chọn bên nào |
|---|---|
| Origin đã cleanup/refactor, có logic tương đương | Giữ **origin** (ví dụ: avatar URL logic, API_BASE refactor) |
| Origin vẫn hardcode localhost/127.0.0.1 | Giữ **fix deploy** (VITE_API_BASE_URL) |
| Origin có tính năng mới mà fix deploy làm thủ công | Giữ **origin**, bỏ fix thủ công |
| Docker / nginx / workflow files | Giữ **deploy** (origin không biết deploy) |
| `config/database.php`, `.env.example` | Merge thủ công — gộp cả 2 |

---

## 4. Nếu hỏng — cách rollback

Mọi scenario đều có cách quay lại vì đã có tag backup.

### 4.1. Đang merge/cherry-pick mà muốn huỷ

```bash
git merge --abort        # huỷ merge đang conflict
git cherry-pick --abort  # huỷ cherry-pick đang conflict
```

### 4.2. Đã commit nhưng kết quả sai

```bash
# Xem commit trước đó
git log --oneline -5

# Quay về commit cũ (thay <hash> bằng commit đúng gần nhất)
git reset --hard <hash>
```

### 4.3. Lỡ xoá branch hoặc làm hỏng nặng

```bash
# Danh sách tag backup
git tag | grep backup

# Tái lập branch từ tag backup gần nhất
git checkout -b aws-deploy-synced-restore aws-deploy-backup-20260424
```

### 4.4. Worst case — mất toàn bộ local

```bash
# Fetch lại từ remote
git fetch old
git checkout -b aws-deploy-synced old/aws-deploy-synced
```

Remote `old/aws-deploy-synced` luôn là nguồn tin cậy vì ta không bao giờ force-push.

---

## 5. Khi cần thêm fix deploy mới (không phải sync từ origin)

Trường hợp bạn phát hiện bug chỉ xảy ra trên production (ví dụ cần sửa nginx config, đổi env var, fix Dockerfile):

```bash
git checkout aws-deploy-synced
# Sửa file
git add <file>
git commit -m "fix(deploy): mô tả ngắn gọn"
git push old aws-deploy-synced
```

**Không** cần merge về `origin/main`. Fix này chỉ có nghĩa với production của bạn.

---

## 6. Cấu hình git đã bật

Các cấu hình sau đã được bật trong local repo khi thiết lập lần đầu:

```bash
git config rerere.enabled true     # ghi nhớ conflict resolution
git config rerere.autoupdate true  # tự add file đã resolve vào staging
```

Nếu bạn clone repo về máy mới, chạy lại 2 lệnh trên.

---

## 7. Tag backup định kỳ (khuyên làm)

Trước mỗi lần sync lớn, tạo tag backup để có điểm rollback:

```bash
# Đặt tên theo ngày: aws-deploy-backup-YYYYMMDD
git tag aws-deploy-backup-$(date +%Y%m%d) aws-deploy-synced
git push old --tags
```

Tag hiện tại: `aws-deploy-backup-20260424` (tạo trước lần sync đầu tiên).

---

## 8. Checklist nhanh cho mỗi lần sync

- [ ] `git fetch origin --prune && git fetch old --prune`
- [ ] `git checkout aws-deploy-synced`
- [ ] Tạo tag backup mới: `git tag aws-deploy-backup-$(date +%Y%m%d)`
- [ ] `git merge origin/main`
- [ ] Resolve conflict (nếu có) theo bảng ở mục 3
- [ ] `cd petty_FE && npm run build` → pass
- [ ] `cd petty_BE && php -l app/Http/Controllers/*.php` → no syntax errors
- [ ] `git push old aws-deploy-synced`
- [ ] `git push old --tags`
- [ ] Rebuild Docker image và redeploy ECS (xem `docs/aws-ecr-docker-deployment.md`)

---

## 9. Nếu workflow này gãy

Các dấu hiệu nguy hiểm cần dừng lại và suy nghĩ:

- `git status` báo `detached HEAD` → checkout lại branch đúng trước khi làm gì
- Team khoá luận báo đã **force-push** lên `origin/main` → contact họ, có thể cần rebase thay vì merge, phức tạp hơn
- Conflict xảy ra ở **hơn 20 file cùng lúc** → có thể origin đã refactor lớn, cân nhắc sync từng feature branch thay vì merge một cục

Khi không chắc: tạo tag backup, thử trên branch throwaway (`git checkout -b test-sync`), nếu OK mới áp dụng lên `aws-deploy-synced`.
