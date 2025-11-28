<template>
  <div class="flex flex-col h-full bg-[#f3f3f5]">
    <div class="bg-white rounded-[14px] flex flex-col shadow-sm overflow-hidden h-full">
      <!-- Header -->
      <div class="flex items-center justify-between px-6 py-4 border-b border-gray-200">
        <div class="flex items-center gap-4">
          <button @click="router.back()" class="hover:bg-gray-100 p-2 rounded-lg transition-colors">
            <img :src="iconBack" alt="Back" class="w-4 h-4" />
          </button>
          <h2 class="text-lg font-semibold text-neutral-950">Chỉnh sửa bài viết</h2>
        </div>
        <div class="flex gap-2">
          <button class="px-4 py-2 border border-gray-200 rounded-lg text-sm font-medium hover:bg-gray-50">
            Xem thử
          </button>
          <button class="px-4 py-2 border border-gray-200 rounded-lg text-sm font-medium hover:bg-gray-50">
            Lưu nháp
          </button>
          <button class="px-4 py-2 bg-[#00a63e] text-white rounded-lg text-sm font-medium hover:bg-[#008c35]">
            Cập nhật
          </button>
        </div>
      </div>

      <!-- Content -->
      <div class="flex-1 overflow-y-auto bg-[#f3f3f5] p-6">
        <div class="flex gap-6">
          <!-- Main Content (Left) -->
          <div class="flex-1 flex flex-col gap-6">
            <!-- Title -->
            <input 
              type="text" 
              v-model="post.title"
              placeholder="Nhập tiêu đề bài viết tại đây..." 
              class="w-full text-xl font-medium px-4 py-3 rounded-lg border-0 focus:ring-2 focus:ring-[#009689]"
            />

            <!-- Slug -->
            <div class="flex flex-col gap-2">
              <label class="text-sm font-medium text-[#4a5565]">Đường dẫn tĩnh (Slug)</label>
              <div class="flex items-center bg-white rounded-lg px-3 py-2 border border-gray-200">
                <span class="text-[#6a7282] text-sm">petty.vn/</span>
                <input type="text" v-model="post.slug" class="flex-1 border-0 focus:ring-0 text-sm p-0 ml-1" />
              </div>
            </div>

            <!-- Editor -->
            <div class="bg-white rounded-[14px] border border-gray-200 flex flex-col h-[500px]">
              <!-- Toolbar -->
              <div class="flex items-center gap-2 p-2 border-b border-gray-200 overflow-x-auto">
                <button v-for="i in 10" :key="i" class="p-2 hover:bg-gray-100 rounded">
                  <div class="w-4 h-4 bg-gray-400 rounded-sm"></div>
                </button>
              </div>
              <!-- Textarea -->
              <textarea 
                v-model="post.content"
                class="flex-1 p-4 resize-none border-0 focus:ring-0"
                placeholder="Nhập nội dung bài viết..."
              ></textarea>
            </div>

            <!-- Excerpt -->
            <div class="flex flex-col gap-2">
              <label class="text-sm font-medium text-neutral-950">Tóm tắt (Excerpt)</label>
              <textarea 
                v-model="post.excerpt"
                rows="3"
                class="w-full px-4 py-2 rounded-lg border-0 focus:ring-2 focus:ring-[#009689]"
                placeholder="Mô tả ngắn hiển thị khi share Facebook/Zalo..."
              ></textarea>
              <p class="text-xs text-[#6a7282]">Gợi ý: 150-160 ký tự để hiển thị tốt trên social media</p>
            </div>
          </div>

          <!-- Sidebar (Right) -->
          <div class="w-[350px] flex flex-col gap-6">
            <!-- Publish Status -->
            <div class="bg-white rounded-[14px] p-6 border border-gray-200 flex flex-col gap-4">
              <h3 class="font-medium text-neutral-950">Đăng (Publish)</h3>
              <div class="flex flex-col gap-2">
                <label class="text-sm font-medium text-[#4a5565]">Trạng thái hiện tại</label>
                <p class="text-sm text-[#101828]">{{ post.statusLabel }}</p>
              </div>
            </div>

            <!-- Categories -->
            <div class="bg-white rounded-[14px] p-6 border border-gray-200 flex flex-col gap-4">
              <h3 class="font-medium text-neutral-950">Phân loại</h3>
              <div class="flex flex-col gap-3">
                <label class="flex items-center gap-2">
                  <input type="checkbox" v-model="post.categories" value="knowledge" class="rounded text-[#009689] focus:ring-[#009689]" />
                  <span class="text-sm text-neutral-950">🩺 Kiến thức Thú y</span>
                </label>
                <label class="flex items-center gap-2">
                  <input type="checkbox" v-model="post.categories" value="news" class="rounded text-[#009689] focus:ring-[#009689]" />
                  <span class="text-sm text-neutral-950">📢 Tin tức & Sự kiện</span>
                </label>
                <label class="flex items-center gap-2">
                  <input type="checkbox" v-model="post.categories" value="promotion" class="rounded text-[#009689] focus:ring-[#009689]" />
                  <span class="text-sm text-neutral-950">🎁 Khuyến mãi</span>
                </label>
                <button class="flex items-center gap-2 text-[#009689] text-sm font-medium mt-2">
                  <span class="text-lg">+</span> Thêm danh mục mới
                </button>
              </div>
            </div>

            <!-- Featured Image -->
            <div class="bg-white rounded-[14px] p-6 border border-gray-200 flex flex-col gap-4">
              <h3 class="font-medium text-neutral-950">Ảnh đại diện</h3>
              <div class="border-2 border-dashed border-gray-300 rounded-lg h-[150px] flex flex-col items-center justify-center gap-2 relative overflow-hidden">
                <img v-if="post.thumbnail" :src="post.thumbnail" class="absolute inset-0 w-full h-full object-cover" />
                <div v-else class="flex flex-col items-center gap-2">
                  <div class="w-8 h-8 bg-gray-200 rounded-full"></div>
                  <p class="text-sm text-[#4a5565]">Chưa có ảnh</p>
                </div>
                <button class="px-3 py-1 border border-gray-200 rounded text-sm hover:bg-gray-50 bg-white z-10 shadow-sm">
                  Upload ảnh
                </button>
              </div>
              <p class="text-xs text-[#6a7282]">Gợi ý: 1200x630px (tỷ lệ 16:9)</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';

// Router
const router = useRouter();
const route = useRoute();

// Icons
const iconBack = "https://www.figma.com/api/mcp/asset/222dbe18-e596-41f0-905b-cf09aa5d7b51"

// Post Data (Mock)
const post = ref({
  title: 'Cách chăm sóc chó Poodle: Hướng dẫn từ A đến Z',
  slug: 'cach-cham-soc-cho-poodle',
  content: 'Nội dung bài viết...',
  excerpt: 'Mô tả ngắn hiển thị khi share Facebook/Zalo...',
  status: 'published',
  statusLabel: 'Đã xuất bản',
  categories: ['knowledge'],
  thumbnail: 'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e'
});

onMounted(() => {
  // In a real app, fetch post data using route.params.id
  console.log('Editing post ID:', route.params.id);
});
</script>

<style scoped>
.font-nunito {
  font-family: 'Nunito Sans', sans-serif;
}
</style>
