# Hướng dẫn sync code giữa repo khoá luận (`origin`) và repo deploy (`old`)

Tài liệu này mô tả cách làm việc với **2 vai trò song song** trên cùng 1 working copy:
- **Code feature cho khoá luận** → push về `origin`
- **Cấu hình/deploy AWS** → push về `old`

---

## 1. Bối cảnh — 2 remote, 2 branch

Project có 2 remote tách biệt, với 2 team khác nhau:

| Remote | URL | Phục vụ |
|---|---|---|
| `origin` | github.com/KLTN-03-2026/GR58 | Repo khoá luận (team chung) |
| `old` | github.com/tmcmanhcuong/petty_care_vms | Repo deploy AWS (team nhỏ: bạn + Men + Hưng) |

Tương ứng, có 2 local branch:

```
Local            Tracks            Mục đích
────────────     ─────────────     ─────────────────────────────────
main             origin/main       Code feature cho khoá luận
aws-main         old/main          Cấu hình + docs deploy AWS
```

**Kiểm tra:** `git branch -vv` — sẽ thấy `main [origin/main]` và `aws-main [old/main]`.

`push.default` đã được cấu hình là `upstream` → `git push` sẽ tự đi đúng remote dựa vào branch đang checkout, bất kể tên local khác remote hay không.

---

## 2. Checkout branch nào cho việc gì?

| Việc muốn làm | Checkout | Push đi đâu |
|---|---|---|
| Code feature mới (forum, pet, appointment...) | `main` | `origin/main` |
| Sửa bug feature đang có | `main` | `origin/main` |
| Sửa `Dockerfile`, nginx config, docker/ | `aws-main` | `old/main` |
| Sửa evidence docs, screenshots, W3_evidence | `aws-main` | `old/main` |
| Fix bug chỉ xảy ra trên production | `aws-main` | `old/main` |
| Mang feature mới từ khoá luận về deploy | `aws-main`, rồi `merge origin/main` | `old/main` |

---

## 3. Nguyên tắc bất di bất dịch

1. **Trên `main`:** chỉ code feature. KHÔNG thêm Dockerfile, docker configs, evidence docs.
2. **Trên `aws-main`:** KHÔNG tạo feature mới. Chỉ config deploy + fix production bug + sync từ origin.
3. **KHÔNG force-push** khi có teammate đang làm việc. Nếu bất đắc dĩ, dùng `--force-with-lease`.
4. **KHÔNG rebase** branch đã push. Dùng merge để giữ history.
5. Luôn `git fetch` trước khi làm gì.

---

## 4. Workflow code feature cho khoá luận (trên `main`)

```bash
git checkout main
git pull origin main          # kéo code mới nhất từ team khoá luận
# Code feature
git add <file>
git commit -m "feat(xxx): mô tả"
git push                       # upstream = origin/main, tự đi đúng chỗ
```

**Lưu ý:** không dùng `git push` trên `main` khi đang ở state không rõ — kiểm tra `git status` và `git log` trước.

---

## 5. Workflow sync code mới từ `origin/main` vào `aws-main`

Mỗi khi team khoá luận có feature mới merge vào `origin/main`, mang về phía deploy:

```bash
git checkout aws-main
git fetch origin --prune
git fetch old --prune

# Cập nhật aws-main với commit teammate deploy vừa push
git pull --ff-only           # upstream = old/main

# Tag backup TRƯỚC khi merge (để rollback được)
git tag aws-deploy-backup-$(date +%Y%m%d)

# Merge code mới từ khoá luận
git merge origin/main
```

### Nếu không conflict

```bash
# Kiểm tra build
cd petty_FE && npm install && npm run build && cd ..
cd petty_BE && composer install && cd ..

git push                 # upstream = old/main
git push old --tags      # đẩy luôn tag backup
```

### Nếu có conflict

Git sẽ dừng và liệt kê file xung đột. `rerere` đã bật → các resolution đã làm trước sẽ được áp dụng tự động.

```bash
git status                     # xem file nào conflict
# Mở file, giải quyết:
#   <<<<<<< HEAD            → phiên bản aws-main hiện tại (có fix deploy)
#   >>>>>>> origin/main     → phiên bản khoá luận mới push
git add <file>                 # sau khi resolve mỗi file
git merge --continue
cd petty_FE && npm run build   # test
git push
```

### Nguyên tắc chọn bên khi resolve conflict

| Loại conflict | Chọn |
|---|---|
| Origin đã refactor, có logic tương đương | Giữ **origin** |
| Origin vẫn hardcode localhost/127.0.0.1 | Giữ **fix deploy** (VITE_API_BASE_URL) |
| Origin có feature mới mà fix deploy làm thủ công | Giữ **origin** |
| Docker / nginx / workflow files | Giữ **deploy** (origin không biết) |
| `config/database.php`, `.env.example` | Gộp cả 2 thủ công |
| Bug typo origin (ví dụ `VITE_API_BASE` thiếu `_URL`) | Giữ fix, nên PR về origin để fix tận gốc |

---

## 6. Workflow sửa config deploy riêng (không liên quan origin)

Ví dụ cần sửa `Dockerfile` thêm extension PHP, sửa nginx timeout:

```bash
git checkout aws-main
git pull                 # kéo teammate nếu có
# Sửa file
git add <file>
git commit -m "fix(deploy): mô tả"
git push                 # → old/main
```

Rồi rebuild Docker image, push ECR, redeploy ECS theo `docs/manual-deploy-ecs.md`.

---

## 7. Nếu hỏng — cách rollback

### 7.1. Đang merge/cherry-pick mà muốn huỷ

```bash
git merge --abort
git cherry-pick --abort
```

### 7.2. Đã commit nhưng kết quả sai (chưa push)

```bash
git log --oneline -5
git reset --hard <hash-đúng>
```

### 7.3. Lỡ push commit sai

**Nếu chắc chắn teammate chưa pull:**
```bash
git reset --hard <hash-đúng>
git push --force-with-lease   # chặn nếu teammate đã push thêm
```

**Nếu teammate đã pull** — KHÔNG force-push. Tạo revert:
```bash
git revert <hash-sai>
git push
```

### 7.4. Worst case — mất local

```bash
git fetch old
git checkout -b aws-main old/main
git fetch origin
git checkout -b main origin/main
git config push.default upstream
```

---

## 8. Cấu hình git đã bật (local repo này)

```bash
git config rerere.enabled true      # ghi nhớ conflict resolution
git config rerere.autoupdate true   # tự add file đã resolve
git config push.default upstream    # git push → tự đi đúng remote
```

Nếu clone repo về máy mới, chạy lại 3 lệnh trên.

---

## 9. Setup lại từ đầu nếu mất working copy

```bash
# Clone (giả sử clone từ old)
git clone https://github.com/tmcmanhcuong/petty_care_vms.git Petty
cd Petty

# Add remote origin
git remote add origin https://github.com/KLTN-03-2026/GR58.git
git fetch origin --prune

# Rename local main → aws-main (track old/main)
git branch -m main aws-main
git branch --set-upstream-to=old/main aws-main

# Tạo main mới từ origin/main
git checkout -b main origin/main

# Config
git config rerere.enabled true
git config rerere.autoupdate true
git config push.default upstream
```

Verify bằng `git branch -vv`:
```
  aws-main    <hash> [old/main]     ...
* main        <hash> [origin/main]  ...
```

---

## 10. Checklist nhanh cho mỗi lần sync

- [ ] `git fetch origin --prune && git fetch old --prune`
- [ ] `git checkout aws-main`
- [ ] `git pull --ff-only` (kéo teammate deploy)
- [ ] `git tag aws-deploy-backup-$(date +%Y%m%d)`
- [ ] `git merge origin/main`
- [ ] Resolve conflict (nếu có) theo bảng ở mục 5
- [ ] `cd petty_FE && npm run build` → pass
- [ ] `cd petty_BE && php -l app/Http/Controllers/*.php` → no syntax errors
- [ ] `git push`
- [ ] `git push old --tags`
- [ ] Rebuild Docker + redeploy ECS (xem `docs/manual-deploy-ecs.md`)

---

## 11. Nếu workflow này gãy

- `git status` báo `detached HEAD` → `git checkout aws-main` hoặc `git checkout main` tuỳ bạn đang làm gì
- Team khoá luận **force-push** lên `origin/main` → contact họ, cân nhắc rebase thay vì merge
- `git push` báo **non-fast-forward** → teammate push thêm, `git pull` rồi push lại (KHÔNG force)
- Conflict ở **>20 file** → origin refactor lớn, cân nhắc sync từng feature branch

Khi không chắc: tạo tag backup, thử trên branch throwaway (`git checkout -b test-sync aws-main`), OK mới apply lên `aws-main`.

---

## 12. Lịch sử doc

- **v1** (20260424 sáng): Workflow 2 branch `main` + `aws-deploy-synced`. Bỏ.
- **v2** (20260424 trưa): Gộp thành 1 branch `main`. Bỏ — không support code feature về origin.
- **v3** (20260424 chiều): **Hiện tại.** Tách rõ `main` (→origin, feature dev) + `aws-main` (→old, deploy).
