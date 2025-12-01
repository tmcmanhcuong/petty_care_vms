<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[1000] pt-24">
    <div class="bg-white border border-gray-200/60 rounded-[10px] shadow-xl w-[495px] max-h-[85vh] overflow-y-auto">
      <div class="p-6 flex flex-col gap-4">
        <!-- Header -->
        <div class="flex flex-col gap-2">
          <h2 class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight">
            Chi tiết Nhân viên
          </h2>
          <p class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">
            Thông tin đầy đủ về nhân viên
          </p>
        </div>

        <!-- Content -->
        <div class="flex flex-col">
          <!-- Avatar -->
          <div class="flex justify-center mb-6">
            <div class="border-4 border-[#cbfbf1] rounded-full w-24 h-24 overflow-hidden">
              <img :src="staff.avatar" alt="Avatar" class="w-full h-full object-cover" />
            </div>
          </div>

          <!-- Basic Information Section -->
          <div class="flex flex-col gap-3 mb-6">
            <div class="flex items-center gap-3 h-5">
              <div class="bg-[#009689] w-1 h-5 rounded"></div>
              <h3 class="font-nunito font-medium text-sm leading-5 text-[#101828] tracking-tight">
                Thông tin cơ bản
              </h3>
            </div>
            <div class="bg-gray-50 rounded-[10px] p-4 grid grid-cols-2 gap-4">
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Họ và tên</span>
                <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.name }}</span>
              </div>
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Email</span>
                <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.email }}</span>
              </div>
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Số điện thoại</span>
                <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.phone }}</span>
              </div>
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Địa chỉ</span>
                <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.address }}</span>
              </div>
            </div>
          </div>

          <!-- Role & Assignment Section -->
          <div class="flex flex-col gap-3 mb-6">
            <div class="flex items-center gap-3 h-5">
              <div class="bg-[#009689] w-1 h-5 rounded"></div>
              <h3 class="font-nunito font-medium text-sm leading-5 text-[#101828] tracking-tight">
                Vai trò & Phân công
              </h3>
            </div>
            <div class="bg-gray-50 rounded-[10px] p-4 flex flex-col gap-4">
              <div class="grid grid-cols-2 gap-4">
                <div class="flex flex-col">
                  <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Vai trò hệ thống</span>
                  <div class="mt-2">
                    <span
                      v-for="(role, index) in staff.roles"
                      :key="index"
                      :class="[
                        'inline-flex items-center justify-center px-2 py-[3px] rounded-lg text-xs leading-4 font-nunito font-medium mr-1',
                        role.color === 'blue' ? 'bg-blue-50 border border-[#8ec5ff] text-[#1447e6]' :
                        role.color === 'green' ? 'bg-green-100 text-[#008236]' :
                        'bg-purple-100 text-[#8200db]'
                      ]"
                    >
                      {{ role.name }}
                    </span>
                  </div>
                </div>
              </div>
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Chức danh</span>
                <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.position }}</span>
              </div>
            </div>
          </div>

          <!-- Education & Experience Section -->
          <div class="flex flex-col gap-3 mb-6">
            <div class="flex items-center gap-3 h-5">
              <div class="bg-[#009689] w-1 h-5 rounded"></div>
              <h3 class="font-nunito font-medium text-sm leading-5 text-[#101828] tracking-tight">
                Trình độ & Kinh nghiệm
              </h3>
            </div>
            <div class="bg-gray-50 rounded-[10px] p-4 flex flex-col gap-4">
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Năm kinh nghiệm</span>
                <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.yearsOfExperience }} năm</span>
              </div>
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight mb-2">Chứng chỉ hành nghề</span>
                <button
                  v-if="staff.practiceCertificate"
                  class="bg-white border border-[#96f7e4] rounded-lg h-8 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors"
                >
                  <img :src="iconDocument" alt="Document" class="w-4 h-4" />
                  <span class="font-nunito font-medium text-sm leading-5 text-[#009689] tracking-tight">
                    {{ staff.practiceCertificate }}
                  </span>
                </button>
                <span v-else class="font-nunito text-sm leading-5 text-[#6a7282] tracking-tight">Chưa cập nhật</span>
              </div>
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight mb-2">Bằng cấp chuyên môn</span>
                <button
                  v-if="staff.professionalDegree"
                  class="bg-white border border-[#96f7e4] rounded-lg h-8 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors"
                >
                  <img :src="iconDocument" alt="Document" class="w-4 h-4" />
                  <span class="font-nunito font-medium text-sm leading-5 text-[#009689] tracking-tight">
                    {{ staff.professionalDegree }}
                  </span>
                </button>
                <span v-else class="font-nunito text-sm leading-5 text-[#6a7282] tracking-tight">Chưa cập nhật</span>
              </div>
            </div>
          </div>

          <!-- Account Status Section -->
          <div class="flex flex-col gap-3">
            <div class="flex items-center gap-3 h-5">
              <div class="bg-[#009689] w-1 h-5 rounded"></div>
              <h3 class="font-nunito font-medium text-sm leading-5 text-[#101828] tracking-tight">
                Trạng thái Tài khoản
              </h3>
            </div>
            <div class="bg-gray-50 rounded-[10px] p-4 flex flex-col gap-4">
              <div class="grid grid-cols-2 gap-4">
                <div class="flex flex-col">
                  <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Ngày gia nhập</span>
                  <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.joinDate }}</span>
                </div>
                <div class="flex flex-col">
                  <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Trạng thái</span>
                  <span
                    :class="[
                      'inline-flex items-center gap-2 px-2 py-[3px] rounded-lg text-xs leading-4 font-nunito font-medium mt-[1px] w-fit',
                      staff.status === 'active' ? 'bg-green-100 text-[#008236]' : 'bg-gray-100 text-[#364153]'
                    ]"
                  >
                    <img :src="staff.status === 'active' ? iconCheck : iconX" alt="" class="w-3 h-3" />
                    {{ staff.status === 'active' ? 'Hoạt động' : 'Đã khóa' }}
                  </span>
                </div>
              </div>
              <div class="flex flex-col">
                <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">Lần đăng nhập cuối</span>
                <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ staff.lastLogin }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Footer Buttons -->
        <div class="flex items-center justify-end gap-2 mt-4">
          <button
            @click="$emit('close')"
            class="bg-white border border-gray-200/60 rounded-lg h-9 px-[17px] py-[9px] hover:bg-gray-50 transition-colors"
          >
            <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Đóng</span>
          </button>
          <button
            @click="$emit('edit')"
            class="bg-[#009689] rounded-lg h-9 px-4 py-2 hover:bg-[#007d72] transition-colors"
          >
            <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">Chỉnh sửa</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
// Props
const props = defineProps({
  staff: {
    type: Object,
    default: () => ({
      avatar: 'https://www.figma.com/api/mcp/asset/192ea54b-05f0-477e-b541-a07eb038b747',
      name: 'BS. Nguyễn Văn A',
      email: 'bsnguyen@vcms.vn',
      phone: '0901234567',
      address: '123 Nguyễn Huệ, Quận 1, TP.HCM',
      roles: [
        { name: 'Bác sĩ', color: 'blue' }
      ],
      department: 'Khoa Nội',
      position: 'Bác sĩ chuyên khoa cấp I',
      yearsOfExperience: 8,
      practiceCertificate: 'Chứng chỉ hành nghề số 12345.pdf',
      professionalDegree: 'Bằng Bác sĩ Đa khoa - ĐH Y Hà Nội.pdf',
      joinDate: '2024-01-15',
      status: 'active',
      lastLogin: 'Vừa xong'
    })
  }
})

// Emits
const emit = defineEmits(['close', 'edit'])

// Icons (from Figma - expire in 7 days)
const iconDocument = "https://www.figma.com/api/mcp/asset/1999c559-f5f3-4ca8-9746-18cb477ea7ae"
const iconCheck = "https://www.figma.com/api/mcp/asset/88e79f47-07af-4ad7-9625-fd73fe0e00fe"
const iconX = "https://www.figma.com/api/mcp/asset/1d86c67f-830e-4ef0-a6fe-45849993acf4"
</script>

<style scoped>
/* Custom scrollbar for modal */
div::-webkit-scrollbar {
  width: 8px;
}

div::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

div::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

div::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>
