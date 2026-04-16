# ============================================================
# Stage 1: Composer builder — install PHP dependencies
# ============================================================
FROM composer:2 AS builder

WORKDIR /app

# Copy only dependency files first (cache-friendly layer)
COPY composer.json composer.lock ./

# Install production dependencies
# --ignore-platform-reqs: composer:2 image thiếu ext-gd, ext-curl (cần bởi dompdf, socialite)
# --no-scripts: bỏ qua post-autoload-dump (php artisan package:discover) vì builder không có .env
# Runtime image php:8.2-fpm-alpine sẽ cài đầy đủ extensions — an toàn để bỏ qua ở build stage
RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction \
    --no-progress \
    --prefer-dist \
    --ignore-platform-reqs \
    --no-scripts

# Copy the full application source
COPY . .

# ============================================================
# Stage 2: Runtime — PHP-FPM + Nginx in one container
# ============================================================
FROM php:8.2-fpm-alpine AS runtime

LABEL maintainer="Petty VMCS Team"

# Install system dependencies: nginx, supervisor, and PHP extensions for Laravel
RUN apk add --no-cache \
    nginx \
    supervisor \
    curl \
    # Required PHP extensions
    && docker-php-ext-install pdo pdo_mysql opcache \
    && docker-php-ext-enable opcache

# Copy application from builder stage
WORKDIR /var/www/html
COPY --from=builder /app .

# Create Laravel required directories and set proper permissions
RUN mkdir -p storage/logs \
             storage/framework/cache/data \
             storage/framework/sessions \
             storage/framework/views \
             bootstrap/cache \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 storage bootstrap/cache

# Copy Nginx and Supervisor configuration files
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# PHP-FPM config: run as www-data
RUN sed -i 's/user = www-data/user = www-data/' /usr/local/etc/php-fpm.d/www.conf 2>/dev/null || true

# Expose HTTP port
EXPOSE 80

# Health check — ALB uses this endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/api/health || exit 1

ENTRYPOINT ["/entrypoint.sh"]
