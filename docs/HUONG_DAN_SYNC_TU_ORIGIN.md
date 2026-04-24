# Hướng dẫn sync code mới từ repo khoá luận (`origin`) về repo deploy (`old`)

Tài liệu này mô tả workflow kéo code mới nhất từ repo khoá luận về repo deploy AWS mà vẫn giữ được toàn bộ cấu hình production. Áp dụng mỗi khi bên khoá luận push feature mới lên `origin/main`.

---

## 1. Bối cảnh

Project có **2 remote tách biệt**:

| Remote | URL | Vai trò |
|---|---|---|
| `origin` | github.com/KLTN-03-2026/GR58 | Repo khoá luận (team chung). **CHỈ ĐỌC từ phía deploy.** |
| `old` | github.com/tmcmanhcuong/petty_care_vms | Repo deploy AWS (có team nhỏ cùng làm deploy/docs). |

Branch chính: **`main`** trên cả local và remote `old`.

Local `main` track `old/main` (xác nhận bằng `git branch -vv` — thấy `[old/main]`). Vì vậy `git push` / `git pull` mặc định đi qua remote `old`, không đụng `origin`.

---

## 2. Nguyên tắc bất di bất dịch

1. **KHÔNG BAO GIỜ `git push origin`** từ phía deploy. Repo khoá luận phải sạch, không dính config deploy.
2. **KHÔNG force-push `old/main`** khi có teammate cũng đang làm việc. Dùng `--force-with-lease` nếu bất đắc dĩ phải force (nó sẽ chặn nếu có commit mới của người khác).
3. **KHÔNG rebase `main`** — dùng `merge` để giữ history sync rõ ràng.
4. Luôn `git fetch old` trước khi làm gì để biết teammate có push gì mới không.
5. Mọi fix production riêng commit trực tiếp lên `main`, không tạo PR ngược về `origin`.

---

## 3. Quy trình sync chuẩn (làm định kỳ)

Mỗi khi team khoá luận thông báo có feature mới đã merge vào `origin/main`:

```bash
# 1. Về đúng branch
git checkout main

# 2. Kéo code mới từ CẢ HAI remote
git fetch origin --prune
git fetch old --prune

# 3. Đảm bảo local main đồng bộ với old/main (tránh conflict với teammate)
git pull --ff-only old main

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
git push old main
```

### Trường hợp có conflict

Git sẽ dừng merge và liệt kê các file xung đột. `rerere` đã được bật (xem mục 6) nên các resolution đã làm trước sẽ được áp dụng tự động — giảm nhiều công resolve lặp lại.

```bash
# 1. Xem file nào đang xung đột
git status

# 2. Mở từng file, chọn giữ bên nào (hoặc gộp cả hai)
#    - Marker <<<<<<< HEAD         → phiên bản main hiện tại (có fix deploy)
#    - Marker >>>>>>> origin/main  → phiên bản team khoá luận mới push

# 3. Sau khi sửa xong mỗi file:
git add <đường-dẫn-file>

# 4. Khi hết conflict:
git merge --continue

# 5. Test build rồi push
cd petty_FE && npm run build && cd ..
git push old main
```

### Nguyên tắc chọn bên khi resolve conflict

| Loại conflict | Chọn bên nào |
|---|---|
| Origin đã cleanup/refactor, có logic tương đương | Giữ **origin** (ví dụ: avatar URL logic, API_BASE refactor) |
| Origin vẫn hardcode localhost/127.0.0.1 | Giữ **fix deploy** (VITE_API_BASE_URL) |
| Origin có tính năng mới mà fix deploy làm thủ công | Giữ **origin**, bỏ fix thủ công |
| Docker / nginx / workflow files | Giữ **deploy** (origin không biết deploy) |
| `config/database.php`, `.env.example` | Merge thủ công — gộp cả 2 |
| Bug typo trong origin (ví dụ `VITE_API_BASE` thiếu `_URL`) | Giữ fix của mình, đồng thời báo team khoá luận fix upstream |

---

## 4. Nếu hỏng — cách rollback

Mọi scenario đều có cách quay lại vì đã có tag backup.

### 4.1. Đang merge/cherry-pick mà muốn huỷ

```bash
git merge --abort        # huỷ merge đang conflict
git cherry-pick --abort  # huỷ cherry-pick đang conflict
```

### 4.2. Đã commit nhưng kết quả sai (chưa push)

```bash
# Xem commit trước đó
git log --oneline -5

# Quay về commit cũ (thay <hash> bằng commit đúng gần nhất)
git reset --hard <hash>
```

### 4.3. Lỡ push commit sai lên old/main

Nếu teammate chưa pull:

```bash
git reset --hard <hash-đúng>
git push old main --force-with-lease    # --force-with-lease sẽ chặn nếu teammate đã push thêm
```

Nếu teammate đã pull — KHÔNG force-push. Tạo commit revert thay thế:

```bash
git revert <hash-sai>
git push old main
```

### 4.4. Lỡ xoá branch hoặc làm hỏng nặng

```bash
# Danh sách tag backup
git tag | grep backup

# Tái lập branch từ tag backup
git checkout -b recover aws-deploy-backup-20260424
```

### 4.5. Worst case — mất toàn bộ local

```bash
# Fetch lại từ remote
git fetch old
git checkout -b main old/main
```

---

## 5. Khi cần thêm fix deploy mới (không phải sync từ origin)

Trường hợp bạn phát hiện bug chỉ xảy ra trên production (ví dụ cần sửa nginx config, đổi env var, fix Dockerfile):

```bash
git checkout main
git pull --ff-only old main        # kéo bản mới nhất từ teammate
# Sửa file
git add <file>
git commit -m "fix(deploy): mô tả ngắn gọn"
git push old main
```

**Không** cần merge về `origin/main`. Fix này chỉ có nghĩa với production của bạn.

---

## 6. Cấu hình git đã bật

Các cấu hình sau đã được bật trong local repo khi thiết lập lần đầu:

```bash
git config rerere.enabled true     # ghi nhớ conflict resolution
git config rerere.autoupdate true  # tự add file đã resolve vào staging
```

Nếu bạn clone repo về máy mới, chạy lại 2 lệnh trên. Sau khi clone cũng nhớ **đổi tracking của main sang old/main**:

```bash
git remote add old https://github.com/tmcmanhcuong/petty_care_vms.git
git remote add origin https://github.com/KLTN-03-2026/GR58.git
git fetch old --prune
git branch --set-upstream-to=old/main main
```

---

## 7. Tag backup định kỳ (khuyên làm)

Trước mỗi lần sync lớn, tạo tag backup để có điểm rollback:

```bash
# Đặt tên theo ngày: aws-deploy-backup-YYYYMMDD
git tag aws-deploy-backup-$(date +%Y%m%d) main
git push old --tags
```

Tag hiện tại: `aws-deploy-backup-20260424` (tạo trước lần sync đầu tiên từ workflow cũ `aws-deploy-synced`).

---

## 8. Checklist nhanh cho mỗi lần sync

- [ ] `git fetch origin --prune && git fetch old --prune`
- [ ] `git checkout main`
- [ ] `git pull --ff-only old main` (kéo phần teammate đã push nếu có)
- [ ] Tạo tag backup mới: `git tag aws-deploy-backup-$(date +%Y%m%d) main`
- [ ] `git merge origin/main`
- [ ] Resolve conflict (nếu có) theo bảng ở mục 3
- [ ] `cd petty_FE && npm run build` → pass
- [ ] `cd petty_BE && php -l app/Http/Controllers/*.php` → no syntax errors
- [ ] `git push old main`
- [ ] `git push old --tags`
- [ ] Rebuild Docker image và redeploy ECS (xem `docs/aws-ecr-docker-deployment.md` hoặc `docs/manual-deploy-ecs.md`)

---

## 9. Nếu workflow này gãy

Các dấu hiệu nguy hiểm cần dừng lại và suy nghĩ:

- `git status` báo `detached HEAD` → checkout lại `main` trước khi làm gì
- Team khoá luận báo đã **force-push** lên `origin/main` → contact họ, có thể cần rebase thay vì merge, phức tạp hơn
- Conflict xảy ra ở **hơn 20 file cùng lúc** → có thể origin đã refactor lớn, cân nhắc sync từng feature branch thay vì merge một cục
- `git push old main` báo **non-fast-forward** → teammate đã push thêm, chạy `git pull --rebase old main` hoặc `git pull old main` rồi push lại (KHÔNG force)

Khi không chắc: tạo tag backup, thử trên branch throwaway (`git checkout -b test-sync`), nếu OK mới áp dụng lên `main`.

---

## 10. Lịch sử version của tài liệu này

- **v1** (20260424): Workflow với 2 branch `main` + `aws-deploy-synced`. Đã lỗi thời.
- **v2** (20260424): Gộp thành 1 branch `main`. Xoá `aws-deploy-synced` vì không cần thiết với team nhỏ.
