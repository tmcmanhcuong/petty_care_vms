<template>
  <div class="flex flex-col gap-6 h-full bg-[#f3f3f5] p-6">
    <!-- Header -->
    <div class="flex items-center justify-between h-[60px]">
      <div class="flex items-center gap-4">
        <button
          @click="handleBack"
          class="flex items-center gap-2 px-3 py-2 rounded-lg hover:bg-gray-100 transition-colors"
        >
          <img :src="iconBack" alt="Back" class="w-4 h-4" />
          <span class="text-sm font-medium text-neutral-950">Quay lại</span>
        </button>
        <div class="flex flex-col">
          <h1 class="text-2xl font-medium text-[#101828]">Tạo khuyến mãi mới</h1>
          <p class="text-base text-[#4a5565]">Thiết lập các điều kiện và mức giảm giá</p>
        </div>
      </div>
      <button
        @click="handleSave"
        class="flex items-center gap-2 px-4 py-2 bg-[#00a63e] text-white rounded-lg hover:bg-[#008c35] transition-colors"
      >
        <img :src="iconSave" alt="Save" class="w-4 h-4" />
        <span class="text-sm font-medium">Lưu chương trình</span>
      </button>
    </div>

    <!-- Main Content Grid -->
    <div class="grid grid-cols-2 gap-6">
      <!-- Card 1: Thông tin cơ bản -->
      <div class="bg-white rounded-[14px] border border-[rgba(0,0,0,0.1)] p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconInfo" alt="Info" class="w-5 h-5" />
          <h2 class="text-base text-neutral-950">1. Thông tin cơ bản</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Tên chương trình -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Tên chương trình
              <span class="text-[#fb2c36]">*</span>
            </label>
            <input
              v-model="form.name"
              type="text"
              placeholder="VD: Tri ân khách hàng tháng 11"
              class="w-full px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
          </div>

          <!-- Mô tả ngắn -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Mô tả ngắn (Optional)
            </label>
            <textarea
              v-model="form.description"
              rows="3"
              placeholder="Giải thích về chương trình khuyến mãi này..."
              class="w-full px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg text-sm resize-none focus:outline-none focus:ring-2 focus:ring-[#009689]"
            ></textarea>
          </div>

          <!-- Loại khuyến mãi -->
          <div class="flex flex-col gap-3">
            <label class="text-sm font-medium text-neutral-950">
              Loại khuyến mãi
              <span class="text-[#fb2c36]">*</span>
            </label>

            <!-- Option 1: Voucher -->
            <div
              @click="form.type = 'voucher'"
              :class="[
                'flex flex-col gap-1 p-4 rounded-[10px] border-2 cursor-pointer transition-all',
                form.type === 'voucher'
                  ? 'bg-teal-50 border-[#009689]'
                  : 'bg-white border-gray-200 hover:border-gray-300'
              ]"
            >
              <div class="flex items-start gap-3">
                <div class="flex items-center justify-center w-4 h-4 mt-1">
                  <div
                    :class="[
                      'w-4 h-4 rounded-full border-2 flex items-center justify-center',
                      form.type === 'voucher'
                        ? 'border-[#009689]'
                        : 'border-[#d1d5dc]'
                    ]"
                  >
                    <div
                      v-if="form.type === 'voucher'"
                      class="w-2 h-2 rounded-full bg-[#009689]"
                    ></div>
                  </div>
                </div>
                <div class="flex-1">
                  <div class="flex items-center gap-2 mb-1">
                    <img :src="iconVoucher" alt="Voucher" class="w-4 h-4" />
                    <span class="text-base text-[#101828]">Mã giảm giá (Voucher)</span>
                  </div>
                  <p class="text-sm text-[#4a5565]">
                    Khách hàng phải nhập mã code để áp dụng giảm giá
                  </p>
                </div>
              </div>
            </div>

            <!-- Option 2: Auto -->
            <div
              @click="form.type = 'auto'"
              :class="[
                'flex flex-col gap-1 p-4 rounded-[10px] border-2 cursor-pointer transition-all',
                form.type === 'auto'
                  ? 'bg-teal-50 border-[#009689]'
                  : 'bg-white border-gray-200 hover:border-gray-300'
              ]"
            >
              <div class="flex items-start gap-3">
                <div class="flex items-center justify-center w-4 h-4 mt-1">
                  <div
                    :class="[
                      'w-4 h-4 rounded-full border-2 flex items-center justify-center',
                      form.type === 'auto'
                        ? 'border-[#009689]'
                        : 'border-[#d1d5dc]'
                    ]"
                  >
                    <div
                      v-if="form.type === 'auto'"
                      class="w-2 h-2 rounded-full bg-[#009689]"
                    ></div>
                  </div>
                </div>
                <div class="flex-1">
                  <div class="flex items-center gap-2 mb-1">
                    <img :src="iconAuto" alt="Auto" class="w-4 h-4" />
                    <span class="text-base text-[#101828]">Chương trình tự động</span>
                  </div>
                  <p class="text-sm text-[#4a5565]">
                    Hệ thống tự động trừ tiền khi đủ điều kiện
                  </p>
                </div>
              </div>
            </div>
          </div>

          <!-- Mã Code (chỉ hiện khi chọn voucher) -->
          <div
            v-if="form.type === 'voucher'"
            class="flex flex-col gap-2 p-4 bg-purple-50 border border-[#e9d4ff] rounded-[10px]"
          >
            <label class="text-sm font-medium text-neutral-950">
              Mã Code
              <span class="text-[#fb2c36]">*</span>
            </label>
            <input
              v-model="form.code"
              type="text"
              placeholder="VD: SALE11, TET2025"
              class="w-full px-3 py-2 bg-white border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <p class="text-xs text-[#4a5565]">
              💡 Gợi ý: Dùng chữ in hoa, dễ nhớ (6-12 ký tự)
            </p>
          </div>
        </div>
      </div>

      <!-- Card 2: Mức giảm giá -->
      <div class="bg-white rounded-[14px] border border-[rgba(0,0,0,0.1)] p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconDiscount" alt="Discount" class="w-5 h-5" />
          <h2 class="text-base text-neutral-950">2. Mức giảm giá (The Logic)</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Hình thức giảm -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Hình thức giảm
              <span class="text-[#fb2c36]">*</span>
            </label>
            <div
              @click="toggleDiscountType"
              class="flex items-center justify-between px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg cursor-pointer hover:bg-gray-100"
            >
              <div class="flex items-center gap-2">
                <img :src="iconPercent" alt="Percent" class="w-4 h-4" />
                <span class="text-sm text-neutral-950">
                  {{ form.discountType === 'percent' ? 'Giảm theo % (Phần trăm)' : 'Giảm theo số tiền cố định' }}
                </span>
              </div>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </div>
          </div>

          <!-- Giá trị giảm -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Giá trị giảm
              <span class="text-[#fb2c36]">*</span>
            </label>
            <div class="relative">
              <input
                v-model="form.discountValue"
                type="number"
                placeholder="VD: 20"
                class="w-full px-3 py-2 pr-12 bg-[#f3f3f5] border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
              <span class="absolute right-3 top-1/2 -translate-y-1/2 text-[#6a7282]">
                {{ form.discountType === 'percent' ? '%' : 'đ' }}
              </span>
            </div>
          </div>

          <!-- Giảm tối đa (Max Cap) -->
          <div
            v-if="form.discountType === 'percent'"
            class="flex flex-col gap-3 p-4 bg-amber-50 border border-[#fee685] rounded-[10px]"
          >
            <div class="flex items-start gap-2">
              <img :src="iconWarning" alt="Warning" class="w-5 h-5 mt-0.5" />
              <div class="flex flex-col gap-1">
                <label class="text-sm font-medium text-neutral-950">
                  Giảm tối đa (Max Cap)
                </label>
                <p class="text-xs text-[#4a5565]">
                  Rất quan trọng để tránh lỗ vốn với đơn hàng lớn!
                </p>
              </div>
            </div>
            <div class="relative">
              <input
                v-model="form.maxDiscount"
                type="number"
                placeholder="VD: 50000"
                class="w-full px-3 py-2 pr-12 bg-white border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
              <span class="absolute right-3 top-1/2 -translate-y-1/2 text-[#6a7282]">đ</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Card 3: Điều kiện áp dụng -->
      <div class="bg-white rounded-[14px] border border-[rgba(0,0,0,0.1)] p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconCondition" alt="Condition" class="w-5 h-5" />
          <h2 class="text-base text-neutral-950">3. Điều kiện áp dụng (Smart Logic)</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Áp dụng cho -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Áp dụng cho</label>
            <div
              @click="toggleApplyTo"
              class="flex items-center justify-between px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg cursor-pointer hover:bg-gray-100"
            >
              <span class="text-sm text-neutral-950">
                {{ form.applyTo === 'all' ? 'Toàn bộ đơn hàng' : 'Nhóm dịch vụ cụ thể' }}
              </span>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </div>
          </div>

          <!-- Chọn dịch vụ áp dụng (chỉ hiện khi chọn specific) -->
          <div
            v-if="form.applyTo === 'specific'"
            class="flex flex-col gap-3 p-4 bg-blue-50 border border-[#bedbff] rounded-[10px]"
          >
            <label class="text-sm font-medium text-neutral-950">
              Chọn dịch vụ áp dụng
            </label>
            <div class="flex flex-col gap-2 max-h-[320px] overflow-y-auto">
              <label
                v-for="service in services"
                :key="service.id"
                class="flex items-center gap-3 px-3 py-3 bg-white border border-gray-200 rounded-[10px] cursor-pointer hover:bg-gray-50 transition-colors"
              >
                <input
                  type="checkbox"
                  v-model="form.selectedServices"
                  :value="service.id"
                  class="w-4 h-4 rounded border-2 border-[#d1d5dc] text-[#009689] focus:ring-[#009689]"
                />
                <span class="text-sm text-[#101828]">{{ service.name }}</span>
              </label>
            </div>
            <p class="text-xs text-[#4a5565]">
              💡 VD: Chỉ giảm cho Spa, không giảm cho Thuốc
            </p>
          </div>

          <!-- Giá trị đơn tối thiểu -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Giá trị đơn tối thiểu (Optional)
            </label>
            <div class="relative">
              <input
                v-model="form.minOrderValue"
                type="number"
                placeholder="VD: 300000"
                class="w-full px-3 py-2 pr-12 bg-[#f3f3f5] border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
              <span class="absolute right-3 top-1/2 -translate-y-1/2 text-[#6a7282]">đ</span>
            </div>
          </div>

          <!-- Đối tượng khách hàng -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Đối tượng khách hàng</label>
            <div
              @click="toggleCustomerType"
              class="flex items-center justify-between px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg cursor-pointer hover:bg-gray-100"
            >
              <div class="flex items-center gap-2">
                <img :src="iconUsers" alt="Users" class="w-4 h-4" />
                <span class="text-sm text-neutral-950">
                  {{ form.customerType === 'all' ? 'Tất cả khách hàng' : 'Khách hàng VIP' }}
                </span>
              </div>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </div>
          </div>
        </div>
      </div>

      <!-- Card 4: Giới hạn & Thời gian -->
      <div class="bg-white rounded-[14px] border border-[rgba(0,0,0,0.1)] p-6">
        <div class="flex items-center gap-2 mb-6">
          <img :src="iconCalendar" alt="Calendar" class="w-5 h-5" />
          <h2 class="text-base text-neutral-950">4. Giới hạn & Thời gian</h2>
        </div>

        <div class="flex flex-col gap-4">
          <!-- Thời gian hiệu lực -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Thời gian hiệu lực
              <span class="text-[#fb2c36]">*</span>
            </label>
            <div class="grid grid-cols-2 gap-3">
              <div class="flex flex-col gap-1">
                <label class="text-xs font-medium text-[#4a5565]">Từ ngày</label>
                <input
                  v-model="form.startDate"
                  type="date"
                  class="px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
              </div>
              <div class="flex flex-col gap-1">
                <label class="text-xs font-medium text-[#4a5565]">Đến ngày</label>
                <input
                  v-model="form.endDate"
                  type="date"
                  class="px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
              </div>
            </div>
          </div>

          <!-- Tổng số lượng mã -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Tổng số lượng mã
              <span class="text-[#fb2c36]">*</span>
            </label>
            <input
              v-model="form.totalQuantity"
              type="number"
              placeholder="VD: 100"
              class="w-full px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <p class="text-xs text-[#4a5565]">
              Số lượng tối đa khách hàng có thể sử dụng chương trình này
            </p>
          </div>

          <!-- Giới hạn mỗi khách -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">
              Giới hạn mỗi khách
              <span class="text-[#fb2c36]">*</span>
            </label>
            <input
              v-model="form.perCustomerLimit"
              type="number"
              placeholder="1"
              class="w-full px-3 py-2 bg-[#f3f3f5] border border-transparent rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <p class="text-xs text-[#4a5565]">
              Mỗi khách hàng có thể sử dụng bao nhiêu lần
            </p>
          </div>

          <!-- Tóm tắt cấu hình -->
          <div class="flex flex-col gap-2 p-4 bg-teal-50 border border-[#96f7e4] rounded-[10px]">
            <p class="text-sm font-medium text-[#101828]">📋 Tóm tắt cấu hình:</p>
            <ul class="flex flex-col gap-1 text-sm text-[#364153]">
              <li>
                • Loại: 
                <strong class="font-bold">{{ form.type === 'voucher' ? 'Voucher' : 'Tự động' }}</strong>
              </li>
              <li>
                • Đối tượng: 
                <strong class="font-bold">{{ form.customerType === 'all' ? 'Tất cả' : 'VIP' }}</strong>
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
        class="px-4 py-2 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors"
      >
        Hủy
      </button>
      <button
        @click="handleCreate"
        class="flex items-center gap-2 px-4 py-2 bg-[#00a63e] text-white rounded-lg text-sm font-medium hover:bg-[#008c35] transition-colors"
      >
        <img :src="iconSave" alt="Save" class="w-4 h-4" />
        <span>Tạo chương trình</span>
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Icons - Replace with your actual icon paths
const iconBack = 'https://www.figma.com/api/mcp/asset/2833a072-3c1e-473f-a7d0-f72972a54afc'
const iconSave = 'https://www.figma.com/api/mcp/asset/ce07e089-dce1-41d2-8b67-2f7b95cf5f37'
const iconInfo = 'https://www.figma.com/api/mcp/asset/60e4ee2a-bb38-4b7e-a342-76c4d4b743d0'
const iconVoucher = 'https://www.figma.com/api/mcp/asset/04c81bd0-4298-4ef5-95b9-86be400f1674'
const iconAuto = 'https://www.figma.com/api/mcp/asset/cd8c94c8-61d8-4a57-98a7-97a2f2cf252d'
const iconDiscount = 'https://www.figma.com/api/mcp/asset/f3120024-852b-4274-b327-b93e347d11f6'
const iconPercent = 'https://www.figma.com/api/mcp/asset/e0de8752-5c0c-49fe-ac0a-113be9b9329d'
const iconChevronDown = 'https://www.figma.com/api/mcp/asset/0ba16cdf-9a22-4228-88c1-36c8b7fe134d'
const iconWarning = 'https://www.figma.com/api/mcp/asset/325694c3-5085-44a0-b711-2619e613aa31'
const iconCondition = 'https://www.figma.com/api/mcp/asset/10c0e793-cad4-4588-83be-8f9c526e34ee'
const iconUsers = 'https://www.figma.com/api/mcp/asset/fd23a3d6-0a39-4038-a357-75f8d609d118'
const iconCalendar = 'https://www.figma.com/api/mcp/asset/d33dc2e7-262c-45b7-8d08-ae09b640c221'

// Services list
const services = [
  { id: 'spa', name: 'Dịch vụ Spa' },
  { id: 'grooming', name: 'Cắt tỉa lông' },
  { id: 'checkup', name: 'Khám tổng quát' },
  { id: 'vaccine', name: 'Tiêm phòng' },
  { id: 'surgery', name: 'Phẫu thuật' },
  { id: 'medicine', name: 'Thuốc & Vật tư' }
]

// Form data
const form = reactive({
  name: '',
  description: '',
  type: 'voucher', // 'voucher' or 'auto'
  code: '',
  discountType: 'percent', // 'percent' or 'fixed'
  discountValue: '',
  maxDiscount: '',
  applyTo: 'all', // 'all' or 'specific'
  selectedServices: [], // Array of selected service IDs
  minOrderValue: '',
  customerType: 'all', // 'all' or 'vip'
  startDate: '',
  endDate: '',
  totalQuantity: '',
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

const handleCancel = () => {
  if (confirm('Bạn có chắc chắn muốn hủy? Các thay đổi sẽ không được lưu.')) {
    router.back()
  }
}

const handleSave = () => {
  console.log('Saving promotion...', form)
  // Add your save logic here
}

const handleCreate = () => {
  console.log('Creating promotion...', form)
  // Add your create logic here
}
</script>

<style scoped>
/* Custom scrollbar for the form */
::-webkit-scrollbar {
  width: 6px;
}

::-webkit-scrollbar-track {
  background: #f3f3f5;
}

::-webkit-scrollbar-thumb {
  background: #d1d5dc;
  border-radius: 3px;
}

::-webkit-scrollbar-thumb:hover {
  background: #a1a1aa;
}
</style>
