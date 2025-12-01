<template>
  <div class="fixed inset-0 bg-black/50 flex items-center justify-center z-50" @click.self="$emit('close')">
    <div class="bg-white border border-black/10 rounded-[10px] shadow-[0px_10px_15px_-3px_rgba(0,0,0,0.1),0px_4px_6px_-4px_rgba(0,0,0,0.1)] w-[510px] h-[671px] relative">
      <!-- Close Button -->
      <button 
        @click="$emit('close')"
        class="absolute right-4 top-4 w-4 h-4 opacity-70 hover:opacity-100 transition-opacity"
      >
        <img :src="iconClose" alt="Close" class="w-full h-full" />
      </button>

      <!-- Dialog Header -->
      <div class="flex flex-col gap-2 h-12 px-6 pt-6">
        <div class="h-5 flex items-center gap-2">
          <img :src="iconFolder" alt="" class="w-5 h-5" />
          <h2 class="font-nunitoSans font-semibold text-lg leading-[18px] text-neutral-950 tracking-[-0.4395px]">
            Quản lý Danh Mục Hàng Hoá
          </h2>
        </div>
        <p class="font-nunitoSans text-sm leading-5 text-[#717182] tracking-[-0.1504px]">
          Tạo và quản lý các danh mục để phân loại hàng hóa trong kho
        </p>
      </div>

      <!-- Main Content -->
      <div class="flex flex-col gap-6 px-6 pt-4">
        <!-- Categories List -->
        <div class="bg-gray-50 border border-black/10 rounded-[10px] h-[320px] overflow-hidden">
          <div class="flex flex-col gap-2 p-[17px] pr-8 h-full overflow-y-auto">
            <!-- Category Item -->
            <div
              v-for="category in categories"
              :key="category.id"
              class="bg-white border border-black/10 rounded-[10px] flex items-center justify-between px-[13px] py-[13px] min-h-[66px]"
            >
              <div class="flex flex-col gap-0 flex-1">
                <p class="font-nunitoSans text-base leading-6 text-[#101828] tracking-[-0.3125px]">
                  {{ category.name }}
                </p>
                <p class="font-nunitoSans text-xs leading-4 text-[#6a7282]">
                  {{ category.description }} • {{ category.count }} sản phẩm
                </p>
              </div>
              <button 
                @click="handleDeleteCategory(category.id)"
                class="w-9 h-8 rounded-lg flex items-center justify-center hover:bg-red-50 transition-colors group"
              >
                <img :src="iconDelete" alt="" class="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>

        <!-- Add New Category Section -->
        <div class="border-t border-black/10 pt-[17px] flex flex-col gap-2">
          <label class="font-nunitoSans font-medium text-sm leading-[14px] text-neutral-950 tracking-[-0.1504px]">
            Thêm danh mục mới
          </label>
          <div class="flex flex-col gap-3">
            <input
              v-model="newCategoryName"
              type="text"
              placeholder="Tên danh mục..."
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunitoSans text-sm text-neutral-950 tracking-[-0.1504px] outline-none placeholder:text-[#717182]"
            />
            <input
              v-model="newCategoryDescription"
              type="text"
              placeholder="Mô tả (tùy chọn)..."
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunitoSans text-sm text-neutral-950 tracking-[-0.1504px] outline-none placeholder:text-[#717182]"
            />
            <button
              @click="handleAddCategory"
              :disabled="!newCategoryName.trim()"
              class="bg-[#009689] hover:bg-[#007d72] disabled:opacity-50 disabled:cursor-not-allowed rounded-lg h-9 w-full flex items-center justify-center gap-2 transition-colors"
            >
              <img :src="iconPlus" alt="" class="w-4 h-4" />
              <span class="font-nunitoSans font-medium text-sm leading-5 text-white text-center tracking-[-0.1504px]">
                Thêm danh mục
              </span>
            </button>
          </div>
        </div>
      </div>

      <!-- Close Button at Bottom -->
      <div class="absolute bottom-6 right-6">
        <button
          @click="$emit('close')"
          class="bg-white border border-black/10 rounded-lg h-9 px-[17px] py-[9px] hover:bg-gray-50 transition-colors"
        >
          <span class="font-nunitoSans font-medium text-sm leading-5 text-center text-neutral-950 tracking-[-0.1504px]">
            Đóng
          </span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Emits
const emit = defineEmits(['close', 'add', 'delete'])

// State
const newCategoryName = ref('')
const newCategoryDescription = ref('')

// Sample data
const categories = ref([
  {
    id: 1,
    name: 'Thuốc kháng sinh',
    description: 'Các loại thuốc kháng sinh cho thú cưng',
    count: 3
  },
  {
    id: 2,
    name: 'Vắc-xin',
    description: 'Vắc-xin phòng bệnh cho chó mèo',
    count: 2
  },
  {
    id: 3,
    name: 'Vitamin & Dinh dưỡng',
    description: 'Thực phẩm chức năng, vitamin bổ sung',
    count: 19
  },
  {
    id: 4,
    name: 'Dụng cụ y tế',
    description: 'Kim tiêm, băng, gạc y tế',
    count: 12
  },
  {
    id: 5,
    name: 'Thức ăn',
    description: 'Thức ăn hạt, pate, snack',
    count: 6
  }
])

// Icon URLs from Figma (expire in 7 days)
const iconFolder = "https://www.figma.com/api/mcp/asset/f0df365a-f0f1-4058-8ad8-46797b406a2f"
const iconDelete = "https://www.figma.com/api/mcp/asset/f2cb3d48-4a4e-4b60-a490-ea671074f9bc"
const iconPlus = "https://www.figma.com/api/mcp/asset/d0a73c79-526d-485d-b19f-ba509b9e608b"
const iconClose = "https://www.figma.com/api/mcp/asset/ba87382a-a238-4bc0-a0dc-55ef3aa6b507"

// Methods
const handleAddCategory = () => {
  if (!newCategoryName.value.trim()) return

  const newCategory = {
    id: Date.now(),
    name: newCategoryName.value.trim(),
    description: newCategoryDescription.value.trim() || '',
    count: 0
  }

  categories.value.push(newCategory)
  emit('add', newCategory)

  // Reset form
  newCategoryName.value = ''
  newCategoryDescription.value = ''
}

const handleDeleteCategory = (categoryId) => {
  const index = categories.value.findIndex(cat => cat.id === categoryId)
  if (index !== -1) {
    const deleted = categories.value.splice(index, 1)[0]
    emit('delete', deleted)
  }
}
</script>

<style scoped>
/* Custom scrollbar for categories list */
.overflow-y-auto::-webkit-scrollbar {
  width: 6px;
}

.overflow-y-auto::-webkit-scrollbar-track {
  background: transparent;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #d1d5db;
  border-radius: 3px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
  background: #9ca3af;
}
</style>
