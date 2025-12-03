<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white border border-gray-200/60 rounded-[10px] shadow-lg w-[656px] max-h-[90vh] overflow-y-auto relative">
      <!-- Header -->
      <div class="flex items-center justify-between px-6 pt-6 pb-4">
        <div class="flex flex-col gap-0">
          <h2 class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight">
            Chi tiết Phiếu nhập {{ receipt?.code || '#PN001' }}
          </h2>
          <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
            Thông tin chi tiết phiếu nhập kho
          </p>
        </div>
        <!-- <div class="bg-green-100 border border-[#b9f8cf] rounded-lg px-[9px] py-[3px] h-[22px]">
          <span class="font-nunito font-medium text-xs leading-4 text-[#008236]">
            Đã nhập kho
          </span>
        </div> -->
      </div>

      <!-- Content -->
      <div class="flex flex-col gap-6 px-6 py-4">
        <!-- General Info Section -->
        <div class="bg-gray-50 border border-gray-200/60 rounded-[10px] p-[17px] flex flex-col gap-3">
          <h3 class="font-nunito text-sm leading-5 text-[#364153] tracking-tight">
            Thông tin chung
          </h3>
          
          <div class="grid grid-cols-3 gap-4">
            <!-- Supplier -->
            <div class="flex flex-col gap-1">
              <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                Nhà cung cấp
              </p>
              <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                {{ receipt?.supplier || 'Công ty TNHH Dược phẩm ABC' }}
              </p>
            </div>

            <!-- Import Date -->
            <div class="flex flex-col gap-1">
              <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                Ngày nhập
              </p>
              <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                {{ receipt?.importDate || '2024-11-01' }}
              </p>
            </div>

            <!-- Importer -->
            <div class="flex flex-col gap-1">
              <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                Người nhập
              </p>
              <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                {{ receipt?.importer || 'Nguyễn Văn A' }}
              </p>
            </div>
          </div>
        </div>

        <!-- Items List Section -->
        <div class="flex flex-col gap-3">
          <h3 class="font-nunito text-sm leading-5 text-[#364153] tracking-tight">
            Danh sách hàng hóa
          </h3>

          <!-- Items Table -->
          <div class="border border-gray-200/60 rounded-[10px] overflow-hidden">
            <table class="w-full">
              <thead class="bg-gray-50">
                <tr class="border-b border-gray-200/60">
                  <th class="text-left py-[10px] px-2 w-[43px]">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">STT</span>
                  </th>
                  <th class="text-left py-[10px] px-2 min-w-[160px]">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tên hàng hóa</span>
                  </th>
                  <th class="text-left py-[10px] px-2 w-[45px]">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">ĐVT</span>
                  </th>
                  <th class="text-right py-[10px] px-2 w-[74px]">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Số lượng</span>
                  </th>
                  <th class="text-right py-[10px] px-2 w-[75px]">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Đơn giá</span>
                  </th>
                  <th class="text-left py-[10px] px-2 w-[115px]">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Lô / Hạn dùng</span>
                  </th>
                  <th class="text-right py-[10px] px-2 w-[95px]">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thành tiền</span>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="(item, index) in items"
                  :key="index"
                  class="border-b border-gray-200/60"
                >
                  <!-- STT -->
                  <td class="py-4 px-2 text-center">
                    <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
                      {{ index + 1 }}
                    </span>
                  </td>

                  <!-- Product Name -->
                  <td class="py-2 px-2">
                    <div class="flex flex-col gap-0">
                      <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                        {{ item.name }}
                      </span>
                      <span class="font-nunito text-xs leading-4 text-[#6a7282]">
                        {{ item.code }}
                      </span>
                    </div>
                  </td>

                  <!-- Unit -->
                  <td class="py-4 px-2">
                    <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
                      {{ item.unit }}
                    </span>
                  </td>

                  <!-- Quantity -->
                  <td class="py-4 px-2 text-right">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                      {{ item.quantity }}
                    </span>
                  </td>

                  <!-- Unit Price -->
                  <td class="py-4 px-2 text-right">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                      {{ formatCurrency(item.unitPrice) }}
                    </span>
                  </td>

                  <!-- Lot / Expiry -->
                  <td class="py-2 px-2">
                    <div class="flex flex-col gap-1">
                      <span class="font-nunito text-xs leading-4 text-[#101828]">
                        Lô: {{ item.lotNumber }}
                      </span>
                      <span class="font-nunito text-xs leading-4 text-[#f54900]">
                        HSD: {{ item.expiryDate }}
                      </span>
                    </div>
                  </td>

                  <!-- Total -->
                  <td class="py-4 px-2 text-right">
                    <span class="font-nunito text-sm leading-5 text-[#009689] tracking-tight">
                      {{ formatCurrency(item.total) }}
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Summary Section -->
        <div class="border-t border-gray-200/60 pt-[17px] pl-[287px] flex flex-col gap-2">
          <!-- Total Quantity -->
          <div class="flex items-center justify-between">
            <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
              Tổng số lượng:
            </span>
            <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
              {{ totalQuantity }} sản phẩm
            </span>
          </div>

          <!-- Total Amount -->
          <div class="border-t border-gray-200/60 pt-[9px] flex items-center justify-between">
            <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">
              Tổng tiền hàng:
            </span>
            <span class="font-nunito text-lg leading-7 text-[#009689] tracking-tight">
              {{ formatCurrency(totalAmount) }}
            </span>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="flex items-center justify-end gap-2 px-6 py-4 border-t border-gray-200/60">
        <button
          @click="$emit('close')"
          class="bg-white border border-gray-200/60 rounded-lg h-9 px-[17px] py-[9px] hover:bg-gray-50 transition-colors"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Đóng</span>
        </button>
        <button
          @click="handlePrint"
          class="bg-[#009689] rounded-lg h-9 px-3 py-2 flex items-center gap-2 hover:bg-[#007d72] transition-colors"
        >
          <img :src="iconPrint" alt="" class="w-4 h-4" />
          <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">In phiếu nhập</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

// Props
const props = defineProps({
  receipt: {
    type: Object,
    default: () => ({
      code: '#PN001',
      supplier: 'Công ty TNHH Dược phẩm ABC',
      importDate: '2024-11-01',
      importer: 'Nguyễn Văn A',
      status: 'completed'
    })
  },
  itemsData: {
    type: Array,
    default: () => [
      {
        name: 'Zoletil 50',
        code: 'MED001',
        unit: 'Lọ',
        quantity: 50,
        unitPrice: 50000,
        lotNumber: 'LOT2024001',
        expiryDate: '2025-12-15',
        total: 2500000
      },
      {
        name: 'Kháng sinh Amoxicillin',
        code: 'MED002',
        unit: 'Viên',
        quantity: 500,
        unitPrice: 500,
        lotNumber: 'AMO2023015',
        expiryDate: '2024-11-20',
        total: 250000
      }
    ]
  }
})

// Emits
const emit = defineEmits(['close', 'print'])

// Icons from Figma (expire in 7 days)
const iconPrint = "https://www.figma.com/api/mcp/asset/53268957-177a-4bdd-8dcf-af164696ce79"

// Computed
const items = computed(() => props.itemsData)

const totalQuantity = computed(() => {
  return items.value.reduce((sum, item) => sum + item.quantity, 0)
})

const totalAmount = computed(() => {
  return items.value.reduce((sum, item) => sum + item.total, 0)
})

// Methods
const formatCurrency = (amount) => {
  return `${(amount || 0).toLocaleString('vi-VN')} ₫`
}

const handlePrint = () => {
  emit('print', props.receipt)
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
</style>
