<template>
  <div class="flex flex-col gap-6 w-full h-full" style="font-family: 'Nunito Sans', sans-serif;">
    <!-- Header Section -->
    <div class="flex items-center justify-between h-[60px] w-full">
      <div class="flex flex-col">
        <h1 class="font-medium text-2xl text-[#101828] leading-9 tracking-[0.0703px]">Hồ sơ Bác sĩ</h1>
        <p class="font-normal text-base text-[#4a5565] leading-6 tracking-[-0.3125px]">
          Quản lý thông tin cá nhân và hồ sơ chuyên môn
        </p>
      </div>
    </div>

    <!-- Main Content Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-[362px_1fr] gap-4 w-full">
      <!-- Left Column - Profile Card -->
      <div class="bg-white border-2 border-[#cbfbf1] rounded-[14px] p-6 h-[457.5px]">
        <div class="flex flex-col items-center h-full">
          <!-- Profile Picture -->
          <div class="relative mb-6">
            <div class="w-32 h-32 rounded-full border-4 border-[#cbfbf1] overflow-hidden">
              <img 
                :src="doctorProfile.avatar || 'https://www.figma.com/api/mcp/asset/4af27492-9c88-43d5-b84b-905cf059ab56'" 
                alt="Doctor Avatar" 
                class="w-full h-full object-cover"
              />
            </div>
            <!-- Upload Button -->
            <button 
              @click="uploadAvatar"
              class="absolute bottom-0 right-0 w-10 h-10 bg-[#009689] rounded-full shadow-lg flex items-center justify-center hover:bg-[#007d72] transition-colors"
            >
              <svg class="w-5 h-5 text-white" viewBox="0 0 20 20" fill="currentColor">
                <path d="M10 3.5a1 1 0 011 1v4.5h4.5a1 1 0 110 2H11v4.5a1 1 0 11-2 0V11H4.5a1 1 0 110-2H9V4.5a1 1 0 011-1z"/>
              </svg>
            </button>
          </div>

          <!-- Name & Badge -->
          <div class="text-center mb-6">
            <h2 class="text-base text-[#101828] leading-6 tracking-[-0.3125px] mb-3">
              {{ doctorProfile.name }}
            </h2>
            <span class="inline-block px-3 py-1 bg-blue-100 text-[#1447e6] text-xs font-medium rounded-lg">
              {{ doctorProfile.role }}
            </span>
          </div>

          <!-- Work Status -->
          <div class="bg-gray-50 rounded-[10px] p-4 w-full mb-6 space-y-3">
            <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Trạng thái làm việc</label>
            <div class="flex items-center justify-between">
              <span class="text-sm text-[#364153] tracking-[-0.1504px]">
                {{ workStatus.active ? '🟢 Hoạt động' : '🔴 Không hoạt động' }}
              </span>
              <button 
                @click="toggleWorkStatus"
                :class="[
                  'w-8 h-[18.398px] rounded-full transition-colors',
                  workStatus.active ? 'bg-[#030213]' : 'bg-[#cbced4]'
                ]"
              >
                <div :class="[
                  'w-4 h-4 bg-white rounded-full transition-transform',
                  workStatus.active ? 'translate-x-[15px]' : 'translate-x-[1px]'
                ]"></div>
              </button>
            </div>
            <p class="text-xs text-[#6a7282] leading-4">
              Lễ tân có thể xếp lịch khám cho bạn
            </p>
          </div>

          <!-- Join Date -->
          <div class="border-t border-black/10 pt-4 w-full flex items-center gap-2">
            <svg class="w-4 h-4 text-[#4a5565]" viewBox="0 0 16 16" fill="currentColor">
              <path d="M11 2v2H5V2H3v2H2a1 1 0 00-1 1v9a1 1 0 001 1h12a1 1 0 001-1V5a1 1 0 00-1-1h-1V2h-2zM3 6h10v7H3V6z"/>
            </svg>
            <span class="text-sm text-[#4a5565] tracking-[-0.1504px]">
              Tham gia từ: {{ doctorProfile.joinDate }}
            </span>
          </div>
        </div>
      </div>

      <!-- Right Column - Tabs & Content -->
      <div class="flex flex-col gap-8">
        <!-- Tabs -->
        <div class="bg-[#ececf0] h-9 rounded-[14px] p-[3px] grid grid-cols-2 gap-1">
          <button 
            @click="activeTab = 'personal'"
            :class="[
              'h-[29px] rounded-[14px] text-sm font-medium text-gray-950 tracking-[-0.1504px] transition-colors flex items-center justify-center gap-2',
              activeTab === 'personal' ? 'bg-white' : ''
            ]"
          >
            <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
              <path d="M8 2a3 3 0 100 6 3 3 0 000-6zM4 11a3 3 0 00-3 3v1h14v-1a3 3 0 00-3-3H4z"/>
            </svg>
            Thông tin cá nhân
          </button>
          <button 
            @click="activeTab = 'professional'"
            :class="[
              'h-[29px] rounded-[14px] text-sm font-medium text-gray-950 tracking-[-0.1504px] transition-colors flex items-center justify-center gap-2',
              activeTab === 'professional' ? 'bg-white' : ''
            ]"
          >
            <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
              <path d="M3 2a1 1 0 00-1 1v10a1 1 0 001 1h10a1 1 0 001-1V3a1 1 0 00-1-1H3zm2 3h6v1H5V5zm0 3h6v1H5V8z"/>
            </svg>
            Hồ sơ chuyên môn
          </button>
        </div>

        <!-- Content Card -->
        <div class="bg-white border border-black/10 rounded-[14px] h-[441px]">
          <!-- Personal Information Tab -->
          <div v-if="activeTab === 'personal'" class="p-6">
            <h3 class="text-base text-gray-950 tracking-[-0.3125px] mb-6">
              Thông tin hành chính & Liên hệ
            </h3>

            <div class="space-y-4">
              <!-- Full Name -->
              <div class="space-y-2">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Họ và tên</label>
                <input 
                  v-model="personalInfo.fullName"
                  type="text" 
                  class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
              </div>

              <!-- Email (Disabled) -->
              <div class="space-y-2">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Email đăng nhập</label>
                <input 
                  v-model="personalInfo.email"
                  type="email" 
                  disabled
                  class="w-full h-9 px-3 py-1 bg-gray-50 border-0 rounded-lg text-sm text-gray-950 tracking-[-0.1504px] opacity-50 cursor-not-allowed"
                />
                <p class="text-xs text-[#6a7282] leading-4">
                  Email không thể thay đổi vì được dùng làm định danh
                </p>
              </div>

              <!-- Address -->
              <div class="space-y-2">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Địa chỉ</label>
                <textarea 
                  v-model="personalInfo.address"
                  placeholder="Nhập địa chỉ liên hệ"
                  class="w-full h-16 px-3 py-2 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] leading-5 tracking-[-0.1504px] resize-none focus:outline-none focus:ring-2 focus:ring-[#009689]"
                ></textarea>
              </div>

              <!-- Security Section -->
              <div class="border-t border-black/10 pt-4">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px] mb-4 block">
                  Bảo mật
                </label>
                <div class="flex items-center justify-between">
                  <button 
                    @click="showChangePasswordModal = true"
                    class="bg-white border border-black/10 h-9 px-3 rounded-lg flex items-center gap-2 text-sm font-medium text-gray-950 tracking-[-0.1504px] hover:bg-gray-50 transition-colors"
                  >
                    <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                      <path d="M8 2a3 3 0 00-3 3v1H4a1 1 0 00-1 1v6a1 1 0 001 1h8a1 1 0 001-1V7a1 1 0 00-1-1h-1V5a3 3 0 00-3-3zm0 2a1 1 0 011 1v1H7V5a1 1 0 011-1z"/>
                    </svg>
                    Đổi mật khẩu
                  </button>

                  <button 
                    @click="savePersonalInfo"
                    class="bg-[#009689] h-9 px-3 rounded-lg flex items-center gap-2 text-sm font-medium text-white tracking-[-0.1504px] hover:bg-[#007d72] transition-colors"
                  >
                    <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                      <path d="M13.854 3.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L6.5 10.293l6.646-6.647a.5.5 0 01.708 0z"/>
                    </svg>
                    Lưu thay đổi
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- Professional Information Tab -->
          <div v-if="activeTab === 'professional'" class="p-6">
            <h3 class="text-base text-gray-950 tracking-[-0.3125px] mb-6">
              Hồ sơ chuyên môn
            </h3>

            <div class="space-y-4">
              <!-- License Number -->
              <div class="space-y-2">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Số chứng chỉ hành nghề</label>
                <input 
                  v-model="professionalInfo.licenseNumber"
                  type="text" 
                  placeholder="Nhập số chứng chỉ"
                  class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
              </div>

              <!-- Specialization -->
              <div class="space-y-2">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Chuyên môn</label>
                <input 
                  v-model="professionalInfo.specialization"
                  type="text" 
                  placeholder="VD: Phẫu thuật, Nội khoa..."
                  class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
              </div>

              <!-- Years of Experience -->
              <div class="space-y-2">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Số năm kinh nghiệm</label>
                <input 
                  v-model="professionalInfo.yearsOfExperience"
                  type="number" 
                  placeholder="VD: 5"
                  class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-[#009689]"
                />
              </div>

              <!-- Qualifications -->
              <div class="space-y-2">
                <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Bằng cấp & Chứng chỉ</label>
                <textarea 
                  v-model="professionalInfo.qualifications"
                  placeholder="Liệt kê các bằng cấp, chứng chỉ..."
                  class="w-full h-16 px-3 py-2 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] leading-5 tracking-[-0.1504px] resize-none focus:outline-none focus:ring-2 focus:ring-[#009689]"
                ></textarea>
              </div>

              <!-- Save Button -->
              <div class="border-t border-black/10 pt-4 flex justify-end">
                <button 
                  @click="saveProfessionalInfo"
                  class="bg-[#009689] h-9 px-3 rounded-lg flex items-center gap-2 text-sm font-medium text-white tracking-[-0.1504px] hover:bg-[#007d72] transition-colors"
                >
                  <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                    <path d="M13.854 3.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3.5-3.5a.5.5 0 11.708-.708L6.5 10.293l6.646-6.647a.5.5 0 01.708 0z"/>
                  </svg>
                  Lưu thay đổi
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Change Password Modal -->
    <transition name="fade">
      <div 
        v-if="showChangePasswordModal" 
        class="fixed inset-0 bg-black/50 flex items-center justify-center z-50"
        @click.self="showChangePasswordModal = false"
      >
        <div class="bg-white rounded-[14px] p-6 w-full max-w-md space-y-4">
          <div class="flex items-center justify-between mb-4">
            <h3 class="text-lg font-medium text-gray-950">Đổi mật khẩu</h3>
            <button 
              @click="showChangePasswordModal = false"
              class="text-gray-400 hover:text-gray-600"
            >
              <svg class="w-5 h-5" viewBox="0 0 20 20" fill="currentColor">
                <path d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"/>
              </svg>
            </button>
          </div>

          <div class="space-y-4">
            <div class="space-y-2">
              <label class="font-medium text-sm text-gray-950">Mật khẩu hiện tại</label>
              <input 
                v-model="passwordChange.current"
                type="password" 
                class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
            </div>

            <div class="space-y-2">
              <label class="font-medium text-sm text-gray-950">Mật khẩu mới</label>
              <input 
                v-model="passwordChange.new"
                type="password" 
                class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
            </div>

            <div class="space-y-2">
              <label class="font-medium text-sm text-gray-950">Xác nhận mật khẩu mới</label>
              <input 
                v-model="passwordChange.confirm"
                type="password" 
                class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#009689]"
              />
            </div>
          </div>

          <div class="flex gap-3 pt-4">
            <button 
              @click="showChangePasswordModal = false"
              class="flex-1 h-9 bg-white border border-black/10 rounded-lg text-sm font-medium text-gray-950 hover:bg-gray-50 transition-colors"
            >
              Hủy
            </button>
            <button 
              @click="changePassword"
              class="flex-1 h-9 bg-[#009689] rounded-lg text-sm font-medium text-white hover:bg-[#007d72] transition-colors"
            >
              Xác nhận
            </button>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: 'TrangCaNhan',
  data() {
    return {
      // Active Tab
      activeTab: 'personal', // 'personal' or 'professional'

      // Doctor Profile
      doctorProfile: {
        avatar: 'https://www.figma.com/api/mcp/asset/4af27492-9c88-43d5-b84b-905cf059ab56',
        name: 'BS. Nguyễn Văn A',
        role: 'Bác sĩ chính',
        joinDate: '20/11/2023'
      },

      // Work Status
      workStatus: {
        active: true
      },

      // Personal Information
      personalInfo: {
        fullName: 'BS. Nguyễn Văn A',
        email: 'nguyenvana@vietvetclinic.com',
        address: ''
      },

      // Professional Information
      professionalInfo: {
        licenseNumber: '',
        specialization: '',
        yearsOfExperience: null,
        qualifications: ''
      },

      // Password Change Modal
      showChangePasswordModal: false,
      passwordChange: {
        current: '',
        new: '',
        confirm: ''
      }
    };
  },

  methods: {
    // Toggle Work Status
    toggleWorkStatus() {
      this.workStatus.active = !this.workStatus.active;
      // TODO: Update work status in backend
      console.log('Work status changed:', this.workStatus.active);
    },

    // Upload Avatar
    uploadAvatar() {
      // TODO: Implement file upload
      console.log('Upload avatar clicked');
      // Create file input programmatically
      const input = document.createElement('input');
      input.type = 'file';
      input.accept = 'image/*';
      input.onchange = (e) => {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = (event) => {
            this.doctorProfile.avatar = event.target.result;
            // TODO: Upload to server
          };
          reader.readAsDataURL(file);
        }
      };
      input.click();
    },

    // Save Personal Information
    savePersonalInfo() {
      console.log('Saving personal info:', this.personalInfo);
      // TODO: Implement API call to save personal information
      alert('Thông tin cá nhân đã được lưu!');
    },

    // Save Professional Information
    saveProfessionalInfo() {
      console.log('Saving professional info:', this.professionalInfo);
      // TODO: Implement API call to save professional information
      alert('Hồ sơ chuyên môn đã được lưu!');
    },

    // Change Password
    changePassword() {
      if (this.passwordChange.new !== this.passwordChange.confirm) {
        alert('Mật khẩu xác nhận không khớp!');
        return;
      }

      if (this.passwordChange.new.length < 6) {
        alert('Mật khẩu mới phải có ít nhất 6 ký tự!');
        return;
      }

      console.log('Changing password...');
      // TODO: Implement API call to change password
      this.showChangePasswordModal = false;
      this.passwordChange = {
        current: '',
        new: '',
        confirm: ''
      };
      alert('Mật khẩu đã được thay đổi thành công!');
    }
  },

  mounted() {
    // TODO: Load doctor profile data from API
    console.log('Doctor profile page mounted');
  }
};
</script>

<style scoped>
/* Import Nunito Sans font */
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;500;600;700&display=swap');

/* Fade transition for modal */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
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

/* Input focus styles */
input:focus,
textarea:focus {
  outline: none;
}

/* Disabled input styles */
input:disabled {
  cursor: not-allowed;
}

/* Button hover effects */
button {
  transition: all 0.2s ease;
}

button:active {
  transform: scale(0.98);
}
</style>