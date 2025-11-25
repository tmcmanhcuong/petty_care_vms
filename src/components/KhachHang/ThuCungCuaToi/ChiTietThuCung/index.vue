<template>
  <!-- Main Detail Popup -->
  <div v-if="isOpen" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4" @click="close">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto" @click.stop>
      <div class="p-6">

        <!-- Header Modal -->
        <div class="text-center relative mb-4">
          <h2 class="text-lg font-bold">Hồ sơ chi tiết</h2>
          <button @click="close" class="absolute right-0 top-1/2 -translate-y-1/2 p-1 hover:bg-gray-100 rounded-full transition">
            <svg class="w-7 h-7" fill="none" stroke="currentColor" viewBox="0 0 28 28">
              <path d="M21 7L7 21M7 7l14 14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
          </button>
          <p class="text-gray-600 mt-1">Thông tin sức khỏe và lịch sử khám bệnh</p>
        </div>

        <!-- Pet Info -->
        <div class="flex gap-4 mb-6">
          <img :src="pet.image" alt="Pet" class="w-24 h-24 rounded-xl object-cover">
          <div>
            <h3 class="text-amber-600 font-semibold text-lg">{{ pet.name }}</h3>
            <div class="grid grid-cols-2 gap-y-2 mt-2 text-sm">
              <div><span class="text-gray-500 font-medium">Giống:</span> <span class="font-semibold text-slate-900">{{ pet.breed }}</span></div>
              <div><span class="text-gray-500 font-medium">Tuổi:</span> <span class="font-semibold text-slate-900">{{ pet.age }}</span></div>
              <div><span class="text-gray-500 font-medium">Cân nặng:</span> <span class="font-semibold text-slate-900">{{ pet.weight }}</span></div>
              <div><span class="text-gray-500 font-medium">Giới tính:</span> <span class="font-semibold text-slate-900">{{ pet.gender }}</span></div>
            </div>
          </div>
        </div>

        <!-- Tabs -->
        <div class="bg-gray-200 rounded-2xl p-1 mb-6 flex">
          <button @click="tab = 'vaccination'" :class="{ 'bg-white shadow-sm': tab === 'vaccination' }" class="flex-1 py-2 rounded-2xl font-semibold text-sm transition">
            Lịch tiêm phòng
          </button>
          <button @click="tab = 'medical'" :class="{ 'bg-white shadow-sm': tab === 'medical' }" class="flex-1 py-2 rounded-2xl font-semibold text-sm transition">
            Bệnh án
          </button>
        </div>

        <!-- Tab Vaccination -->
        <div v-show="tab === 'vaccination'" class="space-y-4">
          <div v-for="v in pet.vaccinations" :key="v.date" class="border border-gray-300 rounded-xl p-4">
            <div class="flex justify-between items-center">
              <span class="font-semibold text-slate-900">{{ v.name }}</span>
              <span class="text-sm font-medium">{{ v.date }}</span>
            </div>
            <p class="text-gray-600 text-sm mt-1">Bác sĩ: {{ v.doctor }}</p>
          </div>

          <div v-if="pet.upcomingVaccination" class="bg-amber-50 border border-yellow-300 rounded-xl p-4">
            <div class="flex items-center gap-2 mb-1">
              <svg class="w-5 h-5" fill="none" stroke="#bb4d00" viewBox="0 0 16 16">
                <circle cx="8" cy="8" r="6" stroke-width="2"/>
                <path d="M8 5v3l2 2" stroke-width="2" stroke-linecap="round"/>
              </svg>
              <span class="font-bold text-orange-900">Lịch tiêm sắp tới</span>
            </div>
            <p class="font-bold text-orange-700">{{ pet.upcomingVaccination }}</p>
          </div>
        </div>

        <!-- Tab Medical -->
        <div v-show="tab === 'medical'" class="space-y-4">
          <div v-for="m in pet.medicalRecords" :key="m.date" class="border border-gray-300 rounded-xl p-4">
            <div class="flex justify-between items-center mb-1">
              <span class="font-semibold text-slate-900">{{ m.title }}</span>
              <span class="text-sm font-medium">{{ m.date }}</span>
            </div>
            <p class="text-gray-600 text-sm">Bác sĩ: {{ m.doctor }}</p>
            <p class="text-slate-700 font-medium text-sm">Ghi chú: {{ m.note }}</p>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex gap-3 mt-8">
          <button class="flex-1 bg-[#5a9690] text-white py-3 rounded-lg font-bold flex items-center justify-center gap-2 hover:opacity-90 transition">
            <svg class="w-5 h-5" fill="none" stroke="white" viewBox="0 0 16 16">
              <rect x="3" y="4" width="10" height="10" rx="1" stroke-width="2"/>
              <path d="M6 2v4M10 2v4M3 7h10" stroke-width="2" stroke-linecap="round"/>
            </svg>
            Đặt lịch khám lại
          </button>
          <button @click="openUpdatePopup" class="flex-1 border border-gray-400 py-3 rounded-lg font-bold flex items-center justify-center gap-2 hover:bg-gray-50 transition">
            <svg class="w-5 h-5" fill="none" stroke="black" viewBox="0 0 16 16">
              <path d="M11.333 2A2.667 2.667 0 0114 4.667v6.666A2.667 2.667 0 0111.333 14H4.667A2.667 2.667 0 012 11.333V4.667A2.667 2.667 0 014.667 2h6.666z" stroke-width="2"/>
              <path d="M10.667 6.667L7.333 10l-2-2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            Cập nhật thông tin
          </button>
        </div>

      </div>
    </div>
  </div>

  <!-- Update Pet Info Popup -->
  <div
    v-if="showUpdatePopup"
    class="fixed inset-0 z-[60] flex items-center justify-center bg-black/50 p-4"
    @click="closeUpdatePopup"
  >
    <div
      class="bg-white border border-black/15 rounded-[10px] shadow-2xl w-full max-w-[512px] max-h-[90vh] overflow-y-auto"
      @click.stop
    >
      <div class="p-6 flex flex-col gap-6">
        <!-- Header -->
        <div class="flex flex-col gap-2">
          <div class="h-7 relative">
            <div class="flex items-center justify-between">
              <h2 class="font-bold text-lg leading-7 text-black">
                Cập nhật hồ sơ {{ petData.name }}
              </h2>
              <button @click="closeUpdatePopup" class="w-7 h-7">
                <img :src="iconClose" alt="Close" class="w-full h-full" />
              </button>
            </div>
          </div>
          <p class="font-normal text-sm leading-6 text-gray-500">
            Chỉnh sửa thông tin định danh thú cưng
          </p>
        </div>

        <!-- Form Container -->
        <div class="flex flex-col gap-6">
          <!-- Form Fields with Pet Image -->
          <div class="bg-amber-50 border-2 border-amber-300 rounded-[10px] p-[18px] flex flex-col gap-4">
            <!-- Pet Image and Name/Breed -->
            <div class="flex gap-4">
              <!-- Pet Image -->
              <div class="relative w-24 h-24">
                <img
                  :src="petData.image || imgPetPlaceholder"
                  alt="Pet"
                  class="w-24 h-24 rounded-[10px] object-cover"
                />
                <div
                  class="absolute inset-0 bg-black/50 rounded-[10px] flex items-center justify-center opacity-0 hover:opacity-100 transition-opacity cursor-pointer"
                  @click="handleImageUpload"
                >
                  <div class="w-8 h-8">
                    <img :src="iconCamera" alt="Upload" class="w-full h-full" />
                  </div>
                </div>
              </div>

              <!-- Name and Breed Fields -->
              <div class="flex-1 flex flex-col gap-3">
                <!-- Name Field -->
                <div class="flex flex-col gap-1">
                  <label class="font-semibold text-sm leading-5 text-black">
                    Tên thú cưng
                    <span class="text-red-600">*</span>
                  </label>
                  <input
                    v-model="petData.name"
                    type="text"
                    placeholder="Milo"
                    class="bg-gray-50 border border-black/15 rounded-lg h-9 px-3 py-1 text-sm text-gray-500 focus:outline-none focus:ring-2 focus:ring-teal-500"
                  />
                </div>

                <!-- Breed Field -->
                <div class="flex flex-col gap-1">
                  <label class="font-semibold text-sm leading-5 text-black">
                    Giống
                  </label>
                  <input
                    v-model="petData.breed"
                    type="text"
                    placeholder="Golden Retriever"
                    class="bg-gray-50 border border-black/15 rounded-lg h-9 px-3 py-1 text-sm text-gray-500 focus:outline-none focus:ring-2 focus:ring-teal-500"
                  />
                </div>
              </div>
            </div>

            <!-- Birth Date Field -->
            <div class="flex flex-col gap-1">
              <label class="font-semibold text-sm leading-5 text-black">
                Ngày sinh
              </label>
              <button
                @click="handleDatePicker"
                class="bg-white border border-black/15 rounded-lg h-9 px-3 py-2 flex items-center gap-4 text-left hover:bg-gray-50 transition"
              >
                <div class="w-4 h-4">
                  <img :src="iconCalendar" alt="Calendar" class="w-full h-full" />
                </div>
                <span class="font-semibold text-sm leading-5 text-black">
                  {{ petData.birthDate || 'Chọn ngày sinh...' }}
                </span>
              </button>
            </div>

            <!-- Weight and Gender Grid -->
            <div class="grid grid-cols-2 gap-3">
              <!-- Weight Field -->
              <div class="flex flex-col gap-1">
                <label class="font-semibold text-sm leading-5 text-black">
                  Cân nặng (kg)
                  <span class="text-red-600">*</span>
                </label>
                <input
                  v-model="petData.weight"
                  type="number"
                  placeholder="28"
                  class="bg-gray-50 border border-black/15 rounded-lg h-9 px-3 py-1 text-sm text-gray-500 focus:outline-none focus:ring-2 focus:ring-teal-500"
                />
              </div>

              <!-- Gender Field -->
              <div class="flex flex-col gap-3">
                <label class="font-semibold text-sm leading-5 text-black">
                  Giới tính
                </label>
                <div class="flex items-center gap-4 h-4">
                  <!-- Male Radio -->
                  <div class="flex items-center gap-2">
                    <button
                      @click="petData.gender = 'male'"
                      class="w-4 h-4 rounded-full border border-black/15 flex items-center justify-center bg-transparent"
                    >
                      <div
                        v-if="petData.gender === 'male'"
                        class="w-2 h-2"
                      >
                        <img :src="iconCheck" alt="Check" class="w-full h-full" />
                      </div>
                    </button>
                    <label class="font-semibold text-sm leading-5 text-black">
                      Đực
                    </label>
                  </div>

                  <!-- Female Radio -->
                  <div class="flex items-center gap-2">
                    <button
                      @click="petData.gender = 'female'"
                      class="w-4 h-4 rounded-full border border-black/15 flex items-center justify-center bg-transparent"
                    >
                      <div
                        v-if="petData.gender === 'female'"
                        class="w-2 h-2"
                      >
                        <img :src="iconCheck" alt="Check" class="w-full h-full" />
                      </div>
                    </button>
                    <label class="font-semibold text-sm leading-5 text-black">
                      Cái
                    </label>
                  </div>
                </div>
              </div>
            </div>

            <!-- Warning Note -->
            <div class="bg-amber-50 border border-amber-500 rounded px-6 py-3 flex items-center gap-5">
              <p class="font-bold text-xs leading-4 text-amber-800">
                Lưu ý:
              </p>
              <p class="font-normal text-xs leading-4 text-amber-800">
                Cân nặng này là thông tin tham khảo. Cân nặng chính xác sẽ được đo bởi Bác sĩ trong mỗi lần khám.
              </p>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="flex gap-3">
            <button
              @click="closeUpdatePopup"
              class="flex-1 bg-white border border-black/15 rounded-lg h-9 flex items-center justify-center gap-2 hover:bg-gray-50 transition"
            >
              <div class="w-4 h-4">
                <img :src="iconCancel" alt="Cancel" class="w-full h-full" />
              </div>
              <span class="font-semibold text-sm leading-5 text-black text-center">
                Hủy bỏ
              </span>
            </button>
            <button
              @click="handleSave"
              class="flex-1 bg-[#5a9690] rounded-lg h-9 flex items-center justify-center gap-2 hover:opacity-90 transition"
            >
              <div class="w-4 h-4">
                <img :src="iconSave" alt="Save" class="w-full h-full" />
              </div>
              <span class="font-semibold text-sm leading-5 text-white text-center">
                Lưu thay đổi
              </span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue';

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: false
  },
  pet: {
    type: Object,
    default: () => ({})
  }
});

const emit = defineEmits(['close', 'save']);

// State for tabs and update popup
const tab = ref('vaccination');
const showUpdatePopup = ref(false);

// Icon URLs from Figma
const iconClose = "https://www.figma.com/api/mcp/asset/4d87fa33-ac2d-4cba-8927-955ccda358c0";
const iconCamera = "https://www.figma.com/api/mcp/asset/57dea092-4899-4f1c-8556-da10fb08401a";
const iconCalendar = "https://www.figma.com/api/mcp/asset/e8c3b0ec-1b26-4f96-b58b-70d919cfd525";
const iconCheck = "https://www.figma.com/api/mcp/asset/4c59f3ee-3346-4481-972a-039e25c57ba4";
const iconCancel = "https://www.figma.com/api/mcp/asset/fba839da-4b3e-4f65-af14-ae508ea8adae";
const iconSave = "https://www.figma.com/api/mcp/asset/a70f24d7-c94e-4805-a57e-19a2a7f84371";
const imgPetPlaceholder = "https://www.figma.com/api/mcp/asset/f456f1c3-8143-4157-a509-7e9742162fdd";

// Local pet data for editing
const petData = ref({
  name: '',
  breed: '',
  birthDate: '',
  weight: '',
  gender: 'male',
  image: ''
});

// Watch for prop changes and update local data
watch(
  () => props.pet,
  (newPet) => {
    if (newPet) {
      petData.value = {
        name: newPet.name || '',
        breed: newPet.breed || '',
        birthDate: newPet.birthDate || newPet.age || '',
        weight: newPet.weight || '',
        gender: newPet.gender === 'Cái' || newPet.gender === 'female' ? 'female' : 'male',
        image: newPet.image || ''
      };
    }
  },
  { immediate: true, deep: true }
);

const close = () => {
  emit('close');
};

const openUpdatePopup = () => {
  showUpdatePopup.value = true;
};

const closeUpdatePopup = () => {
  showUpdatePopup.value = false;
};

const handleImageUpload = () => {
  console.log('Handle image upload');
  // TODO: Implement image upload functionality
  alert('Chức năng tải ảnh đang được phát triển');
};

const handleDatePicker = () => {
  console.log('Handle date picker');
  // TODO: Implement date picker
  alert('Chức năng chọn ngày đang được phát triển');
};

const handleSave = () => {
  // Validate required fields
  if (!petData.value.name || !petData.value.weight) {
    alert('Vui lòng điền đầy đủ thông tin bắt buộc (Tên thú cưng, Cân nặng)');
    return;
  }

  // Emit save event with updated data
  emit('save', {
    ...petData.value,
    gender: petData.value.gender === 'male' ? 'Đực' : 'Cái'
  });
  
  console.log('Saving pet data:', petData.value);
  // Close update popup after save
  closeUpdatePopup();
};
</script>

<style scoped>
/* Custom styles for number input */
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

input[type="number"] {
  -moz-appearance: textfield;
  appearance: textfield;
}
</style>
