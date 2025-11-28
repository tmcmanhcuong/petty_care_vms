<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 font-nunito">
    <div class="bg-white rounded-[10px] shadow-lg w-full max-w-[510px] relative p-6 flex flex-col gap-6">
      <!-- Close Button -->
      <button 
        @click="$emit('close')"
        class="absolute right-4 top-4 opacity-70 hover:opacity-100 transition-opacity"
      >
        <img :src="iconClose" alt="Close" class="w-4 h-4" />
      </button>

      <!-- Content -->
      <div class="flex flex-col gap-2">
        <h3 class="text-lg font-semibold text-neutral-950">Xác nhận xóa bài viết</h3>
        <p class="text-sm text-[#717182] leading-5">
          Bạn có chắc chắn muốn xóa bài viết "<span class="font-medium text-neutral-950">{{ postTitle }}</span>"? Hành động này không thể hoàn tác.
        </p>
      </div>

      <!-- Actions -->
      <div class="flex items-center justify-end gap-2">
        <button 
          @click="$emit('close')"
          class="bg-white border border-black/10 rounded-lg px-4 py-2 h-9 text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors"
        >
          Hủy
        </button>
        <button 
          @click="$emit('confirm')"
          class="bg-[#d4183d] text-white rounded-lg px-4 py-2 h-9 text-sm font-medium hover:bg-[#b01231] transition-colors"
        >
          Xóa bài viết
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
// Icons
const iconClose = "https://www.figma.com/api/mcp/asset/94bd510f-1a62-4e75-9333-69c5798771b4"

defineProps({
  postTitle: {
    type: String,
    default: 'Cách chăm sóc chó Poodle: Hướng dẫn từ A đến Z'
  }
})

defineEmits(['close', 'confirm'])
</script>

<style scoped>
.font-nunito {
  font-family: 'Nunito Sans', sans-serif;
}
</style>
