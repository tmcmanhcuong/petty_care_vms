<template>
  <div class="flex flex-col gap-6 w-full">
    <!-- Page Header -->
    <div class="flex flex-col h-[60px]">
      <h1 class="font-nunitoSans font-medium text-2xl leading-9 text-[#101828] tracking-[0.0703px]">
        Dashboard - Bác sĩ
      </h1>
      <p class="font-inter font-normal text-base leading-6 text-[#4a5565] tracking-[-0.3125px]">
        Hôm nay bạn bận thế nào? Ai đang đợi bạn?
      </p>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-4 gap-4 h-[110px]">
      <!-- Card 1: Ca khám hôm nay -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] flex flex-col px-[25px] py-[25px]">
        <div class="flex items-start justify-between w-full h-full">
          <div class="flex flex-col gap-1">
            <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
              Ca khám hôm nay
            </p>
            <p class="font-inter font-normal text-[30px] leading-9 text-[#155dfc] tracking-[0.3955px]">
              {{ stats.appointments }}
            </p>
          </div>
          <div class="bg-blue-100 rounded-[10px] w-12 h-12 flex items-center justify-center">
            <img :src="icons.calendar" alt="" class="w-6 h-6" />
          </div>
        </div>
      </div>

      <!-- Card 2: Đã hoàn thành -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] flex flex-col px-[25px] py-[25px]">
        <div class="flex items-start justify-between w-full h-full">
          <div class="flex flex-col gap-1">
            <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
              Đã hoàn thành
            </p>
            <p class="font-inter font-normal text-[30px] leading-9 text-[#00a63e] tracking-[0.3955px]">
              {{ stats.completed }}
            </p>
          </div>
          <div class="bg-green-100 rounded-[10px] w-12 h-12 flex items-center justify-center">
            <img :src="icons.checkCircle" alt="" class="w-6 h-6" />
          </div>
        </div>
      </div>

      <!-- Card 3: Đang chờ -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] flex flex-col px-[25px] py-[25px]">
        <div class="flex items-start justify-between w-full h-full">
          <div class="flex flex-col gap-1">
            <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
              Đang chờ
            </p>
            <p class="font-inter font-normal text-[30px] leading-9 text-[#f54900] tracking-[0.3955px]">
              {{ stats.waiting }}
            </p>
          </div>
          <div class="bg-[#ffedd4] rounded-[10px] w-12 h-12 flex items-center justify-center">
            <img :src="icons.clock" alt="" class="w-6 h-6" />
          </div>
        </div>
      </div>

      <!-- Card 4: Doanh thu hôm nay -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] flex flex-col px-[25px] py-[25px]">
        <div class="flex items-start justify-between w-full h-full">
          <div class="flex flex-col gap-1">
            <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
              Doanh thu hôm nay
            </p>
            <p class="font-inter font-normal text-[30px] leading-9 text-[#009689] tracking-[0.3955px]">
              {{ stats.revenue }}
            </p>
          </div>
          <div class="bg-[#cbfbf1] rounded-[10px] w-12 h-12 flex items-center justify-center">
            <img :src="icons.money" alt="" class="w-6 h-6" />
          </div>
        </div>
      </div>
    </div>

    <!-- Waiting Patients Card -->
    <div class="bg-white border-2 border-[#bedbff] rounded-[14px] h-[664px] relative">
      <!-- Card Header -->
      <div class="absolute left-[26px] top-[26px] flex items-center justify-between w-[calc(100%-52px)] h-[22px] bg-blue-50">
        <div class="flex items-center h-5">
          <img :src="icons.patients" alt="" class="w-5 h-5" />
          <p class="font-inter font-normal text-base leading-4 text-neutral-950 tracking-[-0.3125px] ml-2">
            Bệnh nhân đang chờ ({{ waitingList.length }})
          </p>
        </div>
        <div class="bg-[#ffedd4] border border-transparent rounded-lg h-[22px] px-[9px] py-[3px] flex items-center">
          <p class="font-inter font-medium text-xs leading-4 text-[#ca3500]">
            {{ waitingList.length }} người
          </p>
        </div>
      </div>

      <!-- Card Content -->
      <div class="absolute left-[2px] top-[78px] w-[calc(100%-4px)] h-[584px] flex flex-col gap-6 px-6 pt-6">
        <!-- Next Patient Section -->
        <div class="flex flex-col gap-4 h-[272px]">
          <div class="flex gap-2 items-center h-5">
            <img :src="icons.star" alt="" class="w-5 h-5" />
            <p class="font-inter font-bold text-sm leading-5 text-[#7e2a0c] tracking-[-0.1504px]">
              Bệnh nhân tiếp theo:
            </p>
          </div>

          <!-- Next Patient Card -->
          <div v-if="nextPatient" class="border-2 border-[#8ec5ff] rounded-[14px] flex gap-6 px-[26px] py-[26px] h-[236px]">
            <div class="bg-transparent border-4 border-white rounded-[14px] w-32 h-32 overflow-hidden">
              <img :src="nextPatient.petImage" alt="" class="w-full h-full object-cover" />
            </div>
            
            <div class="flex-1">
              <div class="flex items-start justify-between mb-4">
                <div class="flex flex-col gap-1">
                  <h3 class="font-inter font-normal text-2xl leading-8 text-[#101828] tracking-[0.0703px]">
                    {{ nextPatient.petName }}
                  </h3>
                  <p class="font-inter font-normal text-base leading-6 text-[#4a5565] tracking-[-0.3125px]">
                    {{ nextPatient.petType }}
                  </p>
                </div>
                <div class="bg-[#ffedd4] border border-transparent rounded-lg px-[9px] py-[3px] flex items-center gap-1">
                  <img :src="icons.clockSmall" alt="" class="w-3 h-3" />
                  <p class="font-inter font-medium text-xs leading-4 text-[#ca3500]">
                    Chờ {{ nextPatient.waitTime }}
                  </p>
                </div>
              </div>

              <div class="grid grid-cols-2 gap-4 mb-6">
                <div class="flex flex-col">
                  <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
                    Chủ nuôi
                  </p>
                  <p class="font-inter font-normal text-base leading-6 text-[#101828] tracking-[-0.3125px]">
                    {{ nextPatient.ownerName }}
                  </p>
                </div>
                <div class="flex flex-col">
                  <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
                    Dịch vụ
                  </p>
                  <p class="font-inter font-normal text-base leading-6 text-[#101828] tracking-[-0.3125px]">
                    {{ nextPatient.service }}
                  </p>
                </div>
              </div>

              <button class="bg-[#155dfc] rounded-lg h-10 px-4 flex items-center gap-2">
                <img :src="icons.playCircle" alt="" class="w-4 h-4" />
                <span class="font-inter font-medium text-sm leading-5 text-white tracking-[-0.1504px]">
                  BẮT ĐẦU KHÁM
                </span>
              </button>
            </div>
          </div>
        </div>

        <!-- Queue List -->
        <div class="flex flex-col gap-3 h-[240px]">
          <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
            Tiếp theo trong hàng chờ:
          </p>
          
          <div class="flex flex-col gap-3">
            <div
              v-for="patient in queueList"
              :key="patient.id"
              class="bg-white border border-gray-200 rounded-[10px] flex gap-4 items-center px-[17px] py-[1px] h-[98px]"
            >
              <div class="rounded-[10px] w-16 h-16 overflow-hidden">
                <img :src="patient.petImage" alt="" class="w-full h-full object-cover" />
              </div>
              
              <div class="flex-1 flex flex-col gap-1">
                <div class="flex items-center">
                  <span class="font-inter font-bold text-base leading-6 text-[#101828] tracking-[-0.3125px]">
                    {{ patient.petName }}
                  </span>
                  <span class="font-inter font-normal text-base leading-6 text-[#101828] tracking-[-0.3125px]">
                    - {{ patient.petType }}
                  </span>
                </div>
                <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
                  Chủ: {{ patient.ownerName }} | {{ patient.service }}
                </p>
              </div>

              <div class="bg-gray-100 border border-transparent rounded-lg px-[9px] py-[3px] flex items-center gap-1">
                <img :src="icons.clockGray" alt="" class="w-3 h-3" />
                <p class="font-inter font-medium text-xs leading-4 text-[#364153] text-right">
                  {{ patient.waitTime }}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Schedule Today Card -->
    <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] flex flex-col gap-[30px] h-[472px] px-[25px] py-[25px]">
      <!-- Card Title -->
      <div class="flex items-center h-5">
        <img :src="icons.calendarToday" alt="" class="w-5 h-5" />
        <p class="font-inter font-normal text-base leading-4 text-neutral-950 tracking-[-0.3125px] ml-2">
          Lịch hôm nay
        </p>
      </div>

      <!-- Schedule List -->
      <div class="flex-1 flex flex-col gap-2 overflow-y-auto">
        <div
          v-for="schedule in scheduleToday"
          :key="schedule.id"
          class="bg-gray-50 rounded-[10px] flex gap-4 items-center px-3 h-[68px]"
        >
          <div class="w-16 text-center">
            <p class="font-inter font-normal text-base leading-6 text-[#101828] tracking-[-0.3125px]">
              {{ schedule.time }}
            </p>
          </div>
          
          <div class="flex-1 flex flex-col gap-0">
            <p class="font-inter font-normal text-base leading-6 text-[#101828] tracking-[-0.3125px]">
              {{ schedule.petName }}
            </p>
            <p class="font-inter font-normal text-sm leading-5 text-[#4a5565] tracking-[-0.1504px]">
              {{ schedule.ownerName }}
            </p>
          </div>

          <div
            class="rounded-lg px-[9px] py-[3px] h-[22px] flex items-center"
            :class="getBadgeClass(schedule.status)"
          >
            <p class="font-inter font-medium text-xs leading-4" :class="getBadgeTextClass(schedule.status)">
              {{ schedule.statusText }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

// Icon URLs from Figma
const icons = {
  calendar: 'https://www.figma.com/api/mcp/asset/d18e35a2-001a-4869-894a-ad06d798fa43',
  checkCircle: 'https://www.figma.com/api/mcp/asset/8651badb-d209-49cb-b39e-8cefb1af0e2b',
  clock: 'https://www.figma.com/api/mcp/asset/9e880ce6-069d-4b2e-a62f-5dca3b049967',
  money: 'https://www.figma.com/api/mcp/asset/0106ca48-db78-4162-8cae-e8a70fa71bf1',
  patients: 'https://www.figma.com/api/mcp/asset/1f06022c-a411-477f-86f6-612cde40035c',
  star: 'https://www.figma.com/api/mcp/asset/1abe5ec6-c7e8-4f91-bfad-0c88801a64ea',
  clockSmall: 'https://www.figma.com/api/mcp/asset/26c6aa88-0e51-468e-adf9-83dc19ba2e32',
  playCircle: 'https://www.figma.com/api/mcp/asset/8b8c2e89-a002-4dc8-a3cc-0fcfe868bce7',
  clockGray: 'https://www.figma.com/api/mcp/asset/db575725-2945-49c8-bfbf-395b8d8f8f96',
  calendarToday: 'https://www.figma.com/api/mcp/asset/1e8932ec-799f-4446-be9e-053783d29477'
};

// Stats data
const stats = ref({
  appointments: 12,
  completed: 5,
  waiting: 3,
  revenue: '8.5M'
});

// Next patient data
const nextPatient = ref({
  petName: 'Milo',
  petType: 'Chó Golden',
  petImage: 'https://www.figma.com/api/mcp/asset/0996f435-1b15-49c1-8678-c2d5ea87f3d9',
  ownerName: 'Nguyễn Văn A',
  service: 'Khám tổng quát',
  waitTime: '15 phút'
});

// Queue list data
const queueList = ref([
  {
    id: 1,
    petName: 'Luna',
    petType: 'Mèo Ba Tư',
    petImage: 'https://www.figma.com/api/mcp/asset/c38b6fa3-a3ee-45f7-8478-eddbcec7fb06',
    ownerName: 'Trần Thị B',
    service: 'Tiêm phòng vắc-xin',
    waitTime: '5 phút'
  },
  {
    id: 2,
    petName: 'Max',
    petType: 'Chó Husky',
    petImage: 'https://www.figma.com/api/mcp/asset/b14ada9b-9ec6-46f2-8312-7a66ec0b3f78',
    ownerName: 'Lê Văn C',
    service: 'Cắt tỉa lông',
    waitTime: '30 phút'
  }
]);

// Computed waiting list
const waitingList = computed(() => {
  return [nextPatient.value, ...queueList.value];
});

// Schedule today data
const scheduleToday = ref([
  {
    id: 1,
    time: '09:00',
    petName: 'Milo',
    ownerName: 'Nguyễn Văn A',
    status: 'waiting',
    statusText: 'Đang chờ'
  },
  {
    id: 2,
    time: '09:30',
    petName: 'Luna',
    ownerName: 'Trần Thị B',
    status: 'confirmed',
    statusText: 'Đã xác nhận'
  },
  {
    id: 3,
    time: '10:00',
    petName: 'Kiki',
    ownerName: 'Phạm Thị D',
    status: 'completed',
    statusText: 'Hoàn thành'
  },
  {
    id: 4,
    time: '10:30',
    petName: 'Max',
    ownerName: 'Lê Văn C',
    status: 'confirmed',
    statusText: 'Đã xác nhận'
  },
  {
    id: 5,
    time: '11:00',
    petName: 'Bella',
    ownerName: 'Hoàng Văn E',
    status: 'confirmed',
    statusText: 'Đã xác nhận'
  }
]);

// Badge styling helper
const getBadgeClass = (status) => {
  const classes = {
    waiting: 'bg-[#ffedd4]',
    confirmed: 'bg-blue-100',
    completed: 'bg-green-100'
  };
  return classes[status] || 'bg-gray-100';
};

const getBadgeTextClass = (status) => {
  const classes = {
    waiting: 'text-[#ca3500]',
    confirmed: 'text-[#1447e6]',
    completed: 'text-[#008236]'
  };
  return classes[status] || 'text-gray-700';
};
</script>

<style scoped>
.font-nunitoSans {
  font-family: 'Nunito Sans', sans-serif;
}

.font-inter {
  font-family: 'Inter', sans-serif;
}

/* Custom scrollbar for schedule list */
.overflow-y-auto::-webkit-scrollbar {
  width: 6px;
}

.overflow-y-auto::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>
