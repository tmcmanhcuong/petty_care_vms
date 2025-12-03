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
        <h2 class="text-base font-normal text-[#101828]">Viết bài mới</h2>
      </div>
    </div>

    <!-- Content -->
    <div class="flex-1 overflow-y-auto">
      <div class="flex gap-6 p-6">
        <!-- Main Content (Left) -->
        <div class="flex-1 flex flex-col gap-6">
          <!-- Title -->
          <input 
            v-model="title"
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
                v-model="slug"
                type="text" 
                class="flex-1 text-sm px-3 py-2 bg-[#f3f3f5] rounded-lg border-0 focus:ring-0"
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
              v-model="content"
              class="flex-1 min-h-[525px] px-[25px] pb-[25px] resize-none bg-[#f3f3f5] rounded-b-[14px] border-0 focus:ring-0 text-sm text-[#717182] placeholder:text-[#717182] font-['Tinos']"
              placeholder="Nhập nội dung bài viết..."
            ></textarea>
          </div>

          <!-- Excerpt -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Tóm tắt (Excerpt)</label>
            <textarea 
              v-model="excerpt"
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
                  type="checkbox" 
                  class="w-4 h-4 rounded bg-[#f3f3f5] border border-[rgba(0,0,0,0.1)] text-[#00a63e] focus:ring-0 focus:ring-offset-0"
                />
                <span class="text-sm font-medium text-neutral-950">🩺 Kiến thức Thú y</span>
              </label>
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  type="checkbox" 
                  class="w-4 h-4 rounded bg-[#f3f3f5] border border-[rgba(0,0,0,0.1)] text-[#00a63e] focus:ring-0 focus:ring-offset-0"
                />
                <span class="text-sm font-medium text-neutral-950">📢 Tin tức & Sự kiện</span>
              </label>
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  type="checkbox" 
                  class="w-4 h-4 rounded bg-[#f3f3f5] border border-[rgba(0,0,0,0.1)] text-[#00a63e] focus:ring-0 focus:ring-offset-0"
                />
                <span class="text-sm font-medium text-neutral-950">🎁 Khuyến mãi</span>
              </label>
              <button 
                @click="isAddCategoryModalOpen = true"
                class="w-full h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center gap-2 text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors mt-2"
              >
                <img :src="iconPlus" alt="Plus" class="w-4 h-4" />
                Thêm danh mục mới
              </button>
            </div>
          </div>

          <!-- Featured Image -->
          <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-6 flex flex-col gap-4">
            <h3 class="text-base font-medium text-neutral-950">Ảnh đại diện</h3>
            <div class="border-2 border-dashed border-[#d1d5dc] rounded-[10px] h-[152px] flex flex-col items-center justify-center gap-2">
              <img :src="iconImagePlaceholder" alt="Image" class="w-8 h-8" />
              <p class="text-sm text-[#4a5565]">Chưa có ảnh</p>
              <button class="h-8 px-[10px] bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center gap-2 text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors">
                <img :src="iconUpload" alt="Upload" class="w-4 h-4" />
                Upload ảnh
              </button>
            </div>
            <p class="text-xs text-[#6a7282]">Gợi ý: 1200x630px (tỷ lệ 16:9)</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Add Category Modal -->
    <div v-if="isAddCategoryModalOpen" class="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <ThemDanhMuc 
        @close="isAddCategoryModalOpen = false"
        @add-category="handleAddCategory" 
      />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import ThemDanhMuc from '../ThemDanhMuc/index.vue';

// Router
const router = useRouter();

// Form data
const title = ref('');
const slug = ref('');
const content = ref('');
const excerpt = ref('');

// Modal state
const isAddCategoryModalOpen = ref(false);

const handleAddCategory = (name) => {
  console.log('New category:', name);
  // Logic to add category to the list
  isAddCategoryModalOpen.value = false;
};

// Icons
const iconBack = "https://www.figma.com/api/mcp/asset/3f2733ca-4f38-4210-90ec-78d179d5943f";
const iconBold = "https://www.figma.com/api/mcp/asset/a9ebc27f-fb29-4cc3-9bd9-d71281cb979d";
const iconItalic = "https://www.figma.com/api/mcp/asset/e873520f-d287-4e8e-aa6b-bafc41b07232";
const iconUnderline = "https://www.figma.com/api/mcp/asset/dd034119-b589-49c1-b1a6-db5ae7beb58a";
const iconH1 = "https://www.figma.com/api/mcp/asset/c4bb48d6-0103-497d-98d1-a066a7a82382";
const iconH2 = "https://www.figma.com/api/mcp/asset/e8bad410-b603-468c-a7a3-23c69acdac18";
const iconH3 = "https://www.figma.com/api/mcp/asset/e6fb0145-609a-444e-a031-79afea4d1e52";
const iconList = "https://www.figma.com/api/mcp/asset/7b36897b-4f6c-4519-872f-69ae2ab6ad43";
const iconNumberList = "https://www.figma.com/api/mcp/asset/37f78a34-fdb6-41fa-b41f-2482a89d698a";
const iconAlignLeft = "https://www.figma.com/api/mcp/asset/3eec9697-b1ab-435e-b5a6-90b5891dab81";
const iconAlignCenter = "https://www.figma.com/api/mcp/asset/fe17cbd3-498e-4b94-8855-5bf75c4acf67";
const iconAlignRight = "https://www.figma.com/api/mcp/asset/d26f0125-27f8-47a1-8868-97faf295882e";
const iconImage = "https://www.figma.com/api/mcp/asset/5b841a31-c583-4c0c-a90a-fc5729e8b925";
const iconCheck = "https://www.figma.com/api/mcp/asset/dc075e9b-6178-427a-8248-ea72269f0dd7";
const iconPlus = "https://www.figma.com/api/mcp/asset/22db2fab-bc29-456a-925e-825a449a2093";
const iconImagePlaceholder = "https://www.figma.com/api/mcp/asset/4d6b4eb6-b356-40ad-bcb8-8cacf5aafb16";
const iconUpload = "https://www.figma.com/api/mcp/asset/d4889db0-d37e-4fa6-bcd4-66afa1cdc4b6";
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
