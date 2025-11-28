<template>
  <div class="flex flex-col gap-6 w-full font-nunito h-full">
    <!-- Header -->
    <div class="flex items-center justify-between">
      <div class="flex flex-col">
        <h1 class="text-2xl font-medium text-[#101828] leading-9">Quản lý Mã giảm giá & CTKM</h1>
        <p class="text-base text-[#4a5565] leading-6">Tạo và quản lý các chương trình khuyến mãi</p>
      </div>
      <button 
        @click="router.push('/admin/khuyen-mai/them-moi')"
        class="bg-[#00a63e] text-white rounded-lg px-4 py-2 h-9 flex items-center gap-2 text-sm font-medium hover:bg-[#008c35] transition-colors"
      >
        <img :src="iconPlus" alt="" class="w-4 h-4" />
        Tạo khuyến mãi mới  
      </button>
    </div>

    <!-- Search and Filters -->
    <div class="bg-white border border-black/10 rounded-[14px] p-[25px]">
      <div class="flex flex-col gap-4">
        <!-- Search Bar -->
        <div class="relative w-full">
          <img :src="iconSearch" alt="" class="absolute left-3 top-2.5 w-5 h-5" />
          <input
            type="text"
            v-model="searchQuery"
            placeholder="Tìm theo tên chương trình, mã code (VD: TET2025)..."
            class="w-full h-9 pl-10 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] placeholder-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
          />
        </div>

        <!-- Filters -->
        <div class="grid grid-cols-2 gap-4">
          <!-- Status Filter -->
          <button class="bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 flex items-center justify-between h-9 hover:bg-gray-200 transition-colors">
            <span class="text-sm text-neutral-950">Tất cả trạng thái</span>
            <img :src="iconChevronDown" alt="" class="w-4 h-4" />
          </button>

          <!-- Type Filter -->
          <button class="bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 flex items-center justify-between h-9 hover:bg-gray-200 transition-colors">
            <span class="text-sm text-neutral-950">Tất cả loại hình</span>
            <img :src="iconChevronDown" alt="" class="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>

    <!-- Promotions Table -->
    <div class="bg-white border border-black/10 rounded-[14px] p-[25px]">
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead>
            <tr class="border-b border-black/10">
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2 w-[220px]">Tên chương trình</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Mức giảm</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Loại hình</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Thời gian</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2 w-[180px]">Lượt sử dụng</th>
              <th class="text-left text-sm font-medium text-neutral-950 py-2.5 px-2">Trạng thái</th>
              <th class="text-right text-sm font-medium text-neutral-950 py-2.5 px-2">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <tr 
              v-for="promo in promotions" 
              :key="promo.id"
              class="border-b border-black/10 hover:bg-gray-50 transition-colors last:border-0"
            >
              <!-- Name & Code -->
              <td class="py-4 px-2 align-top">
                <div class="flex flex-col gap-1">
                  <p class="text-sm text-[#101828] font-normal leading-5">{{ promo.name }}</p>
                  <p v-if="promo.code" class="text-sm text-[#6a7282] leading-5">
                    (Mã: <span class="text-[#009689] font-normal">{{ promo.code }}</span>)
                  </p>
                </div>
              </td>

              <!-- Value -->
              <td class="py-4 px-2 align-top">
                <div class="flex flex-col gap-1">
                  <p class="text-sm text-[#101828] font-normal leading-5">{{ promo.value }}</p>
                  <p class="text-xs text-[#6a7282] leading-4" v-if="promo.maxDiscount">Tối đa: {{ promo.maxDiscount }}</p>
                </div>
              </td>

              <!-- Type -->
              <td class="py-4 px-2 align-top">
                <span 
                  class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-lg border text-xs font-medium"
                  :class="getTypeClass(promo.type)"
                >
                  <span v-html="promo.type === 'voucher' ? svgVoucher : svgAuto"></span>
                  {{ promo.typeLabel }}
                </span>
              </td>

              <!-- Date -->
              <td class="py-4 px-2 align-top">
                <div class="flex items-start gap-2">
                   <img :src="iconCalendar" alt="" class="w-4 h-4 mt-0.5" />
                   <span class="text-sm text-[#4a5565] leading-5">{{ promo.dateRange }}</span>
                </div>
              </td>

              <!-- Usage Progress -->
              <td class="py-4 px-2 align-top">
                <div class="flex flex-col gap-2 w-full max-w-[160px]">
                  <div class="flex justify-between items-center text-sm leading-5">
                    <span class="text-[#101828]">{{ promo.used }} / {{ promo.total }}</span>
                    <span class="text-[#6a7282]">{{ Math.round((promo.used / promo.total) * 100) }}%</span>
                  </div>
                  <div class="w-full h-2 bg-[#030213]/20 rounded-full overflow-hidden">
                    <div 
                      class="h-full bg-[#030213] rounded-full"
                      :style="{ width: `${(promo.used / promo.total) * 100}%` }"
                    ></div>
                  </div>
                </div>
              </td>

              <!-- Status -->
              <td class="py-4 px-2 align-top">
                <div class="flex flex-col gap-2">
                  <span 
                    class="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-lg border-0 text-xs font-medium w-fit"
                    :class="getStatusClass(promo.status)"
                  >
                    {{ promo.statusLabel }}
                  </span>
                  
                  <!-- Toggle Switch -->
                  <div class="flex items-center gap-2">
                    <button 
                      class="relative w-8 h-4.5 rounded-full transition-colors duration-200 ease-in-out focus:outline-none"
                      :class="promo.isEnabled ? 'bg-[#030213]' : 'bg-[#cbced4]'"
                      @click="toggleStatus(promo)"
                    >
                      <span 
                        class="absolute left-0.5 top-0.5 w-3.5 h-3.5 bg-white rounded-full transition-transform duration-200 ease-in-out"
                        :class="promo.isEnabled ? 'translate-x-3.5' : 'translate-x-0'"
                      ></span>
                    </button>
                    <span class="text-xs text-[#4a5565]">{{ promo.isEnabled ? 'Đang bật' : 'Đã tắt' }}</span>
                  </div>
                </div>
              </td>

              <!-- Actions -->
              <td class="py-4 px-2 align-top">
                <div class="flex items-center justify-end gap-2">
                  <button 
                    class="w-9 h-8 flex items-center justify-center rounded-lg hover:bg-gray-100 transition-colors"
                    title="Xem chi tiết"
                  >
                     <img :src="iconEye" alt="" class="w-4 h-4" />
                  </button>
                  <button 
                    @click="router.push(`/admin/khuyen-mai/chinh-sua/${promo.id}`)"
                    class="w-9 h-8 flex items-center justify-center rounded-lg hover:bg-gray-100 transition-colors"
                    title="Chỉnh sửa"
                  >
                    <img :src="iconEdit" alt="" class="w-4 h-4" />
                  </button>
                  <button 
                    @click="handleDelete(promo)"
                    class="w-9 h-8 flex items-center justify-center rounded-lg hover:bg-gray-100 transition-colors"
                    title="Xóa"
                  >
                    <img :src="iconDelete" alt="" class="w-4 h-4" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modals could be added here -->
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

// Icons
const iconPlus = 'https://www.figma.com/api/mcp/asset/bd491dc9-ee5e-4b10-88a8-62b03bef9093';
const iconSearch = 'https://www.figma.com/api/mcp/asset/8df55cc2-682a-4eaf-baa1-55b3c1c1c558';
const iconChevronDown = 'https://www.figma.com/api/mcp/asset/8d066934-07ff-48dd-abfa-6acf31386f7a';
const iconEdit = 'https://www.figma.com/api/mcp/asset/ded66c3e-db3c-4c02-965a-702a4c0fdca8';
const iconDelete = 'https://www.figma.com/api/mcp/asset/9c38866f-8dd6-447a-84f8-060c94dd483b';
const iconCalendar = 'https://www.figma.com/api/mcp/asset/calendar-placeholder'; 
// Using a placeholder/reused icon for Eye until asset is available, or we can use SVG string if needed.
// For now, I'll use a generic placeholder URL or a data URI for the Eye icon to avoid breaking.
// Better yet, I'll use an SVG string for the Eye icon as well to be safe, but since I'm using img tags for others, I'll try to find a suitable placeholder or reuse one. 
// Actually, let's just use a simple SVG data URI for the Eye icon.
const iconEye = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjNDk1MDU3IiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PHBhdGggZD0iTTIgMTJzNC04IDEwLTggMTAgOCAxMCA4LTQgOC0xMCA4LTEwLTgtMTAtOHoiPjwvcGF0aD48Y2lyY2xlIGN4PSIxMiIgY3k9IjEyIiByPSIzIj48L2NpcmNsZT48L3N2Zz4=';


// Inline SVGs for types (Voucher/Auto) to ensure they render correctly without external assets
const svgVoucher = `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10.5 5.5C10.5 4.94772 10.9477 4.5 11.5 4.5V1.5H0.5V4.5C1.05228 4.5 1.5 4.94772 1.5 5.5C1.5 6.05228 1.05228 6.5 0.5 6.5V9.5H11.5V6.5C10.9477 6.5 10.5 6.05228 10.5 5.5Z" stroke="#8200DB" stroke-linecap="round" stroke-linejoin="round"/></svg>`;
const svgAuto = `<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6.5 1L0.5 7H5.5L4.5 11L10.5 5H5.5L6.5 1Z" stroke="#BB4D00" stroke-linecap="round" stroke-linejoin="round"/></svg>`;

const router = useRouter();
const searchQuery = ref('');

// Mock Data for Promotions (Updated to match Design)
const promotions = ref([
  {
    id: 1,
    name: 'Mừng Khai Trương',
    code: 'KHAI-TRUONG-10',
    value: '10%',
    maxDiscount: '50.000đ',
    type: 'voucher',
    typeLabel: 'Voucher',
    dateRange: '20-11 - 30/11/2025',
    used: 45,
    total: 100,
    status: 'active',
    statusLabel: '🟢 Đang chạy',
    isEnabled: true
  },
  {
    id: 2,
    name: 'Ưu đãi VIP - Tự động',
    code: '', // No code for Auto type in design
    value: '50.000đ',
    maxDiscount: '', // No max discount shown for this one
    type: 'auto',
    typeLabel: 'Tự động',
    dateRange: '01-11 - 31/12/2025',
    used: 23,
    total: 50,
    status: 'active',
    statusLabel: '🟢 Đang chạy',
    isEnabled: true
  },
  {
    id: 3,
    name: 'Flash Sale Spa cuối tuần',
    code: 'SPA-SALE',
    value: '20%',
    maxDiscount: '100.000đ',
    type: 'voucher',
    typeLabel: 'Voucher',
    dateRange: '25-11 - 27/11/2025',
    used: 0,
    total: 200,
    status: 'scheduled',
    statusLabel: '⏰ Sắp diễn ra',
    isEnabled: false
  },
  {
    id: 4,
    name: 'Tết 2025 - Khách hàng mới',
    code: 'TET2025',
    value: '15%',
    maxDiscount: '150.000đ',
    type: 'voucher',
    typeLabel: 'Voucher',
    dateRange: '01-01 - 15/01/2025',
    used: 150,
    total: 150,
    status: 'expired',
    statusLabel: '🔴 Đã kết thúc',
    isEnabled: false // Assuming ended means toggle off or just showing state
  },
  {
    id: 5,
    name: 'Black Friday - Toàn bộ dịch vụ',
    code: 'BLACKFRIDAY',
    value: '25%',
    maxDiscount: '200.000đ',
    type: 'voucher',
    typeLabel: 'Voucher',
    dateRange: '29-11 - 29/11/2025',
    used: 178,
    total: 300,
    status: 'paused',
    statusLabel: '⏸️ Tạm dừng',
    isEnabled: false
  }
]);

// Helper for status styles
const getStatusClass = (status) => {
  const classes = {
    active: 'bg-green-100 text-[#008236]',
    scheduled: 'bg-blue-100 text-[#1447e6]',
    expired: 'bg-gray-100 text-[#364153]',
    paused: 'bg-[#ffedd4] text-[#ca3500]'
  };
  return classes[status] || 'bg-gray-100 text-gray-700';
};

// Helper for type styles
const getTypeClass = (type) => {
  const classes = {
    voucher: 'bg-purple-50 text-[#8200db] border-[#e9d4ff]',
    auto: 'bg-amber-50 text-[#bb4d00] border-[#fee685]'
  };
  return classes[type] || 'bg-gray-50 text-gray-700 border-gray-200';
};

const toggleStatus = (promo) => {
  promo.isEnabled = !promo.isEnabled;
  // Logic to update status on backend would go here
};

const handleDelete = (promo) => {
  if(confirm(`Bạn có chắc chắn muốn xóa khuyến mãi "${promo.name}"?`)) {
    console.log('Delete', promo.id);
    promotions.value = promotions.value.filter(p => p.id !== promo.id);
  }
};
</script>

<style scoped>
.font-nunito {
  font-family: 'Nunito Sans', sans-serif;
}
/* Custom scrollbar for table if needed, though Tailwind's overflow-auto handles basic scrolling */
</style>