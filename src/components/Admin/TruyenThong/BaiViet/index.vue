<template>
  <div class="flex flex-col gap-6 w-full font-nunito">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div class="flex flex-col">
        <h1 class="text-2xl font-medium text-[#101828] leading-9">Quản lý Bài viết</h1>
        <p class="text-base text-[#4a5565] leading-6">Tạo và quản lý nội dung cho website</p>
      </div>
      <button 
        @click="router.push('/admin/bai-viet/them-moi')"
        class="bg-[#00a63e] text-white rounded-lg px-4 py-2 h-9 flex items-center gap-2 text-sm font-medium hover:bg-[#008c35] transition-colors"
      >
        <img :src="iconPlus" alt="" class="w-4 h-4" />
        Viết bài mới
      </button>
    </div>

    <!-- Search and Filters -->
    <div class="bg-white border border-black/10 rounded-[14px] p-[25px]">
      <div class="flex flex-col gap-4">
        <!-- Search Bar -->
        <div class="relative">
          <img :src="iconSearch" alt="" class="absolute left-3 top-2 w-5 h-5" />
          <input
            type="text"
            v-model="searchQuery"
            placeholder="Tìm theo tiêu đề bài viết, tên tác giả..."
            class="w-full h-9 pl-10 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
          />
        </div>

        <!-- Filters -->
        <div class="grid grid-cols-2 gap-4">
          <!-- Category Filter -->
          <button class="bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 flex items-center justify-between h-9 hover:bg-gray-200 transition-colors">
            <span class="text-sm text-neutral-950">Tất cả danh mục</span>
            <img :src="iconChevronDown" alt="" class="w-4 h-4" />
          </button>

          <!-- Status Filter -->
          <button class="bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 flex items-center justify-between h-9 hover:bg-gray-200 transition-colors">
            <span class="text-sm text-neutral-950">Tất cả</span>
            <img :src="iconChevronDown" alt="" class="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>

    <!-- Posts Table -->
    <div class="bg-white border border-black/10 rounded-[14px] p-[25px]">
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead>
            <tr class="border-b border-black/10">
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Tiêu đề & Tóm tắt</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Danh mục</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Ngày đăng</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Trạng thái</th>
              <th class="text-right text-sm font-medium text-neutral-950 py-2.5 px-2">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <tr 
              v-for="post in posts" 
              :key="post.id"
              class="border-b border-black/10 hover:bg-gray-50 transition-colors"
            >
              <!-- Title & Summary -->
              <td class="py-4 px-2">
                <div class="flex flex-col gap-1">
                  <p class="text-sm text-[#101828] leading-5">{{ post.title }}</p>
                  <p class="text-sm text-[#6a7282] leading-5 truncate max-w-[500px]">
                    {{ post.summary }}
                  </p>
                </div>
              </td>

              <!-- Category -->
              <td class="py-4 px-2">
                <span 
                  class="inline-block px-3 py-1 rounded-lg border text-xs font-medium"
                  :class="getCategoryClass(post.category)"
                >
                  {{ post.categoryLabel }}
                </span>
              </td>

              <!-- Date -->
              <td class="py-4 px-2">
                <div v-if="post.publishedAt" class="flex flex-col gap-1">
                  <p class="text-sm text-[#101828] leading-5">{{ post.publishedDate }}</p>
                  <p class="text-xs text-[#6a7282] leading-4">{{ post.publishedTime }}</p>
                </div>
                <p v-else class="text-sm text-[#99a1af] leading-5">Chưa xuất bản</p>
              </td>

              <!-- Status -->
              <td class="py-4 px-2">
                <span 
                  class="inline-block px-3 py-1 rounded-lg border-0 text-xs font-medium"
                  :class="getStatusClass(post.status)"
                >
                  {{ post.statusLabel }}
                </span>
              </td>

              <!-- Actions -->
              <td class="py-4 px-2">
                <div class="flex items-center justify-end gap-2">
                  <button 
                    @click="router.push(`/admin/bai-viet/chinh-sua/${post.id}`)"
                    class="w-9 h-8 flex items-center justify-center rounded-lg hover:bg-gray-100 transition-colors"
                    title="Chỉnh sửa"
                  >
                    <img :src="iconEdit" alt="" class="w-4 h-4" />
                  </button>
                  <button 
                    @click="handleDeletePost(post)"
                    class="w-9 h-8 flex items-center justify-center rounded-lg hover:bg-gray-100 transition-colors"
                    title="Xóa"
                  >
                    <img :src="iconDelete" alt="" class="w-4 h-4" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

    </div>

    <!-- Modals -->
    <XoaBaiViet
      v-if="isDeletePostModalOpen"
      :post-title="selectedPostForDelete?.title"
      @close="isDeletePostModalOpen = false"
      @confirm="handleDeleteConfirm"
    />
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import XoaBaiViet from './XoaBaiViet/index.vue';

// Icons
const iconPlus = 'https://www.figma.com/api/mcp/asset/bd491dc9-ee5e-4b10-88a8-62b03bef9093';
const iconSearch = 'https://www.figma.com/api/mcp/asset/8df55cc2-682a-4eaf-baa1-55b3c1c1c558';
const iconChevronDown = 'https://www.figma.com/api/mcp/asset/8d066934-07ff-48dd-abfa-6acf31386f7a';
const iconEdit = 'https://www.figma.com/api/mcp/asset/ded66c3e-db3c-4c02-965a-702a4c0fdca8';
const iconDelete = 'https://www.figma.com/api/mcp/asset/9c38866f-8dd6-447a-84f8-060c94dd483b';

// Define emits
const emit = defineEmits(['create-post', 'edit-post', 'delete-post']);

// Router
const router = useRouter();

// Search query
const searchQuery = ref('');
const isDeletePostModalOpen = ref(false);
const selectedPostForDelete = ref(null);

// Sample posts data
const posts = ref([
  {
    id: 1,
    title: 'Cách chăm sóc chó Poodle: Hướng dẫn từ A đến Z',
    summary: 'Poodle là giống chó thông minh, năng động và đáng yêu....',
    category: 'knowledge',
    categoryLabel: 'Kiến thức Thú y',
    publishedAt: '2025-11-20T09:30:00',
    publishedDate: '20/11/2025',
    publishedTime: '09:30',
    status: 'published',
    statusLabel: 'Đã xuất bản',
    views: 1300
  },
  {
    id: 2,
    title: 'Top 5 loại thức ăn tốt nhất cho mèo Ba Tư',
    summary: 'Mèo Ba Tư có nhu cầu dinh dưỡng đặc biệt. Cùng khám phá.....',
    category: 'knowledge',
    categoryLabel: 'Kiến thức Thú y',
    publishedAt: '2025-11-19T14:20:00',
    publishedDate: '19/11/2025',
    publishedTime: '14:20',
    status: 'published',
    statusLabel: 'Đã xuất bản',
    views: 890
  },
  {
    id: 3,
    title: 'Khuyến mãi 20% dịch vụ tiêm phòng cho thú cưng',
    summary: 'Chương trình khuyến mãi đặc biệt nhân dịp khai trương....',
    category: 'promotion',
    categoryLabel: 'Khuyến mãi',
    publishedAt: '2025-11-20T10:00:00',
    publishedDate: '20/11/2025',
    publishedTime: '10:00',
    status: 'published',
    statusLabel: 'Đã xuất bản',
    views: 2300
  },
  {
    id: 4,
    title: 'Sự kiện Workshop: Chăm sóc thú cưng mùa mưa',
    summary: 'Tham gia workshop miễn phí để học cách chăm sóc......',
    category: 'news',
    categoryLabel: 'Tin tức & Sự kiện',
    publishedAt: null,
    publishedDate: null,
    publishedTime: null,
    status: 'draft',
    statusLabel: 'Bản nháp',
    views: 456
  },
  {
    id: 5,
    title: 'Lịch tiêm phòng cho chó con từ 2-6 tháng tuổi',
    summary: 'Hướng dẫn lịch tiêm phòng chi tiết cho chó con........',
    category: 'knowledge',
    categoryLabel: 'Kiến thức Thú y',
    publishedAt: null,
    publishedDate: null,
    publishedTime: null,
    status: 'hidden',
    statusLabel: 'Đã ẩn',
    views: 0
  }
]);

// Get category badge class
const getCategoryClass = (category) => {
  const classes = {
    knowledge: 'bg-blue-100 border-black/10 text-[#1447e6]',
    promotion: 'bg-[#ffe2e2] border-black/10 text-[#c10007]',
    news: 'bg-gray-100 border-black/10 text-[#364153]'
  };
  return classes[category] || 'bg-gray-100 border-black/10 text-gray-700';
};

// Get status badge class
const getStatusClass = (status) => {
  const classes = {
    published: 'bg-green-100 text-[#008236]',
    draft: 'bg-gray-100 text-[#364153]',
    hidden: 'bg-[#ffe2e2] text-[#c10007]'
  };
  return classes[status] || 'bg-gray-100 text-gray-700';
};

const handleDeletePost = (post) => {
  selectedPostForDelete.value = post;
  isDeletePostModalOpen.value = true;
};

const handleDeleteConfirm = () => {
  console.log('Deleting post:', selectedPostForDelete.value?.id);
  // Logic to delete post goes here
  isDeletePostModalOpen.value = false;
  selectedPostForDelete.value = null;
};
</script>

<style scoped>
/* Ensure Nunito Sans font is applied */
.font-nunito {
  font-family: 'Nunito Sans', sans-serif;
}
</style>
