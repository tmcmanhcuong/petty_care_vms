<template>
  <div class="bg-white border border-gray-200/60 rounded-[10px] shadow-lg p-6 w-full max-w-[510px]">
    <!-- Error Modal: Cannot Delete Service -->
    <div v-if="modalType === 'error'" class="flex flex-col gap-6">
      <!-- Header -->
      <div class="flex gap-3 items-center">
        <div class="bg-[#ffe2e2] rounded-full w-12 h-12 flex items-center justify-center">
          <span class="text-2xl">⛔</span>
        </div>
        <h2 class="font-nunito font-semibold text-lg leading-7 text-[#e7000b] tracking-tight">
          Không thể xóa dịch vụ này
        </h2>
      </div>

      <!-- Content -->
      <div class="flex flex-col gap-4">
        <!-- Service Info -->
        <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
          Dịch vụ
          <span class="font-semibold text-[#101828]">{{ service.name }}</span>
          đang có
          <span class="font-semibold text-[#e7000b]">{{ appointmentCount }} lịch hẹn sắp tới</span>
          chưa hoàn thành.
        </p>

        <!-- Appointment List -->
        <div class="border border-gray-200/60 rounded-[10px] overflow-hidden">
          <!-- List Header -->
          <div class="bg-gray-50 border-b border-gray-200/60 px-3 py-2">
            <p class="font-nunito text-xs leading-4 text-[#4a5565]">
              Danh sách lịch hẹn:
            </p>
          </div>

          <!-- Appointment Items -->
          <div class="flex flex-col">
            <div
              v-for="(appointment, index) in appointments"
              :key="index"
              class="px-3 py-3 flex flex-col gap-0.5"
              :class="{ 'border-b border-gray-200/60': index < appointments.length - 1 }"
            >
              <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                {{ appointment.time }} - {{ appointment.date }}:
                <span class="font-medium">{{ appointment.petName }}</span>
              </p>
              <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                ({{ appointment.ownerName }})
              </p>
            </div>
          </div>
        </div>

        <!-- Warning Box -->
        <div class="bg-orange-50 border border-[#ffd6a7] rounded-[10px] px-[13px] py-[13px]">
          <p class="font-nunito text-sm leading-5 text-[#9f2d00] tracking-tight">
            Để xóa dịch vụ này, bạn cần hủy các lịch hẹn liên quan hoặc đợi đến khi các ca khám hoàn tất.
          </p>
        </div>
      </div>

      <!-- Footer Button -->
      <div class="flex justify-end">
        <button
          class="bg-[#009689] rounded-lg px-4 py-2 hover:bg-[#007d72] transition-colors"
          @click="handleClose"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
            Đã hiểu
          </span>
        </button>
      </div>
    </div>

    <!-- Confirm Modal: Delete Service -->
    <div v-else-if="modalType === 'confirm'" class="grid grid-cols-1 grid-rows-[56px_80px_minmax(0,1fr)] gap-4">
      <!-- Header -->
      <div class="flex gap-3 items-center">
        <div class="bg-[#ffedd4] rounded-full w-12 h-12 flex items-center justify-center">
          <img :src="iconWarning" alt="" class="w-6 h-6" />
        </div>
        <h2 class="font-nunito font-semibold text-lg leading-7 text-neutral-950 tracking-tight">
          Xóa dịch vụ?
        </h2>
      </div>

      <!-- Content -->
      <div class="flex flex-col">
        <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
          Bạn có chắc chắn muốn xóa dịch vụ
          <span class="font-semibold text-[#101828]">{{ service.name }}</span>
          không?
        </p>
        <p class="font-nunito text-sm leading-5 text-[#ca3500] tracking-tight mt-3">
          ⚠️ Lưu ý: Hành động này sẽ ẩn dịch vụ khỏi danh sách đặt lịch mới. Các hóa đơn và lịch sử cũ liên quan đến dịch vụ này vẫn được giữ nguyên.
        </p>
      </div>

      <!-- Footer Buttons -->
      <div class="flex gap-2 justify-end items-start">
        <button
          class="bg-white border border-gray-200/60 rounded-lg px-[17px] py-[9px] hover:bg-gray-50 transition-colors"
          @click="handleClose"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
            Hủy bỏ
          </span>
        </button>
        <button
          class="bg-[#e7000b] rounded-lg px-4 py-2 hover:bg-[#c00009] transition-colors"
          @click="handleConfirmDelete"
        >
          <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
            Xác nhận xóa
          </span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  modalType: {
    type: String,
    required: true,
    validator: (value) => ['error', 'confirm'].includes(value)
  },
  service: {
    type: Object,
    required: true,
    default: () => ({
      id: '',
      name: 'Khám tổng quát'
    })
  },
  appointments: {
    type: Array,
    default: () => [
      {
        time: '09:00',
        date: '25-11',
        petName: 'Milo',
        ownerName: 'Nguyễn Văn A'
      },
      {
        time: '10:30',
        date: '25-11',
        petName: 'Lu',
        ownerName: 'Trần Thị B'
      },
      {
        time: '14:00',
        date: '26-11',
        petName: 'Max',
        ownerName: 'Lê Văn C'
      }
    ]
  }
})

const emit = defineEmits(['close', 'confirmDelete'])

// Computed
const appointmentCount = computed(() => {
  return props.appointments.length
})

// Icon URL from Figma (expires in 7 days)
const iconWarning = "https://www.figma.com/api/mcp/asset/f7f4eb19-4aa5-4396-96e7-400e540e5c26"

// Methods
const handleClose = () => {
  emit('close')
}

const handleConfirmDelete = () => {
  emit('confirmDelete', {
    serviceId: props.service.id,
    serviceName: props.service.name
  })
}
</script>

<style scoped>
/* Add any additional custom styles if needed */
</style>
