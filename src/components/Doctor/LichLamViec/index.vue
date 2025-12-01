<template>
  <div class="flex flex-col gap-6 size-full">
    <!-- Header Section -->
    <div class="flex flex-col h-[105px]">
      <!-- Title -->
      <h1 class="text-base font-normal text-[#101828] leading-6 tracking-[-0.3125px]" style="font-family: 'Nunito Sans', sans-serif;">
        Lịch làm việc
      </h1>
      <!-- Subtitle -->
      <p class="text-base font-normal text-[#4a5565] leading-6 tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
        Quản lý lịch trực và đăng ký ca làm việc
      </p>
      <!-- Tabs -->
      <div class="border-b border-gray-200 h-[41px] relative mt-auto">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="[
            'absolute top-0 h-10 px-4 pt-2 pb-0 flex items-center gap-2',
            tab.id === activeTab ? 'text-[#155dfc]' : 'text-[#4a5565]'
          ]"
          :style="{ left: tab.left }"
        >
          <img :src="icons[tab.icon]" alt="" class="w-4 h-4" />
          <span class="text-base font-normal leading-6 tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
            {{ tab.label }}
          </span>
          <div v-if="tab.id === activeTab" class="absolute left-0 bottom-[-1px] w-full h-0.5 bg-[#155dfc]" />
        </button>
      </div>
    </div>

    <!-- My Schedule Card -->
    <div v-if="activeTab === 'my-schedule'" class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-px h-[717px]">
      <!-- Header with gradient background -->
      <div class="bg-gradient-to-r from-[#f0fdfa] to-[#f0fdf4] h-[110px] px-6 pt-6 pb-1.5 flex flex-col gap-4">
        <!-- Week Navigation -->
        <div class="flex items-center justify-between">
          <button class="bg-white border border-[rgba(0,0,0,0.1)] rounded-lg h-8 px-3 flex items-center gap-2">
            <img :src="icons.chevronLeft" alt="" class="w-4 h-4" />
            <span class="text-sm font-medium text-neutral-950 leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Tuần trước
            </span>
          </button>
          
          <div class="flex items-center gap-2">
            <img :src="icons.calendar" alt="" class="w-5 h-5" />
            <span class="text-base font-normal text-neutral-950 leading-4 tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
              Tuần {{ weekNumber }} ({{ weekRange }})
            </span>
          </div>

          <button class="bg-white border border-[rgba(0,0,0,0.1)] rounded-lg h-8 px-3 flex items-center gap-2">
            <span class="text-sm font-medium text-neutral-950 leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Tuần sau
            </span>
            <img :src="icons.chevronRight" alt="" class="w-4 h-4" />
          </button>
        </div>

        <!-- Status Info & View Toggle -->
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-4">
            <div class="flex items-center gap-2">
              <span class="text-sm font-normal text-[#4a5565] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                Ca tuần này:
              </span>
              <span class="text-sm font-normal text-[#009689] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ weekShifts }}
              </span>
            </div>
            <div class="w-px h-4 bg-[#d1d5dc]" />
            <div class="flex items-center gap-2">
              <span class="text-sm font-normal text-[#4a5565] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                Tổng giờ làm:
              </span>
              <span class="text-sm font-normal text-[#009689] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ totalHours }}h
              </span>
            </div>
          </div>

          <!-- View Toggle -->
          <div class="flex items-center gap-2">
            <button
              @click="viewMode = 'week'"
              :class="[
                'h-8 px-4 rounded-lg flex items-center gap-2',
                viewMode === 'week' ? 'bg-[#030213] text-white' : 'bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950'
              ]"
            >
              <img :src="viewMode === 'week' ? icons.calendarWhite : icons.calendarBlack" alt="" class="w-4 h-4" />
              <span class="text-sm font-medium leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                Lịch Tuần
              </span>
            </button>
            <button
              @click="viewMode = 'list'"
              :class="[
                'h-8 px-4 rounded-lg flex items-center gap-2',
                viewMode === 'list' ? 'bg-[#030213] text-white' : 'bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950'
              ]"
            >
              <img :src="viewMode === 'list' ? icons.listWhite : icons.listBlack" alt="" class="w-4 h-4" />
              <span class="text-sm font-medium leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                Danh sách
              </span>
            </button>
          </div>
        </div>
      </div>

      <!-- Calendar Table -->
      <div class="px-6 py-6 flex flex-col gap-6">
        <div class="overflow-auto">
          <table class="w-full border-collapse">
            <thead>
              <tr>
                <th class="bg-gray-50 border border-[#d1d5dc] h-[61px] px-2 text-center text-sm font-bold text-[#364153] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif; width: 112px;">
                  Giờ / Ngày
                </th>
                <th
                  v-for="day in calendarDays"
                  :key="day.label"
                  class="bg-gray-50 border border-[#d1d5dc] h-[61px] px-2 text-center"
                  :style="{ width: day.width }"
                >
                  <div class="flex flex-col items-center justify-center gap-1">
                    <span class="text-sm font-bold text-[#101828] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                      {{ day.label }}
                    </span>
                    <span class="text-xs font-bold text-[#6a7282] leading-4" style="font-family: 'Inter', sans-serif;">
                      {{ day.date }}
                    </span>
                  </div>
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="timeSlot in timeSlots" :key="timeSlot.name">
                <td class="bg-gray-50 border border-[#d1d5dc] h-[117px] text-center">
                  <div class="flex flex-col items-center justify-center gap-1">
                    <span class="text-sm font-normal text-[#101828] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                      {{ timeSlot.name }}
                    </span>
                    <span class="text-xs font-normal text-[#6a7282] leading-4" style="font-family: 'Inter', sans-serif;">
                      {{ timeSlot.time }}
                    </span>
                  </div>
                </td>
                <td
                  v-for="(daySchedule, dayIndex) in timeSlot.schedule"
                  :key="dayIndex"
                  class="border border-[#d1d5dc] h-[117px] p-2"
                >
                  <div
                    v-if="daySchedule"
                    :class="[
                      'h-[100px] border-2 rounded-[10px] p-3.5 flex flex-col justify-between',
                      daySchedule.status === 'upcoming' ? 'border-[#05df72]' : '',
                      daySchedule.status === 'ongoing' ? 'border-[#ff8904]' : '',
                      daySchedule.status === 'past' ? 'bg-gray-50 border-transparent' : ''
                    ]"
                  >
                    <div class="flex items-center gap-1">
                      <img :src="icons.mapPin" alt="" class="w-3 h-3" />
                      <span class="text-xs font-normal text-[#364153] leading-4 truncate" style="font-family: 'Inter', sans-serif;">
                        {{ daySchedule.room }}
                      </span>
                    </div>
                    <div
                      :class="[
                        'h-[22px] px-2 py-0.5 rounded-lg flex items-center gap-1 w-fit',
                        daySchedule.status === 'upcoming' ? 'bg-green-100' : 'bg-[#ffedd4]'
                      ]"
                    >
                      <img :src="daySchedule.status === 'upcoming' ? icons.usersGreen : icons.usersOrange" alt="" class="w-3 h-3" />
                      <span
                        :class="[
                          'text-xs font-medium leading-4',
                          daySchedule.status === 'upcoming' ? 'text-[#008236]' : 'text-[#ca3500]'
                        ]"
                        style="font-family: 'Inter', sans-serif;"
                      >
                        {{ daySchedule.patients }} khách
                      </span>
                    </div>
                  </div>
                  <div v-else class="bg-gray-50 h-[100px] rounded-[10px]" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Legend -->
        <div class="bg-gray-50 rounded-[10px] h-24 px-4 py-4">
          <p class="text-sm font-bold text-[#364153] leading-5 tracking-[-0.1504px] mb-3" style="font-family: 'Inter', sans-serif;">
            Chú thích:
          </p>
          <div class="flex items-center gap-[351.66px]">
            <div v-for="calendarLegend in calendarLegends" :key="calendarLegend.label" class="flex items-center gap-2">
              <div :class="['w-8 h-8 border-2 rounded', calendarLegend.class]" />
              <span class="text-sm font-normal text-[#4a5565] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ calendarLegend.label }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Schedule Registration Card -->
    <div v-else class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-px h-[767px]">
      <!-- Header with gradient background -->
      <div class="bg-gradient-to-r from-[#eff6ff] to-[#f0fdfa] h-[104px] px-6 pt-6 pb-1.5 flex flex-col gap-4">
        <!-- Week Navigation -->
        <div class="flex items-center justify-between">
          <button class="bg-white border border-[rgba(0,0,0,0.1)] rounded-lg h-8 px-3 flex items-center gap-2">
            <img :src="icons.chevronLeft" alt="" class="w-4 h-4" />
            <span class="text-sm font-medium text-neutral-950 leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Tuần trước
            </span>
          </button>
          
          <div class="flex items-center gap-2">
            <img :src="icons.calendar" alt="" class="w-5 h-5" />
            <span class="text-base font-normal text-neutral-950 leading-4 tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
              Tuần {{ weekNumber }} ({{ weekRange }})
            </span>
          </div>

          <button class="bg-white border border-[rgba(0,0,0,0.1)] rounded-lg h-8 px-3 flex items-center gap-2">
            <span class="text-sm font-medium text-neutral-950 leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Tuần sau
            </span>
            <img :src="icons.chevronRight" alt="" class="w-4 h-4" />
          </button>
        </div>

        <!-- Status Info -->
        <div class="flex items-center justify-between">
          <div class="bg-[#ffedd4] border-0 rounded-lg h-[26px] px-3 flex items-center gap-2">
            <img :src="icons.alertCircle" alt="" class="w-3 h-3" />
            <span class="text-xs font-medium text-[#ca3500] leading-4" style="font-family: 'Inter', sans-serif;">
              ⚠️ Hạn đăng ký: Thứ 6, 17:00
            </span>
          </div>

          <div class="flex items-center gap-4">
            <div class="flex items-center gap-2">
              <span class="text-sm font-normal text-[#4a5565] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                Đã đăng ký:
              </span>
              <span class="text-sm font-normal text-[#155dfc] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ registeredShifts }} ca
              </span>
            </div>
            <div class="w-px h-4 bg-[#d1d5dc]" />
            <div class="flex items-center gap-2">
              <span class="text-sm font-normal text-[#4a5565] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                Yêu cầu tối thiểu:
              </span>
              <span class="text-sm font-normal text-[#f54900] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ minRequirement }} ca/tuần
              </span>
            </div>
          </div>
        </div>
      </div>

      <!-- Schedule Table -->
      <div class="px-6 py-6">
        <div class="overflow-auto">
          <table class="w-full border-collapse">
            <thead>
              <tr>
                <th class="bg-gray-50 border border-[#d1d5dc] h-[45px] px-2 text-center text-sm font-bold text-[#364153] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif; width: 128px;">
                  Ca Trực
                </th>
                <th
                  v-for="day in weekDays"
                  :key="day"
                  class="bg-gray-50 border border-[#d1d5dc] h-[45px] px-2 text-center text-sm font-bold text-[#101828] tracking-[-0.1504px]"
                  style="font-family: 'Inter', sans-serif;"
                >
                  {{ day }}
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="shift in shifts" :key="shift.id">
                <td class="bg-gray-50 border border-[#d1d5dc] h-[97px] text-center">
                  <div class="flex flex-col items-center justify-center gap-1">
                    <span class="text-sm font-normal text-[#101828] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                      {{ shift.name }}
                    </span>
                    <span class="text-xs font-normal text-[#6a7282] leading-4" style="font-family: 'Inter', sans-serif;">
                      {{ shift.time }}
                    </span>
                  </div>
                </td>
                <td
                  v-for="(status, dayIndex) in shift.days"
                  :key="dayIndex"
                  class="border border-[#d1d5dc] h-[97px] p-0.5"
                >
                  <div
                    :class="[
                      'flex flex-col items-center justify-center h-full border-2 cursor-pointer',
                      status === 'selected' ? 'bg-blue-100 border-[#51a2ff]' : '',
                      status === 'approved' ? 'bg-green-100 border-[#00c950]' : '',
                      status === 'full' ? 'bg-gray-200 border-[#99a1af]' : 'bg-white border-gray-200'
                    ]"
                    @click="toggleShift(shift.id, dayIndex, status)"
                  >
                    <img
                      v-if="status === 'selected'"
                      :src="icons.checkCircleBlue"
                      alt=""
                      class="w-6 h-6"
                    />
                    <img
                      v-else-if="status === 'approved'"
                      :src="icons.checkCircleGreen"
                      alt=""
                      class="w-6 h-6"
                    />
                    <img
                      v-else-if="status === 'full'"
                      :src="icons.lockIcon"
                      alt=""
                      class="w-6 h-6"
                    />
                    <img
                      v-else
                      :src="icons.plusCircle"
                      alt=""
                      class="w-6 h-6"
                    />
                    <span
                      v-if="status === 'approved'"
                      class="text-xs font-normal text-[#016630] leading-4 mt-1"
                      style="font-family: 'Inter', sans-serif;"
                    >
                      Đã duyệt
                    </span>
                    <span
                      v-if="status === 'full'"
                      class="text-xs font-normal text-[#364153] leading-4 mt-1"
                      style="font-family: 'Inter', sans-serif;"
                    >
                      Full
                    </span>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Legend -->
        <div class="bg-gray-50 rounded-[10px] h-24 px-4 py-4 mt-6">
          <p class="text-sm font-bold text-[#364153] leading-5 tracking-[-0.1504px] mb-3" style="font-family: 'Inter', sans-serif;">
            Chú thích:
          </p>
          <div class="grid grid-cols-4 gap-4">
            <div v-for="legend in legends" :key="legend.label" class="flex items-center gap-2">
              <div :class="['w-8 h-8 border-2 rounded flex items-center justify-center', legend.class]">
                <img :src="icons[legend.icon]" alt="" class="w-4 h-4" />
              </div>
              <span class="text-sm font-normal text-[#4a5565] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ legend.label }}
              </span>
            </div>
          </div>
        </div>

        <!-- Summary -->
        <div class="bg-blue-50 border border-[#bedbff] rounded-[10px] h-14 px-4 py-4 mt-4 flex items-center justify-between">
          <div class="flex items-center gap-2">
            <span class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Tổng cộng đã chọn:
            </span>
            <span class="text-sm font-normal text-[#1447e6] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              {{ newShiftsCount }} ca mới
            </span>
            <span class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              +
            </span>
            <span class="text-sm font-normal text-[#008236] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              {{ approvedShiftsCount }} ca đã duyệt
            </span>
            <span class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              =
            </span>
            <span class="text-sm font-bold text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              {{ totalShiftsCount }} ca
            </span>
          </div>
          
          <div class="bg-green-100 border-0 rounded-lg h-[22px] px-2.5 py-0.5 flex items-center">
            <span class="text-xs font-medium text-[#008236]" style="font-family: 'Inter', sans-serif;">
              ✓ Đủ yêu cầu
            </span>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex items-center justify-end gap-3 mt-4">
          <button class="bg-white border border-[rgba(0,0,0,0.1)] rounded-lg h-9 px-4 flex items-center gap-2">
            <img :src="icons.save" alt="" class="w-4 h-4" />
            <span class="text-sm font-medium text-neutral-950 leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Lưu nháp
            </span>
          </button>
          <button class="bg-[#155dfc] rounded-lg h-9 px-4 flex items-center gap-2">
            <img :src="icons.send" alt="" class="w-4 h-4" />
            <span class="text-sm font-medium text-white leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              🚀 Gửi đăng ký
            </span>
          </button>
        </div>
      </div>
    </div>

    <!-- Important Notes Card -->
    <div v-if="activeTab === 'my-schedule'" class="border border-[#b9f8cf] rounded-[14px] px-6 py-6 h-[174px]">
      <div class="flex gap-4">
        <div class="bg-green-100 rounded-[10px] w-10 h-10 flex items-center justify-center shrink-0">
          <img :src="icons.lightbulb" alt="" class="w-5 h-5" />
        </div>
        <div>
          <p class="text-base font-bold text-[#364153] leading-6 tracking-[-0.3125px] mb-2" style="font-family: 'Inter', sans-serif;">
            💡 Hướng dẫn sử dụng:
          </p>
          <ul class="flex flex-col gap-1 pl-2">
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              <span class="font-bold">Bấm vào ô ca trực</span> để xem chi tiết danh sách bệnh nhân.
            </li>
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Ca <span class="font-bold text-[#ca3500]">Đang diễn ra</span> sẽ nhấp nháy để bạn dễ nhận biết.
            </li>
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Nếu cần nghỉ đột xuất, vào chi tiết ca và bấm <span class="font-bold">"Xin nghỉ"</span>.
            </li>
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Lịch này là <span class="font-bold">lịch chính thức</span> đã được Admin duyệt.
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Important Notes Card for Registration -->
    <div v-else class="border border-[#96f7e4] rounded-[14px] px-6 py-6 h-[174px]">
      <div class="flex gap-4">
        <div class="bg-[#cbfbf1] rounded-[10px] w-10 h-10 flex items-center justify-center shrink-0">
          <img :src="icons.infoCircle" alt="" class="w-5 h-5" />
        </div>
        <div>
          <p class="text-base font-bold text-[#364153] leading-6 tracking-[-0.3125px] mb-2" style="font-family: 'Inter', sans-serif;">
            📌 Lưu ý quan trọng:
          </p>
          <ul class="flex flex-col gap-1 pl-2">
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Vui lòng đăng ký <span class="font-bold">trước Thứ 6, 17:00</span> hàng tuần.
            </li>
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Các ca <span class="font-bold text-[#008236]">Đã duyệt</span> không thể thay đổi.
            </li>
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Các ca <span class="font-bold">Đã kín</span> là ca đã đủ bác sĩ đăng ký.
            </li>
            <li class="text-sm font-normal text-[#364153] leading-5 tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
              Sau khi gửi đăng ký, Admin sẽ phê duyệt trong vòng <span class="font-bold">24 giờ</span>.
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const activeTab = ref('my-schedule')

const tabs = [
  { id: 'register', label: 'Đăng ký ca trực', icon: 'clipboardCheck', left: '0px' },
  { id: 'my-schedule', label: 'Lịch của tôi', icon: 'calendarUser', left: '178.15px' }
]

const weekNumber = ref(49)
const weekRange = ref('01/12 - 07/12')
const registeredShifts = ref(5)
const minRequirement = ref(4)
const newShiftsCount = ref(4)
const approvedShiftsCount = ref(1)
const weekShifts = ref(5)
const totalHours = ref(19)
const viewMode = ref('week')

const totalShiftsCount = computed(() => newShiftsCount.value + approvedShiftsCount.value)

const weekDays = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN']

const calendarDays = [
  { label: 'Thứ 2', date: '02/12', width: '181.867px' },
  { label: 'Thứ 3', date: '03/12', width: '200.75px' },
  { label: 'Thứ 4', date: '04/12', width: '172.297px' },
  { label: 'Thứ 5', date: '05/12', width: '174.328px' },
  { label: 'Thứ 6', date: '06/12', width: '78.82px' },
  { label: 'Thứ 7', date: '07/12', width: '77.469px' },
  { label: 'CN', date: '08/12', width: '72.469px' }
]

const timeSlots = [
  {
    name: 'Sáng',
    time: '8h-12h',
    schedule: [
      { room: 'Phòng Khám 1', patients: 3, status: 'upcoming' },
      { room: 'Phòng Phẫu Thuật', patients: 1, status: 'ongoing' },
      { room: 'Phòng Khám 1', patients: 2, status: 'upcoming' },
      null,
      null,
      null,
      null
    ]
  },
  {
    name: 'Chiều',
    time: '13h-17h',
    schedule: [
      { room: 'Phòng Cấp Cứu', patients: 0, status: 'upcoming' },
      null,
      null,
      null,
      null,
      null,
      null
    ]
  },
  {
    name: 'Tối',
    time: '18h-21h',
    schedule: [
      null,
      null,
      null,
      { room: 'Phòng Khám 2', patients: 1, status: 'upcoming' },
      null,
      null,
      null
    ]
  }
]

const shifts = ref([
  {
    id: 1,
    name: 'Sáng',
    time: '8h-12h',
    days: ['selected', 'empty', 'selected', 'full', 'empty', 'empty', 'empty']
  },
  {
    id: 2,
    name: 'Chiều',
    time: '13h-17h',
    days: ['empty', 'selected', 'empty', 'empty', 'approved', 'empty', 'empty']
  },
  {
    id: 3,
    name: 'Tối',
    time: '18h-21h',
    days: ['empty', 'empty', 'empty', 'empty', 'empty', 'selected', 'empty']
  }
])

const legends = [
  { label: 'Chưa chọn', class: 'bg-white border-gray-200', icon: 'plusCircleGray' },
  { label: 'Đang chọn', class: 'bg-blue-100 border-[#51a2ff]', icon: 'checkCircleBlue' },
  { label: 'Đã duyệt', class: 'bg-green-100 border-[#00c950]', icon: 'checkCircleGreen' },
  { label: 'Đã kín', class: 'bg-gray-200 border-[#99a1af]', icon: 'lockIcon' }
]

const calendarLegends = [
  { label: 'Sắp tới', class: 'border-[#05df72] bg-transparent' },
  { label: 'Đang diễn ra', class: 'border-[#ff8904] bg-transparent' },
  { label: 'Đã qua', class: 'border-[#d1d5dc] bg-gray-100' }
]

const icons = {
  clipboardCheck: 'https://www.figma.com/api/mcp/asset/afaa17a8-4dd1-4159-afba-ce6de41be981',
  calendarUser: 'https://www.figma.com/api/mcp/asset/1d8695a1-d3ce-41f5-be9a-f01d493bd4ff',
  chevronLeft: 'https://www.figma.com/api/mcp/asset/95893011-66af-46a2-89d0-8c37f38af121',
  calendar: 'https://www.figma.com/api/mcp/asset/9bf5af36-6033-44b5-bc9f-c9d509e09bbd',
  chevronRight: 'https://www.figma.com/api/mcp/asset/19f37aaa-5617-4f0f-a2f0-850b473694b0',
  alertCircle: 'https://www.figma.com/api/mcp/asset/ac86bf5b-9f0d-484a-bc78-f45f1cfae5f1',
  calendarWhite: 'https://www.figma.com/api/mcp/asset/0061a89d-0be4-4567-82c5-fa1ac2abfd69',
  listBlack: 'https://www.figma.com/api/mcp/asset/ce93a96a-c48d-45d5-bfd4-9412ada63533',
  calendarBlack: 'https://www.figma.com/api/mcp/asset/ce93a96a-c48d-45d5-bfd4-9412ada63533',
  listWhite: 'https://www.figma.com/api/mcp/asset/0061a89d-0be4-4567-82c5-fa1ac2abfd69',
  mapPin: 'https://www.figma.com/api/mcp/asset/80e0c896-dee8-4a04-98ce-137631eada1a',
  usersGreen: 'https://www.figma.com/api/mcp/asset/525d3e04-34e1-478f-ab67-dcab0c194926',
  usersOrange: 'https://www.figma.com/api/mcp/asset/23c7949b-a408-4b98-b4e4-624c65022e04',
  lightbulb: 'https://www.figma.com/api/mcp/asset/307dc19e-d484-413b-977d-4ce4ececcd6b',
  checkCircleBlue: 'https://www.figma.com/api/mcp/asset/71657569-34c5-4c7a-8449-a69598eac37c',
  plusCircle: 'https://www.figma.com/api/mcp/asset/952ab492-d9f1-42fe-80eb-50dbf7b3c167',
  lockIcon: 'https://www.figma.com/api/mcp/asset/be64e2a4-92fa-4ce0-8fa5-0ade98416436',
  checkCircleGreen: 'https://www.figma.com/api/mcp/asset/8842afba-a48d-4d12-a65c-2b2a8b3760b5',
  plusCircleGray: 'https://www.figma.com/api/mcp/asset/20fe5daa-db0a-4643-bb00-6350643d9ec5',
  save: 'https://www.figma.com/api/mcp/asset/afd59c54-58a8-4849-bc1c-e61fde5b1006',
  send: 'https://www.figma.com/api/mcp/asset/b8ce81d2-9e32-4792-8429-e45c725bc1c4',
  infoCircle: 'https://www.figma.com/api/mcp/asset/74328a54-dc6a-450b-9316-ee606f99aace'
}

function toggleShift(shiftId, dayIndex, currentStatus) {
  if (currentStatus === 'approved' || currentStatus === 'full') {
    return // Cannot toggle approved or full shifts
  }
  
  const shift = shifts.value.find(s => s.id === shiftId)
  if (shift) {
    if (currentStatus === 'selected') {
      shift.days[dayIndex] = 'empty'
    } else {
      shift.days[dayIndex] = 'selected'
    }
  }
}
</script>

<style scoped>
/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #f3f3f5;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb {
  background: #d1d1d6;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #a8a8b0;
}

/* Remove default button styling */
button:focus {
  outline: none;
}

/* Font imports */
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
</style>
