<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[9999] pt-24 font-nunito">
    <div class="bg-white border border-gray-200/60 rounded-[10px] w-full max-w-[510px] max-h-[85vh] p-6 flex flex-col gap-4 shadow-xl relative">
      <!-- Header -->
      <div class="flex flex-col gap-2">
        <h2 class="text-2xl font-semibold text-neutral-950 leading-8">
          Chi tiết phiếu chi - {{ expense.code }}
        </h2>
        <p class="text-sm text-[#717182] leading-5">
          Thông tin chi tiết và lịch sử thanh toán
        </p>
      </div>

      <!-- Content - Scrollable -->
      <div class="flex flex-col gap-6 overflow-y-auto flex-1">
        <!-- Info Card -->
        <div class="bg-gray-50 rounded-[10px] p-4 grid grid-cols-2 gap-4">
          <!-- Loại chi -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-[#4a5565]">Loại chi</label>
            <span 
              class="inline-block px-3 py-1 rounded-lg border text-xs font-medium w-fit"
              :class="getCategoryClass(expense.category)"
            >
              {{ expense.categoryLabel }}
            </span>
          </div>

          <!-- Đối tượng nhận tiền -->
          <div class="flex flex-col gap-1">
            <label class="text-sm font-medium text-[#4a5565]">Đối tượng nhận tiền</label>
            <p class="text-base text-[#101828] leading-6">{{ expense.recipient }}</p>
          </div>

          <!-- Nội dung chi -->
          <div class="flex flex-col gap-1">
            <label class="text-sm font-medium text-[#4a5565]">Nội dung chi</label>
            <p class="text-base text-[#101828] leading-6">{{ expense.description }}</p>
          </div>

          <!-- Ngày tạo -->
          <div class="flex flex-col gap-1">
            <label class="text-sm font-medium text-[#4a5565]">Ngày tạo</label>
            <p class="text-base text-[#101828] leading-6">{{ expense.createdAt }}</p>
          </div>

          <!-- Người tạo -->
          <div class="flex flex-col gap-1">
            <label class="text-sm font-medium text-[#4a5565]">Người tạo</label>
            <p class="text-base text-[#101828] leading-6">{{ expense.createdBy }}</p>
          </div>

          <!-- Trạng thái -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-[#4a5565]">Trạng thái</label>
            <span 
              class="inline-block px-3 py-1 rounded-lg border-0 text-xs font-medium w-fit"
              :class="getStatusClass(expense.status)"
            >
              {{ expense.statusLabel }}
            </span>
          </div>
        </div>

        <!-- Summary Card -->
        <div class="bg-red-50 border border-[#ffc9c9] rounded-[10px] p-4">
          <div class="grid grid-cols-3 gap-4">
            <!-- Tổng giá trị -->
            <div class="flex flex-col gap-1 items-center">
              <p class="text-sm text-[#4a5565] leading-5">Tổng giá trị</p>
              <p class="text-xl text-[#101828] leading-7">{{ formatCurrency(expense.totalAmount) }}</p>
            </div>

            <!-- Đã trả -->
            <div class="flex flex-col gap-1 items-center">
              <p class="text-sm text-[#4a5565] leading-5">Đã trả</p>
              <p class="text-xl text-[#00a63e] leading-7">{{ formatCurrency(expense.paidAmount) }}</p>
            </div>

            <!-- Còn nợ -->
            <div class="flex flex-col gap-1 items-center">
              <p class="text-sm text-[#4a5565] leading-5">Còn nợ</p>
              <p class="text-xl text-[#e7000b] leading-7">{{ formatCurrency(expense.remainingAmount) }}</p>
            </div>
          </div>
        </div>

        <!-- Payment History Section -->
        <div class="flex flex-col gap-3">
          <!-- Header with Button -->
          <div class="flex items-center justify-between">
            <h3 class="text-base text-[#101828] leading-6">Lịch sử thanh toán</h3>
            <!-- <button 
              v-if="expense.remainingAmount > 0"
              @click="$emit('add-payment')"
              class="bg-[#f54900] text-white rounded-lg px-3 py-2 h-8 flex items-center gap-2 text-sm font-medium hover:bg-[#d43f00] transition-colors"
            >
              <img :src="iconPlus" alt="" class="w-4 h-4" />
              Thanh toán thêm
            </button> -->
          </div>

          <!-- Payment History Items -->
          <div class="flex flex-col gap-3">
            <div 
              v-for="(payment, index) in expense.paymentHistory" 
              :key="index"
              class="bg-white border border-black/10 rounded-[10px] p-4"
            >
              <div class="flex items-start justify-between">
                <div class="flex flex-col gap-2 flex-1">
                  <!-- Payment number and date -->
                  <div class="flex items-center gap-3">
                    <span class="border border-black/10 rounded-lg px-2 py-1 text-sm font-medium text-neutral-950">
                      Lần {{ index + 1 }}
                    </span>
                    <span class="text-sm text-[#4a5565] leading-5">
                      {{ payment.date }}
                    </span>
                  </div>

                  <!-- Payment details -->
                  <div class="flex flex-col gap-1">
                    <p class="text-sm text-neutral-950 leading-5">{{ payment.method }}</p>
                    <p class="text-lg text-[#101828] leading-7">
                      Số tiền: 
                      <span class="font-bold text-[#00a63e]">{{ formatCurrency(payment.amount) }}</span>
                    </p>
                    <p class="text-sm text-[#4a5565] leading-5 italic">
                      Ghi chú: {{ payment.note }}
                    </p>
                  </div>
                </div>

                <!-- Status Badge -->
                <span class="bg-green-100 border-0 rounded-lg px-3 py-1 text-xs font-medium text-[#008236] flex items-center gap-1">
                  <img :src="iconCheck" alt="" class="w-3 h-3" />
                  Thành công
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="flex items-center justify-center pt-2 border-t border-black/10">
        <button 
          @click="$emit('close')"
          class="bg-white border border-black/10 rounded-lg px-4 py-2 h-9 text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors"
        >
          Đóng
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';

// Icons
const iconPlus = 'https://www.figma.com/api/mcp/asset/f5c9e8e8-9dd6-4412-8668-a11e39c18cd4';
const iconCheck = 'https://www.figma.com/api/mcp/asset/5f04eea2-bc66-4e58-95f5-505282ec50e6';

// Props
const props = defineProps({
  expense: {
    type: Object,
    required: true,
    default: () => ({
      code: 'PC0056',
      category: 'purchase',
      categoryLabel: 'Nhập hàng',
      recipient: 'Công ty CP Dược Thú Y Việt Nam',
      description: 'Nhập thuốc lô A1 - Tháng 11',
      createdAt: '09:30 - 20/11/2025',
      createdBy: 'Kế toán Hoa',
      status: 'debt',
      statusLabel: 'Còn nợ NCC',
      totalAmount: 15000000,
      paidAmount: 5000000,
      remainingAmount: 10000000,
      paymentHistory: [
        {
          date: '10:00 - 10/11/2025',
          method: '🏦 Chuyển khoản',
          amount: 5000000,
          note: 'Trả đợt 1',
          status: 'success'
        }
      ]
    })
  }
});

// Define emits
const emit = defineEmits(['close', 'add-payment']);

// Format currency
const formatCurrency = (amount) => {
  return new Intl.NumberFormat('vi-VN', {
    style: 'decimal',
    minimumFractionDigits: 0
  }).format(amount) + 'đ';
};

// Get category badge class
const getCategoryClass = (category) => {
  const classes = {
    purchase: 'bg-blue-100 border-black/10 text-[#1447e6]',
    operating: 'bg-[#fef9c2] border-black/10 text-[#a65f00]'
  };
  return classes[category] || 'bg-gray-100 border-black/10 text-gray-700';
};

// Get status badge class
const getStatusClass = (status) => {
  const classes = {
    completed: 'bg-green-100 text-[#008236]',
    debt: 'bg-[#ffedd4] text-[#ca3500]'
  };
  return classes[status] || 'bg-gray-100 text-gray-700';
};
</script>

<style scoped>
/* Ensure Nunito Sans font is applied */
.font-nunito {
  font-family: 'Nunito Sans', sans-serif;
}

/* Scrollbar styling */
.overflow-y-auto::-webkit-scrollbar {
  width: 6px;
}

.overflow-y-auto::-webkit-scrollbar-track {
  background: #f3f3f5;
  border-radius: 3px;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #c4c4c4;
  border-radius: 3px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
  background: #a0a0a0;
}
</style>
