<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white border border-gray-200/60 rounded-[10px] shadow-lg w-[510px] relative">
      <!-- Close Button -->
      <button
        @click="$emit('close')"
        class="absolute right-4 top-4 w-4 h-4 opacity-70 hover:opacity-100 transition-opacity"
      >
        <img :src="iconClose" alt="Close" class="w-full h-full" />
      </button>

      <!-- Header -->
      <div class="flex flex-col gap-2 px-6 pt-6 pb-4">
        <h2 class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight">
          Thêm Hàng Hoá mới
        </h2>
        <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
          Tạo mã hàng mới trong hệ thống
        </p>
      </div>

      <!-- Form Content -->
      <div class="px-6 py-4">
        <div class="flex flex-col gap-[66px]">
          <!-- Row 1: Code & Name -->
          <div class="grid grid-cols-2 gap-2">
            <!-- Code -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Mã hàng hoá
              </label>
              <input
                v-model="formData.code"
                type="text"
                placeholder="VD: MED001"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>

            <!-- Name -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Tên mặt hàng
              </label>
              <input
                v-model="formData.name"
                type="text"
                placeholder="VD: Zoletil 50"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>
          </div>

          <!-- Row 2: Category & Unit -->
          <div class="grid grid-cols-2 gap-4 -mt-[50px]">
            <!-- Category -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Phân loại
              </label>
              <button
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-[13px] py-0.5 flex items-center justify-between hover:bg-gray-200 transition-colors mt-0"
              >
                <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">{{ formData.category }}</span>
                <img :src="iconChevronDown" alt="" class="w-4 h-4" />
              </button>
            </div>

            <!-- Unit -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Đơn vị tính
              </label>
              <input
                v-model="formData.unit"
                type="text"
                placeholder="VD: Lọ, Viên, ml"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>
          </div>

          <!-- Row 3: Cost Price & Sale Price -->
          <div class="grid grid-cols-2 gap-4 -mt-[50px]">
            <!-- Cost Price -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Giá vốn (VNĐ)
              </label>
              <input
                v-model.number="formData.costPrice"
                type="number"
                placeholder="50000"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>

            <!-- Sale Price -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Giá bán (VNĐ)
              </label>
              <input
                v-model.number="formData.salePrice"
                type="number"
                placeholder="150000"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>
          </div>

          <!-- Minimum Stock -->
          <div class="flex flex-col gap-0 -mt-[50px]">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
              Định mức tối thiểu
            </label>
            <input
              v-model.number="formData.minStock"
              type="number"
              placeholder="10"
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
            />
            <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-1">
              Hệ thống sẽ cảnh báo khi tồn kho thấp hơn mức này
            </p>
          </div>

          <!-- Image Upload -->
          <div class="flex flex-col gap-0 -mt-[34px]">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
              Ảnh sản phẩm
            </label>
            <div
              class="border-2 border-dashed border-[#d1d5dc] rounded-[10px] h-48 flex flex-col items-center justify-center gap-2 cursor-pointer hover:border-gray-400 transition-colors mt-0"
              @click="triggerFileInput"
            >
              <img :src="iconUpload" alt="" class="w-12 h-12" />
              <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
                Click để chọn ảnh
              </p>
              <p class="font-nunito text-xs leading-4 text-[#99a1af]">
                PNG, JPG, GIF (Max 5MB)
              </p>
              <input
                ref="fileInput"
                type="file"
                accept="image/png,image/jpeg,image/gif"
                class="hidden"
                @change="handleFileUpload"
              />
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="flex items-center justify-end gap-2 px-6 py-4 border-t border-gray-200/60">
        <button
          @click="$emit('close')"
          class="bg-white border border-gray-200/60 rounded-lg h-9 px-[17px] py-[9px] hover:bg-gray-50 transition-colors"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Hủy</span>
        </button>
        <button
          @click="handleSubmit"
          class="bg-[#009689] rounded-lg h-9 px-4 py-2 hover:bg-[#007d72] transition-colors"
          :disabled="!isFormValid"
          :class="{ 'opacity-50 cursor-not-allowed': !isFormValid }"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">Thêm hàng hóa</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

// Props
defineProps({
  // No props needed for now
})

// Emits
const emit = defineEmits(['close', 'save'])

// Refs
const fileInput = ref(null)

// Form Data
const formData = ref({
  code: '',
  name: '',
  category: 'Thuốc',
  unit: '',
  costPrice: null,
  salePrice: null,
  minStock: null,
  image: null
})

// Icons from Figma (expire in 7 days)
const iconChevronDown = "https://www.figma.com/api/mcp/asset/dbefd2f7-66cb-45b5-b3bd-03f52f8f35ea"
const iconUpload = "https://www.figma.com/api/mcp/asset/a9f0c092-b6b7-4d37-8be2-b4e38e1b7a18"
const iconClose = "https://www.figma.com/api/mcp/asset/4bc93462-6979-4e31-a7e9-deba0f6b8173"

// Computed
const isFormValid = computed(() => {
  return formData.value.code &&
         formData.value.name &&
         formData.value.unit &&
         formData.value.costPrice !== null &&
         formData.value.salePrice !== null &&
         formData.value.minStock !== null
})

// Methods
const triggerFileInput = () => {
  fileInput.value?.click()
}

const handleFileUpload = (event) => {
  const file = event.target.files[0]
  if (file) {
    // Check file size (5MB max)
    if (file.size > 5 * 1024 * 1024) {
      alert('Kích thước file không được vượt quá 5MB')
      return
    }

    // Check file type
    const validTypes = ['image/png', 'image/jpeg', 'image/gif']
    if (!validTypes.includes(file.type)) {
      alert('Chỉ chấp nhận file PNG, JPG, GIF')
      return
    }

    formData.value.image = file
  }
}

const handleSubmit = () => {
  if (isFormValid.value) {
    emit('save', formData.value)
  }
}
</script>

<style scoped>
/* Remove number input arrows */
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  appearance: none;
  margin: 0;
}

input[type="number"] {
  -moz-appearance: textfield;
  appearance: textfield;
}
</style>
