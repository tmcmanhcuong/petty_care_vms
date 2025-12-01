<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[9999] pt-24 font-nunito">
    <div class="bg-white border border-black/10 rounded-[10px] shadow-xl w-full max-w-[510px] max-h-[85vh] flex flex-col">
      <!-- Header -->
      <div class="flex items-start justify-between px-6 pt-6 pb-4">
        <div class="flex flex-col gap-2">
          <h2 class="text-lg font-semibold text-neutral-950">Tạo phiếu chi mới</h2>
          <p class="text-sm text-[#717182]">Nhập thông tin chi tiết về khoản chi</p>
        </div>
        <button 
          @click="$emit('close')"
          class="opacity-70 hover:opacity-100 transition-opacity"
        >
          <img :src="iconClose" alt="Close" class="w-4 h-4" />
        </button>
      </div>

      <!-- Form Content - Scrollable -->
      <div class="px-6 overflow-y-auto flex-1">
        <div class="flex flex-col gap-4 pb-6">
          <!-- Loại phiếu chi -->
          <div class="flex flex-col">
            <label class="text-sm font-medium text-neutral-950 mb-2">Loại phiếu chi</label>
            <div class="flex flex-col gap-3">
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  type="radio" 
                  v-model="formData.type" 
                  value="purchase"
                  class="w-4 h-4 text-[#009689] focus:ring-[#009689]"
                />
                <span class="text-sm font-medium text-neutral-950">📦 Chi nhập hàng (Liên kết với Kho)</span>
              </label>
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  type="radio" 
                  v-model="formData.type" 
                  value="operating"
                  class="w-4 h-4 text-[#009689] focus:ring-[#009689]"
                />
                <span class="text-sm font-medium text-neutral-950">💡 Chi phí vận hành (Điện, nước, thuê nhà...)</span>
              </label>
            </div>
          </div>

          <!-- Đối tượng nhận tiền -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Đối tượng nhận tiền</label>
            <div v-if="formData.type === 'purchase'">
              <!-- Dropdown for Purchase Type -->
              <button 
                @click="toggleSupplierDropdown"
                class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-2 flex items-center justify-between h-9 text-left"
              >
                <span class="text-sm" :class="formData.supplier ? 'text-neutral-950' : 'text-[#717182]'">
                  {{ formData.supplier || 'Chọn nhà cung cấp' }}
                </span>
                <img :src="iconChevronDown" alt="" class="w-4 h-4" />
              </button>
            </div>
            <input 
              v-else
              type="text"
              v-model="formData.recipient"
              placeholder="VD: Điện lực TP.HCM, Chủ nhà..."
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 h-9 text-sm text-neutral-950 placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
          </div>

          <!-- Mã Phiếu Nhập (Only for Purchase Type) -->
          <div v-if="formData.type === 'purchase'" class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Mã Phiếu Nhập (Optional)</label>
            <button 
              @click="togglePurchaseOrderDropdown"
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-2 flex items-center justify-between h-9 text-left"
            >
              <span class="text-sm text-neutral-950">
                {{ formData.purchaseOrderCode || '-- Không liên kết --' }}
              </span>
              <img :src="iconChevronDown" alt="" class="w-4 h-4" />
            </button>
          </div>

          <!-- Lý do chi -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Lý do chi</label>
            <textarea
              v-model="formData.reason"
              placeholder="VD: Trả tiền nhập Vắc-xin tháng 10, Tiền điện tháng 11..."
              rows="3"
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-2 text-sm text-neutral-950 placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689] resize-none"
            ></textarea>
          </div>

          <!-- Tổng số tiền -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Tổng số tiền</label>
            <input 
              type="text"
              v-model="formData.totalAmount"
              placeholder="VD: 15000000"
              @input="formatNumberInput('totalAmount', $event)"
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 h-9 text-sm text-neutral-950 placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
          </div>

          <!-- Số tiền thanh toán ngay -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Số tiền thanh toán ngay</label>
            <input 
              type="text"
              v-model="formData.paidAmount"
              placeholder="VD: 5000000 (Nếu nhập ít hơn Tổng tiền -> Ghi nhận nợ)"
              @input="formatNumberInput('paidAmount', $event)"
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-1 h-9 text-sm text-neutral-950 placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <p class="text-xs text-[#6a7282] leading-4">
              💡 Tip: Nếu nhập ít hơn Tổng tiền, hệ thống sẽ tự động ghi nhận phần còn lại là Nợ
            </p>
          </div>

          <!-- Nguồn tiền -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Nguồn tiền</label>
            <button 
              @click="togglePaymentSourceDropdown"
              class="w-full bg-[#f3f3f5] border-0 rounded-lg px-3 py-2 flex items-center justify-between h-9 text-left"
            >
              <span class="text-sm text-neutral-950">
                {{ formData.paymentSource || '💵 Tiền mặt tại két' }}
              </span>
              <img :src="iconChevronDown" alt="" class="w-4 h-4" />
            </button>
          </div>

          <!-- Chứng từ kèm theo -->
          <div class="flex flex-col gap-2">
            <label class="text-sm font-medium text-neutral-950">Chứng từ kèm theo (Optional)</label>
            <button 
              @click="handleFileUpload"
              class="w-full bg-white border border-black/10 rounded-lg h-9 flex items-center justify-center gap-2 hover:bg-gray-50 transition-colors"
            >
              <img :src="iconUpload" alt="" class="w-4 h-4" />
              <span class="text-sm font-medium text-neutral-950">Upload ảnh hóa đơn</span>
            </button>
            <p class="text-xs text-[#6a7282] leading-4">
              Chụp hóa đơn điện nước hoặc hóa đơn đỏ của NCC để lưu trữ
            </p>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="flex items-center justify-end gap-2 px-6 py-4 border-t border-black/10">
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
            'bg-[#e7000b] rounded-lg px-4 py-2 h-9 text-sm font-medium text-white transition-colors',
            isFormValid ? 'hover:bg-[#c4000a] cursor-pointer' : 'opacity-50 cursor-not-allowed'
          ]"
        >
          Tạo phiếu chi
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

// Icons
const iconClose = 'https://www.figma.com/api/mcp/asset/63dd8b1e-1eb6-4c6d-829b-78b5f57b41e9';
const iconChevronDown = 'https://www.figma.com/api/mcp/asset/6cfab6d3-a5cc-4c06-b534-3fd16a585a3f';
const iconUpload = 'https://www.figma.com/api/mcp/asset/de9a42eb-3efd-4bfd-887c-0b2043ef30df';
const iconCheck = 'https://www.figma.com/api/mcp/asset/c89b26f1-55c6-4d25-9216-c6454ab37981';

// Define emits
const emit = defineEmits(['close', 'submit']);

// Form data
const formData = ref({
  type: 'operating', // 'purchase' or 'operating'
  supplier: '', // For purchase type
  recipient: '', // For operating type
  purchaseOrderCode: '', // Optional, for purchase type
  reason: '',
  totalAmount: '',
  paidAmount: '',
  paymentSource: '💵 Tiền mặt tại két',
  attachments: []
});

// Dropdown states
const showSupplierDropdown = ref(false);
const showPurchaseOrderDropdown = ref(false);
const showPaymentSourceDropdown = ref(false);

// Toggle dropdown functions
const toggleSupplierDropdown = () => {
  showSupplierDropdown.value = !showSupplierDropdown.value;
};

const togglePurchaseOrderDropdown = () => {
  showPurchaseOrderDropdown.value = !showPurchaseOrderDropdown.value;
};

const togglePaymentSourceDropdown = () => {
  showPaymentSourceDropdown.value = !showPaymentSourceDropdown.value;
};

// Format number input
const formatNumberInput = (field, event) => {
  // Remove non-numeric characters
  const value = event.target.value.replace(/\D/g, '');
  formData.value[field] = value;
};

// File upload handler
const handleFileUpload = () => {
  // Create file input element
  const input = document.createElement('input');
  input.type = 'file';
  input.accept = 'image/*';
  input.multiple = true;
  input.onchange = (e) => {
    const files = Array.from(e.target.files);
    formData.value.attachments = files;
    console.log('Files selected:', files);
  };
  input.click();
};

// Form validation
const isFormValid = computed(() => {
  const hasRecipient = formData.value.type === 'purchase' 
    ? formData.value.supplier.trim() !== '' 
    : formData.value.recipient.trim() !== '';
  
  return (
    formData.value.type &&
    hasRecipient &&
    formData.value.reason.trim() !== '' &&
    formData.value.totalAmount.trim() !== '' &&
    formData.value.paidAmount.trim() !== '' &&
    formData.value.paymentSource.trim() !== ''
  );
});

// Submit handler
const handleSubmit = () => {
  if (!isFormValid.value) return;

  const submitData = {
    type: formData.value.type,
    recipient: formData.value.type === 'purchase' ? formData.value.supplier : formData.value.recipient,
    purchaseOrderCode: formData.value.type === 'purchase' ? formData.value.purchaseOrderCode : null,
    reason: formData.value.reason,
    totalAmount: parseInt(formData.value.totalAmount),
    paidAmount: parseInt(formData.value.paidAmount),
    remainingAmount: parseInt(formData.value.totalAmount) - parseInt(formData.value.paidAmount),
    paymentSource: formData.value.paymentSource,
    attachments: formData.value.attachments,
    createdAt: new Date().toISOString()
  };

  emit('submit', submitData);
};
</script>

<style scoped>
/* Ensure Nunito Sans font is applied */
.font-nunito {
  font-family: 'Nunito Sans', sans-serif;
}

/* Custom radio button styling */
input[type="radio"] {
  appearance: none;
  width: 16px;
  height: 16px;
  border: 1px solid rgba(0, 0, 0, 0.3);
  border-radius: 50%;
  outline: none;
  cursor: pointer;
  position: relative;
  flex-shrink: 0;
}

input[type="radio"]:checked {
  border-color: #009689;
}

input[type="radio"]:checked::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 8px;
  height: 8px;
  background-color: #009689;
  border-radius: 50%;
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
