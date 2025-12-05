<template>
  <div
    class="w-full min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 p-8"
  >
    <!-- Header Section -->
    <div class="mb-8">
      <h1 class="text-3xl font-bold text-gray-900 font-nunito mb-2">
        Phân ca làm việc
      </h1>
      <p class="text-gray-600 font-nunito">
        Quản lý lịch làm việc và lịch hẹn cho nhân viên
      </p>
    </div>

    <!-- Control Panel -->
    <div
      class="bg-white rounded-xl border border-gray-200 p-6 mb-6 shadow-sm hover:shadow-md transition-shadow"
    >
      <div class="flex flex-col lg:flex-row items-center justify-between gap-4">
        <!-- Left: Navigation -->
        <div class="flex items-center gap-3">
          <button
            @click="previousWeek"
            class="p-2 rounded-lg border border-gray-300 hover:bg-gray-50 hover:border-gray-400 transition"
            title="Tuần trước"
          >
            <img :src="iconChevronLeft" class="w-5 h-5" />
          </button>

          <div
            class="bg-gradient-to-r from-teal-50 to-cyan-50 px-6 py-2 rounded-lg font-medium text-sm text-gray-800 border border-teal-200 min-w-max"
          >
            {{ currentWeekRange }}
          </div>

          <button
            @click="nextWeek"
            class="p-2 rounded-lg border border-gray-300 hover:bg-gray-50 hover:border-gray-400 transition"
            title="Tuần sau"
          >
            <img :src="iconChevronRight" class="w-5 h-5" />
          </button>

          <button
            @click="goToToday"
            class="flex items-center gap-2 px-4 py-2 rounded-lg border border-teal-200 bg-teal-50 hover:bg-teal-100 transition text-teal-700 font-medium text-sm"
          >
            <img :src="iconCalendar" class="w-4 h-4" />
            Hôm nay
          </button>
        </div>

        <!-- Right: Actions -->
        <div class="flex items-center gap-3 w-full lg:w-auto">
          <div class="relative flex-1 lg:flex-none">
            <input
              type="text"
              placeholder="Tìm nhân viên..."
              class="w-full lg:w-48 pl-10 pr-4 py-2 bg-gray-50 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-teal-500 focus:bg-white transition"
            />
            <img
              :src="iconSearch"
              class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400"
            />
          </div>

          <button
            @click="handleAddShift"
            class="bg-gradient-to-r from-teal-500 to-teal-600 hover:from-teal-600 hover:to-teal-700 text-white px-5 py-2 rounded-lg flex items-center gap-2 font-medium text-sm transition shadow-sm hover:shadow-md"
          >
            <img :src="iconPlus" class="w-4 h-4" />
            Thêm ca
          </button>
        </div>
      </div>
    </div>

    <!-- Summary Section -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
      <!-- Overall Total -->
      <div
        class="bg-white border border-gray-200 rounded-lg p-5 shadow-sm hover:shadow-md transition"
      >
        <p class="text-gray-600 text-sm font-medium mb-2">Tổng giờ tuần</p>
        <p class="text-3xl font-bold text-teal-600">
          {{ overallTotal }}<span class="text-lg text-gray-400">h</span>
        </p>
      </div>

      <!-- Day Totals -->
      <template v-for="day in weekDays" :key="day.dateStr">
        <div
          :class="[
            'bg-white border rounded-lg p-4 shadow-sm hover:shadow-md transition text-center',
            day.isToday
              ? 'border-teal-300 bg-gradient-to-br from-teal-50 to-cyan-50'
              : 'border-gray-200',
          ]"
        >
          <p
            :class="[
              'text-xs font-bold mb-1',
              day.isToday ? 'text-teal-700' : 'text-gray-600',
            ]"
          >
            {{ day.dayName }}
          </p>
          <p
            :class="[
              'text-lg font-bold mb-2',
              day.isToday ? 'text-teal-600' : 'text-gray-900',
            ]"
          >
            {{ day.date }}
          </p>
          <p class="text-sm font-semibold text-gray-600">
            {{ totalsPerDay[day.dateStr] || 0
            }}<span class="text-xs text-gray-400">h</span>
          </p>
        </div>
      </template>
    </div>

    <!-- Empty State -->
    <div v-if="!isLoading && !hasAnyShift" class="mb-6">
      <div
        class="bg-amber-50 border border-amber-200 text-amber-800 px-5 py-4 rounded-lg flex items-start gap-3"
      >
        <svg
          class="w-5 h-5 mt-0.5 flex-shrink-0"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M12 9v2m0 4v2m0 4v2M7.08 6.47A9.968 9.968 0 0112 1c4.97 0 9 4.03 9 9s-4.03 9-9 9S3 17 3 12c0-2.395.904-4.577 2.391-6.22"
          />
        </svg>
        <div>
          <p class="font-semibold">Không có dữ liệu</p>
          <p class="text-sm mt-1">
            Chưa có ca làm việc hoặc lịch hẹn trong tuần này
          </p>
        </div>
      </div>
    </div>

    <!-- Schedule Table -->
    <div
      class="bg-white rounded-lg border border-gray-200 shadow-sm overflow-hidden"
    >
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead>
            <tr
              class="bg-gradient-to-r from-gray-50 to-gray-100 border-b border-gray-200"
            >
              <th
                class="text-left px-6 py-4 sticky left-0 bg-gradient-to-r from-gray-50 to-gray-100 z-10 border-r border-gray-200 font-semibold text-sm text-gray-900"
              >
                Nhân viên
              </th>
              <th
                v-for="day in weekDays"
                :key="day.dateStr"
                :class="[
                  'px-5 py-4 text-center border-r border-gray-200 font-semibold text-sm',
                  day.isToday ? 'bg-teal-50 text-teal-900' : 'text-gray-900',
                ]"
              >
                <div class="flex flex-col items-center">
                  <span class="text-xs font-bold text-gray-600">{{
                    day.dayName
                  }}</span>
                  <span class="text-lg font-bold mt-1">{{ day.date }}</span>
                  <span
                    class="text-xs mt-2 font-semibold"
                    :class="day.isToday ? 'text-teal-600' : 'text-gray-500'"
                  >
                    {{ totalsPerDay[day.dateStr] || 0 }}h
                  </span>
                </div>
              </th>
              <th
                class="px-6 py-4 text-center font-semibold text-sm text-gray-900 bg-gradient-to-l from-gray-50 to-gray-100"
              >
                Tổng giờ
              </th>
            </tr>
          </thead>

          <tbody>
            <tr
              v-for="staff in staffList"
              :key="staff.id"
              class="border-b border-gray-100 hover:bg-gray-50 transition group"
            >
              <!-- Staff Info -->
              <td
                class="px-6 py-5 border-r border-gray-100 sticky left-0 bg-white group-hover:bg-gray-50 z-10"
              >
                <div class="flex items-center gap-3">
                  <img
                    :src="staff.avatar"
                    :alt="staff.name"
                    class="w-10 h-10 rounded-full object-cover border-2 border-gray-200"
                  />
                  <div>
                    <p class="font-semibold text-sm text-gray-900">
                      {{ staff.name }}
                    </p>
                    <p class="text-xs text-gray-500 mt-1">{{ staff.role }}</p>
                  </div>
                </div>
              </td>

              <!-- Days -->
              <td
                v-for="day in weekDays"
                :key="day.dateStr"
                :class="[
                  'border-r border-gray-100 px-3 py-4',
                  day.isToday ? 'bg-teal-50/50' : '',
                ]"
              >
                <div class="min-h-32">
                  <div
                    @click="addShiftForStaff(staff, day)"
                    class="h-full space-y-2 rounded-lg border-2 border-dashed border-gray-200 hover:border-teal-300 hover:bg-teal-50/30 transition-all cursor-pointer p-2"
                    :class="{
                      'border-teal-300 bg-teal-50':
                        hasShift(staff, day.dateStr) ||
                        getAppointmentsForCell(staff, day.dateStr).length > 0,
                    }"
                  >
                    <!-- Shifts -->
                    <template
                      v-if="getShiftsForCell(staff, day.dateStr).length"
                    >
                      <div
                        v-for="shift in getShiftsForCell(staff, day.dateStr)"
                        :key="shift.id"
                        class="bg-white rounded-md border-l-4 p-2 text-xs hover:shadow-sm transition"
                        :class="shiftBorderClass(shift)"
                      >
                        <div class="font-semibold text-gray-800 truncate">
                          {{ shift.phong_truc || "Phòng" }}
                        </div>
                        <span
                          :class="[
                            'inline-block mt-1 px-2 py-0.5 rounded text-white text-xs font-bold',
                            shift.thoi_gian_truc === 'ca_sang'
                              ? 'bg-emerald-500'
                              : shift.thoi_gian_truc === 'ca_chieu'
                              ? 'bg-amber-500'
                              : 'bg-slate-600',
                          ]"
                        >
                          {{
                            shift.thoi_gian_truc === "ca_sang"
                              ? "Sáng"
                              : shift.thoi_gian_truc === "ca_chieu"
                              ? "Chiều"
                              : "Tối"
                          }}
                        </span>
                      </div>
                    </template>

                    <!-- Appointments -->
                    <template
                      v-if="getAppointmentsForCell(staff, day.dateStr).length"
                    >
                      <div
                        v-for="appointment in getAppointmentsForCell(
                          staff,
                          day.dateStr
                        )"
                        :key="appointment.id"
                        class="bg-blue-50 rounded-md border-l-4 border-blue-400 p-2 text-xs hover:shadow-sm transition"
                      >
                        <div class="font-semibold text-blue-900 truncate">
                          {{ appointment.customer }}
                        </div>
                        <div class="text-blue-700 truncate mt-1 text-xs">
                          {{ appointment.service }}
                        </div>
                      </div>
                    </template>
                  </div>
                </div>
              </td>

              <!-- Total Hours -->
              <td class="px-6 py-5 text-center">
                <span
                  class="inline-flex items-center justify-center px-4 py-2 bg-gradient-to-r from-gray-50 to-gray-100 border border-gray-200 rounded-lg text-lg font-bold text-gray-900"
                >
                  {{ staff.totalHours
                  }}<span class="text-sm text-gray-500 ml-1">h</span>
                </span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modal -->
    <PhanCaTruc
      v-if="isAddShiftModalOpen"
      :preselected-staff="selectedStaffForShift"
      :preselected-date="selectedDateForShift"
      :serverErrors="serverErrors"
      :saving="isSavingShift"
      @close="isAddShiftModalOpen = false"
      @save="handleSaveShift"
    />
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from "vue";
import PhanCaTruc from "./PhanCaTruc/index.vue";
import api from "@/utils/api";
import { showSuccessToast, showErrorToast } from "@/utils/toast";

// Icons
const iconChevronLeft =
  "https://www.figma.com/api/mcp/asset/b9509eb5-3157-4012-a086-91b4ade81fc8";
const iconChevronRight =
  "https://www.figma.com/api/mcp/asset/b779fc4b-d0d6-4c7c-a642-6b25429867b0";
const iconCalendar =
  "https://www.figma.com/api/mcp/asset/5bb1b000-78c1-46b1-bd87-17b2263bbd78";
const iconChevronDown =
  "https://www.figma.com/api/mcp/asset/fc11cada-6bb9-4808-bc7e-4762d45854bc";
const iconSearch =
  "https://www.figma.com/api/mcp/asset/fb2a8768-bd69-4b3b-9191-13487ee0138c";
const iconPlus =
  "https://www.figma.com/api/mcp/asset/0f3e9ec3-0c1c-45bd-986e-ca0749a17b23";

// State
const staffList = ref([]);
const currentWeekStart = ref(new Date());
const shifts = ref({}); // lich_lam_viec (ca làm việc)
const appointments = ref({}); // lich_hen (lịch hẹn khách hàng)
const totalsPerDay = ref({});
const overallTotal = ref(0);
const isLoading = ref(false);

// Modal
const isAddShiftModalOpen = ref(false);
const selectedStaffForShift = ref(null);
const selectedDateForShift = ref("");
const isSavingShift = ref(false);
const serverErrors = ref({});

// Helpers
const formatDate = (date) => {
  const d = new Date(date);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(
    2,
    "0"
  )}-${String(d.getDate()).padStart(2, "0")}`;
};

// Normalize date key to YYYY-MM-DD (handles ISO datetimes returned from API)
const normalizeDateKey = (d) => {
  if (!d && d !== 0) return d;
  if (typeof d === "string") {
    return d.includes("T") ? d.slice(0, 10) : d;
  }
  return formatDate(d);
};

const currentWeekRange = computed(() => {
  const start = new Date(currentWeekStart.value);
  const end = new Date(start);
  end.setDate(start.getDate() + 6);
  const fmt = (d) =>
    `${String(d.getDate()).padStart(2, "0")}/${String(
      d.getMonth() + 1
    ).padStart(2, "0")}`;
  return `${fmt(start)} - ${fmt(end)}`;
});

const weekDays = computed(() => {
  const days = [];
  const names = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  for (let i = 0; i < 7; i++) {
    const date = new Date(currentWeekStart.value);
    date.setDate(date.getDate() + i);
    const dateStr = formatDate(date);
    const isToday = formatDate(date) === formatDate(today);

    days.push({
      dayName: names[i],
      date: `${String(date.getDate()).padStart(2, "0")}/${String(
        date.getMonth() + 1
      ).padStart(2, "0")}`,
      dateStr,
      isToday,
    });
  }
  return days;
});

const hasAnyShift = computed(() => {
  // Check if any staff has totalHours > 0 OR if there are any appointments
  if (Object.keys(totalsPerDay.value).length) return true;
  if (Object.keys(appointments.value).length) return true; // Check appointments too
  return staffList.value.some((s) => (s.totalHours || 0) > 0);
});

const hasShift = (staff, dateStr) =>
  getShiftsForCell(staff, dateStr).length > 0;
const getShiftsForCell = (staff, dateStr) =>
  (shifts.value[staff.id] || {})[dateStr] || [];

const getAppointmentsForCell = (staff, dateStr) =>
  (appointments.value[staff.id] || {})[dateStr] || [];

const shiftBorderClass = (shift) => {
  if (shift.thoi_gian_truc === "ca_sang") return "border-emerald-400";
  if (shift.thoi_gian_truc === "ca_chieu") return "border-amber-400";
  return "border-slate-700";
};

// Fetch & Calculate
const fetchStaff = async () => {
  try {
    const res = await api.get("/nhan-vien", { params: { per_page: 500 } });
    const data = res.data?.data?.data || res.data?.data || [];
    staffList.value = data.map((s) => ({
      id: s.id,
      name: s.ho_ten || s.full_name || "Không tên",
      role: s.chuc_vu || s.vai_tro || "Nhân viên",
      avatar:
        s.avatar ||
        `https://ui-avatars.com/api/?name=${encodeURIComponent(
          s.ho_ten || "N"
        )}&background=0D8ABC&color=fff`,
      totalHours: 0,
    }));
  } catch (e) {
    showErrorToast("Lỗi", "Không tải được nhân viên");
  }
};

const fetchShiftsForWeek = async () => {
  isLoading.value = true;
  try {
    const dates = weekDays.value.map((d) => d.dateStr);
    const requests = dates.map((d) =>
      api.get("/lich-lam-viec", { params: { ngay_lam: d, per_page: 200 } })
    );
    const responses = await Promise.all(requests);

    const newShifts = {};
    const dayTotals = {};
    let totalAll = 0;

    responses.forEach((res) => {
      const items = res.data?.data?.data || res.data?.data || [];
      items.forEach((item) => {
        const sid = item.nhan_vien_id || item.nhanvien_id;
        const rawDate = item.ngay_lam || item.date || "";
        const date = normalizeDateKey(rawDate);
        if (!sid || !date) return;

        if (!newShifts[sid]) newShifts[sid] = {};
        if (!newShifts[sid][date]) newShifts[sid][date] = [];
        newShifts[sid][date].push(item);

        const hours = item.thoi_gian_truc === "ca_toi" ? 12 : 8;
        dayTotals[date] = (dayTotals[date] || 0) + hours;
        totalAll += hours;
      });
    });

    shifts.value = newShifts;
    totalsPerDay.value = dayTotals;
    overallTotal.value = totalAll;

    // Update total per staff
    staffList.value.forEach((staff) => {
      let h = 0;
      weekDays.value.forEach((day) => {
        const dayShifts = getShiftsForCell(staff, day.dateStr);
        dayShifts.forEach((s) => (h += s.thoi_gian_truc === "ca_toi" ? 12 : 8));
      });
      staff.totalHours = h;
    });

    // Also fetch appointments
    await fetchAppointmentsForWeek();

    // Calculate totals INCLUDING appointments (mỗi lịch hẹn = 1 giờ)
    let updatedDayTotals = { ...dayTotals };
    let updatedOverallTotal = totalAll;

    Object.keys(appointments.value).forEach((staffId) => {
      Object.keys(appointments.value[staffId]).forEach((dateStr) => {
        const appointmentCount = appointments.value[staffId][dateStr].length;
        updatedDayTotals[dateStr] =
          (updatedDayTotals[dateStr] || 0) + appointmentCount;
        updatedOverallTotal += appointmentCount;
      });
    });

    totalsPerDay.value = updatedDayTotals;
    overallTotal.value = updatedOverallTotal;
  } catch (e) {
    console.error("Lỗi tải lịch làm việc", e);
  } finally {
    isLoading.value = false;
  }
};

// Fetch appointments for the week
const fetchAppointmentsForWeek = async () => {
  try {
    const startDate = weekDays.value[0].dateStr;
    const endDate = weekDays.value[6].dateStr;

    const res = await api.get("/lich-hen", {
      params: { per_page: 500 },
    });

    const allAppointments = res.data?.data?.data || res.data?.data || [];
    const newAppointments = {};

    allAppointments.forEach((item) => {
      const sid = item.nhan_vien_id; // Bác sĩ được phân công
      const rawDate = item.ngay_gio || "";
      const date = normalizeDateKey(rawDate);

      if (!sid || !date) return;

      const itemDate = date.substring(0, 10); // Lấy phần ngày (YYYY-MM-DD)
      if (itemDate < startDate || itemDate > endDate) return;

      if (!newAppointments[sid]) newAppointments[sid] = {};
      if (!newAppointments[sid][itemDate]) newAppointments[sid][itemDate] = [];

      // Transform appointment data to get customer name and service name
      const transformedAppointment = {
        id: item.id,
        customer:
          typeof item.khach_hang === "string"
            ? item.khach_hang
            : item.khach_hang?.ho_ten ||
              item.khach_hang?.full_name ||
              item.khach_hang?.name ||
              "Khách hàng",
        service: item.dich_vu?.ten || item.dich_vu?.name || "Dịch vụ",
        pet: item.thu_cung?.ten_thu_cung || item.thu_cung?.name || "Thú cưng",
        time: item.ngay_gio
          ? new Date(item.ngay_gio).toLocaleTimeString("vi-VN", {
              hour: "2-digit",
              minute: "2-digit",
            })
          : "",
        status: item.trang_thai,
      };

      newAppointments[sid][itemDate].push(transformedAppointment);
    });

    appointments.value = newAppointments;
  } catch (e) {
    console.error("Lỗi tải lịch hẹn", e);
  }
};

// Navigation
const previousWeek = () =>
  (currentWeekStart.value = new Date(
    currentWeekStart.value.setDate(currentWeekStart.value.getDate() - 7)
  ));
const nextWeek = () =>
  (currentWeekStart.value = new Date(
    currentWeekStart.value.setDate(currentWeekStart.value.getDate() + 7)
  ));
const goToToday = () => {
  const today = new Date();
  const diff = today.getDay() === 0 ? -6 : 1 - today.getDay();
  currentWeekStart.value = new Date(today.setDate(today.getDate() + diff));
};

// Modal
const addShiftForStaff = (staff, day) => {
  selectedStaffForShift.value = staff;
  selectedDateForShift.value = day.dateStr;
  isAddShiftModalOpen.value = true;
};

const handleAddShift = () => {
  selectedStaffForShift.value = null;
  selectedDateForShift.value = "";
  isAddShiftModalOpen.value = true;
};

const handleSaveShift = async (data) => {
  isSavingShift.value = true;
  try {
    await api.post("/lich-lam-viec", {
      nhan_vien_id: data.staff.id,
      ngay_lam: data.date,
      thoi_gian_truc:
        data.shift === "morning"
          ? "ca_sang"
          : data.shift === "afternoon"
          ? "ca_chieu"
          : "ca_toi",
      phong_truc: data.room,
    });
    showSuccessToast("Thành công", "Đã thêm ca làm việc");
    isAddShiftModalOpen.value = false;
    await fetchShiftsForWeek();
  } catch (e) {
    if (e.response?.status === 422) {
      serverErrors.value = e.response.data.errors || {};
      showErrorToast("Lỗi", "Vui lòng kiểm tra lại thông tin");
    }
  } finally {
    isSavingShift.value = false;
  }
};

// Init
onMounted(async () => {
  goToToday();
  // Ensure staff list is loaded before calculating totals (fetchShifts uses staffList)
  await fetchStaff();
  await fetchShiftsForWeek();
});

watch(currentWeekStart, fetchShiftsForWeek);
</script>

<style scoped>
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #f3f4f6;
  border-radius: 10px;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(180deg, #14b8a6 0%, #0d9488 100%);
  border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(180deg, #0d9488 0%, #0a7c66 100%);
}

/* Table responsiveness */
@media (max-width: 1024px) {
  table {
    font-size: 0.875rem;
  }
}

@media (max-width: 768px) {
  table {
    font-size: 0.75rem;
  }
}
</style>
