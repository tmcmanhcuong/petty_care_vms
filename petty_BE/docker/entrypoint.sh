#!/bin/sh
set -e

echo "==> Petty VMCS: Container starting..."

# Ensure storage and bootstrap directories have correct permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true

# Create supervisor log directory
mkdir -p /var/log/supervisor

# Run Laravel production optimizations
# package:discover chạy ở đây vì composer install dùng --no-scripts
echo "==> Caching config, routes, and views..."
php artisan package:discover --ansi
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "==> Starting supervisord (nginx + php-fpm)..."
exec /usr/bin/supervisord -c /etc/supervisord.conf
