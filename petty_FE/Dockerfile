# ============================================================
# Stage 1: Builder — npm ci + npm run build
# Used by CI to produce dist/ artifact for S3 upload
# ============================================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency files first (layer cache optimization)
COPY package.json package-lock.json ./

# Fresh, reproducible install (uses lock file)
RUN npm ci

# Copy source code
COPY . .

# Build with configurable API URL (injected at CI build time)
# Example: docker build --build-arg VITE_API_BASE_URL=http://<alb-dns> .
ARG VITE_API_BASE_URL
ENV VITE_API_BASE_URL=${VITE_API_BASE_URL}

RUN npm run build

# ============================================================
# Stage 2: Nginx server — serve dist/ (for local testing only)
# NOTE: FE is NOT deployed to ECS — CI uploads dist/ to S3
# ============================================================
FROM nginx:alpine AS nginx

COPY --from=builder /app/dist /usr/share/nginx/html

# SPA fallback: redirect all 404s to index.html for Vue Router
RUN printf 'server {\n  listen 80;\n  root /usr/share/nginx/html;\n  index index.html;\n  location / {\n    try_files $uri $uri/ /index.html;\n  }\n}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
