# ERR-001 — Docker Daemon Not Running (macOS)

**Ngày gặp:** 2026-04-16  
**Task liên quan:** Task 2.7 — `docker build -t petty-be:local ./petty_BE`  
**Môi trường:** macOS, Docker Desktop

---

## ❌ Lỗi gặp phải

```
ERROR: failed to connect to the docker API at unix:///Users/enma/.docker/run/docker.sock;
check if the path is correct and if the daemon is running:
dial unix /Users/enma/.docker/run/docker.sock: connect: no such file or directory
```

## 🔍 Nguyên nhân

Docker CLI không kết nối được tới Docker Daemon vì **Docker Desktop chưa được khởi động**.  
Trên macOS, Docker chạy thông qua một VM nhỏ (daemon). CLI chỉ là wrapper — nếu daemon chưa chạy thì mọi lệnh `docker` đều fail.

## ✅ Cách giải quyết

### Bước 1 — Mở Docker Desktop
- Mở **Spotlight** (`Cmd + Space`) → gõ `Docker` → Enter
- Hoặc vào **Applications** → **Docker.app**
- Chờ icon Docker trên menu bar (góc trên phải) **ngừng animation** (whale đứng yên = ready)

### Bước 2 — Verify daemon đã chạy
```bash
docker info
```
Output không có error = daemon đang chạy bình thường.

### Bước 3 — Chạy lại lệnh build
```bash
docker build -t petty-be:local ./petty_BE
```

---

## 💡 Ghi chú
- Docker Desktop cần được khởi động **mỗi lần reboot** máy (trừ khi bật "Start Docker Desktop when you log in" trong Preferences)
- Để bật auto-start: Docker Desktop → Settings → General → ✅ "Start Docker Desktop when you log in"

---

## ❌ Lỗi #2 — Wrong Working Directory

```
ERROR: failed to build: unable to prepare context: path "./petty_BE" not found
```

## 🔍 Nguyên nhân

Chạy lệnh từ **bên trong** `petty_BE/` thay vì từ **thư mục gốc** project.  
Docker tìm `./petty_BE` tương đối so với thư mục hiện tại — nếu đang đứng trong `petty_BE/` thì không có subfolder `petty_BE/petty_BE/`.

## ✅ Cách giải quyết

Luôn chạy lệnh `docker build` từ **thư mục gốc project** (chứa cả `petty_BE/` và `petty_FE/`):

```bash
# Quay về thư mục gốc
cd /Users/enma/Downloads/Coding/Case_Study_PJ/Petty_VMCS_SaaS/Petty

# Verify đúng vị trí
ls petty_BE petty_FE   # phải thấy cả 2 folder

# Rồi mới build
docker build -t petty-be:local ./petty_BE
```

---

## ❌ Lỗi #3 — `.dockerignore` exclude nhầm thư mục `docker/`

```
CopyIgnoredFile: Attempting to Copy file "docker/nginx.conf" that is excluded by .dockerignore (line 52)
CopyIgnoredFile: Attempting to Copy file "docker/supervisord.conf" that is excluded by .dockerignore (line 53)
CopyIgnoredFile: Attempting to Copy file "docker/entrypoint.sh" that is excluded by .dockerignore (line 54)
ERROR: failed to build: failed to solve: ... "/docker/entrypoint.sh": not found
```

## 🔍 Nguyên nhân

`.dockerignore` có dòng `docker/` để loại bỏ thư mục Docker config ra khỏi build context — **nhưng Dockerfile lại cần COPY các file đó vào image** (`COPY docker/nginx.conf`, `COPY docker/supervisord.conf`, `COPY docker/entrypoint.sh`). Hai yêu cầu mâu thuẫn nhau.

## ✅ Cách giải quyết

Xóa dòng `docker/` và `Dockerfile` khỏi `.dockerignore`. Các file trong `docker/` phải có mặt trong build context để lệnh `COPY` hoạt động.

**File `petty_BE/.dockerignore` đã được sửa** — dòng `docker/` đã bị xóa.

Chạy lại:
```bash
docker build -t petty-be:local ./petty_BE
```

---

## ❌ Lỗi #4 — `composer install` exit code: 2 (thiếu PHP extensions)

```
ERROR: failed to build: failed to solve: process "/bin/sh -c composer install ..."
did not complete successfully: exit code: 2
```

## 🔍 Nguyên nhân

`composer:2` builder image chỉ có PHP cơ bản. Các package sau **yêu cầu extensions không có trong builder:**
- `barryvdh/laravel-dompdf` → cần `ext-gd`, `ext-dom`
- `laravel/socialite` → cần `ext-curl`

Composer kiểm tra platform requirements và fail vì thiếu extensions.

## ✅ Cách giải quyết

Thêm flag `--ignore-platform-reqs` vào `composer install` trong Dockerfile builder stage.  
Extensions thực sự được cài ở **runtime stage** (`php:8.2-fpm-alpine`) — nên đây là an toàn.

**Đã sửa trong `petty_BE/Dockerfile`** — builder stage giờ dùng:
```dockerfile
RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction \
    --no-progress \
    --prefer-dist \
    --ignore-platform-reqs
```

Chạy lại:
```bash
docker build -t petty-be:local ./petty_BE
```

---

## ❌ Lỗi #5 — `php artisan package:discover` fail trong builder (exit code: 1)

```
Script @php artisan package:discover --ansi handling the post-autoload-dump event returned with error code 1
ERROR: failed to build: ... exit code: 1
```

## 🔍 Nguyên nhân

`composer.json` có script `post-autoload-dump` chạy sau khi install:
```json
"post-autoload-dump": [
    "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",
    "@php artisan package:discover --ansi"
]
```

Trong builder container (`composer:2`) không có file `.env` → **Laravel không boot được** → `artisan package:discover` fail.

## ✅ Cách giải quyết

Thêm flag `--no-scripts` vào `composer install` để bỏ qua toàn bộ Composer scripts.  
Script `package:discover` sẽ được chạy ở `entrypoint.sh` khi container khởi động thay thế.

**Đã sửa trong `petty_BE/Dockerfile`:**
```dockerfile
RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction \
    --no-progress \
    --prefer-dist \
    --ignore-platform-reqs \
    --no-scripts
```

Chạy lại:
```bash
docker build -t petty-be:local ./petty_BE
```
