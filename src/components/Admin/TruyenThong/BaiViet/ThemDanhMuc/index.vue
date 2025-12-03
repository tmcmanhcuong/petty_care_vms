<template>
  <div 
    class="bg-white border border-black/10 rounded-[10px] shadow-lg w-full max-w-[510px] relative"
    role="dialog"
    aria-labelledby="dialog-title"
    aria-describedby="dialog-description"
  >
    <!-- Header -->
    <div class="flex flex-col gap-2 px-6 pt-6">
      <h2 
        id="dialog-title"
        class="text-lg font-semibold text-neutral-950 tracking-tight"
      >
        Thêm danh mục mới
      </h2>
      <p 
        id="dialog-description"
        class="text-sm text-[#717182] leading-5"
      >
        Tạo danh mục mới cho bài viết
      </p>
    </div>

    <!-- Close Button -->
    <button
      @click="closeDialog"
      class="absolute top-4 right-4 w-4 h-4 opacity-70 hover:opacity-100 transition-opacity"
      aria-label="Close"
    >
      <img :src="iconClose" alt="Close" class="w-full h-full" />
    </button>

    <!-- Content -->
    <div class="flex flex-col gap-2 px-6 mt-8">
      <label 
        for="category-name"
        class="text-sm font-medium text-neutral-950"
      >
        Tên danh mục
      </label>
      <input
        id="category-name"
        v-model="categoryName"
        type="text"
        placeholder="Ví dụ: Kiến thức Thú y, Tin tức..."
        class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
      />
    </div>

    <!-- Footer -->
    <div class="flex items-center justify-end gap-2 px-6 py-6 mt-8">
      <button
        @click="closeDialog"
        class="h-9 px-4 bg-white border border-black/10 rounded-lg text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors"
      >
        Hủy
      </button>
      <button
        @click="addCategory"
        :disabled="!categoryName.trim()"
        class="h-9 px-4 bg-[#009689] rounded-lg text-sm font-medium text-white hover:bg-[#008177] transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
      >
        <img :src="iconPlus" alt="Plus" class="w-4 h-4" />
        Thêm danh mục
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

// Props
const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  }
});

// Emits
const emit = defineEmits(['update:modelValue', 'add-category', 'close']);

// State
const categoryName = ref('');

// Icons
const iconPlus = "https://www.figma.com/api/mcp/asset/8e49ba51-073d-4b1c-9e55-7a621afa4eab";
const iconClose = "https://www.figma.com/api/mcp/asset/4328a1eb-684c-4f6b-8ce6-b3a3dfe83234";

// Methods
const closeDialog = () => {
  categoryName.value = '';
  emit('update:modelValue', false);
  emit('close');
};

const addCategory = () => {
  if (categoryName.value.trim()) {
    emit('add-category', categoryName.value.trim());
    categoryName.value = '';
    closeDialog();
  }
};
</script>

<style scoped>
/* Nunito Sans font family */
* {
  font-family: 'Nunito Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
}
</style>
