<template>
  <div
    class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[9999] pt-24 font-nunito"
  >
    <div
      class="bg-white border border-gray-200/60 rounded-[10px] w-full max-w-[510px] max-h-[85vh] p-6 flex flex-col gap-4 shadow-xl relative"
    >
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
            <label class="text-sm font-medium text-[#4a5565]"
              >Đối tượng nhận tiền</label
            >
            <p class="text-base text-[#101828] leading-6">
              {{ expense.recipient }}
            </p>
          </div>

          <!-- Nội dung chi -->
          <div class="flex flex-col gap-1">
            <label class="text-sm font-medium text-[#4a5565]"
              >Nội dung chi</label
            >
            <p class="text-base text-[#101828] leading-6">
              {{ expense.description }}
            </p>
          </div>

          <!-- Ngày tạo -->
          <div class="flex flex-col gap-1">
            <label class="text-sm font-medium text-[#4a5565]">Ngày tạo</label>
            <p class="text-base text-[#101828] leading-6">
              {{ expense.createdAt }}
            </p>
          </div>

          <!-- Người tạo -->
          <div class="flex flex-col gap-1">
            <label class="text-sm font-medium text-[#4a5565]">Người tạo</label>
            <p class="text-base text-[#101828] leading-6">
              {{ expense.createdBy }}
            </p>
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
              <p class="text-xl text-[#101828] leading-7">
                {{ formatCurrency(expense.totalAmount) }}
              </p>
            </div>

            <!-- Đã trả -->
            <div class="flex flex-col gap-1 items-center">
              <p class="text-sm text-[#4a5565] leading-5">Đã trả</p>
              <p class="text-xl text-[#00a63e] leading-7">
                {{ formatCurrency(expense.paidAmount) }}
              </p>
            </div>

            <!-- Còn nợ -->
            <div class="flex flex-col gap-1 items-center">
              <p class="text-sm text-[#4a5565] leading-5">Còn nợ</p>
              <p class="text-xl text-[#e7000b] leading-7">
                {{ formatCurrency(expense.remainingAmount) }}
              </p>
            </div>
          </div>
        </div>

        <!-- Payment History Section -->
        <div class="flex flex-col gap-3">
          <!-- Header with Button -->
          <div class="flex items-center justify-between">
            <h3 class="text-base text-[#101828] leading-6">
              Lịch sử thanh toán
            </h3>
            <button
              v-if="displayPaymentHistory.length > 0"
              @click="exportToPDF"
              class="bg-white border border-[#009689] text-[#009689] rounded-lg px-3 py-2 h-8 flex items-center gap-2 text-sm font-medium hover:bg-[#009689] hover:text-white transition-colors"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="w-4 h-4"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                />
              </svg>
              Xuất PDF
            </button>
          </div>

          <!-- Loading State -->
          <div v-if="loading" class="flex items-center justify-center py-8">
            <svg
              class="animate-spin h-8 w-8 text-[#f54900]"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
            >
              <circle
                class="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                stroke-width="4"
              ></circle>
              <path
                class="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
              ></path>
            </svg>
          </div>

          <!-- Empty State -->
          <div
            v-else-if="displayPaymentHistory.length === 0"
            class="bg-gray-50 rounded-[10px] p-8 text-center"
          >
            <p class="text-sm text-[#717182]">Chưa có lịch sử thanh toán</p>
          </div>

          <!-- Payment History Items -->
          <div v-else class="flex flex-col gap-3">
            <div
              v-for="(payment, index) in displayPaymentHistory"
              :key="index"
              class="bg-white border border-black/10 rounded-[10px] p-4"
            >
              <div class="flex items-start justify-between">
                <div class="flex flex-col gap-2 flex-1">
                  <!-- Payment number and date -->
                  <div class="flex items-center gap-3">
                    <span
                      class="border border-black/10 rounded-lg px-2 py-1 text-sm font-medium text-neutral-950"
                    >
                      Lần {{ index + 1 }}
                    </span>
                    <span class="text-sm text-[#4a5565] leading-5">
                      {{ payment.date }}
                    </span>
                  </div>

                  <!-- Payment details -->
                  <div class="flex flex-col gap-1">
                    <p class="text-sm text-neutral-950 leading-5">
                      {{ payment.method }}
                    </p>

                    <!-- Chi tiết tiền mặt và chuyển khoản nếu có -->
                    <div
                      v-if="
                        payment.cashAmount > 0 || payment.transferAmount > 0
                      "
                      class="flex flex-col gap-1 pl-4 border-l-2 border-gray-200 my-1"
                    >
                      <p
                        v-if="payment.cashAmount > 0"
                        class="text-xs text-[#4a5565]"
                      >
                        💵 Tiền mặt:
                        <span class="font-medium">{{
                          formatCurrency(payment.cashAmount)
                        }}</span>
                      </p>
                      <p
                        v-if="payment.transferAmount > 0"
                        class="text-xs text-[#4a5565]"
                      >
                        🏦 Chuyển khoản:
                        <span class="font-medium">{{
                          formatCurrency(payment.transferAmount)
                        }}</span>
                      </p>
                    </div>

                    <p class="text-lg text-[#101828] leading-7">
                      Số tiền:
                      <span class="font-bold text-[#00a63e]">{{
                        formatCurrency(payment.amount)
                      }}</span>
                    </p>
                    <p class="text-sm text-[#4a5565] leading-5 italic">
                      Ghi chú: {{ payment.note }}
                    </p>
                  </div>
                </div>

                <!-- Status Badge -->
                <span
                  class="bg-green-100 border-0 rounded-lg px-3 py-1 text-xs font-medium text-[#008236] flex items-center gap-1"
                >
                  <img :src="iconCheck" alt="" class="w-3 h-3" />
                  Thành công
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div
        class="flex items-center justify-center pt-2 border-t border-black/10"
      >
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
import { ref, onMounted, computed } from "vue";
import { getPhieuChiPaymentHistory } from "@/utils/phieuChi";
import { showErrorToast } from "@/utils/toast";

// Icons
const iconPlus =
  "https://www.figma.com/api/mcp/asset/f5c9e8e8-9dd6-4412-8668-a11e39c18cd4";
const iconCheck =
  "https://www.figma.com/api/mcp/asset/5f04eea2-bc66-4e58-95f5-505282ec50e6";

// Props
const props = defineProps({
  expense: {
    type: Object,
    required: true,
    default: () => ({
      code: "PC0056",
      category: "purchase",
      categoryLabel: "Nhập hàng",
      recipient: "Công ty CP Dược Thú Y Việt Nam",
      description: "Nhập thuốc lô A1 - Tháng 11",
      createdAt: "09:30 - 20/11/2025",
      createdBy: "Kế toán Hoa",
      status: "debt",
      statusLabel: "Còn nợ NCC",
      totalAmount: 15000000,
      paidAmount: 5000000,
      remainingAmount: 10000000,
      paymentHistory: [],
    }),
  },
});

// Define emits
const emit = defineEmits(["close", "add-payment"]);

// State
const paymentHistory = ref([]);
const loading = ref(false);

// Load payment history
const loadPaymentHistory = async () => {
  if (!props.expense?.id) {
    console.warn("⚠️ No expense ID provided:", props.expense);
    return;
  }

  console.log("🔄 Loading payment history for ID:", props.expense.id);
  console.log(
    "📍 API Endpoint:",
    `/phieu-chi/${props.expense.id}/lich-su-thanh-toan`
  );

  try {
    loading.value = true;
    const response = await getPhieuChiPaymentHistory(props.expense.id);

    console.log("📥 Full API Response:", response);
    console.log("📥 Response Status:", response?.status);
    console.log("📥 Response Data Type:", typeof response?.data);
    console.log("📥 Response Data:", response?.data);

    // Backend trả về: { status: true, message: "...", data: [...] }
    if (response && response.status === true && response.data) {
      // Kiểm tra nếu data là array
      if (Array.isArray(response.data)) {
        console.log("✅ Data is array with", response.data.length, "items");

        paymentHistory.value = response.data.map((item, index) => {
          console.log(`🔍 Mapping item ${index + 1}:`, item);

          return {
            date: formatDateTime(item.ngay_thanh_toan || item.created_at),
            method: getPaymentMethodLabel(item.hinh_thuc_thanh_toan),
            amount: parseFloat(item.so_tien_thanh_toan) || 0,
            note: item.ghi_chu || "Không có ghi chú",
            status: "success",
            cashAmount: parseFloat(item.tien_mat) || 0,
            transferAmount: parseFloat(item.tien_chuyen_khoan) || 0,
            rawData: item,
          };
        });

        console.log("✅ Đã tải lịch sử thanh toán thành công!");
        console.log("✅ Payment History:", paymentHistory.value);
      } else {
        console.warn("⚠️ Response data is not an array:", response.data);
        paymentHistory.value = [];
      }
    } else {
      // Nếu không có lịch sử hoặc API response không đúng format
      console.log("⚠️ Response không hợp lệ hoặc data rỗng");
      console.log("⚠️ Response.status:", response?.status);
      paymentHistory.value = props.expense.paymentHistory || [];
    }
  } catch (error) {
    console.error("❌ Lỗi khi tải lịch sử thanh toán:", error);
    console.error("❌ Error Response:", {
      status: error.response?.status,
      statusText: error.response?.statusText,
      data: error.response?.data,
      message: error.message,
      config: {
        url: error.config?.url,
        method: error.config?.method,
        headers: error.config?.headers,
      },
    });

    // Fallback to props data
    paymentHistory.value = props.expense.paymentHistory || [];

    // Only show error toast if it's not a 404 (endpoint not found)
    if (error.response?.status === 404) {
      console.log(
        "ℹ️ Endpoint 404 - Có thể route chưa được đăng ký trong Laravel"
      );
      console.log("ℹ️ Kiểm tra file: routes/api.php");
      console.log(
        "ℹ️ Cần có route: Route::get('/{id}/lich-su-thanh-toan', [PhieuChiController::class, 'getLichSuThanhToan']);"
      );
    } else if (error.response?.status === 500) {
      console.log("❌ Lỗi server 500 - Có thể:");
      console.log("   1. Bảng 'lich_su_thanh_toan_phieu_chi' chưa tồn tại");
      console.log("   2. Model LichSuThanhToanPhieuChi chưa được tạo");
      console.log(
        "   3. Relationship chưa được định nghĩa trong Model PhieuChi"
      );
      showErrorToast("Lỗi server khi tải lịch sử thanh toán");
    } else if (error.response?.status !== 404) {
      showErrorToast("Không thể tải lịch sử thanh toán");
    }
  } finally {
    loading.value = false;
  }
};

// Format date time
const formatDateTime = (dateString) => {
  if (!dateString) return "N/A";
  const date = new Date(dateString);
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const year = date.getFullYear();
  return `${hours}:${minutes} - ${day}/${month}/${year}`;
};

// Get payment method label
const getPaymentMethodLabel = (method) => {
  const labels = {
    tien_mat: "💵 Tiền mặt",
    chuyen_khoan: "🏦 Chuyển khoản",
    ca_hai: "💳 Cả hai (Tiền mặt + Chuyển khoản)",
    cash: "💵 Tiền mặt",
    transfer: "🏦 Chuyển khoản",
    both: "💳 Cả hai (Tiền mặt + Chuyển khoản)",
  };
  return labels[method] || method || "Không xác định";
};

// Computed: Merge payment history from props and loaded data
const displayPaymentHistory = computed(() => {
  return paymentHistory.value.length > 0
    ? paymentHistory.value
    : props.expense.paymentHistory || [];
});

// Load when component mounts
onMounted(() => {
  loadPaymentHistory();
});

// Export to PDF handler
const exportToPDF = async () => {
  console.log("🔄 Đang xuất PDF lịch sử thanh toán...");
  console.log("📄 Phiếu chi:", props.expense.code);
  console.log("📋 Số lượng giao dịch:", displayPaymentHistory.value.length);

  if (!props.expense?.id) {
    showErrorToast("Không tìm thấy ID phiếu chi");
    return;
  }

  try {
    // Gọi API xuất PDF từ backend
    const API_BASE =
      import.meta.env.VITE_API_BASE || "http://127.0.0.1:8000/api";
    const token = localStorage.getItem("token");

    // Tạo URL để download PDF
    const url = `${API_BASE}/phieu-chi/${props.expense.id}/pdf`;

    // Fetch PDF file
    const response = await fetch(url, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    if (!response.ok) {
      throw new Error("Không thể tải file PDF");
    }

    // Tạo blob từ response
    const blob = await response.blob();

    // Tạo URL tạm thời cho blob
    const blobUrl = window.URL.createObjectURL(blob);

    // Tạo thẻ <a> để download
    const link = document.createElement("a");
    link.href = blobUrl;
    link.download = `PhieuChi_${
      props.expense.code
    }_${new Date().getTime()}.pdf`;

    // Trigger download
    document.body.appendChild(link);
    link.click();

    // Cleanup
    document.body.removeChild(link);
    window.URL.revokeObjectURL(blobUrl);

    console.log("✅ Xuất PDF thành công!");
  } catch (error) {
    console.error("❌ Lỗi khi xuất PDF:", error);
    showErrorToast(
      error.message || "Không thể xuất PDF. Vui lòng thử lại sau."
    );
  }
};

// Format currency
const formatCurrency = (amount) => {
  return (
    new Intl.NumberFormat("vi-VN", {
      style: "decimal",
      minimumFractionDigits: 0,
    }).format(amount) + "đ"
  );
};

// Get category badge class
const getCategoryClass = (category) => {
  const classes = {
    purchase: "bg-blue-100 border-black/10 text-[#1447e6]",
    chi_nhap_hang: "bg-blue-100 border-black/10 text-[#1447e6]",
    operating: "bg-[#fef9c2] border-black/10 text-[#a65f00]",
    chi_van_hanh: "bg-[#fef9c2] border-black/10 text-[#a65f00]",
  };
  return classes[category] || "bg-gray-100 border-black/10 text-gray-700";
};

// Get status badge class
const getStatusClass = (status) => {
  const classes = {
    completed: "bg-green-100 text-[#008236]",
    da_thanh_toan_du: "bg-green-100 text-[#008236]",
    hoan_thanh: "bg-green-100 text-[#008236]",
    debt: "bg-[#ffedd4] text-[#ca3500]",
    chua_thanh_toan_du: "bg-[#ffedd4] text-[#ca3500]",
  };
  return classes[status] || "bg-gray-100 text-gray-700";
};
</script>

<style scoped>
/* Ensure Nunito Sans font is applied */
.font-nunito {
  font-family: "Nunito Sans", sans-serif;
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
