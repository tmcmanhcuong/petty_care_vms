<template>
  <div class="w-full min-h-screen bg-gray-50 p-6">
    <!-- Header -->
    <div class="mb-6">
      <h1 class="text-2xl font-medium text-[#101828] font-nunito">
        Phân ca làm việc
      </h1>
      <p class="text-base text-[#4a5565] font-nunito mt-1">
        Quản lý lịch làm việc cho nhân viên
      </p>
    </div>

    <!-- Control Panel -->
    <div
      class="bg-white rounded-2xl border border-gray-200/60 p-5 mb-6 shadow-sm"
    >
      <div class="flex items-center justify-between">
        <!-- Left: Navigation -->
        <div class="flex items-center gap-4">
          <button
            @click="previousWeek"
            class="p-2.5 rounded-lg border border-gray-300 hover:bg-gray-50 transition"
          >
            <img :src="iconChevronLeft" class="w-5 h-5" />
          </button>

          <div class="bg-gray-50 px-5 py-3 rounded-xl font-medium text-sm">
            Tuần này: {{ currentWeekRange }}
          </div>

          <button
            @click="nextWeek"
            class="p-2.5 rounded-lg border border-gray-300 hover:bg-gray-50 transition"
          >
            <img :src="iconChevronRight" class="w-5 h-5" />
          </button>

          <button
            @click="goToToday"
            class="flex items-center gap-2 px-4 py-3 rounded-lg border border-gray-300 hover:bg-gray-50 transition font-medium text-sm"
          >
            <img :src="iconCalendar" class="w-5 h-5" />
            Hôm nay
          </button>
        </div>

        <!-- Right: Actions -->
        <div class="flex items-center gap-3">
          <button
            class="px-4 py-3 bg-[#f3f3f5] rounded-lg flex items-center gap-2 hover:bg-gray-200 text-sm font-medium"
          >
            Tất cả Vai trò
            <img :src="iconChevronDown" class="w-4 h-4" />
          </button>

          <div class="relative">
            <input
              type="text"
              placeholder="Tìm nhân viên..."
              class="w-64 pl-11 pr-4 py-3 bg-[#f3f3f5] rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <img
              :src="iconSearch"
              class="absolute left-3.5 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500"
            />
          </div>

          <button
            @click="handleAddShift"
            class="bg-[#00a63e] text-white px-5 py-3 rounded-lg flex items-center gap-2 hover:bg-[#008c35] font-medium text-sm transition"
          >
            <img :src="iconPlus" class="w-5 h-5" />
            Thêm ca làm
          </button>
        </div>
      </div>
    </div>

    <!-- Summary (week totals) -->
    <div class="mb-6 flex items-center justify-between gap-4">
      <div class="flex items-center gap-4">
        <div class="bg-white border rounded-lg px-4 py-3 shadow-sm">
          <div class="text-sm text-gray-500">Tổng giờ tuần</div>
          <div class="text-2xl font-bold text-[#0f766e]">
            {{ overallTotal }}h
          </div>
        </div>

        <div class="hidden sm:flex items-center gap-2">
          <template v-for="day in weekDays" :key="day.dateStr">
            <div
              class="bg-white border rounded-md px-3 py-2 text-center shadow-sm"
            >
              <div class="text-xs text-gray-500">{{ day.dayName }}</div>
              <div class="text-sm font-semibold">
                {{ totalsPerDay[day.dateStr] || 0 }}h
              </div>
            </div>
          </template>
        </div>
      </div>

      <div>
        <button
          @click="goToToday"
          class="px-4 py-2 bg-[#009689] text-white rounded-lg text-sm font-medium"
        >
          Hiện tuần hiện tại
        </button>
      </div>
    </div>

    <div v-if="!isLoading && !hasAnyShift" class="mb-4">
      <div
        class="bg-yellow-50 border border-yellow-200 text-yellow-800 px-4 py-3 rounded-md"
      >
        Không có ca làm việc nào trong tuần này.
      </div>
    </div>

    <!-- Schedule Table -->
    <div
      class="bg-white rounded-2xl border border-gray-200/60 overflow-hidden shadow-sm"
    >
      <div class="overflow-x-auto">
        <table class="w-full min-w-max">
          <thead>
            <tr class="bg-gray-50 border-b border-gray-200">
              <th
                class="text-left px-6 py-5 sticky left-0 bg-gray-50 z-10 border-r border-gray-200 w-72"
              >
                <span class="font-bold text-base text-neutral-950"
                  >Nhân viên</span
                >
              </th>
              <th
                v-for="day in weekDays"
                :key="day.dateStr"
                :class="[
                  'px-4 py-5 text-center border-r border-gray-200 w-48',
                  day.isToday ? 'bg-teal-50' : '',
                ]"
              >
                <div class="flex flex-col items-center">
                  <span class="text-sm font-bold text-[#4a5565]">{{
                    day.dayName
                  }}</span>
                  <span
                    :class="[
                      'text-xl font-bold mt-1',
                      day.isToday ? 'text-[#009689]' : 'text-[#101828]',
                    ]"
                  >
                    {{ day.date }}
                  </span>
                  <span class="text-xs text-gray-500 mt-2 font-medium">
                    {{ totalsPerDay[day.dateStr] || 0 }}h
                  </span>
                </div>
              </th>
              <th class="px-6 py-5 bg-gray-50 text-center w-36">
                <div class="flex flex-col items-center">
                  <span class="font-bold text-base text-neutral-950"
                    >Tổng giờ</span
                  >
                  <span class="text-sm text-gray-600 font-bold mt-2"
                    >{{ overallTotal }}h</span
                  >
                </div>
              </th>
            </tr>
          </thead>

          <tbody>
            <tr
              v-for="staff in staffList"
              :key="staff.id"
              class="border-b border-gray-200 hover:bg-gray-50 transition"
            >
              <!-- Staff Info -->
              <td
                class="px-6 py-6 border-r border-gray-200 sticky left-0 bg-white z-10"
              >
                <div class="flex items-center gap-4">
                  <img
                    :src="staff.avatar"
                    :alt="staff.name"
                    class="w-12 h-12 rounded-full object-cover border-2 border-gray-300"
                  />
                  <div>
                    <p class="font-medium text-sm text-[#101828]">
                      {{ staff.name }}
                    </p>
                    <p class="text-xs text-[#6a7282] mt-1">{{ staff.role }}</p>
                  </div>
                </div>
              </td>

              <!-- Days -->
              <td
                v-for="day in weekDays"
                :key="day.dateStr"
                :class="[
                  'border-r border-gray-200 text-center align-top',
                  day.isToday ? 'bg-teal-50' : '',
                ]"
              >
                <div class="py-4 px-3 min-h-36">
                  <div
                    @click="addShiftForStaff(staff, day)"
                    class="h-full rounded-xl border-2 border-dashed border-transparent hover:border-gray-300 hover:bg-gray-100 transition-all cursor-pointer relative group"
                    :class="{
                      'bg-emerald-50 border-emerald-300': hasShift(
                        staff,
                        day.dateStr
                      ),
                    }"
                  >
                    <!-- Shifts -->
                    <div
                      v-if="getShiftsForCell(staff, day.dateStr).length"
                      class="space-y-2 p-3"
                    >
                      <div
                        v-for="shift in getShiftsForCell(staff, day.dateStr)"
                        :key="shift.id"
                        class="bg-white rounded-xl shadow-sm border-2 p-3 flex flex-col"
                        :class="shiftBorderClass(shift)"
                      >
                        <div class="flex items-center justify-between">
                          <div
                            class="flex items-center gap-2 text-sm font-medium text-gray-700"
                          >
                            <svg
                              class="w-4 h-4 text-gray-400"
                              fill="none"
                              stroke="currentColor"
                              viewBox="0 0 24 24"
                            >
                              <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h-4m-8 0H5"
                              />
                            </svg>
                            <span class="truncate max-w-24">{{
                              shift.phong_truc || "Chưa chọn phòng"
                            }}</span>
                          </div>
                          <span
                            :class="[
                              'text-xs px-2.5 py-1 rounded-full text-white font-bold',
                              shift.thoi_gian_truc === 'ca_sang'
                                ? 'bg-emerald-600'
                                : shift.thoi_gian_truc === 'ca_chieu'
                                ? 'bg-amber-500'
                                : 'bg-slate-700',
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
                      </div>
                    </div>

                    <!-- Add Button -->
                    <div
                      class="absolute bottom-3 right-3 opacity-0 group-hover:opacity-100 transition-opacity"
                    >
                      <button
                        class="w-10 h-10 rounded-full bg-white border-2 border-gray-300 shadow-lg flex items-center justify-center hover:bg-gray-50"
                      >
                        <img :src="iconPlus" class="w-5 h-5" />
                      </button>
                    </div>
                  </div>
                </div>
              </td>

              <!-- Total Hours -->
              <td class="px-6 py-6 bg-gray-50 text-center font-bold">
                <span
                  class="inline-block px-5 py-3 bg-white border-2 border-[#d1d5dc] rounded-xl text-lg text-[#101828]"
                >
                  {{ staff.totalHours }}h
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
const shifts = ref({});
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
  // any staff has totalHours > 0 or totalsPerDay has keys
  if (Object.keys(totalsPerDay.value).length) return true;
  return staffList.value.some((s) => (s.totalHours || 0) > 0);
});

const hasShift = (staff, dateStr) =>
  getShiftsForCell(staff, dateStr).length > 0;
const getShiftsForCell = (staff, dateStr) =>
  (shifts.value[staff.id] || {})[dateStr] || [];

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
  } catch (e) {
    console.error("Lỗi tải lịch làm việc", e);
  } finally {
    isLoading.value = false;
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
  height: 8px;
}
::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}
::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}
::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>
