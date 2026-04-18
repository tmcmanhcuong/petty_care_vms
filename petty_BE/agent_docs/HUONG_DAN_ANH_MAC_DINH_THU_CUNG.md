# Hướng Dẫn Hệ Thống Ảnh Mặc Định Thú Cưng

## 📋 Tổng Quan

Hệ thống tự động gán ảnh mặc định cho thú cưng khi người dùng không upload ảnh, dựa trên loại thú cưng và giới tính.

## 🖼️ Các Ảnh Mặc Định

Ảnh được lưu tại: `public/images/default-pets/`

| File | Mô tả | Khi nào sử dụng |
|------|-------|-----------------|
| `choduc.jpg` | Chó đực | Loại = "cho" + Giới tính = "duc" |
| `chocai.jpg` | Chó cái | Loại = "cho" + Giới tính = "cai" |
| `meo.jpg` | Mèo | Loại = "meo" (bất kỳ giới tính) |
| `thucungkhac.jpg` | Thú cưng khác | Loại khác hoặc không xác định |

## 🔧 Cách Hoạt Động

### 1. Khi Tạo Thú Cưng Mới (POST /api/thu-cung)

```json
{
  "ten_thu_cung": "Miu",
  "loai_thu_cung": "meo",
  "gioi_tinh": "cai",
  "giong_thu_cung": "Ba Tư",
  "tuoi_thu_cung": "2023-01-15",
  "can_nang": "3.5"
  // Không có anh_dai_dien
}
```

**Kết quả:**
- Hệ thống tự động gán: `anh_dai_dien = "http://localhost:8000/images/default-pets/meo.jpg"`

### 2. Khi Lấy Danh Sách Thú Cưng (GET /api/thu-cung)

Response sẽ có field `anh_dai_dien_url`:

```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "ten_thu_cung": "Miu",
      "loai_thu_cung": "meo",
      "gioi_tinh": "cai",
      "anh_dai_dien": null,
      "anh_dai_dien_url": "http://localhost:8000/images/default-pets/meo.jpg"
    }
  ]
}
```

### 3. Logic Chọn Ảnh

```php
// Trong PetImageHelper::getDefaultImage()

match(true) {
    $loai === 'cho' && $gioiTinh === 'duc' => 'choduc.jpg',
    $loai === 'cho' && $gioiTinh === 'cai' => 'chocai.jpg',
    $loai === 'cho' => 'choduc.jpg', // Mặc định chó đực
    $loai === 'meo' => 'meo.jpg',
    default => 'thucungkhac.jpg',
}
```

## 📝 Sử dụng Helper

### Import Helper

```php
use App\Helpers\PetImageHelper;
```

### Lấy Ảnh Mặc Định

```php
// Chó đực
$url = PetImageHelper::getDefaultImage('cho', 'duc');
// Kết quả: http://localhost:8000/images/default-pets/choduc.jpg

// Chó cái
$url = PetImageHelper::getDefaultImage('cho', 'cai');
// Kết quả: http://localhost:8000/images/default-pets/chocai.jpg

// Mèo (giới tính không quan trọng)
$url = PetImageHelper::getDefaultImage('meo', 'duc');
$url = PetImageHelper::getDefaultImage('meo', 'cai');
$url = PetImageHelper::getDefaultImage('meo', null);
// Tất cả đều trả về: http://localhost:8000/images/default-pets/meo.jpg

// Thú cưng khác
$url = PetImageHelper::getDefaultImage('tho', null);
$url = PetImageHelper::getDefaultImage('chim', null);
// Kết quả: http://localhost:8000/images/default-pets/thucungkhac.jpg
```

### Kiểm Tra Ảnh Mặc Định

```php
$imageUrl = "http://localhost:8000/images/default-pets/meo.jpg";
$isDefault = PetImageHelper::isDefaultImage($imageUrl);
// Kết quả: true

$imageUrl = "http://localhost:8000/storage/thu_cungs/abc123.jpg";
$isDefault = PetImageHelper::isDefaultImage($imageUrl);
// Kết quả: false

$imageUrl = null;
$isDefault = PetImageHelper::isDefaultImage($imageUrl);
// Kết quả: true (null cũng được coi là mặc định)
```

## 🎨 Frontend Integration

### Vue.js Example

```vue
<template>
  <div class="pet-card">
    <img 
      :src="pet.anh_dai_dien_url" 
      :alt="pet.ten_thu_cung"
      @error="handleImageError"
    />
    <h3>{{ pet.ten_thu_cung }}</h3>
  </div>
</template>

<script setup>
const handleImageError = (event) => {
  // Fallback nếu ảnh không load được
  event.target.src = '/images/default-pets/thucungkhac.jpg';
};
</script>
```

### React Example

```jsx
function PetCard({ pet }) {
  const handleImageError = (e) => {
    e.target.src = '/images/default-pets/thucungkhac.jpg';
  };

  return (
    <div className="pet-card">
      <img 
        src={pet.anh_dai_dien_url} 
        alt={pet.ten_thu_cung}
        onError={handleImageError}
      />
      <h3>{pet.ten_thu_cung}</h3>
    </div>
  );
}
```

## 🔄 Cập Nhật Ảnh Mặc Định

### Thay Thế Ảnh Hiện Có

1. Chuẩn bị ảnh mới (định dạng: jpg, png, webp)
2. Đặt tên file giống như cũ: `choduc.jpg`, `chocai.jpg`, `meo.jpg`, `thucungkhac.jpg`
3. Copy vào thư mục: `public/images/default-pets/`
4. Xóa cache trình duyệt (Ctrl + F5)

### Thêm Ảnh Mới Cho Loại Thú Cưng Khác

**Ví dụ: Thêm ảnh cho thỏ**

1. Thêm file `tho.jpg` vào `public/images/default-pets/`

2. Cập nhật `PetImageHelper.php`:

```php
$imageName = match(true) {
    $loai === 'cho' && $gioiTinh === 'duc' => 'choduc.jpg',
    $loai === 'cho' && $gioiTinh === 'cai' => 'chocai.jpg',
    $loai === 'cho' => 'choduc.jpg',
    $loai === 'meo' => 'meo.jpg',
    $loai === 'tho' => 'tho.jpg', // ← Thêm dòng này
    default => 'thucungkhac.jpg',
};
```

3. Cập nhật method `isDefaultImage()`:

```php
$defaultImages = [
    'choduc.jpg', 
    'chocai.jpg', 
    'meo.jpg', 
    'tho.jpg', // ← Thêm dòng này
    'thucungkhac.jpg'
];
```

## 🧪 Test API

### Test 1: Tạo Thú Cưng Không Có Ảnh

```bash
POST http://localhost:8000/api/thu-cung
Authorization: Bearer {token}
Content-Type: application/json

{
  "ten_thu_cung": "Bông",
  "loai_thu_cung": "cho",
  "gioi_tinh": "cai",
  "giong_thu_cung": "Poodle",
  "tuoi_thu_cung": "2022-05-10",
  "can_nang": "4.2"
}
```

**Expected Response:**
```json
{
  "status": true,
  "data": {
    "id": 1,
    "ten_thu_cung": "Bông",
    "loai_thu_cung": "cho",
    "gioi_tinh": "cai",
    "anh_dai_dien": "http://localhost:8000/images/default-pets/chocai.jpg",
    "anh_dai_dien_url": "http://localhost:8000/images/default-pets/chocai.jpg"
  }
}
```

### Test 2: Lấy Danh Sách Thú Cưng

```bash
GET http://localhost:8000/api/thu-cung
Authorization: Bearer {token}
```

**Expected Response:**
```json
{
  "status": true,
  "data": [
    {
      "id": 1,
      "ten_thu_cung": "Bông",
      "anh_dai_dien": null,
      "anh_dai_dien_url": "http://localhost:8000/images/default-pets/chocai.jpg"
    },
    {
      "id": 2,
      "ten_thu_cung": "Miu",
      "anh_dai_dien": null,
      "anh_dai_dien_url": "http://localhost:8000/images/default-pets/meo.jpg"
    }
  ]
}
```

### Test 3: Upload Ảnh Tùy Chỉnh

```bash
POST http://localhost:8000/api/thu-cung
Authorization: Bearer {token}
Content-Type: multipart/form-data

ten_thu_cung: "Max"
loai_thu_cung: "cho"
gioi_tinh: "duc"
giong_thu_cung: "Golden Retriever"
tuoi_thu_cung: "2021-03-20"
can_nang: "25.5"
anh_dai_dien: [file upload]
```

**Expected Response:**
```json
{
  "status": true,
  "data": {
    "id": 3,
    "ten_thu_cung": "Max",
    "anh_dai_dien": "thu_cungs/abc123xyz.jpg",
    "anh_dai_dien_url": "http://localhost:8000/storage/thu_cungs/abc123xyz.jpg"
  }
}
```

## 📊 Bảng Quyết Định

| Loại | Giới tính | Ảnh mặc định |
|------|-----------|--------------|
| cho | duc | choduc.jpg |
| cho | cai | chocai.jpg |
| cho | null | choduc.jpg |
| meo | duc | meo.jpg |
| meo | cai | meo.jpg |
| meo | null | meo.jpg |
| tho | * | thucungkhac.jpg |
| chim | * | thucungkhac.jpg |
| khac | * | thucungkhac.jpg |
| null | * | thucungkhac.jpg |

## 🚨 Lưu Ý

1. **Không xóa ảnh mặc định** - Hệ thống phụ thuộc vào các file này
2. **Kích thước ảnh** - Nên tối ưu ảnh (< 100KB) để tải nhanh
3. **Định dạng** - Khuyến nghị: JPG hoặc WebP
4. **Tên file** - Không đổi tên file, chỉ thay thế nội dung
5. **Cache** - Sau khi thay ảnh, xóa cache trình duyệt

## 🔍 Troubleshooting

### Ảnh không hiển thị

**Nguyên nhân:** File không tồn tại hoặc quyền truy cập

**Giải pháp:**
```bash
# Kiểm tra file tồn tại
ls public/images/default-pets/

# Kiểm tra quyền
chmod 644 public/images/default-pets/*.jpg
```

### Ảnh bị lỗi 404

**Nguyên nhân:** URL không đúng

**Giải pháp:**
- Kiểm tra `APP_URL` trong `.env`
- Đảm bảo file tồn tại trong `public/images/default-pets/`

### Ảnh cũ vẫn hiển thị sau khi thay

**Nguyên nhân:** Cache trình duyệt

**Giải pháp:**
- Xóa cache: Ctrl + Shift + Delete
- Hard refresh: Ctrl + F5
- Thêm version query: `?v=2` vào URL

## 📚 Tài Liệu Liên Quan

- [ThuCungController.php](../app/Http/Controllers/ThuCungController.php)
- [PetImageHelper.php](../app/Helpers/PetImageHelper.php)
- [API Routes](../routes/api.php)
