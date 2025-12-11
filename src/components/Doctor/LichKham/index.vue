<template>
  <div class="flex flex-col gap-6 w-full max-w-screen-xl mx-auto p-4">
    <!-- Header -->
    <div class="flex flex-col">
      <h1 class="font-medium text-2xl leading-9 text-[#101828]">Lịch khám</h1>
      <p class="text-base text-[#4a5565]">
        Quản lý lịch khám - Chỉ hiển thị ca khám được phân cho bạn
      </p>
    </div>

    <!-- Toolbar -->
    <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-2xl p-4">
      <div class="flex items-center gap-3 mb-4">
        <button
          @click="previousDay"
          :disabled="loading"
          class="w-10 h-10 rounded-lg border border-[rgba(0,0,0,0.1)] hover:bg-gray-50 flex items-center justify-center"
        >
          <img src="@/assets/svg/chevron-left.svg" class="w-5 h-5" />
        </button>

        <div class="flex-1 bg-gray-50 rounded-xl px-8 py-3 text-center">
          <p class="font-medium text-[#101828]">{{ currentDateText }}</p>
        </div>

        <button
          @click="nextDay"
          :disabled="loading"
          class="w-10 h-10 rounded-lg border border-[rgba(0,0,0,0.1)] hover:bg-gray-50 flex items-center justify-center"
        >
          <img src="@/assets/svg/chevron-right.svg" class="w-5 h-5" />
        </button>

        <button
          @click="goToToday"
          class="h-10 px-6 bg-[#5a9690] text-white rounded-lg hover:bg-[#4a857f] font-medium"
        >
          Hôm nay
        </button>
      </div>

      <!-- Tabs -->
      <div class="flex gap-3">
        <button
          v-for="tab in statusTabs"
          :key="tab.value"
          @click="activeTab = tab.value"
          :class="[
            'h-10 px-5 rounded-xl text-sm font-medium transition-colors',
            activeTab === tab.value
              ? 'bg-[#155dfc] text-white'
              : 'bg-gray-100 text-[#364153] hover:bg-gray-200',
          ]"
        >
          {{ tab.label }} <span class="opacity-75 ml-1">({{ tab.count }})</span>
        </button>
      </div>
    </div>

    <!-- Loading / Empty -->
    <div v-if="loading" class="text-center py-12 text-gray-500">
      Đang tải lịch khám...
    </div>
    <div
      v-else-if="displayAppointments.length === 0"
      class="text-center py-12 text-gray-500"
    >
      Không có lịch khám nào trong ngày {{ formatDate(currentDate) }}.
    </div>

    <!-- Appointment List -->
    <div v-else class="flex flex-col gap-4">
      <div
        v-for="appt in displayAppointments"
        :key="appt.id"
        class="bg-white rounded-2xl border overflow-hidden"
        :class="{
          'border-l-4 border-[#60a5fa] border-t border-r border-b border-[rgba(0,0,0,0.1)]':
            appt.displayStatus.type === 'late',
          'border-l-4 border-[#fb923c] border-t border-r border-b border-[rgba(0,0,0,0.1)]':
            appt.displayStatus.type === 'examining',
          'border border-[rgba(0,0,0,0.1)]': true,
        }"
      >
        <div class="flex items-stretch h-48">
          <!-- Time Column -->
          <div
            class="w-44 border-r border-[rgba(0,0,0,0.1)] p-6 flex flex-col justify-between"
          >
            <div>
              <p class="text-3xl font-medium text-[#101828]">
                {{ formatTime(appt.ngay_gio) }}
              </p>

              <div class="mt-3 flex items-center gap-2 text-sm">
                <img
                  v-if="appt.check_in_at"
                  src="@/assets/svg/clock.svg"
                  class="w-4 h-4 brightness-75 hue-rotate-[270deg]"
                />
                <img
                  v-else-if="appt.displayStatus.type === 'late'"
                  src="@/assets/svg/clock.svg"
                  class="w-4 h-4 brightness-75 saturate-150 hue-rotate-[-10deg]"
                />
                <img
                  v-else
                  src="@/assets/svg/clock.svg"
                  class="w-4 h-4 opacity-50"
                />
                <span
                  :class="{
                    'text-[#9810fa]': appt.check_in_at,
                    'text-[#fb2c36]': appt.displayStatus.type === 'late',
                    'text-[#6a7282]':
                      !appt.check_in_at && appt.displayStatus.type !== 'late',
                  }"
                >
                  {{
                    appt.check_in_at
                      ? "+" + formatTime(appt.check_in_at)
                      : "--:--"
                  }}
                  <span v-if="appt.displayStatus.type === 'late'" class="ml-1"
                    >Trễ {{ appt.displayStatus.lateMinutes }}</span
                  >
                </span>
              </div>
            </div>

            <div class="flex flex-col gap-2">
              <!-- Status Badge -->
              <div
                class="inline-flex items-center gap-2 px-3 py-1 rounded-lg text-xs font-medium"
                :class="{
                  'bg-[#dbe7ff] text-[#1447e6]': [
                    'upcoming',
                    'future',
                  ].includes(appt.displayStatus.type),
                  'bg-[#d6fae1] text-[#00a63e]':
                    appt.displayStatus.type === 'arrived',
                  'bg-orange-100 text-[#ea580c]':
                    appt.displayStatus.type === 'examining',
                  'bg-green-100 text-[#00a63e]':
                    appt.displayStatus.type === 'completed',
                }"
              >
                <img
                  v-if="appt.displayStatus.type === 'arrived'"
                  src="@/assets/svg/tick.svg"
                  class="w-4 h-4"
                />
                {{ appt.displayStatus.label }}
              </div>

              <!-- Wait / Remaining time -->
              <div
                v-if="
                  appt.displayStatus.waitMinutes ||
                  appt.displayStatus.futureMinutes
                "
                class="px-3 py-1 rounded-lg text-xs"
                :class="
                  appt.displayStatus.waitMinutes
                    ? 'bg-gray-100 text-gray-600'
                    : 'bg-cyan-100 text-[#0891b2]'
                "
              >
                {{
                  appt.displayStatus.waitMinutes
                    ? appt.displayStatus.waitMinutes + " phút"
                    : appt.displayStatus.label
                }}
              </div>
            </div>
          </div>

          <!-- Pet & Customer Info -->
          <div class="flex-1 p-6 flex gap-6">
            <div
              class="w-28 h-28 border-2 border-gray-200 rounded-2xl overflow-hidden flex-shrink-0"
            >
              <img
                v-if="appt.thu_cung?.anh_dai_dien"
                :src="appt.thu_cung.anh_dai_dien"
                class="w-full h-full object-cover"
              />
              <div
                v-else
                class="w-full h-full bg-gray-50 flex items-center justify-center text-6xl"
              >
                🐾
              </div>
            </div>

            <div class="flex-1">
              <div class="flex items-center gap-3 flex-wrap mb-3">
                <h3 class="text-xl font-bold text-[#101828]">
                  {{ appt.thu_cung?.ten_thu_cung || "Chưa có tên" }}
                </h3>
                <span class="text-[#101828]"
                  >({{ appt.thu_cung?.giong_loai || "?" }})</span
                >
                <span class="text-sm text-[#4a5565]"
                  >- {{ calculateAge(appt.thu_cung?.ngay_sinh) }}</span
                >

                <span
                  class="px-3 py-1 rounded-lg text-xs font-medium flex items-center gap-1"
                  :class="
                    appt.la_khach_vang_lai
                      ? 'bg-[#f2e6ff] text-[#8200db]'
                      : 'bg-[#dbe7ff] text-[#1447e6]'
                  "
                >
                  <img
                    v-if="!appt.la_khach_vang_lai"
                    src="@/assets/svg/calendar.svg"
                    class="w-4 h-4"
                  />
                  <img
                    v-else
                    src="@/assets/svg/user-round.svg"
                    class="w-4 h-4"
                  />
                  {{ appt.la_khach_vang_lai ? "Vãng lai" : "Đặt trước" }}
                </span>
              </div>

              <div class="flex items-center gap-3 text-sm mb-3">
                <span class="text-[#364153]">Chủ:</span>
                <span class="font-bold">{{ appt.khach_hang }}</span>
                <span class="text-[#99a1af]">•</span>
                <div class="flex items-center gap-1">
                  <img src="@/assets/svg/phonecall.svg" class="w-4 h-4" />
                  <span class="text-[#4a5565]">{{
                    appt.khach_hang?.so_dien_thoai || "Chưa có"
                  }}</span>
                </div>
              </div>

              <div
                class="inline-flex px-3 py-1 bg-blue-50 border border-[#bedbff] rounded-lg text-xs text-[#1447e6]"
              >
                {{ appt.dich_vu?.ten || "Khám tổng quát" }}
              </div>

              <!-- Ghi chú -->
              <div
                v-if="appt.ghi_chu"
                class="mt-4 p-3 bg-amber-50 border border-[#fee685] rounded-xl"
              >
                <div class="flex gap-3 text-sm text-[#7b3306]">
                  <img
                    src="@/assets/svg/info-circle.svg"
                    class="w-5 h-5 flex-shrink-0"
                  />
                  <p>
                    <span class="font-bold">Ghi chú:</span> {{ appt.ghi_chu }}
                  </p>
                </div>
              </div>
            </div>
          </div>

          <!-- Action Button -->
          <div class="w-64 p-6 flex items-center justify-end">
            <!-- Đang khám → TIẾP TỤC -->
            <button
              v-if="appt.trang_thai === 'in-progress'"
              @click="startExam(appt.id)"
              class="w-full h-11 bg-[#f54900] text-white rounded-xl font-medium hover:bg-[#ca3500]"
            >
              TIẾP TỤC
            </button>

            <!-- Hoàn thành → Xem lại -->
            <button
              v-else-if="appt.trang_thai === 'completed'"
              class="w-full h-11 border border-[rgba(0,0,0,0.1)] rounded-xl flex items-center justify-center gap-2 text-gray-700 hover:bg-gray-50"
            >
              <img src="@/assets/svg/eye.svg" class="w-5 h-5" />
              Xem lại
            </button>

            <!-- Có thể bắt đầu -->
            <button
              v-else-if="
                ['late', 'arrived', 'upcoming'].includes(
                  appt.displayStatus.type
                )
              "
              @click="startExam(appt.id)"
              class="w-full h-11 bg-[#155dfc] text-white rounded-xl flex items-center justify-center gap-2 hover:bg-[#1447e6]"
            >
              <svg
                class="w-5 h-5"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <circle
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  stroke-width="2"
                />
                <path d="M10 8L16 12L10 16V8Z" fill="currentColor" />
              </svg>
              BẮT ĐẦU
            </button>

            <!-- Tương lai → disable -->
            <button
              v-else
              disabled
              class="w-full h-11 bg-gray-100 text-gray-400 rounded-xl flex items-center justify-center gap-2 cursor-not-allowed"
            >
              <svg
                class="w-5 h-5 opacity-40"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <circle
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  stroke-width="2"
                />
                <path d="M10 8L16 12L10 16V8Z" fill="currentColor" />
              </svg>
              BẮT ĐẦU
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from "vue";
import { useRouter } from "vue-router";
import api from "@/utils/api";
import { format, differenceInMinutes, parseISO } from "date-fns";
import { vi } from "date-fns/locale";

// State
const router = useRouter();
const currentDate = ref(new Date());
const appointments = ref([]);
const loading = ref(false);
const activeTab = ref("all");

// Format helpers
const formatDate = (date) => format(date, "dd/MM/yyyy");
const formatTime = (dateString) => {
  if (!dateString) return "--:--";
  return format(parseISO(dateString), "HH:mm");
};
const currentDateText = computed(() => {
  return format(currentDate.value, "EEEE, dd/MM/yyyy", { locale: vi }).replace(
    /^\w/,
    (c) => c.toUpperCase()
  );
});

// Tính tuổi thú cưng
const calculateAge = (birthDate) => {
  if (!birthDate) return "Chưa rõ tuổi";
  const years = new Date().getFullYear() - new Date(birthDate).getFullYear();
  return `${years} tuổi`;
};

// Xác định trạng thái hiển thị của lịch hẹn
const getStatus = (appt) => {
  const now = new Date();
  const apptTime = parseISO(appt.ngay_gio);
  const diff = differenceInMinutes(now, apptTime);

  if (appt.trang_thai === "in-progress") {
    return { type: "examining", label: "Đang khám", color: "orange" };
  }
  if (appt.trang_thai === "completed") {
    return { type: "completed", label: "Hoàn thành", color: "green" };
  }

  // Đã check-in
  if (appt.check_in_at) {
    const wait = differenceInMinutes(now, parseISO(appt.check_in_at));
    return { type: "arrived", label: "Đã đến", waitMinutes: wait };
  }

  // Tương lai
  if (apptTime > now) {
    const minutesLeft = differenceInMinutes(apptTime, now);
    return {
      type: "future",
      label:
        minutesLeft <= 60
          ? `Còn ${minutesLeft} phút`
          : `Còn ${Math.round(minutesLeft / 60)} giờ`,
      futureMinutes: minutesLeft,
    };
  }

  // Quá giờ chưa check-in
  if (diff > 0) {
    if (diff <= 30) return { type: "upcoming", label: "Sắp đến" };
    return { type: "late", label: `Trễ ${diff} phút`, lateMinutes: diff };
  }

  return { type: "upcoming", label: "Sắp đến" };
};

// Tabs count
const statusTabs = computed(() => {
  const all = appointments.value.length;
  const waiting = appointments.value.filter((a) =>
    ["pending", "confirmed"].includes(a.trang_thai)
  ).length;
  const examining = appointments.value.filter(
    (a) => a.trang_thai === "in-progress"
  ).length;
  const completed = appointments.value.filter(
    (a) => a.trang_thai === "completed"
  ).length;

  return [
    { label: "Tất cả", value: "all", count: all },
    { label: "Đang chờ", value: "waiting", count: waiting },
    { label: "Đang khám", value: "examining", count: examining },
    { label: "Hoàn thành", value: "completed", count: completed },
  ];
});

const displayAppointments = computed(() => {
  let list = [...appointments.value];

  if (activeTab.value === "waiting") {
    list = list.filter((a) => ["pending", "confirmed"].includes(a.trang_thai));
  } else if (activeTab.value === "examining") {
    list = list.filter((a) => a.trang_thai === "in-progress");
  } else if (activeTab.value === "completed") {
    list = list.filter((a) => a.trang_thai === "completed");
  }

  // Sắp xếp theo thời gian
  return list.sort((a, b) => new Date(a.ngay_gio) - new Date(b.ngay_gio));
});

// Lấy dữ liệu từ API
const fetchAppointments = async () => {
  loading.value = true;
  try {
    const dateStr = format(currentDate.value, "yyyy-MM-dd");

    const res = await api.get("/lich-hen-all", {
      params: {
        from_date: `${dateStr} 00:00:00`,
        to_date: `${dateStr} 23:59:59`,
        per_page: 100,
      },
    });

    console.log("API Response:", res.data);

    // Handle both paginated and non-paginated responses
    let data = [];
    if (res.data.status && res.data.data) {
      if (Array.isArray(res.data.data)) {
        data = res.data.data;
      } else if (res.data.data.data && Array.isArray(res.data.data.data)) {
        data = res.data.data.data;
      }
    }

    console.log("Processed data:", data);

    appointments.value = data.map((appt) => ({
      ...appt,
      displayStatus: getStatus(appt),
    }));
  } catch (err) {
    console.error("Error fetching appointments:", err);
    console.error("Error details:", err.response?.data);
  } finally {
    loading.value = false;
  }
};

// Navigation
const previousDay = () =>
  (currentDate.value = new Date(
    currentDate.value.setDate(currentDate.value.getDate() - 1)
  ));
const nextDay = () =>
  (currentDate.value = new Date(
    currentDate.value.setDate(currentDate.value.getDate() + 1)
  ));
const goToToday = () => (currentDate.value = new Date());

watch(currentDate, fetchAppointments);
onMounted(fetchAppointments);

// Bắt đầu khám
const startExam = (id) => {
  router.push(`/doctor/lich-kham/phieu-kham/${id}`);
};
</script>
<style scoped></style>
