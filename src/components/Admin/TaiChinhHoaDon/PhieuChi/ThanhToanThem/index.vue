<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[9999] pt-24 font-nunito">
    <div class="bg-white border border-black/10 rounded-[10px] shadow-xl w-full max-w-[510px] relative">
      <!-- Close Button -->
      <button 
        @click="$emit('close')"
        class="absolute right-4 top-4 opacity-70 hover:opacity-100 transition-opacity"
      >
        <img :src="iconClose" alt="Close" class="w-4 h-4" />
      </button>

      <div class="p-6 flex flex-col gap-4">
        <!-- Header -->
        <div class="flex flex-col gap-2">
          <h2 class="text-lg font-semibold text-neutral-950">
            Thanh toán thêm - {{ expenseCode }}
          </h2>
          <p class="text-sm text-[#717182] leading-5">
            Trả nợ dần cho {{ supplierName }}
          </p>
        </div>

        <!-- Form Content -->
        <div class="flex flex-col gap-4">
          <!-- Debt Info Card -->
          <div class="bg-orange-50 border border-[#ffd6a7] rounded-[10px] p-4 flex flex-col gap-2">
            <p class="text-sm text-[#4a5565] leading-5">Thông tin công nợ:</p>
            <div class="flex flex-col gap-1">
              <p class="text-sm text-neutral-950 leading-5">
                Tổng giá trị: 
                <span class="font-bold">{{ formatCurrency(totalAmount) }}</span>
              </p>
              <p class="text-sm text-neutral-950 leading-5">
                Đã trả: 
                <span class="font-bold text-[#00a63e]">{{ formatCurrency(paidAmount) }}</span>
              </p>
              <p class="text-sm text-neutral-950 leading-5">
                Còn nợ: 
                <span class="font-bold text-[#e7000b]">{{ formatCurrency(remainingAmount) }}</span>
              </p>
            </div>
          </div>

          <!-- Số tiền thanh toán -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Số tiền thanh toán</label>
            <input 
              type="text"
              v-model="formData.amount"
              :placeholder="`Tối đa: ${formatCurrency(remainingAmount)}`"
              @input="formatNumberInput('amount', $event)"
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 h-9 text-sm text-neutral-950 placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <p v-if="amountError" class="text-xs text-red-500">
              {{ amountError }}
            </p>
          </div>

          <!-- Hình thức thanh toán -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Hình thức thanh toán</label>
            <button 
              @click="togglePaymentMethodDropdown"
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-2 flex items-center justify-between h-9 text-left"
            >
              <span class="text-sm text-neutral-950">
                {{ formData.paymentMethod }}
              </span>
              <img :src="iconChevronDown" alt="" class="w-4 h-4" />
            </button>
          </div>

          <!-- Ghi chú -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Ghi chú (Optional)</label>
            <input 
              type="text"
              v-model="formData.note"
              placeholder="VD: Trả đợt 2, Thanh toán nốt..."
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 h-9 text-sm text-neutral-950 placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
          </div>
        </div>

        <!-- Footer -->
        <div class="flex items-center justify-end gap-2 pt-2">
          <button 
            @click="$emit('close')"
            class="bg-white border border-black/10 rounded-lg px-4 py-2 h-9 text-sm font-medium text-neutral-950 hover:bg-gray-50 transition-colors"
          >
            Hủy
          </button>
          <button 
            @click="handleSubmit"
            :disabled="!isFormValid"
            :class="[
              'bg-[#f54900] rounded-lg px-4 py-2 h-9 flex items-center gap-2 text-sm font-medium text-white transition-colors',
              isFormValid ? 'hover:bg-[#d43f00] cursor-pointer' : 'opacity-50 cursor-not-allowed'
            ]"
          >
            <img :src="iconCheck" alt="" class="w-4 h-4" />
            Xác nhận thanh toán
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

// Icons
const iconClose = 'https://www.figma.com/api/mcp/asset/680fc8ee-e948-449d-bd13-15f4801eef7c';
const iconChevronDown = 'https://www.figma.com/api/mcp/asset/3434a214-9724-4afc-9e36-22e86de4bfa7';
const iconCheck = 'https://www.figma.com/api/mcp/asset/360cc4f0-d95e-45b3-9917-3c10fc9fb323';

// Props
const props = defineProps({
  expenseCode: {
    type: String,
    required: true,
    default: 'PC0056'
  },
  supplierName: {
    type: String,
    required: true,
    default: 'Công ty CP Dược Thú Y Việt Nam'
  },
  totalAmount: {
    type: Number,
    required: true,
    default: 15000000
  },
  paidAmount: {
    type: Number,
    required: true,
    default: 5000000
  },
  remainingAmount: {
    type: Number,
    required: true,
    default: 10000000
  }
});

// Define emits
const emit = defineEmits(['close', 'submit']);

// Form data
const formData = ref({
  amount: '',
  paymentMethod: '💵 Tiền mặt',
  note: ''
});

// Dropdown state
const showPaymentMethodDropdown = ref(false);

// Toggle dropdown
const togglePaymentMethodDropdown = () => {
  showPaymentMethodDropdown.value = !showPaymentMethodDropdown.value;
};

// Format number input
const formatNumberInput = (field, event) => {
  // Remove non-numeric characters
  const value = event.target.value.replace(/\D/g, '');
  formData.value[field] = value;
};

// Amount validation error
const amountError = computed(() => {
  if (!formData.value.amount) return '';
  
  const amount = parseInt(formData.value.amount);
  if (isNaN(amount) || amount <= 0) {
    return 'Số tiền phải lớn hơn 0';
  }
  if (amount > props.remainingAmount) {
    return `Số tiền không được vượt quá ${formatCurrency(props.remainingAmount)}`;
  }
  return '';
});

// Form validation
const isFormValid = computed(() => {
  return (
    formData.value.amount.trim() !== '' &&
    parseInt(formData.value.amount) > 0 &&
    parseInt(formData.value.amount) <= props.remainingAmount &&
    formData.value.paymentMethod.trim() !== ''
  );
});

// Format currency
const formatCurrency = (amount) => {
  return new Intl.NumberFormat('vi-VN', {
    style: 'decimal',
    minimumFractionDigits: 0
  }).format(amount) + 'đ';
};

// Submit handler
const handleSubmit = () => {
  if (!isFormValid.value) return;

  const submitData = {
    amount: parseInt(formData.value.amount),
    paymentMethod: formData.value.paymentMethod,
    note: formData.value.note || '',
    date: new Date().toISOString(),
    status: 'success'
  };

  emit('submit', submitData);
};
</script>

<style scoped>
/* Ensure Nunito Sans font is applied */
.font-nunito {
  font-family: 'Nunito Sans', sans-serif;
}
</style>
