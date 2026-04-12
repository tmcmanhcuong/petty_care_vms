<template>
  <div class="min-h-screen bg-gray-50 flex items-center justify-center p-4">
    <div class="max-w-md w-full bg-white rounded-lg shadow-lg p-8">
      <!-- Success Icon -->
      <div v-if="isSuccess" class="text-center">
        <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-green-100 mb-4">
          <svg class="h-10 w-10 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
          </svg>
        </div>
        <h2 class="text-2xl font-bold text-gray-900 mb-2">Thanh toán thành công!</h2>
        <p class="text-gray-600 mb-6">Giao dịch của bạn đã được xử lý thành công</p>
      </div>

      <!-- Error Icon -->
      <div v-else class="text-center">
        <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-red-100 mb-4">
          <svg class="h-10 w-10 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
          </svg>
        </div>
        <h2 class="text-2xl font-bold text-gray-900 mb-2">Thanh toán thất bại</h2>
        <p class="text-gray-600 mb-6">{{ errorMessage }}</p>
      </div>

      <!-- Payment Details -->
      <div class="bg-gray-50 rounded-lg p-4 mb-6">
        <div class="space-y-2">
          <div class="flex justify-between text-sm">
            <span class="text-gray-600">Mã đơn hàng:</span>
            <span class="font-medium text-gray-900">{{ orderId }}</span>
          </div>
          <div class="flex justify-between text-sm">
            <span class="text-gray-600">Số tiền:</span>
            <span class="font-medium text-gray-900">{{ formatCurrency(amount) }}</span>
          </div>
          <div class="flex justify-between text-sm">
            <span class="text-gray-600">Phương thức:</span>
            <span class="font-medium text-gray-900">{{ paymentMethod }}</span>
          </div>
          <div class="flex justify-between text-sm">
            <span class="text-gray-600">Thời gian:</span>
            <span class="font-medium text-gray-900">{{ paymentTime }}</span>
          </div>
        </div>
      </div>

      <!-- Actions -->
      <div class="space-y-3">
        <button
          @click="goToPaymentHistory"
          class="w-full bg-teal-600 text-white rounded-lg px-4 py-3 font-semibold hover:bg-teal-700 transition"
        >
          Xem lịch sử thanh toán
        </button>
        <button
          @click="goToHome"
          class="w-full bg-white border border-gray-300 text-gray-700 rounded-lg px-4 py-3 font-semibold hover:bg-gray-50 transition"
        >
          Về trang chủ
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const isSuccess = ref(false);
const errorMessage = ref('');
const orderId = ref('');
const amount = ref(0);
const paymentMethod = ref('');
const paymentTime = ref('');

onMounted(async () => {
  // Parse query parameters from MoMo callback
  const resultCode = route.query.resultCode;
  const message = route.query.message;

  isSuccess.value = resultCode === '0';
  errorMessage.value = message || 'Có lỗi xảy ra trong quá trình thanh toán';

  orderId.value = route.query.orderId || '';
  amount.value = parseInt(route.query.amount) || 0;

  // Map payment type
  const payType = route.query.payType;
  const paymentTypes = {
    'napas': 'Thẻ ATM nội địa',
    'credit': 'Thẻ tín dụng/ghi nợ',
    'qr': 'Quét mã QR',
    'momo_wallet': 'Ví MoMo'
  };
  paymentMethod.value = paymentTypes[payType] || 'MoMo';

  // Format payment time
  const responseTime = route.query.responseTime;
  if (responseTime) {
    paymentTime.value = new Date(parseInt(responseTime)).toLocaleString('vi-VN');
  }

  console.log('Payment callback:', route.query);

  // Cập nhật trạng thái thanh toán nếu thành công
  if (isSuccess.value && orderId.value) {
    try {
      const { updatePaymentStatus } = await import('@/utils/payment.js');
      await updatePaymentStatus({
        order_id: orderId.value,
        result_code: resultCode
      });
      console.log('Payment status updated successfully');
    } catch (error) {
      console.error('Error updating payment status:', error);
    }
  }
});

const formatCurrency = (value) => {
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND'
  }).format(value);
};

const goToPaymentHistory = () => {
  router.push('/customer/payment?refresh=true');
};

const goToHome = () => {
  router.push('/');
};
</script>
