<template>
  <div 
    class="bg-white rounded-[10px] shadow-[0px_20px_25px_-5px_rgba(0,0,0,0.1),0px_8px_10px_-6px_rgba(0,0,0,0.1)] w-full max-w-[480px] overflow-hidden" 
    style="font-family: 'Nunito Sans', sans-serif;"
  >
    <div class="flex flex-col gap-4 p-6 pb-0">
      <!-- Modal Title -->
      <h2 class="text-lg text-[#101828] leading-7 tracking-[-0.4395px] font-normal">
        THÊM KHÁCH HÀNG & BỆNH NHÂN MỚI
      </h2>

      <!-- Form Content -->
      <div class="flex flex-col gap-6">
        <!-- Section 1: Owner Information -->
        <div class="flex flex-col gap-3">
          <!-- Section Header -->
          <div class="flex items-center gap-2 border-b border-black/10 pb-1">
            <svg class="w-4 h-4 text-[#009689]" viewBox="0 0 16 16" fill="currentColor">
              <path d="M8 2a3 3 0 100 6 3 3 0 000-6zM4 11a3 3 0 00-3 3v1h14v-1a3 3 0 00-3-3H4z"/>
            </svg>
            <h3 class="text-sm text-[#101828] leading-5 tracking-[-0.1504px] font-normal">
              1. Thông tin Chủ nuôi
            </h3>
          </div>

          <!-- Phone Number -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px] flex items-center gap-1">
              Số điện thoại
              <span class="text-[#fb2c36]">*</span>
            </label>
            <div class="relative">
              <input 
                v-model="formData.owner.phone"
                type="tel" 
                placeholder="09xxxxxxxx"
                class="w-full h-9 pl-10 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
                @input="validatePhone"
              />
              <svg class="w-4 h-4 absolute left-3 top-2.5 text-gray-400" viewBox="0 0 16 16" fill="currentColor">
                <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328z"/>
              </svg>
            </div>
            <p v-if="errors.phone" class="text-xs text-[#fb2c36]">{{ errors.phone }}</p>
          </div>

          <!-- Full Name -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px] flex items-center gap-1">
              Họ và tên
              <span class="text-[#fb2c36]">*</span>
            </label>
            <div class="relative">
              <input 
                v-model="formData.owner.fullName"
                type="text" 
                placeholder="Nguyễn Văn A"
                class="w-full h-9 pl-10 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
              <svg class="w-4 h-4 absolute left-3 top-2.5 text-gray-400" viewBox="0 0 16 16" fill="currentColor">
                <path d="M8 8a3 3 0 100-6 3 3 0 000 6zM12.93 11.07A9.953 9.953 0 018 10c-1.85 0-3.58.5-5.07 1.37A3.98 3.98 0 001 14.5V16h14v-1.5c0-1.24-.57-2.35-1.46-3.08l-.61-.35z"/>
              </svg>
            </div>
            <p v-if="errors.fullName" class="text-xs text-[#fb2c36]">{{ errors.fullName }}</p>
          </div>

          <!-- Address -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px] flex items-center gap-1">
              Địa chỉ
              <span class="text-sm font-medium text-[#6a7282]">(Có thể bỏ qua)</span>
            </label>
            <div class="relative">
              <input 
                v-model="formData.owner.address"
                type="text" 
                placeholder="Quận 1, TP.HCM"
                class="w-full h-9 pl-10 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
              <svg class="w-4 h-4 absolute left-3 top-2.5 text-gray-400" viewBox="0 0 16 16" fill="currentColor">
                <path d="M8 0a6 6 0 00-6 6c0 4.5 6 10 6 10s6-5.5 6-10a6 6 0 00-6-6zm0 8a2 2 0 110-4 2 2 0 010 4z"/>
              </svg>
            </div>
          </div>
        </div>

        <!-- Section 2: Pet Information -->
        <div class="flex flex-col gap-3">
          <!-- Section Header -->
          <div class="flex items-center gap-2 border-b border-black/10 pb-1">
            <svg class="w-4 h-4 text-[#009689]" viewBox="0 0 16 16" fill="currentColor">
              <path d="M4 5.5a2.5 2.5 0 115 0 2.5 2.5 0 01-5 0zM3.5 2.5a2 2 0 114 0 2 2 0 01-4 0zM10.5 2.5a2 2 0 114 0 2 2 0 01-4 0zM11 5.5a2.5 2.5 0 115 0 2.5 2.5 0 01-5 0zM5.5 11a3.5 3.5 0 107 0H16v3.5a1.5 1.5 0 01-1.5 1.5h-13A1.5 1.5 0 010 14.5V11h5.5z"/>
            </svg>
            <h3 class="text-sm text-[#101828] leading-5 tracking-[-0.1504px] font-normal">
              2. Thông tin Thú cưng
            </h3>
          </div>

          <!-- Pet Name -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px] flex items-center gap-1">
              Tên thú cưng
              <span class="text-[#fb2c36]">*</span>
            </label>
            <input 
              v-model="formData.pet.name"
              type="text" 
              placeholder="Milo, Kitty, Luna..."
              class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
            <p v-if="errors.petName" class="text-xs text-[#fb2c36]">{{ errors.petName }}</p>
          </div>

          <!-- Species/Breed -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">
              Giống loài
            </label>
            <input 
              v-model="formData.pet.breed"
              type="text" 
              placeholder="Chó Golden Retriever, Mèo Anh lông ngắn..."
              class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
            />
          </div>

          <!-- Weight & Age -->
          <div class="grid grid-cols-2 gap-3">
            <!-- Weight -->
            <div class="space-y-2">
              <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">
                Cân nặng
              </label>
              <div class="relative">
                <input 
                  v-model="formData.pet.weight"
                  type="text" 
                  placeholder="3 kg"
                  class="w-full h-9 pl-10 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
                <svg class="w-4 h-4 absolute left-3 top-2.5 text-gray-400" viewBox="0 0 16 16" fill="currentColor">
                  <path d="M2 3a1 1 0 011-1h10a1 1 0 011 1v1a1 1 0 01-1 1H3a1 1 0 01-1-1V3zm0 4v6a2 2 0 002 2h8a2 2 0 002-2V7H2zm3 2a1 1 0 112 0v3a1 1 0 11-2 0V9zm4-1a1 1 0 011 1v3a1 1 0 11-2 0V9a1 1 0 011-1z"/>
                </svg>
              </div>
            </div>

            <!-- Age -->
            <div class="space-y-2">
              <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">
                Tuổi
              </label>
              <div class="relative">
                <input 
                  v-model="formData.pet.age"
                  type="text" 
                  placeholder="2 tuổi"
                  class="w-full h-9 pl-10 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
                <svg class="w-4 h-4 absolute left-3 top-2.5 text-gray-400" viewBox="0 0 16 16" fill="currentColor">
                  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3.5a.5.5 0 0 1-.5-.5v-4a.5.5 0 0 1 .5-.5z"/>
                </svg>
              </div>
            </div>
          </div>

          <!-- Gender -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">
              Giới tính
            </label>
            <div class="flex items-center gap-4">
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  v-model="formData.pet.gender"
                  type="radio" 
                  value="male"
                  class="w-4 h-4 text-[#009689] border-gray-300 focus:ring-2 focus:ring-[#009689]"
                />
                <span class="text-sm font-medium text-gray-950 tracking-[-0.1504px]">Đực</span>
              </label>
              <label class="flex items-center gap-2 cursor-pointer">
                <input 
                  v-model="formData.pet.gender"
                  type="radio" 
                  value="female"
                  class="w-4 h-4 text-[#009689] border-gray-300 focus:ring-2 focus:ring-[#009689]"
                />
                <span class="text-sm font-medium text-gray-950 tracking-[-0.1504px]">Cái</span>
              </label>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Footer -->
    <div class="flex items-center justify-end gap-2 h-9 px-6 pb-6 pt-4">
      <button 
        @click="handleCancel"
        class="bg-white border border-black/10 h-9 px-4 rounded-lg text-sm font-medium text-gray-950 tracking-[-0.1504px] hover:bg-gray-50 transition-colors"
      >
        Hủy
      </button>
      <button 
        @click="handleSave"
        :disabled="!isFormValid"
        :class="[
          'bg-[#009689] h-9 px-4 rounded-lg text-sm font-medium text-white tracking-[-0.1504px] transition-colors',
          isFormValid ? 'hover:bg-[#007d72]' : 'opacity-50 cursor-not-allowed'
        ]"
      >
        ✅ Lưu & Bắt đầu khám
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ThemBenhNhan',
  data() {
    return {
      formData: {
        owner: {
          phone: '',
          fullName: '',
          address: ''
        },
        pet: {
          name: '',
          breed: '',
          weight: '',
          age: '',
          gender: ''
        }
      },
      errors: {
        phone: '',
        fullName: '',
        petName: ''
      }
    };
  },

  computed: {
    isFormValid() {
      return (
        this.formData.owner.phone.trim() !== '' &&
        this.formData.owner.fullName.trim() !== '' &&
        this.formData.pet.name.trim() !== '' &&
        !this.errors.phone &&
        !this.errors.fullName &&
        !this.errors.petName
      );
    }
  },

  methods: {
    // Validate phone number
    validatePhone() {
      const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
      if (!this.formData.owner.phone) {
        this.errors.phone = '';
      } else if (!phoneRegex.test(this.formData.owner.phone)) {
        this.errors.phone = 'Số điện thoại không hợp lệ';
      } else {
        this.errors.phone = '';
      }
    },

    // Validate form
    validateForm() {
      let isValid = true;

      // Validate phone
      if (!this.formData.owner.phone.trim()) {
        this.errors.phone = 'Vui lòng nhập số điện thoại';
        isValid = false;
      } else {
        this.validatePhone();
        if (this.errors.phone) {
          isValid = false;
        }
      }

      // Validate full name
      if (!this.formData.owner.fullName.trim()) {
        this.errors.fullName = 'Vui lòng nhập họ và tên';
        isValid = false;
      } else {
        this.errors.fullName = '';
      }

      // Validate pet name
      if (!this.formData.pet.name.trim()) {
        this.errors.petName = 'Vui lòng nhập tên thú cưng';
        isValid = false;
      } else {
        this.errors.petName = '';
      }

      return isValid;
    },

    // Handle cancel
    handleCancel() {
      this.$emit('cancel');
      this.resetForm();
    },

    // Handle save
    async handleSave() {
      if (!this.validateForm()) {
        return;
      }

      const patientData = {
        owner: {
          phone: this.formData.owner.phone,
          fullName: this.formData.owner.fullName,
          address: this.formData.owner.address || null
        },
        pet: {
          name: this.formData.pet.name,
          breed: this.formData.pet.breed || null,
          weight: this.formData.pet.weight || null,
          age: this.formData.pet.age || null,
          gender: this.formData.pet.gender || null
        }
      };

      console.log('Saving patient data:', patientData);
      
      // TODO: Implement API call to save patient data
      this.$emit('save', patientData);
      
      // Navigate to examination page or show success message
      // this.$router.push({ name: 'PhieuKhamBenh', params: { patientId: newPatientId } });
      
      this.resetForm();
    },

    // Reset form
    resetForm() {
      this.formData = {
        owner: {
          phone: '',
          fullName: '',
          address: ''
        },
        pet: {
          name: '',
          breed: '',
          weight: '',
          age: '',
          gender: ''
        }
      };
      this.errors = {
        phone: '',
        fullName: '',
        petName: ''
      };
    }
  }
};
</script>

<style scoped>
/* Import Nunito Sans font */
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;500;600;700&display=swap');

/* Custom radio button styling */
input[type="radio"] {
  appearance: none;
  width: 16px;
  height: 16px;
  border: 2px solid #d1d5db;
  border-radius: 50%;
  outline: none;
  cursor: pointer;
  position: relative;
  transition: all 0.2s ease;
}

input[type="radio"]:checked {
  border-color: #009689;
  background-color: #009689;
}

input[type="radio"]:checked::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background-color: white;
}

input[type="radio"]:focus {
  box-shadow: 0 0 0 3px rgba(0, 150, 137, 0.2);
}

/* Input focus styles */
input:focus {
  outline: none;
}

/* Disabled button styles */
button:disabled {
  cursor: not-allowed;
}

/* Button hover effects */
button:not(:disabled):active {
  transform: scale(0.98);
}

/* Smooth transitions */
* {
  transition-property: background-color, border-color, color, fill, stroke;
  transition-duration: 200ms;
  transition-timing-function: ease;
}

/* Error text animation */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-5px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.text-\[\#fb2c36\] {
  animation: fadeIn 0.3s ease;
}
</style>