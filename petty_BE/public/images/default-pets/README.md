# Ảnh Mặc Định Thú Cưng

Thư mục này chứa các ảnh mặc định cho thú cưng khi người dùng không upload ảnh.

## Danh sách ảnh:

- **choduc.jpg** - Ảnh mặc định cho chó đực
- **chocai.jpg** - Ảnh mặc định cho chó cái
- **meo.jpg** - Ảnh mặc định cho mèo (cả đực và cái)
- **thucungkhac.jpg** - Ảnh mặc định cho các loại thú cưng khác

## Cách hoạt động:

Hệ thống tự động chọn ảnh mặc định dựa trên:
1. **Loại thú cưng** (loai_thu_cung): 'cho', 'meo', 'khac'
2. **Giới tính** (gioi_tinh): 'duc', 'cai'

### Logic chọn ảnh:
- Chó + Đực → choduc.jpg
- Chó + Cái → chocai.jpg
- Chó (không rõ giới tính) → choduc.jpg
- Mèo (bất kỳ giới tính) → meo.jpg
- Loại khác → thucungkhac.jpg

## URL truy cập:

```
http://localhost:8000/images/default-pets/choduc.jpg
http://localhost:8000/images/default-pets/chocai.jpg
http://localhost:8000/images/default-pets/meo.jpg
http://localhost:8000/images/default-pets/thucungkhac.jpg
```

## Sử dụng trong code:

```php
use App\Helpers\PetImageHelper;

// Lấy ảnh mặc định
$imageUrl = PetImageHelper::getDefaultImage('cho', 'duc');
// Kết quả: http://localhost:8000/images/default-pets/choduc.jpg

// Kiểm tra có phải ảnh mặc định không
$isDefault = PetImageHelper::isDefaultImage($imageUrl);
```
