# ERR-002 — IAM User thiếu quyền ECR (AccessDeniedException)

**Ngày gặp:** 2026-04-16  
**Task liên quan:** Task 4.3 — Test push image lên ECR  
**User bị lỗi:** `arn:aws:iam::493499579600:user/github-actions-deployer`

---

## ❌ Lỗi gặp phải

```
aws: [ERROR]: An error occurred (AccessDeniedException) when calling the GetAuthorizationToken operation:
User: arn:aws:iam::493499579600:user/github-actions-deployer is not authorized to perform:
ecr:GetAuthorizationToken on resource: * because no identity-based policy allows the ecr:GetAuthorizationToken action
```

## 🔍 Nguyên nhân

IAM user `github-actions-deployer` được cấu hình trong AWS CLI local chưa được gắn policy ECR.  
`ecr:GetAuthorizationToken` là bước đầu tiên để login vào ECR — thiếu quyền này thì không push/pull được.

## ✅ Cách giải quyết

### Vào IAM Console → gắn policy cho user

1. Vào **IAM** → **Users** → chọn `github-actions-deployer`
2. Tab **Permissions** → **Add permissions** → **Attach policies directly**
3. Tìm và chọn policy: **`AmazonEC2ContainerRegistryPowerUser`**
4. Click **Next** → **Add permissions**

Policy này cho phép: push/pull images, login ECR, xem repositories.

### Chạy lại sau khi gắn policy:
```bash
aws ecr get-login-password --region ap-southeast-1 | \
  docker login --username AWS --password-stdin \
  493499579600.dkr.ecr.ap-southeast-1.amazonaws.com
```
