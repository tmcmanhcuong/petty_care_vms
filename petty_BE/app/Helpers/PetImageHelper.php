<?php

namespace App\Helpers;

class PetImageHelper
{
    /**
     * Lấy ảnh mặc định cho thú cưng dựa trên loại và giới tính
     * 
     * @param string $loai Loại thú cưng: 'cho', 'meo', 'khac'
     * @param string|null $gioiTinh Giới tính: 'duc', 'cai', null
     * @return string URL của ảnh mặc định
     */
    public static function getDefaultImage($loai, $gioiTinh = null)
    {
        $loai = strtolower($loai);
        $gioiTinh = $gioiTinh ? strtolower($gioiTinh) : null;

        // Xác định tên file ảnh mặc định
        $imageName = match(true) {
            $loai === 'cho' && $gioiTinh === 'duc' => 'choduc.jpg',
            $loai === 'cho' && $gioiTinh === 'cai' => 'chocai.jpg',
            $loai === 'cho' => 'choduc.jpg', // Mặc định chó đực nếu không có giới tính
            $loai === 'meo' => 'meo.jpg',
            default => 'thucungkhac.jpg',
        };

        return url('images/default-pets/' . $imageName);
    }

    /**
     * Kiểm tra xem có phải ảnh mặc định không
     * 
     * @param string|null $imageUrl
     * @return bool
     */
    public static function isDefaultImage($imageUrl)
    {
        if (!$imageUrl) {
            return true;
        }

        $defaultImages = ['choduc.jpg', 'chocai.jpg', 'meo.jpg', 'thucungkhac.jpg'];
        
        foreach ($defaultImages as $defaultImage) {
            if (str_contains($imageUrl, $defaultImage)) {
                return true;
            }
        }

        return false;
    }
}
