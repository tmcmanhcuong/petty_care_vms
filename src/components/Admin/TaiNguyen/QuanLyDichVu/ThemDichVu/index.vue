<template>
  <div class="relative bg-white border border-gray-200/60 rounded-[10px] w-full h-full overflow-y-auto">
    <div class="flex flex-col gap-4 p-6">
      <!-- Header -->
      <div class="flex flex-col gap-2 h-[46px]">
        <h2 class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight">
          Thêm dịch vụ mới
        </h2>
        <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
          Nhập đầy đủ thông tin dịch vụ
        </p>
      </div>

      <!-- Form Content -->
      <div class="flex flex-col gap-4">
       

        <!-- Step 1: Select Category -->
        <div class="relative h-[58px]">
          <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight absolute top-0 left-0">
            Bước 1: Chọn Danh mục dịch vụ (*)
          </label>
          <button
            class="bg-[#f3f3f5] border-none rounded-lg h-9 px-[13px] py-0.5 flex items-center justify-between absolute top-[22px] left-0 w-full transition-colors"
            :class="!selectedDepartment ? 'opacity-50 cursor-not-allowed' : 'hover:bg-gray-200 cursor-pointer'"
            :disabled="!selectedDepartment"
            @click="toggleCategoryDropdown"
          >
            <span class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
              {{ selectedCategory || 'Vui lòng chọn khoa trước' }}
            </span>
            <img :src="iconChevronDown" alt="" class="w-4 h-4" />
          </button>
        </div>

        <!-- Step 2: Details -->
        <div class="border-t border-gray-200/60 pt-[17px] flex flex-col gap-3">
          <h4 class="font-nunito font-semibold text-sm leading-5 text-neutral-950 tracking-tight">
            Bước 2: Thông tin chi tiết
          </h4>

          <div class="flex flex-col gap-4">
            <!-- Service Name -->
            <div class="flex flex-col gap-0 h-[50px]">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                Tên dịch vụ (*)
              </label>
              <input
                v-model="formData.name"
                type="text"
                placeholder="Ví dụ: Cắt tỉa lông chó < 5kg"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
              />
            </div>

            <!-- Service Code -->
            <div class="flex flex-col gap-0 h-[50px]">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                Mã Dịch Vụ (*)
              </label>
              <input
                v-model="formData.code"
                type="text"
                placeholder="Ví dụ: SPA-CT-001"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
              />
            </div>

            <!-- Price and Duration -->
            <div class="grid grid-cols-2 gap-4 h-[70px]">
              <!-- Price -->
              <div class="flex flex-col gap-0">
                <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                  Giá bán (VNĐ) (*)
                </label>
                <input
                  v-model.number="formData.price"
                  type="number"
                  placeholder="200000"
                  class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
                />
              </div>

              <!-- Duration -->
              <div class="flex flex-col gap-0">
                <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                  Thời gian (phút) (*)
                </label>
                <input
                  v-model.number="formData.duration"
                  type="number"
                  placeholder="60"
                  class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
                />
                <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-1">
                  Quan trọng để xếp lịch
                </p>
              </div>
            </div>

            <!-- Description -->
            <div class="flex flex-col gap-0 h-[78px]">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                Mô tả
              </label>
              <textarea
                v-model="formData.description"
                placeholder="Nhập mô tả chi tiết về dịch vụ..."
                rows="3"
                class="bg-[#f3f3f5] border-none rounded-lg h-16 px-3 py-2 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] resize-none"
              ></textarea>
            </div>

            <!-- Instructions -->
            <div class="flex flex-col gap-0 h-[78px]">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                Hướng dẫn
              </label>
              <textarea
                v-model="formData.instructions"
                placeholder="Nhập mô tả chi tiết về dịch vụ..."
                rows="3"
                class="bg-[#f3f3f5] border-none rounded-lg h-16 px-3 py-2 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] resize-none"
              ></textarea>
            </div>


            <!-- Status -->
            <div class="bg-gray-50 rounded-[10px] h-[54px] px-3 flex items-center justify-between">
              <div class="flex flex-col">
                <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight">
                  Trạng thái
                </label>
                <p class="font-nunito text-xs leading-4 text-[#4a5565]">
                  Cho phép khách hàng đặt dịch vụ này
                </p>
              </div>
              <button
                type="button"
                class="relative w-8 h-[18.398px] rounded-full transition-colors"
                :class="formData.isActive ? 'bg-[#030213]' : 'bg-gray-300'"
                @click="formData.isActive = !formData.isActive"
              >
                <span
                  class="absolute top-0.5 w-4 h-4 bg-white rounded-full transition-transform"
                  :class="formData.isActive ? 'left-[15px]' : 'left-0.5'"
                ></span>
              </button>
            </div>

            <!-- Image Upload -->
            <div class="flex flex-col gap-0 h-[206px]">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                Ảnh đại diện
              </label>
              <div
                class="border-2 border-dashed border-[#d1d5dc] rounded-[10px] h-48 flex flex-col items-center justify-center gap-2 cursor-pointer hover:border-gray-400 transition-colors"
                @click="triggerFileInput"
              >
                <img :src="iconUpload" alt="" class="w-12 h-12" />
                <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
                  Click để chọn ảnh
                </p>
                <p class="font-nunito text-xs leading-4 text-[#99a1af]">
                  PNG, JPG, GIF (Max 5MB)
                </p>
              </div>
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

      <!-- Footer Buttons -->
      <div class="flex gap-2 justify-end h-9">
        <button
          class="bg-white border border-gray-200/60 rounded-lg h-9 px-[17px] py-[9px] flex items-center justify-center hover:bg-gray-50 transition-colors"
          @click="handleCancel"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
            Hủy
          </span>
        </button>
        <button
          class="bg-[#009689] rounded-lg h-9 px-4 py-2 flex items-center justify-center hover:bg-[#007d72] transition-colors"
          @click="handleSave"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
            Lưu lại
          </span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

const emit = defineEmits(['close', 'save'])

// State
const selectedDepartment = ref('')
const selectedCategory = ref('')
const fileInput = ref(null)

const formData = reactive({
  name: '',
  code: '',
  price: null,
  duration: null,
  description: '',
  instructions: '',
  requireBooking: true,
  isActive: true,
  image: null
})

// Icon URLs from Figma (expire in 7 days)
const iconChevronDown = "https://www.figma.com/api/mcp/asset/c1f4500a-976f-4d96-9aa9-7e5957c97728"
const iconUpload = "https://www.figma.com/api/mcp/asset/f875eb22-4532-4e8e-a61d-a50ba158caec"

// Methods
const toggleDepartmentDropdown = () => {
  console.log('Toggle department dropdown')
  // Implement dropdown logic here
}

const toggleCategoryDropdown = () => {
  if (selectedDepartment.value) {
    console.log('Toggle category dropdown')
    // Implement dropdown logic here
  }
}

const triggerFileInput = () => {
  fileInput.value?.click()
}

const handleFileUpload = (event) => {
  const file = event.target.files?.[0]
  if (file) {
    // Validate file size (5MB max)
    if (file.size > 5 * 1024 * 1024) {
      alert('File size must be less than 5MB')
      return
    }
    
    // Validate file type
    const validTypes = ['image/png', 'image/jpeg', 'image/gif']
    if (!validTypes.includes(file.type)) {
      alert('File type must be PNG, JPG, or GIF')
      return
    }
    
    formData.image = file
    console.log('File uploaded:', file.name)
  }
}

const handleCancel = () => {
  emit('close')
}

const handleSave = () => {
  // Validate required fields
  if (!selectedDepartment.value) {
    alert('Vui lòng chọn khoa')
    return
  }
  
  if (!selectedCategory.value) {
    alert('Vui lòng chọn danh mục dịch vụ')
    return
  }
  
  if (!formData.name || !formData.code || !formData.price || !formData.duration) {
    alert('Vui lòng điền đầy đủ thông tin bắt buộc (*)')
    return
  }
  
  emit('save', {
    department: selectedDepartment.value,
    category: selectedCategory.value,
    ...formData
  })
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
