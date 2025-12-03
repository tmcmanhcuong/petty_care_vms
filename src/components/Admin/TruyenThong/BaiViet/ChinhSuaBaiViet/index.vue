<template>
  <div class="bg-white flex flex-col h-full">
    <!-- Header -->
    <div class="bg-white border-b border-gray-200 flex items-center h-[69px] px-6 py-4">
      <div class="flex items-center gap-4">
        <button 
          @click="router.back()" 
          class="flex items-center justify-center w-9 h-9 hover:bg-gray-100 rounded-lg transition-colors"
        >
          <img :src="iconBack" alt="Back" class="w-4 h-4" />
        </button>
        <div class="border-l border-[#d1d5dc] h-6"></div>
        <h2 class="text-base font-normal text-[#101828]">Chỉnh sửa bài viết</h2>
      </div>
    </div>

    <!-- Content -->
    <div class="flex-1 overflow-y-auto">
      <div class="flex gap-6 p-6">
        <!-- Main Content (Left) -->
        <div class="flex-1 flex flex-col gap-6">
          <!-- Title -->
          <input 
            v-model="post.title"
            type="text" 
            placeholder="Nhập tiêu đề bài viết tại đây..." 
            class="w-full text-sm px-4 py-2 bg-[#f3f3f5] rounded-lg border-0 focus:ring-0 text-[#717182] placeholder:text-[#717182]"
          />

          <!-- Slug -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-[#4a5565]">Đường dẫn tĩnh (Slug)</label>
            <div class="flex items-center gap-2">
              <span class="text-sm text-[#6a7282]">petty.vn/</span>
              <input 
                v-model="post.slug"
                type="text" 
                class="flex-1 text-sm px-3 py-2 bg-[#f3f3f5] rounded-lg border-0 focus:ring-0 text-neutral-950"
              />
            </div>
          </div>

          <!-- Editor -->
          <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] flex flex-col">
            <!-- Toolbar -->
            <div class="flex items-center gap-3 p-[25px] pb-[30px]">
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconBold" alt="Bold" class="w-4 h-4" />
              </button>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconItalic" alt="Italic" class="w-4 h-4" />
              </button>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconUnderline" alt="Underline" class="w-4 h-4" />
              </button>
              <div class="border-l border-[#d1d5dc] h-6"></div>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconH1" alt="H1" class="w-4 h-4" />
              </button>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconH2" alt="H2" class="w-4 h-4" />
              </button>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconH3" alt="H3" class="w-4 h-4" />
              </button>
              <div class="border-l border-[#d1d5dc] h-6"></div>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconList" alt="List" class="w-4 h-4" />
              </button>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconNumberList" alt="Number List" class="w-4 h-4" />
              </button>
              <div class="border-l border-[#d1d5dc] h-6"></div>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconAlignLeft" alt="Align Left" class="w-4 h-4" />
              </button>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconAlignCenter" alt="Align Center" class="w-4 h-4" />
              </button>
              <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50">
                <img :src="iconAlignRight" alt="Align Right" class="w-4 h-4" />
              </button>
              <div class="border-l border-[#d1d5dc] h-6"></div>
              <button class="h-8 px-[10px] bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center gap-2 hover:bg-gray-50">
                <img :src="iconImage" alt="Image" class="w-4 h-4" />
                <span class="text-sm font-medium text-neutral-950">Chèn ảnh/Video</span>
              </button>
            </div>
            <!-- Textarea -->
            <textarea 
              v-model="post.content"
              class="flex-1 min-h-[525px] px-[25px] pb-[25px] resize-none bg-[#f3f3f5] rounded-b-[14px] border-0 focus:ring-0 text-sm text-[#717182] placeholder:text-[#717182] font-['Tinos']"
              placeholder="Nhập nội dung bài viết..."
            ></textarea>
          </div>

          <!-- Excerpt -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Tóm tắt (Excerpt)</label>
            <textarea 
              v-model="post.excerpt"
              rows="3"
              class="w-full px-3 py-2 bg-[#f3f3f5] rounded-lg border-0 focus:ring-0 text-sm text-[#717182] placeholder:text-[#717182]"
              placeholder="Mô tả ngắn hiển thị khi share Facebook/Zalo..."
            ></textarea>
            <p class="text-xs text-[#6a7282]">Gợi ý: 150-160 ký tự để hiển thị tốt trên social media</p>
          </div>
        </div>

        <!-- Sidebar (Right) -->
        <div class="w-[353px] flex flex-col gap-6">
          <!-- Publish Status -->
          <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-6 flex flex-col gap-4">
            <h3 class="text-base font-medium text-neutral-950">Đăng (Publish)</h3>
            <button class="w-full h-9 bg-[#00a63e] text-white rounded-lg flex items-center justify-center gap-2 text-sm font-medium hover:bg-[#008c35] transition-colors">
              <img :src="iconCheck" alt="Check" class="w-4 h-4" />
              Xuất bản
            </button>
          </div>

          <!-- Categories -->
          <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-6 flex flex-col gap-4">
            <h3 class="text-base font-medium text-neutral-950">Phân loại</h3>
            <div class="flex flex-col gap-3">
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  v-model="post.categories"
                  value="knowledge"
                  type="checkbox" 
                  class="w-4 h-4 rounded bg-[#030213] border border-[#030213] text-[#00a63e] focus:ring-0 focus:ring-offset-0"
                />
                <span class="text-sm font-medium text-neutral-950">🩺 Kiến thức Thú y</span>
              </label>
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  v-model="post.categories"
                  value="news"
                  type="checkbox" 
                  class="w-4 h-4 rounded bg-[#f3f3f5] border border-[rgba(0,0,0,0.1)] text-[#00a63e] focus:ring-0 focus:ring-offset-0"
                />
                <span class="text-sm font-medium text-neutral-950">📢 Tin tức & Sự kiện</span>
              </label>
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  v-model="post.categories"
                  value="promotion"
                  type="checkbox" 
                  class="w-4 h-4 rounded bg-[#f3f3f5] border border-[rgba(0,0,0,0.1)] text-[#00a63e] focus:ring-0 focus:ring-offset-0"
                />
                <span class="text-sm font-medium text-neutral-950">🎁 Khuyến mãi</span>
              </label>
              <button class="w-full h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center gap-2 text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors mt-2">
                <img :src="iconPlus" alt="Plus" class="w-4 h-4" />
                Thêm danh mục mới
              </button>
            </div>
          </div>

          <!-- Featured Image -->
          <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-6 flex flex-col gap-4">
            <h3 class="text-base font-medium text-neutral-950">Ảnh đại diện</h3>
            <div class="relative h-[128px] bg-gray-100 rounded overflow-hidden">
              <img v-if="post.thumbnail" :src="post.thumbnail" class="w-full h-full object-cover" />
              <button 
                @click="removeImage"
                class="absolute top-2 right-2 w-9 h-8 bg-[#d4183d] text-white rounded-lg flex items-center justify-center hover:bg-[#b01432] transition-colors"
              >
                <img :src="iconTrash" alt="Delete" class="w-4 h-4" />
              </button>
            </div>
            <p class="text-xs text-[#6a7282]">Gợi ý: 1200x630px (tỷ lệ 16:9)</p>
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
const iconBack = "https://www.figma.com/api/mcp/asset/5e128e4f-26a0-4df7-8d47-9ecda4c56d4c";
const iconBold = "https://www.figma.com/api/mcp/asset/106874c1-e3c4-4da5-a149-2c8e4b7f5639";
const iconItalic = "https://www.figma.com/api/mcp/asset/b41f26cc-d0df-491d-81c5-184c4dd0d3be";
const iconUnderline = "https://www.figma.com/api/mcp/asset/d167c75d-986e-4e02-88f2-41f1e870f54d";
const iconH1 = "https://www.figma.com/api/mcp/asset/987ef401-4438-4f9a-939c-12969ca04c12";
const iconH2 = "https://www.figma.com/api/mcp/asset/00e77e58-f523-4e3a-9aa8-156de6669040";
const iconH3 = "https://www.figma.com/api/mcp/asset/982b0fb4-5a41-46b3-a318-4bc6843b66ba";
const iconList = "https://www.figma.com/api/mcp/asset/14a76ad9-4465-4dfc-b653-26dcd85dfee9";
const iconNumberList = "https://www.figma.com/api/mcp/asset/6984cde9-87cd-41aa-bcac-78e767b35430";
const iconAlignLeft = "https://www.figma.com/api/mcp/asset/a1410641-8671-4cd9-87f5-1aca4e512df9";
const iconAlignCenter = "https://www.figma.com/api/mcp/asset/3b9cc00e-c3e7-4f56-9edb-75a8e3798699";
const iconAlignRight = "https://www.figma.com/api/mcp/asset/a42f83cd-2f74-4e40-aef7-43656c646d00";
const iconImage = "https://www.figma.com/api/mcp/asset/88e192cd-0858-4dfd-b07f-3d1cf5616499";
const iconCheck = "https://www.figma.com/api/mcp/asset/ffec0959-6b87-41c2-8fa5-eb02934bfb81";
const iconPlus = "https://www.figma.com/api/mcp/asset/4ec6f8f5-721f-46e7-a846-7a33148be482";
const iconTrash = "https://www.figma.com/api/mcp/asset/e4c06032-6550-4cf9-b2dd-2c6bf3718cfe";

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

const removeImage = () => {
  post.value.thumbnail = null;
};

onMounted(() => {
  // In a real app, fetch post data using route.params.id
  console.log('Editing post ID:', route.params.id);
});
</script>

<style scoped>
/* Custom font for textarea */
textarea {
  font-family: 'Tinos', serif;
}

/* Remove focus outline for all inputs */
input:focus,
textarea:focus {
  outline: none;
}
</style>
