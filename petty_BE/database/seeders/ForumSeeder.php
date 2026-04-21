<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\BinhLuan;
use App\Models\Reaction;
use App\Models\BaiViet;
use App\Models\KhachHang;
use App\Models\NhanVien;

class ForumSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Get some posts
        $baiViets = BaiViet::take(3)->get();
        
        if ($baiViets->isEmpty()) {
            $this->command->info('No posts found. Please create some posts first.');
            return;
        }

        // Get some users
        $khachHangs = KhachHang::take(3)->get();
        $nhanViens = NhanVien::take(2)->get();

        if ($khachHangs->isEmpty() && $nhanViens->isEmpty()) {
            $this->command->info('No users found. Please create some users first.');
            return;
        }

        // Create comments for each post
        foreach ($baiViets as $baiViet) {
            // Create 3-5 comments per post
            $commentCount = rand(3, 5);
            
            for ($i = 0; $i < $commentCount; $i++) {
                $isKhachHang = rand(0, 1);
                
                $commentData = [
                    'noi_dung' => $this->getRandomComment(),
                    'bai_viet_id' => $baiViet->id,
                    'trang_thai' => 'active',
                ];

                if ($isKhachHang && $khachHangs->isNotEmpty()) {
                    $commentData['khach_hang_id'] = $khachHangs->random()->id;
                } elseif ($nhanViens->isNotEmpty()) {
                    $commentData['nhan_vien_id'] = $nhanViens->random()->id;
                }

                $comment = BinhLuan::create($commentData);

                // Create 1-2 replies for some comments
                if (rand(0, 1)) {
                    $replyCount = rand(1, 2);
                    for ($j = 0; $j < $replyCount; $j++) {
                        $isKhachHangReply = rand(0, 1);
                        
                        $replyData = [
                            'noi_dung' => $this->getRandomReply(),
                            'bai_viet_id' => $baiViet->id,
                            'parent_id' => $comment->id,
                            'trang_thai' => 'active',
                        ];

                        if ($isKhachHangReply && $khachHangs->isNotEmpty()) {
                            $replyData['khach_hang_id'] = $khachHangs->random()->id;
                        } elseif ($nhanViens->isNotEmpty()) {
                            $replyData['nhan_vien_id'] = $nhanViens->random()->id;
                        }

                        BinhLuan::create($replyData);
                    }
                }

                // Add reactions to comment
                $this->addRandomReactions($comment, $khachHangs, $nhanViens);
            }

            // Add reactions to post
            $this->addRandomReactions($baiViet, $khachHangs, $nhanViens);
        }

        $this->command->info('Forum data seeded successfully!');
    }

    private function addRandomReactions($model, $khachHangs, $nhanViens)
    {
        $reactionCount = rand(2, 5);
        $usedUsers = [];

        for ($i = 0; $i < $reactionCount; $i++) {
            $isKhachHang = rand(0, 1);
            $loai = rand(0, 10) > 2 ? 'like' : 'dislike'; // 80% like, 20% dislike

            $reactionData = [
                'loai' => $loai,
                'reactionable_type' => get_class($model),
                'reactionable_id' => $model->id,
            ];

            if ($isKhachHang && $khachHangs->isNotEmpty()) {
                $khachHang = $khachHangs->random();
                $userId = 'kh_' . $khachHang->id;
                
                if (in_array($userId, $usedUsers)) continue;
                
                $reactionData['khach_hang_id'] = $khachHang->id;
                $usedUsers[] = $userId;
            } elseif ($nhanViens->isNotEmpty()) {
                $nhanVien = $nhanViens->random();
                $userId = 'nv_' . $nhanVien->id;
                
                if (in_array($userId, $usedUsers)) continue;
                
                $reactionData['nhan_vien_id'] = $nhanVien->id;
                $usedUsers[] = $userId;
            }

            try {
                Reaction::create($reactionData);
            } catch (\Exception $e) {
                // Skip if duplicate
                continue;
            }
        }
    }

    private function getRandomComment()
    {
        $comments = [
            'Bài viết rất hữu ích, cảm ơn bạn đã chia sẻ!',
            'Thông tin rất bổ ích cho những người nuôi thú cưng như tôi.',
            'Mình đã áp dụng và thấy hiệu quả rồi, cảm ơn nhiều!',
            'Có thể giải thích rõ hơn về phần này được không?',
            'Bài viết hay quá, mình sẽ lưu lại để tham khảo.',
            'Cảm ơn bác sĩ đã chia sẻ kinh nghiệm quý báu!',
            'Rất chi tiết và dễ hiểu, cảm ơn admin!',
            'Mình cũng gặp vấn đề tương tự, cảm ơn bạn đã giải đáp.',
        ];

        return $comments[array_rand($comments)];
    }

    private function getRandomReply()
    {
        $replies = [
            'Cảm ơn bạn đã quan tâm!',
            'Rất vui vì bài viết giúp ích được cho bạn.',
            'Nếu có thắc mắc gì thêm, cứ hỏi nhé!',
            'Chúc bạn và thú cưng luôn khỏe mạnh!',
            'Mình sẽ viết thêm bài chi tiết về vấn đề này.',
            'Bạn có thể tham khảo thêm các bài viết khác của mình.',
        ];

        return $replies[array_rand($replies)];
    }
}
