<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[1000] pt-24" @click.self="$emit('close')">
    <div class="w-[512px] max-h-[85vh] bg-white rounded-[10px] overflow-hidden flex flex-col shadow-xl">
      <div class="flex flex-col w-full h-full overflow-hidden p-6 gap-4">
        <!-- Header -->
        <div class="flex flex-col gap-2 shrink-0">
          <div class="flex items-center gap-2">
            <img :src="iconFolder" alt="" class="w-5 h-5" />
            <h2 class="font-nunito font-semibold text-lg text-gray-900">
              Quản lý Danh Mục Dịch vụ
            </h2>
          </div>
          <p class="font-nunito text-sm text-gray-600">
            Tạo và quản lý các danh mục dịch vụ để phân loại dịch vụ
          </p>
        </div>

        <!-- Categories List -->
        <div class="flex-1 bg-gray-50 border border-gray-200 rounded-lg overflow-hidden flex flex-col min-h-0 p-4">
          <div class="flex-1 overflow-y-auto space-y-2 custom-scrollbar">
            <div
              v-for="category in categories"
              :key="category.id"
              class="bg-white border border-gray-200 rounded-lg p-3 flex items-center justify-between hover:border-teal-600/30 hover:bg-teal-50/30 transition-all"
            >
              <div class="flex flex-col flex-1">
                <span class="font-nunito font-normal text-base text-gray-900 leading-6">{{ category.name }}</span>
                <span class="text-xs text-gray-600 font-nunito">{{ category.description }} • {{ category.serviceCount }} dịch vụ</span>
              </div>
              <button
                class="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all"
                @click="handleDeleteCategory(category)"
                title="Xóa nhóm"
              >
                <img :src="iconDelete" class="w-4 h-4" />
              </button>
            </div>
            
            <!-- Empty State -->
            <div v-if="categories.length === 0" class="flex flex-col items-center justify-center h-full text-gray-400 py-8 gap-2">
              <div class="w-12 h-12 rounded-full bg-gray-100 flex items-center justify-center">
                <img :src="iconFolder" class="w-6 h-6 opacity-20 grayscale" />
              </div>
              <p class="text-sm font-nunito">Chưa có danh mục nào</p>
            </div>
          </div>
        </div>

        <!-- Footer - Add New Category -->
        <div class="border-t border-gray-200 pt-4 shrink-0 space-y-2">
          <label class="font-nunito font-medium text-sm text-gray-900">
            Thêm nhóm mới
          </label>
          <div class="space-y-3">
            <input
              v-model="newCategoryName"
              type="text"
              placeholder="Tên nhóm..."
              class="w-full bg-gray-100 border-0 text-gray-700 text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block p-2.5 font-nunito outline-none transition-all"
              @keyup.enter="handleAddCategory"
            />
            <input
              v-model="newCategoryDescription"
              type="text"
              placeholder="Mô tả (tùy chọn)..."
              class="w-full bg-gray-100 border-0 text-gray-700 text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block p-2.5 font-nunito outline-none transition-all"
              @keyup.enter="handleAddCategory"
            />
            <button
              class="w-full py-2 bg-teal-600 hover:bg-teal-700 text-white rounded-lg font-medium text-sm transition-colors flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed font-nunito"
              :disabled="!newCategoryName.trim()"
              @click="handleAddCategory"
            >
              <img :src="iconPlus" class="w-4 h-4 brightness-0 invert" />
              Thêm nhóm
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const emit = defineEmits(['close', 'addCategory', 'deleteCategory'])

// State
const newCategoryName = ref('')
const newCategoryDescription = ref('')

// Sample data - updated to match new design
const categories = ref([
  {
    id: 1,
    name: 'Cắt tỉa',
    description: 'Cắt tỉa lông chó và mèo',
    serviceCount: 1
  },
  {
    id: 2,
    name: 'Tắm sấy',
    description: 'Tắm và sấy khô thú cưng',
    serviceCount: 2
  },
  {
    id: 3,
    name: 'Nhuộm lông',
    description: 'Nhuộm lông thú cưng',
    serviceCount: 0
  },
  {
    id: 4,
    name: 'Tiêm phòng',
    description: 'Tiêm phòng thú cưng',
    serviceCount: 1
  },
  {
    id: 5,
    name: 'Khám bệnh',
    description: 'Khám tổng quát thú cưng',
    serviceCount: 1
  },
  {
    id: 6,
    name: 'Xét nghiệm',
    description: 'Xét nghiệm máu và các xét nghiệm khác',
    serviceCount: 1
  },
  {
    id: 7,
    name: 'Thức ăn',
    description: 'Thức ăn cho thú cưng',
    serviceCount: 0
  },
  {
    id: 8,
    name: 'Phụ kiện',
    description: 'Phụ kiện thú cưng',
    serviceCount: 0
  }
])

// Icon URLs from Figma
const iconFolder = "https://www.figma.com/api/mcp/asset/4f9adbdd-1893-41d2-8672-ca8be0ced444"
const iconDelete = "https://www.figma.com/api/mcp/asset/ee18260a-445b-40bb-a50c-dbaeb3bdbfc7"
const iconPlus = "https://www.figma.com/api/mcp/asset/23574880-4357-4ba1-ab64-697061f1221b"

// Methods
const handleAddCategory = () => {
  if (newCategoryName.value.trim()) {
    const newId = Math.max(...categories.value.map(c => c.id)) + 1
    categories.value.push({
      id: newId,
      name: newCategoryName.value.trim(),
      description: newCategoryDescription.value.trim() || 'Chưa có mô tả',
      serviceCount: 0
    })
    
    emit('addCategory', {
      name: newCategoryName.value,
      description: newCategoryDescription.value
    })
    
    newCategoryName.value = ''
    newCategoryDescription.value = ''
  }
}

const handleDeleteCategory = (category) => {
  if (confirm(`Bạn có chắc muốn xóa nhóm "${category.name}"?`)) {
    categories.value = categories.value.filter(c => c.id !== category.id)
    emit('deleteCategory', category)
  }
}
</script>

<style scoped>
/* Custom scrollbar for categories list */
.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background: #e5e7eb;
  border-radius: 10px;
}

.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: #d1d5db;
}
</style>
