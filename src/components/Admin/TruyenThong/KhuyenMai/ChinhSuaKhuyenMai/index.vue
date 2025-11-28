<template>
  <div class="flex flex-col gap-6 h-full bg-gray-50 p-6 font-nunitoSans">
    <!-- Header -->
    <div class="flex items-center justify-between h-[60px]">
      <div class="flex items-center gap-4">
        <button
          @click="handleBack"
          class="flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-gray-100 transition-colors"
        >
          <img :src="iconBack" alt="Back" class="w-4 h-4" />
          <span class="text-sm font-medium text-gray-900">Quay lại</span>
        </button>
        <div class="flex flex-col">
          <h1 class="text-2xl font-medium text-gray-800">Chỉnh sửa khuyến mãi</h1>
          <p class="text-base text-gray-500">Thiết lập các điều kiện và mức giảm giá</p>
        </div>
      </div>
      <button
        @click="handleSave"
        class="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors"
      >
        <img :src="iconSave" alt="Save" class="w-4 h-4" />
        <span class="text-sm font-medium">Lưu chương trình</span>
      </button>
    </div>

    <!-- Main Content Grid -->
    <div class="grid grid-cols-2 gap-6">
      <!-- Card 1: Thông tin cơ bản -->
      <div class="bg-white rounded-2xl border border-gray-200 p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconInfo" alt="Info" class="w-5 h-5" />
          <h2 class="text-base text-gray-900 font-normal">1. Thông tin cơ bản</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Tên chương trình -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Tên chương trình
              <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.name"
              type="text"
              class="w-full px-3 py-2 bg-gray-100 border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
            />
          </div>

          <!-- Mô tả ngắn -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Mô tả ngắn (Optional)
            </label>
            <textarea
              v-model="form.description"
              rows="3"
              placeholder="Giải thích về chương trình khuyến mãi này..."
              class="w-full px-3 py-2 bg-gray-100 border-0 rounded-lg text-sm text-gray-600 resize-none focus:outline-none focus:ring-2 focus:ring-teal-600"
            ></textarea>
          </div>

          <!-- Loại khuyến mãi -->
          <div class="flex flex-col gap-3">
            <label class="text-sm font-medium text-gray-900">
              Loại khuyến mãi
              <span class="text-red-500">*</span>
            </label>

            <!-- Option 1: Voucher -->
            <div
              @click="form.type = 'voucher'"
              :class="[
                'flex flex-col gap-1 p-4 rounded-xl border-2 cursor-pointer transition-all',
                form.type === 'voucher'
                  ? 'bg-teal-50 border-teal-600'
                  : 'bg-white border-gray-200 hover:border-gray-300'
              ]"
            >
              <div class="flex items-start gap-3">
                <div class="flex items-center justify-center w-4 h-4 mt-1">
                  <div
                    :class="[
                      'w-4 h-4 rounded-full border-2 flex items-center justify-center',
                      form.type === 'voucher'
                        ? 'border-teal-600'
                        : 'border-gray-300'
                    ]"
                  >
                    <div
                      v-if="form.type === 'voucher'"
                      class="w-2 h-2 rounded-full bg-teal-600"
                    ></div>
                  </div>
                </div>
                <div class="flex-1">
                  <div class="flex items-center gap-2 mb-1">
                    <img :src="iconVoucher" alt="Voucher" class="w-4 h-4" />
                    <span class="text-base text-gray-800">Mã giảm giá (Voucher)</span>
                  </div>
                  <p class="text-sm text-gray-500">
                    Khách hàng phải nhập mã code để áp dụng giảm giá
                  </p>
                </div>
              </div>
            </div>

            <!-- Option 2: Auto -->
            <div
              @click="form.type = 'auto'"
              :class="[
                'flex flex-col gap-1 p-4 rounded-xl border-2 cursor-pointer transition-all',
                form.type === 'auto'
                  ? 'bg-teal-50 border-teal-600'
                  : 'bg-white border-gray-200 hover:border-gray-300'
              ]"
            >
              <div class="flex items-start gap-3">
                <div class="flex items-center justify-center w-4 h-4 mt-1">
                  <div
                    :class="[
                      'w-4 h-4 rounded-full border-2 flex items-center justify-center',
                      form.type === 'auto'
                        ? 'border-teal-600'
                        : 'border-gray-300'
                    ]"
                  >
                    <div
                      v-if="form.type === 'auto'"
                      class="w-2 h-2 rounded-full bg-teal-600"
                    ></div>
                  </div>
                </div>
                <div class="flex-1">
                  <div class="flex items-center gap-2 mb-1">
                    <img :src="iconAuto" alt="Auto" class="w-4 h-4" />
                    <span class="text-base text-gray-800">Chương trình tự động</span>
                  </div>
                  <p class="text-sm text-gray-500">
                    Hệ thống tự động trừ tiền khi đủ điều kiện
                  </p>
                </div>
              </div>
            </div>
          </div>

          <!-- Mã Code (chỉ hiện khi chọn voucher) -->
          <div
            v-if="form.type === 'voucher'"
            class="flex flex-col gap-2 p-4 bg-purple-50 border border-purple-200 rounded-xl"
          >
            <label class="text-sm font-medium text-gray-900">
              Mã Code
              <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.code"
              type="text"
              class="w-full px-3 py-2 bg-white border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
            />
            <p class="text-xs text-gray-500">
              💡 Gợi ý: Dùng chữ in hoa, dễ nhớ (6-12 ký tự)
            </p>
          </div>
        </div>
      </div>

      <!-- Card 2: Mức giảm giá -->
      <div class="bg-white rounded-2xl border border-gray-200 p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconDiscount" alt="Discount" class="w-5 h-5" />
          <h2 class="text-base text-gray-900 font-normal">2. Mức giảm giá (The Logic)</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Hình thức giảm -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Hình thức giảm
              <span class="text-red-500">*</span>
            </label>
            <div
              @click="toggleDiscountType"
              class="flex items-center justify-between px-3 py-2 bg-gray-100 border-0 rounded-lg cursor-pointer hover:bg-gray-200"
            >
              <div class="flex items-center gap-2">
                <img :src="iconPercent" alt="Percent" class="w-4 h-4" />
                <span class="text-sm text-gray-900">
                  {{ form.discountType === 'percent' ? 'Giảm theo % (Phần trăm)' : 'Giảm theo số tiền cố định' }}
                </span>
              </div>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </div>
          </div>

          <!-- Giá trị giảm -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Giá trị giảm
              <span class="text-red-500">*</span>
            </label>
            <div class="relative">
              <input
                v-model="form.discountValue"
                type="number"
                class="w-full px-3 py-2 pr-12 bg-gray-100 border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
              />
              <span class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500">
                {{ form.discountType === 'percent' ? '%' : 'đ' }}
              </span>
            </div>
            <p class="text-sm text-gray-500">
              = Giảm {{ form.discountValue }}{{ form.discountType === 'percent' ? '%' : 'đ' }} trên tổng hóa đơn
            </p>
          </div>

          <!-- Giảm tối đa (Max Cap) -->
          <div
            v-if="form.discountType === 'percent'"
            class="flex flex-col gap-3 p-4 bg-amber-50 border border-amber-200 rounded-xl"
          >
            <div class="flex items-start gap-2">
              <img :src="iconWarning" alt="Warning" class="w-5 h-5 mt-0.5" />
              <div class="flex flex-col gap-1">
                <label class="text-sm font-medium text-gray-900">
                  Giảm tối đa (Max Cap)
                </label>
                <p class="text-xs text-gray-500">
                  Rất quan trọng để tránh lỗ vốn với đơn hàng lớn!
                </p>
              </div>
            </div>
            <div class="relative">
              <input
                v-model="form.maxDiscount"
                type="number"
                class="w-full px-3 py-2 pr-12 bg-white border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
              />
              <span class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500">đ</span>
            </div>
            <p class="text-sm text-gray-500">
              💡 VD: Đơn 1 triệu giảm {{ form.discountValue }}% ={{ form.maxDiscount }}đ
            </p>
          </div>
        </div>
      </div>

      <!-- Card 3: Điều kiện áp dụng -->
      <div class="bg-white rounded-2xl border border-gray-200 p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconCondition" alt="Condition" class="w-5 h-5" />
          <h2 class="text-base text-gray-900 font-normal">3. Điều kiện áp dụng (Smart Logic)</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Áp dụng cho -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">Áp dụng cho</label>
            <div
              @click="toggleApplyTo"
              class="flex items-center justify-between px-3 py-2 bg-gray-100 border-0 rounded-lg cursor-pointer hover:bg-gray-200"
            >
              <span class="text-sm text-gray-900">
                {{ form.applyTo === 'all' ? 'Toàn bộ đơn hàng' : 'Nhóm dịch vụ cụ thể' }}
              </span>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </div>
          </div>

          <!-- Giá trị đơn tối thiểu -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Giá trị đơn tối thiểu (Optional)
            </label>
            <div class="relative">
              <input
                v-model="form.minOrderValue"
                type="number"
                class="w-full px-3 py-2 pr-12 bg-gray-100 border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
              />
              <span class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500">đ</span>
            </div>
            <p class="text-sm text-gray-500">
              Chỉ áp dụng cho đơn hàng ≥ {{ formatCurrency(form.minOrderValue) }}
            </p>
          </div>

          <!-- Đối tượng khách hàng -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">Đối tượng khách hàng</label>
            <div
              @click="toggleCustomerType"
              class="flex items-center justify-between px-3 py-2 bg-gray-100 border-0 rounded-lg cursor-pointer hover:bg-gray-200"
            >
              <div class="flex items-center gap-2">
                <img :src="iconUsers" alt="Users" class="w-4 h-4" />
                <span class="text-sm text-gray-900">
                  {{ form.customerType === 'all' ? 'Tất cả khách hàng' : 'Khách hàng VIP' }}
                </span>
              </div>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </div>
          </div>
        </div>
      </div>

      <!-- Card 4: Giới hạn & Thời gian -->
      <div class="bg-white rounded-2xl border border-gray-200 p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconCalendar" alt="Calendar" class="w-5 h-5" />
          <h2 class="text-base text-gray-900 font-normal">4. Giới hạn & Thời gian</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Thời gian hiệu lực -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Thời gian hiệu lực
              <span class="text-red-500">*</span>
            </label>
            <div class="grid grid-cols-2 gap-3">
              <div class="flex flex-col gap-1">
                <label class="text-xs font-medium text-gray-500">Từ ngày</label>
                <input
                  v-model="form.startDate"
                  type="date"
                  class="px-3 py-2 bg-gray-100 border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
                />
              </div>
              <div class="flex flex-col gap-1">
                <label class="text-xs font-medium text-gray-500">Đến ngày</label>
                <input
                  v-model="form.endDate"
                  type="date"
                  class="px-3 py-2 bg-gray-100 border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
                />
              </div>
            </div>
          </div>

          <!-- Tổng số lượng mã -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Tổng số lượng mã
              <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.totalQuantity"
              type="number"
              class="w-full px-3 py-2 bg-gray-100 border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
            />
            <p class="text-xs text-gray-500">
              Số lượng tối đa khách hàng có thể sử dụng chương trình này
            </p>
          </div>

          <!-- Giới hạn mỗi khách -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-gray-900">
              Giới hạn mỗi khách
              <span class="text-red-500">*</span>
            </label>
            <input
              v-model="form.perCustomerLimit"
              type="number"
              class="w-full px-3 py-2 bg-gray-100 border-0 rounded-lg text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-teal-600"
            />
            <p class="text-xs text-gray-500">
              Mỗi khách hàng có thể sử dụng bao nhiêu lần
            </p>
          </div>

          <!-- Tóm tắt cấu hình -->
          <div class="flex flex-col gap-2 p-4 bg-teal-50 border border-teal-200 rounded-xl">
            <p class="text-sm font-normal text-gray-800">📋 Tóm tắt cấu hình:</p>
            <ul class="flex flex-col gap-1 text-sm text-gray-700">
              <li>
                • Loại: 
                <strong class="font-bold">{{ form.type === 'voucher' ? 'Voucher' : 'Tự động' }}</strong>
              </li>
              <li>
                • Giảm: 
                <strong class="font-bold">
                  {{ form.discountValue }}{{ form.discountType === 'percent' ? '%' : 'đ' }}
                </strong>
                <span v-if="form.discountType === 'percent'"> (Tối đa: {{ formatCurrency(form.maxDiscount) }})</span>
              </li>
              <li>
                • Đơn tối thiểu: 
                <strong class="font-bold">{{ formatCurrency(form.minOrderValue) }}</strong>
              </li>
              <li>
                • Đối tượng: 
                <strong class="font-bold">{{ form.customerType === 'all' ? 'Tất cả' : 'VIP' }}</strong>
              </li>
              <li>
                • Tổng: 
                <strong class="font-bold">{{ form.totalQuantity }} lượt</strong>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer Actions -->
    <div class="flex items-center justify-end gap-3">
      <button
        @click="handleCancel"
        class="px-4 py-2 bg-white border border-gray-200 rounded-lg text-sm font-medium text-gray-900 hover:bg-gray-50 transition-colors"
      >
        Hủy
      </button>
      <button
        @click="handleUpdate"
        class="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg text-sm font-medium hover:bg-green-700 transition-colors"
      >
        <img :src="iconSave" alt="Save" class="w-4 h-4" />
        <span>Cập nhật chương trình</span>
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'

const router = useRouter()
const route = useRoute()

// Icons
const iconBack = 'https://www.figma.com/api/mcp/asset/2c2ac795-9287-494b-bd32-c66a75a1dee7'
const iconSave = 'https://www.figma.com/api/mcp/asset/8fd01f13-006f-43e7-bdeb-79f8fccfeaf9'
const iconInfo = 'https://www.figma.com/api/mcp/asset/61f55a66-8e54-4ffd-8fd2-758d73d3d0d5'
const iconVoucher = 'https://www.figma.com/api/mcp/asset/a15fbb61-c578-488e-ad3b-533ede381565'
const iconAuto = 'https://www.figma.com/api/mcp/asset/0bb1d994-8160-4c8f-b39c-4b74dadb2a51'
const iconDiscount = 'https://www.figma.com/api/mcp/asset/165751ec-d410-4ee8-88c9-edddcc1b8f7b'
const iconPercent = 'https://www.figma.com/api/mcp/asset/be0fad2c-ae07-457d-9d5c-854e64bad2cf'
const iconChevronDown = 'https://www.figma.com/api/mcp/asset/4ce030ac-631d-4883-8c43-511804c94362'
const iconWarning = 'https://www.figma.com/api/mcp/asset/7a07bee7-34f9-4a62-b150-fb5d1ec2fcc3'
const iconCondition = 'https://www.figma.com/api/mcp/asset/8b899860-c082-47a0-9e2e-5f0f2ff077a3'
const iconUsers = 'https://www.figma.com/api/mcp/asset/70f863c0-4fb2-4db8-af1c-cadf6d7cf5ba'
const iconCalendar = 'https://www.figma.com/api/mcp/asset/4e3fb1db-f0b7-40db-a2f4-c0eb345a8515'

// Form data
const form = reactive({
  name: 'Mừng Khai Trương',
  description: '',
  type: 'voucher', // 'voucher' or 'auto'
  code: 'KHAI-TRUONG-10',
  discountType: 'percent', // 'percent' or 'fixed'
  discountValue: '10',
  maxDiscount: '50000',
  applyTo: 'all', // 'all' or 'specific'
  minOrderValue: '300000',
  customerType: 'all', // 'all' or 'vip'
  startDate: '',
  endDate: '',
  totalQuantity: '100',
  perCustomerLimit: '1'
})

// Methods
const handleBack = () => {
  router.back()
}

const toggleDiscountType = () => {
  form.discountType = form.discountType === 'percent' ? 'fixed' : 'percent'
}

const toggleApplyTo = () => {
  form.applyTo = form.applyTo === 'all' ? 'specific' : 'all'
}

const toggleCustomerType = () => {
  form.customerType = form.customerType === 'all' ? 'vip' : 'all'
}

const formatCurrency = (value) => {
  if (!value) return '0đ'
  return new Intl.NumberFormat('vi-VN').format(value) + 'đ'
}

const handleCancel = () => {
  if (confirm('Bạn có chắc chắn muốn hủy? Các thay đổi sẽ không được lưu.')) {
    router.back()
  }
}

const handleSave = () => {
  console.log('Saving promotion...', form)
  // Add your save logic here
}

const handleUpdate = () => {
  console.log('Updating promotion...', form)
  // Add your update logic here
}

// Load promotion data on mount
onMounted(() => {
  // Fetch promotion data based on route params
  const promotionId = route.params.id
  if (promotionId) {
    // Load data from API
    console.log('Loading promotion:', promotionId)
  }
})
</script>

<style scoped>
/* Custom scrollbar */
::-webkit-scrollbar {
  width: 6px;
}

::-webkit-scrollbar-track {
  background: #f3f4f6;
}

::-webkit-scrollbar-thumb {
  background: #d1d5db;
  border-radius: 3px;
}

::-webkit-scrollbar-thumb:hover {
  background: #9ca3af;
}

/* Remove number input arrows */
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

input[type="number"] {
  -moz-appearance: textfield;
  appearance: textfield;
}
</style>
