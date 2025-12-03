<template>
  <div class="w-full min-h-screen  p-6">
    <!-- Page Header -->
    <div class="mb-6">
      <h1 class="font-nunito font-medium text-2xl leading-9 text-[#101828]">
        Quản lý Lịch Hẹn
      </h1>
      <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
        Quản lý Lịch Hẹn của khách hàng và bác sĩ
      </p>
    </div>

    <!-- Main Card -->
    <div class="bg-white border border-gray-200/60 rounded-[14px] p-6">
      <!-- Card Header -->
      <div class="flex items-center justify-between mb-6">
        <div class="w-[120px]"></div>

        <!-- View Toggle and Actions -->
        <div class="flex items-center gap-3">
          <!-- View Toggle -->
          <div class="bg-[#ececf0] rounded-[14px] p-1 flex items-center">
            <!-- <button
              @click="viewMode = 'calendar'"
              :class="[
                'flex items-center gap-2 px-2 py-[5px] rounded-[14px] transition-colors',
                viewMode === 'calendar' ? '' : 'bg-white'
              ]"
            >
              <img :src="iconCalendar" alt="Calendar" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Lịch biểu
              </span>
            </button> -->
            <button
              @click="viewMode = 'list'"
              :class="[
                'flex items-center gap-2 px-2 py-[5px] rounded-[14px] transition-colors',
                viewMode === 'list' ? 'bg-white' : ''
              ]"
            >
              <img :src="iconList" alt="List" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Danh sách
              </span>
            </button>
          </div>

          <!-- Appointment Count Badge -->
          <div class="bg-blue-100 border border-transparent rounded-lg px-2 py-[3px] flex items-center gap-2 h-[22px]">
            <img :src="iconInfo" alt="Info" class="w-3 h-3" />
            <span class="font-nunito font-medium text-xs leading-4 text-[#1447e6]">
              {{ appointments.length }} lịch hẹn
            </span>
          </div>

          <!-- Create Appointment Button
          <button
            @click="isCreateAppointmentModalOpen = true"
            class="bg-[#00a63e] rounded-lg h-9 px-3 flex items-center gap-2 hover:bg-[#008c35] transition-colors"
          >
            <img :src="iconPlus" alt="Add" class="w-4 h-4" />
            <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
              Tạo lịch hẹn
            </span>
          </button> -->
        </div>
      </div>

      <!-- Filters -->
      <div class="flex items-center gap-3 mb-6">
        <!-- Search -->
        <div class="relative w-[204px]">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Tìm kiếm..."
            class="bg-[#f3f3f5] border border-transparent rounded-lg h-9 pl-10 pr-3 w-full font-nunito text-sm text-neutral-950 placeholder:text-[#717182] focus:outline-none focus:ring-2 focus:ring-[#009689]"
          />
          <img :src="iconSearch" alt="Search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4" />
        </div>

        <!-- Date Filter -->
        <button class="bg-[#f3f3f5] rounded-lg h-9 px-3 flex items-center justify-between gap-2 w-[204px] hover:bg-gray-200 transition-colors">
          <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">
            Tất cả ngày
          </span>
          <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
        </button>

        <!-- Doctor Filter -->
        <button class="bg-white border border-gray-200/60 rounded-lg h-9 px-3 flex items-center justify-between gap-2 w-[204px] hover:bg-gray-50 transition-colors">
          <span class="font-nunito font-medium text-sm leading-5 text-[#6a7282] tracking-tight">
            Tất cả Bác sĩ
          </span>
          <img :src="iconChevronDownGray" alt="Dropdown" class="w-4 h-4" />
        </button>

        <!-- Status Filter -->
        <button class="bg-[#f3f3f5] rounded-lg h-9 px-3 flex items-center justify-between gap-2 w-[204px] hover:bg-gray-200 transition-colors">
          <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">
            Tất cả trạng thái
          </span>
          <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
        </button>
      </div>

      <!-- Appointments Table -->
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead>
            <tr class="border-b border-gray-200/60">
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Mã lịch
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Thời gian
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Khách hàng
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Dịch vụ
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Phụ trách
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Trạng thái
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Trạng Thái Thanh Toán
              </th>
              <th class="text-right px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Thao tác
              </th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(appointment, index) in appointments"
              :key="index"
              class="border-b border-gray-200/60 hover:bg-gray-50 transition-colors"
            >
              <!-- Appointment ID -->
              <td class="px-2 py-[14px]">
                <p class="font-nunito font-medium text-base leading-6 text-[#009689] tracking-tight">
                  {{ appointment.id }}
                </p>
              </td>

              <!-- Time & Date -->
              <td class="px-2 py-[8px]">
                <div class="flex flex-col">
                  <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    {{ appointment.time }}
                  </span>
                  <span class="font-nunito text-xs leading-4 text-[#6a7282]">
                    {{ appointment.date }}
                  </span>
                </div>
              </td>

              <!-- Customer -->
              <td class="px-2 py-[8px]">
                <div class="flex flex-col">
                  <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    {{ appointment.customer }}
                  </span>
                  <span class="font-nunito text-xs leading-4 text-[#6a7282]">
                    Pet: {{ appointment.pet }}
                  </span>
                </div>
              </td>

              <!-- Service -->
              <td class="px-2 py-[17px]">
                <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                  {{ appointment.service }}
                </p>
              </td>

              <!-- Assigned Staff -->
              <td class="px-2 py-[8px]">
                <div v-if="appointment.assignedStaff" class="flex items-center gap-3">
                  <div class="w-8 h-8 rounded-full bg-[#cbfbf1] flex items-center justify-center">
                    <span class="font-nunito text-xs leading-4 text-[#00786f]">
                      {{ appointment.assignedStaff.initial }}
                    </span>
                  </div>
                  <div class="flex flex-col">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                      {{ appointment.assignedStaff.name }}
                    </span>
                    <span class="font-nunito text-xs leading-4 text-[#6a7282]">
                      {{ appointment.assignedStaff.department }}
                    </span>
                  </div>
                  <button class="w-7 h-7 rounded-lg hover:bg-gray-100 flex items-center justify-center transition-colors">
                    <img :src="iconEdit" alt="Edit" class="w-4 h-4" />
                  </button>
                </div>
                <button
                  v-else
                  class="bg-orange-50 border border-[#ffd6a7] rounded-lg h-8 px-3 flex items-center gap-2 hover:bg-orange-100 transition-colors"
                  @click="handleAssignDoctor(appointment.id)"
                >
                  <img :src="iconWarning" alt="Warning" class="w-4 h-4" />
                  <span class="font-nunito font-medium text-sm leading-5 text-[#f54900] tracking-tight">
                    Chưa gán
                  </span>
                </button>
              </td>

              <!-- Status -->
              <td class="px-2 py-[15px]">
                <span
                  :class="[
                    'inline-flex items-center px-2 py-[3px] rounded-lg font-nunito font-medium text-xs leading-4',
                    appointment.status === 'confirmed' ? 'bg-green-100 text-[#008236]' :
                    appointment.status === 'in-progress' ? 'bg-purple-100 text-[#8200db]' :
                    appointment.status === 'pending' ? 'bg-blue-100 text-[#1447e6]' :
                    appointment.status === 'completed' ? 'bg-gray-100 text-[#364153]' :
                    'bg-[#ffe2e2] text-[#c10007]'
                  ]"
                >
                  {{ getStatusLabel(appointment.status) }}
                </span>
              </td>

              <!-- Payment Status -->
              <td class="px-2 py-[15px]">
                <span
                  :class="[
                    'inline-flex items-center px-2 py-[3px] rounded-lg font-nunito font-medium text-xs leading-4',
                    appointment.paymentStatus === 'paid' ? 'bg-green-100 text-[#008236]' :
                    appointment.paymentStatus === 'refunded' ? 'bg-purple-100 text-[#7e22ce]' :
                    'bg-gray-100 text-[#4a5565]'
                  ]"
                >
                  {{ getPaymentStatusLabel(appointment.paymentStatus) }}
                </span>
              </td>

              <!-- Actions -->
              <td class="px-2 py-[10px]">
                <div class="flex items-center justify-end gap-2">
                  <!-- <button
                    v-if="appointment.status !== 'completed' && appointment.status !== 'cancelled'"
                    class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
                    title="Xác nhận"
                  >
                    <img :src="iconCheck" alt="Confirm" class="w-4 h-4" />
                  </button> -->
                  <button
                    class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
                    title="Xem chi tiết"
                    @click="handleViewAppointment(appointment.id)"
                  >
                    <img :src="iconEye" alt="View" class="w-4 h-4" />
                  </button>
                  <button
                    v-if="appointment.status !== 'completed' && appointment.status !== 'cancelled'"
                    class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
                    title="Hủy lịch"
                    @click="handleCancelAppointment(appointment.id)"
                  >
                    <img :src="iconCancel" alt="Cancel" class="w-4 h-4" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Modals -->
    <TaoLichHen
      v-if="isCreateAppointmentModalOpen"
      @close="isCreateAppointmentModalOpen = false"
      @submit="handleCreateAppointment"
    />

    <ChiTietLichHen
      v-if="isViewAppointmentModalOpen"
      :appointment-id="selectedAppointmentId"
      @close="isViewAppointmentModalOpen = false"
    />

    <PhanCongBacSi
      v-if="isAssignDoctorModalOpen"
      :appointment-id="selectedAppointmentForAssign"
      @close="isAssignDoctorModalOpen = false"
      @assign="handleAssignDoctorSubmit"
    />

    <XoaLichHen
      v-if="isCancelAppointmentModalOpen"
      :appointment-id="selectedAppointmentForCancel"
      @close="isCancelAppointmentModalOpen = false"
      @confirm="handleCancelAppointmentConfirm"
    />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import TaoLichHen from './TaoLichHen/index.vue'
import ChiTietLichHen from './ChiTietLichHen/index.vue'
import PhanCongBacSi from './PhanCongBacSi/index.vue'
import XoaLichHen from './XoaLichHen/index.vue'

// Icons (from Figma - expire in 7 days)
const iconCalendar = "https://www.figma.com/api/mcp/asset/52bb5c39-6cad-469b-b6f1-ae9080630816"
const iconList = "https://www.figma.com/api/mcp/asset/193b6dd7-26f4-4255-97b9-1dab13480445"
const iconInfo = "https://www.figma.com/api/mcp/asset/d8d78cd2-466d-4e46-91e6-d15ad70ae240"
const iconPlus = "https://www.figma.com/api/mcp/asset/01f06bef-7043-4ea0-9813-1421715a59a0"
const iconChevronDown = "https://www.figma.com/api/mcp/asset/18e0738b-2077-416d-a0ab-1e77c1876e0b"
const iconChevronDownGray = "https://www.figma.com/api/mcp/asset/aa0795ae-fecf-415c-9d22-0a72282b83c5"
const iconSearch = "https://www.figma.com/api/mcp/asset/956514f4-380b-499f-a317-43e4198ab26d"
const iconEdit = "https://www.figma.com/api/mcp/asset/839ffb1e-c31c-4487-bd0a-e7ba3c83ea3a"
const iconCheck = "https://www.figma.com/api/mcp/asset/c35385b8-6c69-4da1-947a-4c825d65703c"
const iconEye = "https://www.figma.com/api/mcp/asset/021018ef-b553-495c-8a16-2f82b9b47bcf"
const iconCancel = "https://www.figma.com/api/mcp/asset/4ef6be71-a70f-4d58-975c-332795e2f34a"
const iconWarning = "https://www.figma.com/api/mcp/asset/7e99d627-ecff-43f8-b928-e9d727f824d0"

// Emits
const emit = defineEmits(['create-appointment'])

// Reactive state
const viewMode = ref('list')
const searchQuery = ref('')
const isCreateAppointmentModalOpen = ref(false)
const isViewAppointmentModalOpen = ref(false)
const selectedAppointmentId = ref('')
const isAssignDoctorModalOpen = ref(false)
const selectedAppointmentForAssign = ref('')
const isCancelAppointmentModalOpen = ref(false)
const selectedAppointmentForCancel = ref('')

// Sample Data
const appointments = ref([
  {
    id: 'LH001234',
    time: '09:00',
    date: '20/11/2025',
    customer: 'Nguyễn Văn A',
    pet: 'Milo',
    service: 'Khám tổng quát',
    assignedStaff: {
      initial: 'B',
      name: 'BS. Nguyễn Văn B',
    },
    status: 'confirmed',
    paymentStatus: 'unpaid'
  },
  {
    id: 'LH001235',
    time: '10:30',
    date: '20/11/2025',
    customer: 'Trần Thị C',
    pet: 'Luna',
    service: 'Tiêm phòng',
    assignedStaff: {
      initial: 'D',
      name: 'NV. Lê Thị D',
    },
    status: 'in-progress',
    paymentStatus: 'unpaid'
  },
  {
    id: 'LH001236',
    time: '14:00',
    date: '20/11/2025',
    customer: 'Lê Văn E',
    pet: 'Bella',
    service: 'Phẫu thuật xương',
    assignedStaff: null,
    status: 'pending',
    paymentStatus: 'unpaid'
  },
  {
    id: 'LH001237',
    time: '15:00',
    date: '19/11/2025',
    customer: 'Phạm Thị G',
    pet: 'Max',
    service: 'Khám bệnh',
    assignedStaff: {
      initial: 'B',
      name: 'BS. Nguyễn Văn B',
    },
    status: 'completed',
    paymentStatus: 'paid'
  },
  {
    id: 'LH001238',
    time: '16:00',
    date: '19/11/2025',
    customer: 'Hoàng Văn H',
    pet: 'Coco',
    service: 'Tư vấn dinh dưỡng',
    assignedStaff: {
      initial: 'D',
      name: 'NV. Lê Thị D',
    },
    status: 'cancelled',
    paymentStatus: 'refunded'
  },
  {
    id: 'LH001239',
    time: '11:00',
    date: '20/11/2025',
    customer: 'Đỗ Thị I',
    pet: 'Rocky',
    service: 'Siêu âm',
    assignedStaff: null,
    status: 'confirmed',
    paymentStatus: 'paid'
  }
])

// Methods
const getStatusLabel = (status) => {
  const labels = {
    'confirmed': 'Đã xác nhận',
    'in-progress': 'Đang khám',
    'pending': 'Chờ xác nhận',
    'completed': 'Hoàn thành',
    'cancelled': 'Đã hủy'
  }
  return labels[status] || status
}

const getPaymentStatusLabel = (status) => {
  const labels = {
    'paid': 'Đã thanh toán',
    'unpaid': 'Chưa thanh toán',
    'refunded': 'Đã hoàn tiền'
  }
  return labels[status] || status
}

const handleCreateAppointment = (data) => {
  console.log('New appointment data:', data)
  // Logic to create appointment goes here
  isCreateAppointmentModalOpen.value = false
}

const handleViewAppointment = (id) => {
  selectedAppointmentId.value = id
  isViewAppointmentModalOpen.value = true
}

const handleAssignDoctor = (id) => {
  selectedAppointmentForAssign.value = id
  isAssignDoctorModalOpen.value = true
}

const handleAssignDoctorSubmit = (data) => {
  console.log('Assigned doctor:', data)
  // Logic to assign doctor goes here
  isAssignDoctorModalOpen.value = false
}

const handleCancelAppointment = (id) => {
  selectedAppointmentForCancel.value = id
  isCancelAppointmentModalOpen.value = true
}

const handleCancelAppointmentConfirm = (id) => {
  console.log('Cancelled appointment:', id)
  // Logic to cancel appointment goes here
  isCancelAppointmentModalOpen.value = false
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
