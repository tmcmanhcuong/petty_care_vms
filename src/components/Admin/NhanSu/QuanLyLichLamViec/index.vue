<template>
  <div class="w-full min-h-screen p-6">
    <!-- Page Header -->
    <div class="mb-6">
      <h1 class="font-nunito font-medium text-2xl leading-9 text-[#101828]">
        Phân ca làm việc
      </h1>
      <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
        Quản lý lịch làm việc cho nhân viên theo khoa
      </p>
    </div>

    <!-- Control Panel Card -->
    <div class="bg-white border border-gray-200/60 rounded-[14px] p-[17px] mb-6">
      <div class="flex items-center justify-between gap-2">
        <!-- Left Side: Week Navigation -->
        <div class="flex items-center gap-2">
          <!-- Previous Week Button -->
          <button
            @click="previousWeek"
            class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
          >
            <img :src="iconChevronLeft" alt="Previous" class="w-4 h-4" />
          </button>

          <!-- Current Week Display -->
          <div class="bg-gray-50 rounded-[10px] h-10 px-4 flex items-center">
            <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">
              Tuần này: {{ currentWeekRange }}
            </span>
          </div>

          <!-- Next Week Button -->
          <button
            @click="nextWeek"
            class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
          >
            <img :src="iconChevronRight" alt="Next" class="w-4 h-4" />
          </button>

          <!-- Today Button -->
          <button
            @click="goToToday"
            class="bg-white border border-gray-200/60 rounded-lg h-8 px-3 flex items-center gap-2 hover:bg-gray-50 transition-colors"
          >
            <img :src="iconCalendar" alt="Calendar" class="w-4 h-4" />
            <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
              Hôm nay
            </span>
          </button>
        </div>

        <!-- Right Side: Filters and Add Button -->
        <div class="flex items-center gap-2">
        
          <!-- Role Filter -->
          <button class="bg-[#f3f3f5] rounded-lg h-9 px-3 flex items-center justify-between gap-2 w-[180px] hover:bg-gray-200 transition-colors">
            <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">
              Tất cả Vai trò
            </span>
            <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
          </button>

          <!-- Search Input -->
          <div class="relative w-[129px]">
            <input
              type="text"
              placeholder=""
              class="bg-[#f3f3f5] rounded-lg h-9 pl-9 pr-3 w-full font-nunito text-sm text-neutral-950 focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <img :src="iconSearch" alt="Search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4" />
          </div>

          <!-- Add Shift Button -->
          <button
            @click="handleAddShift"
            class="bg-[#00a63e] rounded-lg h-9 px-3 flex items-center gap-2 hover:bg-[#008c35] transition-colors"
          >
            <img :src="iconPlus" alt="Add" class="w-4 h-4" />
            <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
              Thêm ca làm
            </span>
          </button>
        </div>
      </div>
    </div>

    <!-- Schedule Table Card -->
    <div class="bg-white border border-gray-200/60 rounded-[14px] overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full">
          <!-- Table Header -->
          <thead>
            <tr class="bg-gray-50 border-b border-gray-200/60">
              <th class="text-left px-4 py-4 w-[220px] border-r border-gray-200/60">
                <span class="font-nunito font-bold text-base leading-6 text-neutral-950 tracking-tight">
                  Nhân viên
                </span>
              </th>
              <th
                v-for="day in weekDays"
                :key="day.date"
                :class="[
                  'px-4 py-4 w-[160px] border-r border-gray-200/60',
                  day.isToday ? 'bg-teal-50' : ''
                ]"
              >
                <div class="flex flex-col items-center gap-1">
                  <span class="font-nunito font-bold text-sm leading-5 text-[#4a5565] tracking-tight">
                    {{ day.dayName }}
                  </span>
                  <span
                    :class="[
                      'font-nunito font-bold text-lg leading-7 tracking-tight',
                      day.isToday ? 'text-[#009689]' : 'text-[#101828]'
                    ]"
                  >
                    {{ day.date }}
                  </span>
                </div>
              </th>
              <th class="px-4 py-4 w-[120px] border-l border-gray-200/60 bg-gray-50">
                <span class="font-nunito font-bold text-base leading-6 text-neutral-950 tracking-tight text-center block">
                  Tổng giờ
                </span>
              </th>
            </tr>
          </thead>

          <!-- Table Body -->
          <tbody>
            <template v-for="(department, deptIndex) in departments" :key="deptIndex">
              <!-- Department Header Row -->
              <tr class="bg-gray-100 border-b border-gray-200/60">
                <td colspan="9" class="px-4 py-[15px]">
                  <div class="flex items-center gap-2">
                    <span class="text-base">{{ department.icon }}</span>
                    <span class="font-nunito font-bold text-base leading-6 text-[#364153] tracking-tight">
                      {{ department.name }}
                    </span>
                  </div>
                </td>
              </tr>

              <!-- Staff Rows -->
              <tr
                v-for="(staff, staffIndex) in department.staff"
                :key="staffIndex"
                class="border-b border-gray-200/60 hover:bg-gray-50 transition-colors"
              >
                <!-- Staff Info Column -->
                <td class="px-4 py-7 border-r border-gray-200/60">
                  <div class="flex items-center gap-3">
                    <img
                      :src="staff.avatar"
                      :alt="staff.name"
                      class="w-10 h-10 rounded-full object-cover"
                    />
                    <div>
                      <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                        {{ staff.name }}
                      </p>
                      <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                        {{ staff.role }}
                      </p>
                    </div>
                  </div>
                </td>

                <!-- Day Cells -->
                <td
                  v-for="(day, dayIndex) in weekDays"
                  :key="dayIndex"
                  :class="[
                    'px-2 py-2 border-r border-gray-200/60 text-center',
                    day.isToday ? 'bg-teal-50' : ''
                  ]"
                >
                  <button
                    @click="addShiftForStaff(staff, day)"
                    class="w-full h-20 rounded-[10px] border-2 border-transparent hover:border-gray-300 hover:bg-gray-100 transition-all flex items-center justify-center opacity-0 hover:opacity-100"
                  >
                    <img :src="iconPlus" alt="Add shift" class="w-5 h-5" />
                  </button>
                </td>

                <!-- Total Hours Column -->
                <td class="px-4 py-7 border-l border-gray-200/60 bg-gray-50">
                  <div class="flex justify-center">
                    <span class="bg-gray-50 border border-[#d1d5dc] rounded-lg px-2 py-[3px] font-nunito font-medium text-xs leading-4 text-[#6a7282] text-center">
                      {{ staff.totalHours }}h
                    </span>
                  </div>
                </td>
              </tr>
            </template>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modals -->
    <PhanCaTruc
      v-if="isAddShiftModalOpen"
      :preselected-staff="selectedStaffForShift"
      :preselected-date="selectedDateForShift"
      @close="isAddShiftModalOpen = false"
      @save="handleSaveShift"
    />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import PhanCaTruc from './PhanCaTruc/index.vue'

// Icons (from Figma - expire in 7 days)
const iconChevronLeft = "https://www.figma.com/api/mcp/asset/b9509eb5-3157-4012-a086-91b4ade81fc8"
const iconChevronRight = "https://www.figma.com/api/mcp/asset/b779fc4b-d0d6-4c7c-a642-6b25429867b0"
const iconCalendar = "https://www.figma.com/api/mcp/asset/5bb1b000-78c1-46b1-bd87-17b2263bbd78"
const iconChevronDown = "https://www.figma.com/api/mcp/asset/fc11cada-6bb9-4808-bc7e-4762d45854bc"
const iconSearch = "https://www.figma.com/api/mcp/asset/fb2a8768-bd69-4b3b-9191-13487ee0138c"
const iconPlus = "https://www.figma.com/api/mcp/asset/0f3e9ec3-0c1c-45bd-986e-ca0749a17b23"

// Emits
const emit = defineEmits(['add-shift', 'add-shift-for-staff'])

// Sample Data
const departments = ref([
  {
    staff: [
      {
        avatar: 'https://www.figma.com/api/mcp/asset/0334ef4a-d77a-4533-bc59-984f45cbcbcf',
        name: 'BS. Nguyễn Văn A',
        role: 'Bác sĩ CKI',
        totalHours: 0
      },
      {
        avatar: 'https://www.figma.com/api/mcp/asset/6d302336-bc6c-4ffb-a72b-0c516fd1c1ff',
        name: 'BS. Trần Văn B',
        role: 'Trưởng khoa',
        totalHours: 0
      },
      {
        avatar: 'https://www.figma.com/api/mcp/asset/65831ac8-3ec7-4acc-948c-9f69a3515f50',
        name: 'Lê Thị C',
        role: 'Điều dưỡng viên',
        totalHours: 0
      }
    ]
  },
  {
    staff: [
      {
        avatar: 'https://www.figma.com/api/mcp/asset/f0f6c2a4-bf3a-4bfb-8d1c-e6d71fdd6107',
        name: 'Ngô Văn E',
        role: 'Điều dưỡng viên',
        totalHours: 0
      }
    ]
  },
  {
    staff: [
      {
        avatar: 'https://www.figma.com/api/mcp/asset/c6264e0c-8428-459b-8be9-9486836d664f',
        name: 'Phạm Thị D',
        role: 'Lễ tân',
        totalHours: 0
      }
    ]
  },
  {
    staff: [
      {
        avatar: 'https://www.figma.com/api/mcp/asset/eb6f01bb-02c2-46e1-82e3-cef45f2ae925',
        name: 'Hoàng Thị F',
        role: 'Bác sĩ CKII',
        totalHours: 0
      }
    ]
  }
])

// Current week state
const currentWeekStart = ref(new Date(2024, 10, 24)) // November 24, 2024 (month is 0-indexed)

// Modal State
const isAddShiftModalOpen = ref(false)
const selectedStaffForShift = ref(null)
const selectedDateForShift = ref('')

// Computed: Week range string
const currentWeekRange = computed(() => {
  const start = currentWeekStart.value
  const end = new Date(start)
  end.setDate(end.getDate() + 6)
  
  const formatDate = (date) => {
    const day = String(date.getDate()).padStart(2, '0')
    const month = String(date.getMonth() + 1).padStart(2, '0')
    return `${day}/${month}`
  }
  
  return `${formatDate(start)} - ${formatDate(end)}`
})

// Computed: Week days array
const weekDays = computed(() => {
  const days = []
  const dayNames = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN']
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  
  for (let i = 0; i < 7; i++) {
    const date = new Date(currentWeekStart.value)
    date.setDate(date.getDate() + i)
    
    const day = String(date.getDate()).padStart(2, '0')
    const month = String(date.getMonth() + 1).padStart(2, '0')
    
    const dateOnly = new Date(date)
    dateOnly.setHours(0, 0, 0, 0)
    
    days.push({
      dayName: dayNames[i],
      date: `${day}/${month}`,
      fullDate: date,
      isToday: dateOnly.getTime() === today.getTime()
    })
  }
  
  return days
})

// Methods
const previousWeek = () => {
  const newDate = new Date(currentWeekStart.value)
  newDate.setDate(newDate.getDate() - 7)
  currentWeekStart.value = newDate
}

const nextWeek = () => {
  const newDate = new Date(currentWeekStart.value)
  newDate.setDate(newDate.getDate() + 7)
  currentWeekStart.value = newDate
}

const goToToday = () => {
  const today = new Date()
  const dayOfWeek = today.getDay()
  const mondayOffset = dayOfWeek === 0 ? -6 : 1 - dayOfWeek
  const monday = new Date(today)
  monday.setDate(today.getDate() + mondayOffset)
  monday.setHours(0, 0, 0, 0)
  currentWeekStart.value = monday
}

const addShiftForStaff = (staff, day) => {
  // emit('add-shift-for-staff', { staff, day })
  selectedStaffForShift.value = staff
  // Format date for input type="date" (YYYY-MM-DD)
  const date = new Date(day.fullDate)
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const d = String(date.getDate()).padStart(2, '0')
  selectedDateForShift.value = `${year}-${month}-${d}`
  
  isAddShiftModalOpen.value = true
}

const handleAddShift = () => {
  selectedStaffForShift.value = null
  selectedDateForShift.value = ''
  isAddShiftModalOpen.value = true
}

const handleSaveShift = (shiftData) => {
  console.log('New shift data:', shiftData)
  // Logic to save shift goes here
  isAddShiftModalOpen.value = false
}
</script>

<style scoped>
/* Custom scrollbar */
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
