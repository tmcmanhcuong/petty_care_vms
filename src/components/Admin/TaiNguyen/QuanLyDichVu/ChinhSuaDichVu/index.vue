<template>
  <div class="relative bg-white border border-gray-200/60 rounded-[10px] w-full h-full overflow-y-auto">
    <div class="flex flex-col gap-4 p-6">
      <!-- Header -->
      <div class="flex flex-col gap-2 h-[46px]">
        <h2 class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight">
          Chỉnh sửa dịch vụ
        </h2>
        <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
          Cập nhật thông tin dịch vụ
        </p>
      </div>

      <!-- Form Content -->
      <div class="flex flex-col gap-4">

        <!-- Category -->
        <div class="flex flex-col gap-2 h-[60px]">
          <div class="flex items-center justify-between h-4">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight">
              Danh mục dịch vụ (*)
            </label>
            <button
              class="font-nunito font-medium text-xs leading-4 text-[#009689] hover:text-[#007d72] transition-colors"
              @click="openCreateCategory"
            >
              Tạo nhóm mới
            </button>
          </div>
          <button
            class="bg-[#f3f3f5] border-none rounded-lg h-9 px-[13px] py-0.5 flex items-center justify-between hover:bg-gray-200 transition-colors"
            @click="toggleCategoryDropdown"
          >
            <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">
              {{ formData.category }}
            </span>
            <img :src="iconChevronDown" alt="" class="w-4 h-4" />
          </button>
        </div>

        <!-- Details Section -->
        <div class="border-t border-gray-200/60 pt-[17px] flex flex-col gap-3">
          <h4 class="font-nunito font-semibold text-sm leading-5 text-neutral-950 tracking-tight">
            Thông tin chi tiết
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
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none"
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
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none"
              />
            </div>

            <!-- Price and Duration -->
            <div class="grid grid-cols-2 gap-4 h-[50px]">
              <!-- Price -->
              <div class="flex flex-col gap-0">
                <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                  Giá bán (VNĐ) (*)
                </label>
                <input
                  v-model.number="formData.price"
                  type="number"
                  class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none"
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
                  class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none"
                />
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

            <!-- Direction -->
            <div class="flex flex-col gap-0 h-[78px]">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[10px]">
                Hướng dẫn
              </label>
              <textarea
                v-model="formData.description"
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
              <div class="border-2 border-[#d1d5dc] border-solid rounded-[10px] h-48 relative overflow-hidden">
                <img
                  v-if="formData.image"
                  :src="formData.image"
                  alt="Service image"
                  class="w-full h-full object-cover"
                />
                <button
                  class="absolute top-[10px] right-[10px] bg-[#d4183d] rounded-lg w-9 h-8 flex items-center justify-center hover:bg-[#b01430] transition-colors"
                  @click="removeImage"
                >
                  <img :src="iconDelete" alt="" class="w-4 h-4" />
                </button>
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
          @click="handleUpdate"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
            Cập nhật
          </span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

const props = defineProps({
  service: {
    type: Object,
    required: true,
    default: () => ({
      id: '',
      department: 'Spa & Grooming',
      category: 'Cắt tỉa',
      name: 'Cắt tỉa lông chó < 5kg',
      code: 'SPA-CT-001',
      price: 200000,
      duration: 60,
      description: '',
      requireBooking: true,
      isActive: true,
      image: 'https://www.figma.com/api/mcp/asset/3449db84-6f8e-45dd-9598-4ac9983daaa8'
    })
  }
})

const emit = defineEmits(['close', 'update', 'openCreateCategory'])

// State
const fileInput = ref(null)

const formData = reactive({
  department: props.service.department,
  category: props.service.category,
  name: props.service.name,
  code: props.service.code,
  price: props.service.price,
  duration: props.service.duration,
  description: props.service.description,
  requireBooking: props.service.requireBooking,
  isActive: props.service.isActive,
  image: props.service.image
})

// Icon URLs from Figma (expire in 7 days)
const iconChevronDown = "https://www.figma.com/api/mcp/asset/cec17f58-3b9d-43b9-b443-ac84410fd70c"
const iconDelete = "https://www.figma.com/api/mcp/asset/0ab25dbb-6ab6-4bf3-8fdb-6f9b84483543"

// Methods
const toggleDepartmentDropdown = () => {
  console.log('Toggle department dropdown')
  // Implement dropdown logic here
}

const toggleCategoryDropdown = () => {
  console.log('Toggle category dropdown')
  // Implement dropdown logic here
}

const openCreateCategory = () => {
  emit('openCreateCategory')
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
    
    // Create preview URL
    const reader = new FileReader()
    reader.onload = (e) => {
      formData.image = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

const removeImage = () => {
  formData.image = ''
  if (fileInput.value) {
    fileInput.value.value = ''
  }
}

const handleCancel = () => {
  emit('close')
}

const handleUpdate = () => {
  // Validate required fields
  if (!formData.name || !formData.code || !formData.price || !formData.duration) {
    alert('Vui lòng điền đầy đủ thông tin bắt buộc (*)')
    return
  }
  
  emit('update', {
    id: props.service.id,
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
