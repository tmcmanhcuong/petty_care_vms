<template>
  <!-- Modal Overlay -->
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <!-- Modal Card -->
    <div class="bg-white border border-black/10 rounded-[10px] shadow-[0px_10px_15px_-3px_rgba(0,0,0,0.1),0px_4px_6px_-4px_rgba(0,0,0,0.1)] w-[510px] relative">
      <!-- Close Button -->
      <button
        @click="$emit('close')"
        class="absolute right-4 top-4 w-4 h-4 opacity-70 hover:opacity-100 transition-opacity"
      >
        <img :src="iconClose" alt="Close" class="w-full h-full" />
      </button>

      <!-- Dialog Header -->
      <div class="px-6 pt-6 pb-0">
        <h2 class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight mb-2">
          Phân công Bác sĩ
        </h2>
        <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
          Chọn bác sĩ phù hợp cho lịch hẹn này
        </p>
      </div>

      <!-- Content -->
      <div class="px-6 pt-[22px] pb-0">
        <div class="flex flex-col gap-4">
          <!-- Appointment Info Alert -->
          <div class="bg-teal-50 border border-[#96f7e4] rounded-[10px] px-[17px] py-[13px] relative">
            <div class="absolute left-[17px] top-[15px] w-4 h-4">
              <img :src="iconInfo" alt="Info" class="w-full h-full" />
            </div>
            <div class="ml-7 flex flex-col gap-1">
              <div class="flex items-start">
                <p class="font-nunito font-bold text-sm text-[#717182] tracking-tight">
                  Lịch hẹn:
                </p>
                <p class="font-nunito text-sm text-[#717182] tracking-tight ml-1">
                  {{ appointmentInfo.id }} - {{ appointmentInfo.service }}
                </p>
                <p class="font-nunito text-sm text-[#6a7282] tracking-tight ml-1">
                  ({{ appointmentInfo.duration }} phút)
                </p>
              </div>
              <div class="flex items-center gap-1">
                <img :src="iconClock" alt="Time" class="w-3 h-3" />
                <p class="font-nunito text-sm text-[#717182] tracking-tight">
                  {{ appointmentInfo.time }} - {{ appointmentInfo.date }} | 🐾 {{ appointmentInfo.pet }}
                </p>
              </div>
            </div>
          </div>

          <!-- Staff List Container -->
          <div class="pr-2 flex flex-col gap-4 max-h-[316px] overflow-y-auto">
            <!-- Available Doctors Section -->
            <div class="flex flex-col gap-3">
              <div class="flex items-center gap-2 h-5">
                <div class="w-2 h-2 rounded-full bg-[#00c950]"></div>
                <h4 class="font-nunito font-medium text-sm leading-5 text-[#364153] tracking-tight">
                  Bác sĩ khả dụng ({{ availableStaff.length }})
                </h4>
              </div>

              <div class="flex flex-col gap-2">
                <div
                  v-for="staff in availableStaff"
                  :key="staff.id"
                  class="bg-green-50 border border-[#b9f8cf] rounded-[10px] px-[13px] py-[13px] flex items-center justify-between"
                >
                  <div class="flex items-center gap-3">
                    <!-- Avatar -->
                    <div class="w-10 h-10 rounded-full bg-[#009689] flex items-center justify-center">
                      <span class="font-nunito text-base leading-6 text-white tracking-tight">
                        {{ staff.initial }}
                      </span>
                    </div>

                    <!-- Info -->
                    <div class="flex flex-col gap-1">
                      <p class="font-nunito font-medium text-base leading-6 text-[#101828] tracking-tight">
                        {{ staff.name }}
                      </p>
                      <div class="flex items-center gap-2">
                        <!-- <span class="bg-white border border-black/10 rounded-lg px-[9px] py-[3px] font-nunito font-medium text-xs leading-4 text-neutral-950">
                          {{ staff.department }}
                        </span> -->
                        <div class="flex items-center gap-1">
                          <div class="w-[6px] h-[6px] rounded-full bg-[#00c950]"></div>
                          <span class="font-nunito text-xs leading-4 text-[#00a63e]">
                            Đang trực
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- Select Button -->
                  <button
                    @click="handleSelectStaff(staff)"
                    class="bg-[#00a63e] rounded-lg h-8 px-[10px] flex items-center gap-1 hover:bg-[#008c35] transition-colors"
                  >
                    <img :src="iconCheck" alt="Check" class="w-4 h-4" />
                    <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
                      Chọn
                    </span>
                  </button>
                </div>
              </div>
            </div>

            <!-- Unavailable Doctors Section -->
            <div class="flex flex-col gap-3">
              <div class="flex items-center gap-2 h-5">
                <div class="w-2 h-2 rounded-full bg-[#99a1af]"></div>
                <h4 class="font-nunito font-medium text-sm leading-5 text-[#99a1af] tracking-tight">
                  Không trực ({{ unavailableStaff.length }})
                </h4>
              </div>

              <div class="flex flex-col gap-2">
                <div
                  v-for="staff in unavailableStaff"
                  :key="staff.id"
                  class="bg-gray-50 border border-gray-200 rounded-[10px] px-[13px] py-[13px] flex items-center opacity-50"
                >
                  <div class="flex items-center gap-3">
                    <!-- Avatar -->
                    <div class="w-10 h-10 rounded-full bg-[#d1d5dc] flex items-center justify-center">
                      <span class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
                        {{ staff.initial }}
                      </span>
                    </div>

                    <!-- Info -->
                    <div class="flex flex-col gap-1">
                      <p class="font-nunito font-medium text-base leading-6 text-[#4a5565] tracking-tight">
                        {{ staff.name }}
                      </p>
                      <div class="flex items-center gap-2">
                        <!-- <span class="bg-white border border-black/10 rounded-lg px-[9px] py-[3px] font-nunito font-medium text-xs leading-4 text-neutral-950">
                          {{ staff.department }}
                        </span> -->
                        <span class="font-nunito text-xs leading-4 text-[#6a7282]">
                          Không có ca trực
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Dialog Footer -->
      <div class="px-6 pt-4 pb-6 flex items-center justify-end">
        <button
          @click="$emit('close')"
          class="bg-white border border-black/10 rounded-lg h-9 px-[17px] py-[9px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight hover:bg-gray-50 transition-colors"
        >
          Đóng
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

// Icons (from Figma - expire in 7 days)
const iconInfo = "https://www.figma.com/api/mcp/asset/e0c17bea-ec11-4dc3-b389-ae1f90d8cc45"
const iconClock = "https://www.figma.com/api/mcp/asset/65653d7b-7617-45e9-bbdd-dda45e426845"
const iconCheck = "https://www.figma.com/api/mcp/asset/a7a71d83-f7b3-46f8-8431-aa9d01394c2a"
const iconClose = "https://www.figma.com/api/mcp/asset/2c1ab02b-5882-483d-8198-c600112252fd"

// Props
const props = defineProps({
  appointmentId: {
    type: String,
    default: 'LH001236'
  }
})

// Emits
const emit = defineEmits(['close', 'assign'])

// Sample Appointment Info (in real app, this would be fetched based on appointmentId)
const appointmentInfo = ref({
  id: props.appointmentId,
  service: 'Phẫu thuật xương',
  duration: 120,
  time: '14:00',
  date: '20/11/2025',
  pet: 'Bella'
})

// Sample Staff Data
const availableStaff = ref([
  {
    id: 'staff1',
    name: 'BS. Nguyễn Văn B',
    initial: 'B',
    available: true
  },
  {
    id: 'staff2',
    name: 'BS. Phạm Thị H',
    initial: 'H',
    available: true
  }
])

const unavailableStaff = ref([
  {
    id: 'staff3',
    name: 'NV. Lê Thị D',
    initial: 'D',
    available: false
  }
])

// Methods
const handleSelectStaff = (staff) => {
  emit('assign', {
    appointmentId: props.appointmentId,
    staffId: staff.id,
    staffName: staff.name
  })
}
</script>

<style scoped>
/* Custom scrollbar */
::-webkit-scrollbar {
  width: 6px;
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
