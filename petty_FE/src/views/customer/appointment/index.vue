<template>
  <div class="min-h-screen font-nunitoSans">
    <div class="container mx-auto px-6 max-w-6xl">
      <!-- Header -->
      <div
        class="flex justify-between items-center mb-6 flex-col md:flex-row gap-4"
      >
        <div>
          <h1 class="text-xl font-bold text-black">Lịch hẹn khám</h1>
          <p class="text-lg font-medium text-gray-600">
            Quản lý các buổi khám đã đặt
          </p>
        </div>
        <button
          @click="handleNewAppointment"
          class="flex items-center gap-3 px-6 py-3 bg-[#5A9690] text-white rounded-lg font-medium text-lg hover:bg-teal-700 transition"
        >
          <AddIcon />
          Đặt lịch mới
        </button>
      </div>

      <!-- Tabs -->
      <div class="flex bg-zinc-100 rounded-2xl p-1 gap-1 mb-8 w-fit">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="
            activeTab === tab.id
              ? 'bg-white text-black shadow-sm'
              : 'text-black hover:opacity-70'
          "
          class="px-6 py-2.5 rounded-2xl font-semibold text-base transition"
        >
          {{ tab.label }} ({{ tab.count }})
        </button>
      </div>

      <!-- Filter -->
      <div class="bg-gray-200 border !border-black/20 rounded-2xl p-6 mb-8">
        <div class="flex flex-wrap items-center gap-4">
          <div class="flex items-center gap-2">
            <svg class="w-5 h-5" viewBox="0 0 20 20" fill="none">
              <path
                d="M3 5h14M7 10h6M5 15h10"
                stroke="#374151"
                stroke-width="2"
                stroke-linecap="round"
              />
            </svg>
            <span class="font-medium text-gray-700">Lọc theo:</span>
          </div>
          <div class="flex flex-1 flex-wrap gap-4">
            <button
              @click="openFilter('pet')"
              class="flex-1 min-w-48 flex justify-between items-center px-4 py-2 bg-white rounded-lg hover:opacity-80 transition"
            >
              <span class="text-gray-500 font-medium">{{
                selectedPetLabel
              }}</span>
              <svg class="w-4 h-4" viewBox="0 0 16 16" fill="none">
                <path
                  d="M2 5l6 6 6-6"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                />
              </svg>
            </button>
            <button
              @click="openFilter('service')"
              class="flex-1 min-w-48 flex justify-between items-center px-4 py-2 bg-white rounded-lg hover:opacity-80 transition"
            >
              <span class="text-gray-500 font-medium">{{
                selectedServiceLabel
              }}</span>
              <svg class="w-4 h-4" viewBox="0 0 16 16" fill="none">
                <path
                  d="M2 5l6 6 6-6"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                />
              </svg>
            </button>
            <button
              @click="openFilter('date')"
              class="flex-1 min-w-48 flex justify-between items-center px-4 py-2 bg-white rounded-lg hover:opacity-80 transition"
            >
              <span class="text-gray-500 font-medium">{{
                dateRangeLabel
              }}</span>
              <svg class="w-4 h-4" viewBox="0 0 16 16" fill="none">
                <path
                  d="M2 5l6 6 6-6"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                />
              </svg>
            </button>
          </div>
          <button
            @click="clearFilters"
            class="px-3 py-1 text-teal-700 font-medium hover:opacity-70 transition"
          >
            Xóa bộ lọc
          </button>
        </div>
      </div>

      <!-- Filter panel -->
      <div v-if="showFilterPanel" class="mb-8">
        <div class="bg-white border rounded-lg p-4 max-w-3xl">
          <div v-if="activeFilterType === 'pet'">
            <label class="block text-sm font-medium text-gray-700 mb-2"
              >Chọn thú cưng</label
            >
            <select v-model="selectedPet" class="w-full border rounded-lg p-2">
              <option value="all">Tất cả thú cưng</option>
              <option v-for="p in pets" :key="p.id" :value="p.id">
                {{ p.name || p.ten || p.ten_thu_cung }}
              </option>
            </select>
          </div>
          <div v-if="activeFilterType === 'service'">
            <label class="block text-sm font-medium text-gray-700 mb-2"
              >Chọn dịch vụ</label
            >
            <select
              v-model="selectedService"
              class="w-full border rounded-lg p-2"
            >
              <option value="all">Tất cả dịch vụ</option>
              <option v-for="s in services" :key="s.id" :value="s.id">
                {{ s.name || s.ten || s.ten_dich_vu }}
              </option>
            </select>
          </div>
          <div v-if="activeFilterType === 'date'">
            <label class="block text-sm font-medium text-gray-700 mb-2"
              >Chọn khoảng thời gian</label
            >
            <div class="flex gap-2">
              <input
                type="date"
                v-model="dateFrom"
                class="border rounded-lg p-2"
              />
              <input
                type="date"
                v-model="dateTo"
                class="border rounded-lg p-2"
              />
            </div>
          </div>
          <div class="mt-4 flex justify-end gap-2">
            <button
              @click="applyFilters"
              class="px-4 py-2 bg-teal-600 text-white rounded-lg"
            >
              Áp dụng
            </button>
            <button @click="closeFilter" class="px-4 py-2 border rounded-lg">
              Đóng
            </button>
          </div>
        </div>
      </div>

      <!-- TAB SẮP TỚI -->
      <div v-if="activeTab === 'upcoming'" class="grid grid-cols-1 gap-4">
        <div
          v-for="appt in upcomingAppointments"
          :key="appt.id"
          class="group bg-white rounded-xl overflow-hidden border border-teal-100/60 shadow-sm hover:shadow-md transition-all duration-300"
        >
          <!-- Card Header: Super Compact -->
          <div class="bg-gradient-to-r from-teal-50/30 to-white border-b border-teal-50/50 px-5 py-3.5">
            <div class="flex flex-row items-center justify-between gap-3">
              <div class="flex items-center gap-3">
                <div class="p-2 bg-teal-50/50 rounded-lg border border-teal-100/50 flex items-center justify-center">
                  <svg class="w-5 h-5 text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                  </svg>
                </div>
                <div class="flex flex-wrap items-center gap-2">
                  <h3 class="text-lg font-bold text-gray-900 leading-tight">{{ appt.service }}</h3>
                  <span
                    :class="[
                      'px-2.5 py-1 rounded-full font-bold text-[10px] uppercase tracking-wider',
                      statusClass(appt.status),
                    ]"
                  >
                    {{ statusLabel(appt.status) }}
                  </span>
                  <span class="text-gray-400 text-xs font-medium hidden sm:inline">#{{ appt.id }}</span>
                </div>
              </div>

              <div class="flex items-center gap-3 bg-white p-2 px-4 rounded-lg border border-teal-50 shadow-sm">
                <div class="flex items-baseline gap-1.5">
                  <span class="text-gray-400 text-[10px] font-bold uppercase tracking-tight">Ngày:</span>
                  <span class="text-gray-900 font-bold text-sm">{{ appt.date }}</span>
                </div>
                <div class="w-px h-5 bg-teal-100 mx-1"></div>
                <div class="flex items-baseline gap-1.5">
                  <span class="text-teal-600 text-[10px] font-bold uppercase tracking-tight">Giờ:</span>
                  <span class="text-teal-600 font-black text-base">{{ appt.time }}</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Card Body: Horizontal Layout & Minimal Spacing -->
          <div class="px-5 py-3.5">
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
              <div class="flex flex-1 flex-col sm:flex-row gap-8">
                <!-- Pet Info -->
                <div class="flex items-center gap-3">
                  <div class="flex-shrink-0 w-10 h-10 bg-sky-50 rounded-lg flex items-center justify-center border border-sky-100/50">
                    <svg class="w-5 h-5 text-sky-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                  <div class="min-w-0">
                    <p class="text-gray-400 text-[10px] font-bold uppercase tracking-widest mb-0.5">Thú cưng</p>
                    <div class="flex items-baseline gap-2 truncate">
                      <span class="text-base font-bold text-gray-900">{{ appt.pet }}</span>
                      <span class="text-gray-400 font-medium text-xs">• {{ appt.breed }}</span>
                    </div>
                  </div>
                </div>

                <!-- Location Info -->
                <div class="flex items-center gap-3">
                  <div class="flex-shrink-0 w-10 h-10 bg-teal-50 rounded-lg flex items-center justify-center border border-teal-100/50">
                    <svg class="w-5 h-5 text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                    </svg>
                  </div>
                  <div class="flex-1 min-w-0">
                    <p class="text-gray-400 text-[10px] font-bold uppercase tracking-widest mb-0.5">Địa điểm</p>
                    <p class="text-sm font-bold text-gray-900 truncate">{{ appt.clinic }}</p>
                  </div>
                </div>
              </div>

              <!-- Action Buttons -->
              <div class="flex items-center gap-3">
                <button
                  @click="handleReschedule(appt.id)"
                  class="p-2.5 border border-teal-100 rounded-lg text-gray-600 hover:bg-teal-50 hover:text-teal-700 transition-colors shadow-sm"
                  title="Đổi lịch"
                >
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                  </svg>
                </button>
                <button
                  @click="handleCancel(appt.id)"
                  class="p-2.5 border border-red-50 rounded-lg text-red-500 hover:bg-red-50 transition-colors shadow-sm"
                  title="Hủy hẹn"
                >
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
                <button
                  @click="openDetail(appt)"
                  class="px-5 py-2.5 bg-[#5A9690] text-white rounded-lg font-bold text-sm hover:bg-[#4a7d78] shadow-sm flex items-center gap-2 transition-all"
                >
                  Chi tiết
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
            </div>

            <!-- Notes: Inline & Discreet -->
            <div v-if="appt.note" class="mt-3 pt-3 border-t border-teal-50/50 flex items-center gap-3">
              <span class="px-2 py-0.5 bg-orange-100 text-orange-700 rounded-md text-[10px] font-black uppercase tracking-tight">Lưu ý</span>
              <p class="text-gray-600 text-xs font-medium leading-tight line-clamp-1 italic">{{ appt.note }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- TAB ĐÃ QUA -->
      <div v-if="activeTab === 'past'" class="grid grid-cols-1 gap-4">
        <div
          v-for="appt in pastAppointments"
          :key="appt.id"
          class="bg-white rounded-xl overflow-hidden border border-gray-100 shadow-sm hover:shadow-md transition-all duration-300 opacity-90"
        >
          <div class="bg-gray-50/50 px-5 py-3.5 border-b border-gray-100">
            <div class="flex items-center justify-between gap-3">
              <div class="flex items-center gap-3">
                <div class="flex flex-wrap items-center gap-3">
                  <h3 class="text-lg font-bold text-gray-700">{{ appt.service }}</h3>
                  <div class="flex gap-2">
                    <span
                      class="px-2.5 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider"
                      :class="appt.status === 'completed' ? 'bg-emerald-100 text-green-700' : 'bg-gray-200 text-gray-700'"
                    >
                      {{ statusLabel(appt.status) }}
                    </span>
                    <span
                      v-if="appt.raw.thanhToan?.trang_thai === 'paid' || appt.status === 'paid'"
                      class="px-2.5 py-1 bg-blue-100 text-blue-700 rounded-full text-[10px] font-bold uppercase tracking-wider"
                    >
                      Đã thanh toán
                    </span>
                  </div>
                </div>
              </div>
              <div class="flex items-center gap-3 text-right">
                <div class="text-gray-500 font-bold text-sm">{{ appt.date }}</div>
                <div class="w-px h-4 bg-gray-300"></div>
                <div class="text-gray-400 font-medium text-sm">{{ appt.time }}</div>
              </div>
            </div>
          </div>

          <div class="px-5 py-3.5">
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
              <div class="flex items-center gap-6">
                <div class="flex items-center gap-3">
                  <div class="w-8 h-8 bg-gray-100 rounded-lg flex items-center justify-center border border-gray-200">
                    <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                  <span class="text-sm font-bold text-gray-600">{{ appt.pet }}</span>
                </div>
                <div class="w-px h-4 bg-gray-200"></div>
                <div class="text-xs text-gray-500 font-medium">Mã: #{{ appt.id }}</div>
              </div>

              <div class="flex items-center gap-3">
                <button
                  v-if="appt.status === 'completed'"
                  @click="viewResult(appt.id)"
                  class="px-4 py-2 bg-white border border-teal-600 text-teal-600 rounded-lg hover:bg-teal-50 transition font-bold text-xs"
                >
                  Xem kết quả
                </button>
                <button
                  v-if="appt.status !== 'cancelled'"
                  @click="rebook(appt.id)"
                  class="px-4 py-2 bg-[#5A9690] text-white rounded-lg hover:bg-[#4a7d78] transition font-bold text-xs shadow-sm"
                >
                  Đặt lại
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- POPUP CHI TIẾT LỊCH HẸN -->
    <teleport to="body">
      <ChiTietLichHen
        v-if="selectedAppt"
        :is-open="showDetail"
        :selected-appt="selectedAppt"
        @close="showDetail = false"
      />
    </teleport>

    <!-- POPUP ĐẶT LỊCH KHÁM -->
    <teleport to="body">
      <DatLichKham
        :is-open="showBookingPopup"
        :initial-data="rebookData"
        @close="showBookingPopup = false"
        @confirm="handleBookingConfirm"
        @openAddPet="() => {}"
      />
    </teleport>

    <!-- POPUP ĐỔI LỊCH HẸN -->
    <teleport to="body">
      <DoiLich
        v-if="rescheduleAppt"
        :is-open="showReschedulePopup"
        :old-appointment="rescheduleAppt"
        @close="showReschedulePopup = false"
        @save="handleRescheduleConfirm"
      />
    </teleport>

    <!-- POPUP HỦY LỊCH HẸN -->
    <teleport to="body">
      <HuyHen
        v-if="cancelAppt"
        :is-open="showCancelPopup"
        :appointment="cancelAppt"
        :cancel-status="cancelStatus"
        @close="showCancelPopup = false"
        @keep="showCancelPopup = false"
        @cancel="handleCancelConfirm"
      />
    </teleport>

    <!-- POPUP KẾT QUẢ KHÁM BỆNH -->
    <teleport to="body">
      <KetQuaKhambenh
        v-if="resultData"
        :is-open="showResultPopup"
        :result="resultData"
        @close="showResultPopup = false"
        @download="(file) => console.log('Downloading', file)"
      />
    </teleport>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { showSuccessToast, showErrorToast } from "@/utils/toast";
import AddIcon from "@/assets/svg/add.svg";

import DatLichKham from "./book-appointment/index.vue";
import ChiTietLichHen from "./appointment-detail/index.vue";
import DoiLich from "./reschedule-appointment/index.vue";
import HuyHen from "./cancel-appointment/index.vue";
import KetQuaKhambenh from "./medical-result/index.vue";

const activeTab = ref("upcoming");
// tabs counts are computed based on filtered lists (defined later)

const upcomingAppointments = ref([]);
const pastAppointments = ref([]);
const loading = ref(false);

const API_BASE = import.meta.env.VITE_API_BASE_URL || import.meta.env.VITE_API_BASE_URL + "";

const mapAppointment = (item) => {
  // item: LichHen with relations thuCung, dichVu, nhanVien, thanhToan
  const ngayGio = item.ngay_gio ? new Date(item.ngay_gio) : null;

  return {
    id: item.id || item.ma || `LH${item.id}`,
    raw: item,
    service:
      item.dichVu?.name ||
      item.dichVu?.ten_dich_vu ||
      item.dich_vu?.ten ||
      item.dich_vu?.name ||
      "Dịch vụ",
    date: ngayGio
      ? `${String(ngayGio.getDate()).padStart(2, "0")}/${String(
          ngayGio.getMonth() + 1
        ).padStart(2, "0")}/${ngayGio.getFullYear()}`
      : "",
    time: ngayGio
      ? `${String(ngayGio.getHours()).padStart(2, "0")}:${String(
          ngayGio.getMinutes()
        ).padStart(2, "0")}`
      : "",
    pet:
      item.thuCung?.ten_thu_cung ||
      item.thuCung?.ten ||
      item.thuCung?.name ||
      item.thu_cung?.ten_thu_cung ||
      item.thu_cung?.ten ||
      item.thu_cung?.name ||
      (typeof item.thuCung === "string" ? item.thuCung : "") ||
      "Thú cưng",
    breed:
      item.thuCung?.giong_thu_cung ||
      item.thuCung?.giong ||
      item.thuCung?.breed ||
      item.thu_cung?.giong_thu_cung ||
      "-",
    age:
      item.thuCung?.tuoi_thu_cung ||
      item.thuCung?.age ||
      item.thu_cung?.tuoi_thu_cung ||
      "-",
    weight: item.thuCung?.can_nang
      ? `${item.thuCung.can_nang} kg`
      : item.thuCung?.weight
      ? `${item.thuCung.weight} kg`
      : "-",
    clinic:
      item.dia_diem || item.clinic || "Phòng khám Petty - Chi nhánh Quận 1",
    address: item.dia_chi || "123 Nguyễn Huệ, Q.1, TP.HCM",
    note: item.ghi_chu || "",
    status: item.trang_thai || (item.thanhToan ? "paid" : "pending"),
  };
};

// helpers to render status badge label and classes
const statusLabel = (s) => {
  if (!s) return "Đang xử lý";
  const st = String(s).toLowerCase();
  switch (st) {
    case "pending":
      return "Chờ xác nhận";
    case "confirmed":
    case "confirmed_by_staff":
      return "Đã xác nhận";
    case "paid":
      return "Đã thanh toán";
    case "completed":
      return "Hoàn thành";
    case "cancelled":
    case "canceled":
      return "Đã hủy";
    default:
      // fallback: if backend already returns a human label, use it
      return String(s);
  }
};

const statusClass = (s) => {
  const st = s ? String(s).toLowerCase() : "";
  if (st === "confirmed" || st === "confirmed_by_staff")
    return "bg-teal-100 text-teal-700";
  if (st === "pending") return "bg-yellow-100 text-yellow-800";
  if (st === "paid" || st === "completed")
    return "bg-emerald-100 text-green-700";
  if (st === "cancelled" || st === "canceled") return "bg-red-100 text-red-700";
  return "bg-gray-200 text-gray-700";
};

const fetchAppointments = async (filters = {}) => {
  loading.value = true;
  try {
    const res = await axios.get(`${API_BASE}/lich-hen`, { params: filters });
    let list = [];
    if (res.data && res.data.data) {
      // handle paginated or plain array
      if (Array.isArray(res.data.data)) list = res.data.data;
      else if (Array.isArray(res.data.data.data)) list = res.data.data.data;
      else if (Array.isArray(res.data)) list = res.data;
    }

    const today = new Date();
    const upcoming = [];
    const past = [];
    list.forEach((it) => {
      const mapped = mapAppointment(it);
      const dt = it.ngay_gio ? new Date(it.ngay_gio) : null;
      if (
        dt &&
        dt >= new Date(today.getFullYear(), today.getMonth(), today.getDate())
      ) {
        upcoming.push(mapped);
      } else {
        past.push(mapped);
      }
    });

    upcomingAppointments.value = upcoming;
    pastAppointments.value = past;
  } catch (err) {
    console.error("Lỗi khi lấy lịch hẹn:", err);
    showErrorToast("Lỗi", "Không thể tải lịch hẹn. Vui lòng thử lại.");
  } finally {
    loading.value = false;
  }
};

// --- Filters state & helpers ---
import { computed } from "vue";

const pets = ref([]);
const services = ref([]);
const selectedPet = ref("all");
const selectedService = ref("all");
const dateFrom = ref("");
const dateTo = ref("");
const showFilterPanel = ref(false);
const activeFilterType = ref(null);

const selectedPetLabel = computed(() => {
  if (selectedPet.value === "all") return "Tất cả thú cưng";
  const p = pets.value.find((x) => String(x.id) === String(selectedPet.value));
  return p
    ? p.name || p.ten || p.ten_thu_cung || "Thú cưng"
    : "Tất cả thú cưng";
});

const selectedServiceLabel = computed(() => {
  if (selectedService.value === "all") return "Tất cả dịch vụ";
  const s = services.value.find(
    (x) => String(x.id) === String(selectedService.value)
  );
  return s ? s.name || s.ten || s.ten_dich_vu || "Dịch vụ" : "Tất cả dịch vụ";
});

const dateRangeLabel = computed(() => {
  if (!dateFrom.value && !dateTo.value) return "Khoảng thời gian";
  if (dateFrom.value && !dateTo.value) return `Từ ${dateFrom.value}`;
  if (!dateFrom.value && dateTo.value) return `Đến ${dateTo.value}`;
  return `${dateFrom.value} → ${dateTo.value}`;
});

const fetchFilterOptions = async () => {
  try {
    const [pRes, sRes] = await Promise.all([
      axios.get(`${API_BASE}/thu-cung?all=1`).catch(() => ({ data: [] })),
      axios.get(`${API_BASE}/dich-vu`).catch(() => ({ data: [] })),
    ]);
    pets.value = Array.isArray(pRes.data) ? pRes.data : pRes.data?.data || [];
    services.value = Array.isArray(sRes.data)
      ? sRes.data
      : sRes.data?.data || [];
  } catch (e) {
    console.warn("Không thể nạp tùy chọn lọc:", e);
  }
};

onMounted(() => {
  fetchAppointments();
  fetchFilterOptions();
});

const openFilter = (type) => {
  activeFilterType.value = type;
  showFilterPanel.value = true;
};

const closeFilter = () => {
  showFilterPanel.value = false;
  activeFilterType.value = null;
};

const applyFilters = () => {
  // call server with filter params
  const params = {};
  if (selectedPet.value !== "all") {
    const p = pets.value.find(
      (x) => String(x.id) === String(selectedPet.value)
    );
    if (p)
      params.pet_name =
        p.ten_thu_cung || p.name || p.ten || p.display_name || "";
  }
  if (selectedService.value !== "all") {
    params.dich_vu_id = selectedService.value;
  }
  if (dateFrom.value) params.from_date = dateFrom.value;
  if (dateTo.value) params.to_date = dateTo.value;

  fetchAppointments(params);
  closeFilter();
};

const clearFilters = () => {
  selectedPet.value = "all";
  selectedService.value = "all";
  dateFrom.value = "";
  dateTo.value = "";
};

const withinDateRange = (isoDate) => {
  if (!isoDate) return false;
  const t = new Date(isoDate).setHours(0, 0, 0, 0);
  if (dateFrom.value) {
    const from = new Date(dateFrom.value).setHours(0, 0, 0, 0);
    if (t < from) return false;
  }
  if (dateTo.value) {
    const to = new Date(dateTo.value).setHours(0, 0, 0, 0);
    if (t > to) return false;
  }
  return true;
};

const tabs = computed(() => [
  {
    id: "upcoming",
    label: "Sắp tới",
    count: upcomingAppointments.value.length,
  },
  { id: "past", label: "Đã qua", count: pastAppointments.value.length },
]);

const showDetail = ref(false);
const selectedAppt = ref(null);
const showBookingPopup = ref(false);
const rebookData = ref(null);
const showReschedulePopup = ref(false);
const rescheduleAppt = ref(null);
const showCancelPopup = ref(false);
const cancelAppt = ref(null);
const cancelStatus = ref("unpaid"); // 'late' | 'refundable' | 'unpaid'
const showResultPopup = ref(false);
const resultData = ref(null);

const openDetail = (appt) => {
  selectedAppt.value = { ...appt };
  showDetail.value = true;
};

const handleNewAppointment = () => {
  rebookData.value = null;
  showBookingPopup.value = true;
};

const handleBookingConfirm = async (bookingData) => {
  // bookingData may be server response or payload
  console.log("Booking confirmed:", bookingData);
  showSuccessToast("Đặt lịch", "Đặt lịch thành công");
  // refresh appointments list
  await fetchAppointments();
  showBookingPopup.value = false;
};

// openFilter/clearFilters implemented above with filter panel logic

const handleReschedule = (id) => {
  const appt = upcomingAppointments.value.find((a) => a.id === id);
  if (appt) {
    rescheduleAppt.value = {
      id: appt.id,
      petName: appt.pet,
      serviceName: appt.service,
      dateTime: `${appt.time} - ${appt.date}`,
      date: appt.date,
      time: appt.time,
    };
    showReschedulePopup.value = true;
  }
};

const handleRescheduleConfirm = async (data) => {
  // data: { oldDateTime, newDate, newTime, newDateTime }
  try {
    const apptId = rescheduleAppt.value?.id || data.id;
    if (!apptId) throw new Error("Không xác định được lịch hẹn để đổi.");

    // newDate is DD/MM/YYYY -> convert to YYYY-MM-DD
    const parts = data.newDate.split("/");
    if (parts.length !== 3) throw new Error("Ngày mới không hợp lệ.");
    const day = parts[0].padStart(2, "0");
    const month = parts[1].padStart(2, "0");
    const year = parts[2];
    const ngayGio = `${year}-${month}-${day} ${data.newTime}:00`;

    // send PATCH to update ngay_gio
    const res = await axios.patch(`${API_BASE}/lich-hen/${apptId}/ngay-gio`, {
      ngay_gio: ngayGio,
    });

    if (res.data && res.data.status) {
      showSuccessToast("Đổi lịch", "Đã cập nhật ngày giờ lịch hẹn");
      // refresh appointments
      await fetchAppointments();
      showReschedulePopup.value = false;
      rescheduleAppt.value = null;
    } else {
      console.error("Unexpected response", res);
      showErrorToast("Đổi lịch", "Không thể đổi lịch. Vui lòng thử lại.");
    }
  } catch (err) {
    console.error("Lỗi khi đổi lịch:", err);
    const msg =
      err?.response?.data?.message || err.message || "Lỗi khi đổi lịch hẹn";
    showErrorToast("Đổi lịch", msg);
  }
};

const handleCancel = (id) => {
  const appt = upcomingAppointments.value.find((a) => a.id === id);
  if (appt) {
    cancelAppt.value = {
      id: appt.id,
      petName: appt.pet,
      serviceName: appt.service,
      paidAmount: "250.000", // Mock amount
    };
    // Mock logic to determine cancel status
    // In real app, check time diff and payment status
    const randomStatus = Math.random();
    if (randomStatus < 0.33) cancelStatus.value = "late";
    else if (randomStatus < 0.66) cancelStatus.value = "refundable";
    else cancelStatus.value = "unpaid";

    showCancelPopup.value = true;
  }
};

const handleCancelConfirm = async (data) => {
  // data: { appointmentId, reason, cancelStatus } emitted from HuyHen
  try {
    const id = data?.appointmentId || data?.id;
    if (!id) throw new Error("Không xác định được lịch hẹn để hủy.");

    const res = await axios.delete(`${API_BASE}/lich-hen/${id}`);
    if (res.data && res.data.status) {
      showSuccessToast("Hủy hẹn", "Lịch hẹn đã được hủy");
      // refresh list
      await fetchAppointments();
      showCancelPopup.value = false;
      cancelAppt.value = null;
    } else {
      console.error("Unexpected delete response", res);
      showErrorToast("Hủy hẹn", "Không thể hủy lịch hẹn. Vui lòng thử lại.");
    }
  } catch (err) {
    console.error("Lỗi khi hủy lịch hẹn:", err);
    const msg =
      err?.response?.data?.message || err.message || "Lỗi khi hủy lịch hẹn";
    showErrorToast("Hủy hẹn", msg);
  }
};

const viewResult = (id) => {
  const appt = pastAppointments.value.find((a) => a.id === id);
  if (appt) {
    // Mock result data
    resultData.value = {
      date: appt.date,
      time: appt.time,
      serviceName: appt.service,
      doctorName: appt.doctor,
      doctorSpecialty: "Nội khoa thú y",
      diagnosis:
        "Viêm da dị ứng do bọ chét. Thú cưng có biểu hiện ngứa nhiều vùng lưng và đuôi, da mẩn đỏ.",
      medicines: [
        {
          name: "Apoquel 5.4mg",
          dosage: "1 viên/ngày",
          instruction: "Uống sau khi ăn sáng",
        },
        {
          name: "Bravecto",
          dosage: "1 viên duy nhất",
          instruction: "Nhai trực tiếp hoặc trộn với thức ăn",
        },
      ],
      postCareGuideline:
        "Vệ sinh môi trường sống sạch sẽ, giặt giũ đệm nằm của thú cưng. Tái khám sau 2 tuần nếu triệu chứng không giảm.",
      attachments: [
        {
          name: "Ket_qua_xet_nghiem_mau.pdf",
          label: "Kết quả xét nghiệm",
          type: "pdf",
          url: "#",
        },
        {
          name: "Hinh_anh_vung_da.jpg",
          label: "Hình ảnh lâm sàng",
          type: "image",
          url: "#",
        },
      ],
    };
    showResultPopup.value = true;
  }
};

const rebook = (id) => {
  const appt =
    pastAppointments.value.find((a) => a.id === id) ||
    upcomingAppointments.value.find((a) => a.id === id);
  if (appt) {
    rebookData.value = {
      petName: appt.pet,
      serviceName: appt.service,
    };
    showBookingPopup.value = true;
  }
};
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;500;600;700;800&family=Inter:wght@700&display=swap");

.font-nunito {
  font-family: "Nunito Sans", sans-serif;
}
</style>
