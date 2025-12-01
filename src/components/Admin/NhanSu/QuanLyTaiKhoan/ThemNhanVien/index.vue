<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[1000] pt-24">
    <div class="bg-white border border-gray-200/60 rounded-[10px] shadow-xl w-[495px] max-h-[85vh] overflow-y-auto">
      <div class="p-6 flex flex-col gap-4">
        <!-- Header -->
        <div class="flex flex-col gap-2">
          <h2 class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight">
            Thêm nhân viên mới
          </h2>
          <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
            Tạo tài khoản và cấp quyền truy cập cho nhân viên
          </p>
        </div>

        <!-- Form Fields -->
        <div class="flex flex-col gap-4">
          <!-- Full Name -->
          <div class="flex flex-col gap-0">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
              Họ và tên *
            </label>
            <input
              v-model="formData.fullName"
              type="text"
              placeholder="VD: BS. Nguyễn Văn A"
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
            />
          </div>

          <!-- Email & Phone -->
          <div class="grid grid-cols-2 gap-4">
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Email (Tên đăng nhập) *
              </label>
              <input
                v-model="formData.email"
                type="email"
                placeholder="email@vcms.vn"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Số điện thoại *
              </label>
              <input
                v-model="formData.phone"
                type="tel"
                placeholder="0901234567"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>
          </div>

          <!-- Address -->
          <div class="flex flex-col gap-0">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
              Địa chỉ
            </label>
            <input
              v-model="formData.address"
              type="text"
              placeholder="VD: 123 Nguyễn Huệ, Quận 1, TP.HCM"
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
            />
          </div>

          <!-- Avatar Upload -->
          <div class="flex flex-col gap-0">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[8px]">
              Ảnh đại diện
            </label>
            <button class="bg-white border border-gray-200/60 rounded-lg h-9 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors">
              <img :src="iconUpload" alt="Upload" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Chọn ảnh</span>
            </button>
            <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-[4px]">
              JPG, PNG (Tối đa 2MB)
            </p>
          </div>

          <!-- System Roles -->
          <div class="flex flex-col gap-0">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
              Vai trò hệ thống (System Roles) *
            </label>
            <div class="flex flex-col gap-3 mt-0">
              <button class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-[1px] flex items-center justify-between hover:bg-[#e8e8ea] transition-colors">
                <span class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">Chọn vai trò...</span>
                <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
              </button>

              <!-- Selected Roles Display -->
              <div v-if="formData.selectedRoles.length > 0" class="bg-gray-50 border border-gray-200 rounded-[10px] p-3 flex flex-wrap gap-2">
                <span
                  v-for="(role, index) in formData.selectedRoles"
                  :key="index"
                  class="bg-green-100 border border-[#b9f8cf] rounded-lg px-3 py-[1px] h-[34px] flex items-center gap-1.5"
                >
                  <span class="font-nunito text-sm leading-5 text-[#008236] tracking-tight">{{ role }}</span>
                  <button @click="removeRole(index)" class="w-3.5 h-3.5 flex items-center justify-center">
                    <img :src="iconX" alt="Remove" class="w-full h-full" />
                  </button>
                </span>
              </div>

              <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                Chọn một hoặc nhiều vai trò cho nhân viên (VD: Điều dưỡng + Lễ tân)
              </p>
            </div>
          </div>

          <!-- Position -->
          <div class="flex flex-col gap-0">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
              Chức danh
            </label>
            <input
              v-model="formData.position"
              type="text"
              placeholder="VD: Trưởng khoa"
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
            />
          </div>

          <!-- Education & Experience Section -->
          <div class="border-t border-gray-200/60 pt-[17px] flex flex-col gap-4">
            <h3 class="font-nunito text-sm leading-5 text-[#364153] tracking-tight">
              Trình độ & Kinh nghiệm
            </h3>

            <!-- Years of Experience -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0">
                Năm kinh nghiệm
              </label>
              <div class="flex items-center gap-2">
                <input
                  v-model.number="formData.yearsOfExperience"
                  type="number"
                  placeholder="VD: 5"
                  class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] w-32"
                />
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">năm</span>
              </div>
            </div>

            <!-- Practice Certificate -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[8px]">
                Chứng chỉ hành nghề
              </label>
              <button class="bg-white border border-gray-200/60 rounded-lg h-9 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors">
                <img :src="iconUpload" alt="Upload" class="w-4 h-4" />
                <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tải lên file</span>
              </button>
              <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-[4px]">
                PDF, JPG, PNG (Tối đa 5MB)
              </p>
            </div>

            <!-- Professional Degree -->
            <div class="flex flex-col gap-0">
              <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[8px]">
                Bằng cấp chuyên môn
              </label>
              <button class="bg-white border border-gray-200/60 rounded-lg h-9 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors">
                <img :src="iconUpload" alt="Upload" class="w-4 h-4" />
                <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tải lên file</span>
              </button>
              <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-[4px]">
                PDF, JPG, PNG (Tối đa 5MB)
              </p>
            </div>
          </div>

          <!-- Auto Generate Password -->
          <div class="border-t border-gray-200/60 pt-[17px] flex flex-col gap-2">
            <label class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight">
              Mật khẩu khởi tạo
            </label>
            <div class="flex items-center gap-2">
              <input
                v-model="formData.autoGeneratePassword"
                type="checkbox"
                class="w-4 h-4 bg-[#030213] border-[#030213] rounded accent-[#030213] cursor-pointer"
              />
              <label class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight cursor-pointer">
                Tự động sinh mật khẩu ngẫu nhiên và gửi về Email
              </label>
            </div>
          </div>
        </div>

        <!-- Footer Buttons -->
        <div class="flex items-center justify-end gap-2 mt-2">
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
            <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">Tạo tài khoản</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

// Emits
const emit = defineEmits(['close', 'submit'])

// Icons (from Figma - expire in 7 days)
const iconUpload = "https://www.figma.com/api/mcp/asset/ac3b14ff-9b65-40de-814c-7485b9cb246e"
const iconChevronDown = "https://www.figma.com/api/mcp/asset/01da1adc-0fe6-4647-ab0c-b8f938f03b86"
const iconX = "https://www.figma.com/api/mcp/asset/7aabb16d-9bbd-4b42-8e59-b92fc982e8aa"
const iconCheck = "https://www.figma.com/api/mcp/asset/0ff2272d-970d-484f-8ee5-78a87be20090"

// Form Data
const formData = ref({
  fullName: '',
  email: '',
  phone: '',
  address: '',
  avatar: null,
  selectedRoles: ['Điều dưỡng'], // Sample selected role
  department: '',
  position: '',
  yearsOfExperience: null,
  practiceCertificate: null,
  professionalDegree: null,
  autoGeneratePassword: true
})

// Computed
const isFormValid = computed(() => {
  return (
    formData.value.fullName &&
    formData.value.email &&
    formData.value.phone &&
    formData.value.selectedRoles.length > 0
  )
})

// Methods
const removeRole = (index) => {
  formData.value.selectedRoles.splice(index, 1)
}

const handleSubmit = () => {
  if (isFormValid.value) {
    emit('submit', formData.value)
  }
}
</script>

<style scoped>
/* Custom scrollbar for modal */
div::-webkit-scrollbar {
  width: 8px;
}

div::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

div::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

div::-webkit-scrollbar-thumb:hover {
  background: #555;
}

/* Custom checkbox styling */
input[type="checkbox"] {
  appearance: none;
  -webkit-appearance: none;
  width: 16px;
  height: 16px;
  border: 1px solid #030213;
  border-radius: 4px;
  background-color: white;
  cursor: pointer;
  position: relative;
}

input[type="checkbox"]:checked {
  background-color: #030213;
  border-color: #030213;
}

input[type="checkbox"]:checked::after {
  content: '';
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 14px;
  height: 14px;
  background-image: url("https://www.figma.com/api/mcp/asset/0ff2272d-970d-484f-8ee5-78a87be20090");
  background-size: contain;
  background-repeat: no-repeat;
}
</style>
