<template>
  <div class="flex flex-col gap-6 h-full w-full">
    <!-- Page Header -->
    <div class="flex flex-col h-[60px]">
      <h1 class="text-[24px] font-medium leading-[36px] text-[#101828] tracking-[0.0703px]" style="font-family: 'Nunito Sans', 'Inter', sans-serif;">
        Quản lý Bệnh nhân
      </h1>
      <p class="text-[16px] font-normal leading-6 text-[#4a5565] tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
        Tìm kiếm và tiếp nhận khám
      </p>
    </div>

    <!-- Search Bar Card -->
    <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] px-[25px] py-[25px]">
      <div class="flex items-center gap-3">
        <!-- Search Input -->
        <div class="flex-1 relative">
          <div class="absolute left-4 top-[14px] w-5 h-5">
            <img :src="icons.search" alt="" class="w-full h-full" />
          </div>
          <input
            v-model="searchQuery"
            type="text"
            placeholder="🔍 Nhập SĐT hoặc Tên chủ nuôi để tìm nhanh..."
            class="w-full h-12 bg-[#f3f3f5] border border-transparent rounded-lg pl-12 pr-3 text-[14px] font-normal text-[#717182] tracking-[-0.1504px] focus:outline-none focus:border-[#009689] transition-colors"
            style="font-family: 'Inter', sans-serif;"
          />
        </div>
        
        <!-- New Customer Button -->
        <button @click="openAddPatientModal" class="h-12 px-3 bg-[#009689] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-[#00857a] transition-colors whitespace-nowrap" style="font-family: 'Inter', sans-serif;">
          <img :src="icons.plus" alt="" class="w-4 h-4" />
          Tiếp nhận khách mới
        </button>
      </div>
    </div>

    <!-- Customer Cards List -->
    <div class="flex flex-col gap-4 overflow-y-auto" style="max-height: calc(100vh - 260px);">
      <!-- Customer Card 1: Nguyễn Văn A -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] px-[25px] py-[25px]">
        <!-- Customer Header -->
        <div class="flex items-center justify-between mb-[42px]">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-[#cbfbf1] rounded-full flex items-center justify-center">
              <img :src="icons.user" alt="" class="w-5 h-5" />
            </div>
            <div class="flex flex-col">
              <p class="text-[16px] font-normal leading-6 text-neutral-950 tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[0].name }}
              </p>
              <div class="flex items-center gap-1">
                <img :src="icons.phone" alt="" class="w-3 h-3" />
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[0].phone }}
                </span>
              </div>
            </div>
          </div>
          <div class="bg-blue-100 border border-transparent rounded-lg px-[9px] py-[3px]">
            <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">Khách quen</span>
          </div>
        </div>

        <!-- Pets List -->
        <div class="flex flex-col gap-3">
          <!-- Pet 1: Milo -->
          <div class="bg-gray-50 rounded-[10px] px-4 py-0 h-[100px] flex items-center gap-4">
            <div class="w-16 h-16 rounded-[10px] overflow-hidden flex-shrink-0">
              <img :src="customers[0].pets[0].image" alt="" class="w-full h-full object-cover" />
            </div>
            <div class="flex-1 flex flex-col gap-1">
              <div class="flex items-center gap-2">
                <p class="text-[16px] font-normal leading-6 text-[#101828] tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[0].pets[0].name }}
                </p>
                <span class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  ({{ customers[0].pets[0].breed }})
                </span>
              </div>
              <div class="flex items-center gap-2">
                <img :src="icons.clock" alt="" class="w-3 h-3" />
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[0].pets[0].lastVisit }}
                </span>
              </div>
              <div class="flex items-center gap-2">
                <img :src="icons.fileText" alt="" class="w-3 h-3" />
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[0].pets[0].diagnosis }}
                </span>
              </div>
            </div>
            <div class="flex items-center gap-2">
              <button class="h-8 px-3 bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950 text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-gray-50 transition-colors" style="font-family: 'Inter', sans-serif;">
                <img :src="icons.eye" alt="" class="w-4 h-4" />
                Xem Hồ sơ
              </button>
              <button @click="goToExamination" class="h-8 px-3 bg-[#009689] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-[#00857a] transition-colors" style="font-family: 'Inter', sans-serif;">
                <img :src="icons.stethoscope" alt="" class="w-4 h-4" />
                🩺 Khám ngay
              </button>
            </div>
          </div>

          <!-- Pet 2: Kitty (No image) -->
          <div class="bg-gray-50 rounded-[10px] px-4 py-0 h-[100px] flex items-center gap-4">
            <div class="w-16 h-16 rounded-[10px] bg-gray-200 flex items-center justify-center flex-shrink-0">
              <span class="text-3xl">🐱</span>
            </div>
            <div class="flex-1 flex flex-col gap-1">
              <div class="flex items-center gap-2">
                <p class="text-[16px] font-normal leading-6 text-[#101828] tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[0].pets[1].name }}
                </p>
                <span class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  ({{ customers[0].pets[1].breed }})
                </span>
              </div>
              <div class="flex items-center gap-2">
                <img :src="icons.clock" alt="" class="w-3 h-3" />
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[0].pets[1].lastVisit }}
                </span>
              </div>
              <div class="flex items-center gap-2">
                <img :src="icons.fileText" alt="" class="w-3 h-3" />
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[0].pets[1].diagnosis }}
                </span>
              </div>
            </div>
            <div class="flex items-center gap-2">
              <button class="h-8 px-3 bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950 text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-gray-50 transition-colors" style="font-family: 'Inter', sans-serif;">
                <img :src="icons.eye" alt="" class="w-4 h-4" />
                Xem Hồ sơ
              </button>
              <button @click="goToExamination" class="h-8 px-3 bg-[#009689] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-[#00857a] transition-colors" style="font-family: 'Inter', sans-serif;">
                <img :src="icons.stethoscope" alt="" class="w-4 h-4" />
                🩺 Khám ngay
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Customer Card 2: Trần Thị B -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] px-[25px] py-[25px]">
        <!-- Customer Header -->
        <div class="flex items-center justify-between mb-[42px]">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-[#cbfbf1] rounded-full flex items-center justify-center">
              <img :src="icons.user" alt="" class="w-5 h-5" />
            </div>
            <div class="flex flex-col">
              <p class="text-[16px] font-normal leading-6 text-neutral-950 tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[1].name }}
              </p>
              <div class="flex items-center gap-1">
                <img :src="icons.phone" alt="" class="w-3 h-3" />
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[1].phone }}
                </span>
              </div>
            </div>
          </div>
          <div class="bg-blue-100 border border-transparent rounded-lg px-[9px] py-[3px]">
            <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">Khách quen</span>
          </div>
        </div>

        <!-- Pet: Luna -->
        <div class="bg-gray-50 rounded-[10px] px-4 py-0 h-[100px] flex items-center gap-4">
          <div class="w-16 h-16 rounded-[10px] overflow-hidden flex-shrink-0">
            <img :src="customers[1].pets[0].image" alt="" class="w-full h-full object-cover" />
          </div>
          <div class="flex-1 flex flex-col gap-1">
            <div class="flex items-center gap-2">
              <p class="text-[16px] font-normal leading-6 text-[#101828] tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[1].pets[0].name }}
              </p>
              <span class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                ({{ customers[1].pets[0].breed }})
              </span>
            </div>
            <div class="flex items-center gap-2">
              <img :src="icons.clock" alt="" class="w-3 h-3" />
              <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[1].pets[0].lastVisit }}
              </span>
            </div>
            <div class="flex items-center gap-2">
              <img :src="icons.fileText" alt="" class="w-3 h-3" />
              <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[1].pets[0].diagnosis }}
              </span>
            </div>
          </div>
          <div class="flex items-center gap-2">
            <button class="h-8 px-3 bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950 text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-gray-50 transition-colors" style="font-family: 'Inter', sans-serif;">
              <img :src="icons.eye" alt="" class="w-4 h-4" />
              Xem Hồ sơ
            </button>
            <button @click="goToExamination" class="h-8 px-3 bg-[#009689] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-[#00857a] transition-colors" style="font-family: 'Inter', sans-serif;">
              <img :src="icons.stethoscope" alt="" class="w-4 h-4" />
              🩺 Khám ngay
            </button>
          </div>
        </div>
      </div>

      <!-- Customer Card 3: Lê Văn C -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] px-[25px] py-[25px]">
        <!-- Customer Header -->
        <div class="flex items-center justify-between mb-[42px]">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-[#cbfbf1] rounded-full flex items-center justify-center">
              <img :src="icons.user" alt="" class="w-5 h-5" />
            </div>
            <div class="flex flex-col">
              <p class="text-[16px] font-normal leading-6 text-neutral-950 tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[2].name }}
              </p>
              <div class="flex items-center gap-1">
                <img :src="icons.phone" alt="" class="w-3 h-3" />
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  {{ customers[2].phone }}
                </span>
              </div>
            </div>
          </div>
          <div class="bg-blue-100 border border-transparent rounded-lg px-[9px] py-[3px]">
            <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">Khách quen</span>
          </div>
        </div>

        <!-- Pet: Bông -->
        <div class="bg-gray-50 rounded-[10px] px-4 py-0 h-[100px] flex items-center gap-4">
          <div class="w-16 h-16 rounded-[10px] overflow-hidden flex-shrink-0">
            <img :src="customers[2].pets[0].image" alt="" class="w-full h-full object-cover" />
          </div>
          <div class="flex-1 flex flex-col gap-1">
            <div class="flex items-center gap-2">
              <p class="text-[16px] font-normal leading-6 text-[#101828] tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[2].pets[0].name }}
              </p>
              <span class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                ({{ customers[2].pets[0].breed }})
              </span>
            </div>
            <div class="flex items-center gap-2">
              <img :src="icons.clock" alt="" class="w-3 h-3" />
              <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[2].pets[0].lastVisit }}
              </span>
            </div>
            <div class="flex items-center gap-2">
              <img :src="icons.fileText" alt="" class="w-3 h-3" />
              <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                {{ customers[2].pets[0].diagnosis }}
              </span>
            </div>
          </div>
          <div class="flex items-center gap-2">
            <button class="h-8 px-3 bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950 text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-gray-50 transition-colors" style="font-family: 'Inter', sans-serif;">
              <img :src="icons.eye" alt="" class="w-4 h-4" />
              Xem Hồ sơ
            </button>
            <button @click="goToExamination" class="h-8 px-3 bg-[#009689] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-[#00857a] transition-colors" style="font-family: 'Inter', sans-serif;">
              <img :src="icons.stethoscope" alt="" class="w-4 h-4" />
              🩺 Khám ngay
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- Add Patient Modal -->
    <div v-if="isAddPatientModalOpen" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">
      <ThemBenhNhan @cancel="closeAddPatientModal" @save="handleSavePatient" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import ThemBenhNhan from './ThemBenhNhan/index.vue';

const router = useRouter();

// Modal state
const isAddPatientModalOpen = ref(false);

const openAddPatientModal = () => {
  isAddPatientModalOpen.value = true;
};

const closeAddPatientModal = () => {
  isAddPatientModalOpen.value = false;
};

const handleSavePatient = (patientData) => {
  console.log('Received patient data:', patientData);
  // TODO: Add logic to update the local list or refetch data
  closeAddPatientModal();
  // Optionally navigate to the examination page for the new patient
  // router.push('/doctor/benh-nhan/phieu-kham');
};

const goToExamination = () => {
  router.push('/doctor/benh-nhan/phieu-kham');
};

// Icons from Figma
const icons = {
  plus: "https://www.figma.com/api/mcp/asset/2f4c83de-dcb7-49bd-91e5-df6f78d1edab",
  search: "https://www.figma.com/api/mcp/asset/e3819e82-33f3-455c-84b0-b4828944849f",
  user: "https://www.figma.com/api/mcp/asset/9c5f1246-17af-428a-9df2-fce6cd1f3c3e",
  phone: "https://www.figma.com/api/mcp/asset/0c9413ff-71b7-4a5d-bd64-75c40d880e59",
  clock: "https://www.figma.com/api/mcp/asset/50befb88-a71a-42a5-87e7-c06988cb1f34",
  fileText: "https://www.figma.com/api/mcp/asset/f43e6876-a6cc-4bc1-9e44-8f8038e2ce40",
  eye: "https://www.figma.com/api/mcp/asset/d334e21f-23f5-4859-a6ee-ba733e1b2c55",
  stethoscope: "https://www.figma.com/api/mcp/asset/98c5f5ef-a937-47ee-8bec-b8e9b40d9991"
};

// Search query
const searchQuery = ref('');

// Customer data
const customers = ref([
  {
    name: 'Nguyễn Văn A',
    phone: '0901234567',
    pets: [
      {
        name: 'Milo',
        breed: 'Chó Golden Retriever',
        image: 'https://www.figma.com/api/mcp/asset/a2761a4b-b6d0-445d-af30-5eb01504eabb',
        lastVisit: 'Lần khám cuối: 3 ngày trước',
        diagnosis: 'Viêm da - Đã khỏi'
      },
      {
        name: 'Kitty',
        breed: 'Mèo Mướp',
        image: null,
        lastVisit: 'Lần khám cuối: 2 tháng trước',
        diagnosis: 'Tiêm phòng 3 bệnh'
      }
    ]
  },
  {
    name: 'Trần Thị B',
    phone: '0912345678',
    pets: [
      {
        name: 'Luna',
        breed: 'Chó Corgi',
        image: 'https://www.figma.com/api/mcp/asset/65d56ecb-de3d-49d7-9c67-99b2b2a4b916',
        lastVisit: 'Lần khám cuối: 1 tuần trước',
        diagnosis: 'Khám định kỳ - Bình thường'
      }
    ]
  },
  {
    name: 'Lê Văn C',
    phone: '0923456789',
    pets: [
      {
        name: 'Bông',
        breed: 'Mèo Anh lông dài',
        image: 'https://www.figma.com/api/mcp/asset/3025f0c5-14b4-4732-91bd-9abc21c4a089',
        lastVisit: 'Lần khám cuối: 5 ngày trước',
        diagnosis: 'Tẩy giun định kỳ'
      }
    ]
  }
]);
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;600;700&family=Inter:wght@400;500;600;700&display=swap');

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}
</style>
