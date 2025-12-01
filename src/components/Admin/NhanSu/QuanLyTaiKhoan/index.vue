<template>
  <div class="w-full min-h-screen p-6">
    <!-- Header -->
    <div class="mb-8">
      <h1 class="font-nunito font-medium text-2xl leading-9 text-[#101828] tracking-tight mb-0">
        Quản lý Người dùng
      </h1>
      <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
        Quản lý tài khoản nhân viên và khách hàng
      </p>
    </div>

    <!-- Content -->
    <div class="flex flex-col gap-8">
      <!-- Tabs -->
      <div class="bg-[#f3f4f6] flex items-center p-1 rounded-[10px] shadow-sm w-fit">
        <button
          @click="activeTab = 'staff'"
          :class="activeTab === 'staff' ? 'bg-white shadow-md text-[#0d9488]' : 'text-[#4b5563]'"
          class="font-nunito font-medium text-sm leading-5 px-6 py-2.5 rounded-lg transition-all"
        >
          Danh sách Nhân viên
        </button>
        <button
          @click="activeTab = 'customer'"
          :class="activeTab === 'customer' ? 'bg-white shadow-md text-[#0d9488]' : 'text-[#4b5563]'"
          class="font-nunito font-medium text-sm leading-5 px-6 py-2.5 rounded-lg transition-all"
        >
          Danh sách Khách hàng
        </button>
      </div>

      <!-- Staff List -->
      <div v-if="activeTab === 'staff'" class="bg-white border border-gray-200/60 rounded-[14px] p-6">
        <!-- Card Header -->
        <div class="flex items-center justify-between mb-6">
          <h2 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight">
            Danh sách Nhân viên
          </h2>
          <button 
            class="bg-[#009689] rounded-lg h-9 px-3 py-2 flex items-center gap-2 hover:bg-[#007d72] transition-colors"
            @click="isAddStaffModalOpen = true"
          >
            <img :src="iconPlus" alt="Add" class="w-4 h-4" />
            <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">Tạo tài khoản mới</span>
          </button>
        </div>

        <!-- Search and Filter -->
        <div class="flex items-center gap-4 mb-6">
          <div class="flex-1 relative">
            <img :src="iconSearch" alt="Search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4" />
            <input
              v-model="staffSearchQuery"
              type="text"
              placeholder="Tìm theo tên, SĐT, email..."
              class="w-full bg-[#f3f3f5] border-none rounded-lg h-9 pl-10 pr-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
            />
          </div>
          <button class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-[1px] flex items-center justify-between gap-2 min-w-[192px]">
            <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">Tất cả</span>
            <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
          </button>
        </div>

        <!-- Staff Table -->
        <div class="overflow-x-auto mb-6">
          <table class="w-full">
            <thead>
              <tr class="border-b border-gray-200/60">
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Nhân viên</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thông tin liên hệ</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Vai trò</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Ngày vào làm</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Trạng thái</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Lần đăng nhập cuối</th>
                <th class="text-right py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="staff in staffList" :key="staff.id" class="border-b border-gray-200/60">
                <td class="py-3 px-2">
                  <div class="flex items-center gap-3">
                    <img :src="staff.avatar" alt="" class="w-10 h-10 rounded-full object-cover" />
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ staff.name }}</span>
                  </div>
                </td>
                <td class="py-3 px-2">
                  <div class="flex flex-col">
                    <span class="font-nunito text-sm leading-6 text-[#101828] tracking-tight">{{ staff.email }}</span>
                    <span class="font-nunito text-sm leading-6 text-[#6a7282] tracking-tight">{{ staff.phone }}</span>
                  </div>
                </td>
                <td class="py-3 px-2">
                  <div class="flex flex-col gap-1">
                    <span
                      v-for="(role, index) in staff.roles"
                      :key="index"
                      :class="[
                        'inline-flex items-center justify-center px-2 py-[3px] rounded-lg text-xs leading-4 font-nunito font-medium w-fit',
                        role.color === 'blue' ? 'bg-blue-100 text-[#1447e6]' :
                        role.color === 'green' ? 'bg-green-100 text-[#008236]' :
                        role.color === 'purple' ? 'bg-purple-100 text-[#8200db]' :
                        'bg-[#ffe2e2] text-[#c10007]'
                      ]"
                    >
                      {{ role.name }}
                    </span>
                  </div>
                </td>
                <td class="py-3 px-2">
                  <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ staff.joinDate }}</span>
                </td>
                <td class="py-3 px-2">
                  <span
                    :class="[
                      'inline-flex items-center gap-2 px-2 py-[3px] rounded-lg text-xs leading-4 font-nunito font-medium',
                      staff.status === 'active' ? 'bg-green-100 text-[#008236]' : 'bg-gray-100 text-[#364153]'
                    ]"
                  >
                    <img :src="staff.status === 'active' ? iconCheck : iconX" alt="" class="w-3 h-3" />
                    {{ staff.status === 'active' ? 'Hoạt động' : 'Đã khóa' }}
                  </span>
                </td>
                <td class="py-3 px-2">
                  <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ staff.lastLogin }}</span>
                </td>
                <td class="py-3 px-2">
                  <div class="flex items-center justify-end gap-2">
                    <button 
                      class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
                      @click="handleViewStaff(staff)"
                    >
                      <img :src="iconEye" alt="View" class="w-4 h-4" />
                    </button>
                    <button 
                      class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
                      @click="handleOpenResetPassword(staff)"
                    >
                      <img :src="iconTrash" alt="Reset Password" class="w-4 h-4" />
                    </button>
                    <button
                      v-if="staff.status === 'active'"
                      class="bg-white border border-gray-200/60 rounded-lg px-3 h-8 hover:bg-gray-50 transition-colors"
                    >
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Khóa</span>
                    </button>
                    <button
                      v-else
                      class="bg-[#00a63e] rounded-lg px-3 h-8 hover:bg-[#008c35] transition-colors"
                    >
                      <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">Kích hoạt</span>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Pagination -->
        <div class="flex items-center justify-between">
          <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
            Hiển thị 1 - {{ staffList.length }} của {{ staffList.length }} nhân viên
          </p>
          <div class="flex items-center gap-1">
            <button class="opacity-50 rounded-lg h-9 px-3 py-2 flex items-center gap-2" disabled>
              <img :src="iconChevronLeft" alt="Previous" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Previous</span>
            </button>
            <button class="bg-white border border-gray-200/60 rounded-lg w-9 h-9 flex items-center justify-center">
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">1</span>
            </button>
            <button class="opacity-50 rounded-lg h-9 px-3 py-2 flex items-center gap-2" disabled>
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Next</span>
              <img :src="iconChevronRight" alt="Next" class="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>

      <!-- Customer List -->
      <div v-if="activeTab === 'customer'" class="bg-white border border-gray-200/60 rounded-[14px] p-6">
        <!-- Card Header -->
        <div class="flex items-center justify-between mb-6">
          <h2 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight">
            Danh sách Khách hàng
          </h2>
          <p class="font-nunito text-sm leading-5 text-[#6a7282] tracking-tight">
            Tổng: {{ customerList.length }} khách hàng
          </p>
        </div>

        <!-- Search -->
        <div class="mb-6 relative">
          <img :src="iconSearch" alt="Search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4" />
          <input
            v-model="customerSearchQuery"
            type="text"
            placeholder="Tìm theo tên, số điện thoại..."
            class="w-full bg-[#f3f3f5] border-none rounded-lg h-9 pl-10 pr-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
          />
        </div>

        <!-- Customer Table -->
        <div class="overflow-x-auto mb-6">
          <table class="w-full">
            <thead>
              <tr class="border-b border-gray-200/60">
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Khách hàng</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Liên hệ</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Số lượng Thú cưng</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tổng chi tiêu</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Ngày tham gia</th>
                <th class="text-left py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Trạng thái</th>
                <th class="text-right py-2.5 px-2 font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="customer in customerList" :key="customer.id" class="border-b border-gray-200/60">
                <td class="py-3 px-2">
                  <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ customer.name }}</span>
                </td>
                <td class="py-3 px-2">
                  <div class="flex flex-col">
                    <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ customer.phone }}</span>
                    <span v-if="customer.zalo" class="font-nunito text-base leading-6 text-[#6a7282] tracking-tight">Zalo: {{ customer.zalo }}</span>
                  </div>
                </td>
                <td class="py-3 px-2">
                  <span class="font-nunito text-sm leading-5 text-[#009689] tracking-tight">{{ customer.petCount }}</span>
                </td>
                <td class="py-3 px-2">
                  <span class="font-nunito text-sm leading-5 text-[#009689] tracking-tight">{{ formatCurrency(customer.totalSpent) }}</span>
                </td>
                <td class="py-3 px-2">
                  <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ customer.joinDate }}</span>
                </td>
                <td class="py-3 px-2">
                  <span
                    :class="[
                      'inline-flex items-center gap-2 px-2 py-[3px] rounded-lg text-xs leading-4 font-nunito font-medium',
                      customer.status === 'active' ? 'bg-green-100 text-[#008236]' : 'bg-[#ffe2e2] text-[#c10007]'
                    ]"
                  >
                    <img :src="customer.status === 'active' ? iconCheck : iconBan" alt="" class="w-3 h-3" />
                    {{ customer.status === 'active' ? 'Hoạt động' : 'Bị chặn' }}
                  </span>
                </td>
                <td class="py-3 px-2">
                  <div class="flex items-center justify-end gap-2">
                    <button 
                      class="bg-white border border-gray-200/60 rounded-lg px-3 h-8 flex items-center gap-2 hover:bg-gray-50 transition-colors"
                      @click="handleViewCustomer(customer)"
                    >
                      <img :src="iconEye" alt="View" class="w-4 h-4" />
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Xem chi tiết</span>
                    </button>
                    <button
                      :class="[
                        'rounded-full w-8 h-8 flex items-center justify-center',
                        customer.status === 'active' ? 'hover:bg-gray-100' : 'hover:bg-green-50'
                      ]"
                    >
                      <img :src="customer.status === 'active' ? iconCircleX : iconCircleCheck" alt="" class="w-4 h-4" />
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Pagination -->
        <div class="flex items-center justify-between">
          <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
            Hiển thị 1 - {{ customerList.length }} của {{ customerList.length }} khách hàng
          </p>
          <div class="flex items-center gap-1">
            <button class="opacity-50 rounded-lg h-9 px-3 py-2 flex items-center gap-2" disabled>
              <img :src="iconChevronLeft" alt="Previous" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Previous</span>
            </button>
            <button class="bg-white border border-gray-200/60 rounded-lg w-9 h-9 flex items-center justify-center">
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">1</span>
            </button>
            <button class="opacity-50 rounded-lg h-9 px-3 py-2 flex items-center gap-2" disabled>
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Next</span>
              <img :src="iconChevronRight" alt="Next" class="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modals -->
    <ThemNhanVien
      v-if="isAddStaffModalOpen"
      @close="isAddStaffModalOpen = false"
      @submit="handleAddStaff"
    />

    <ChiTietNhanVien
      v-if="isViewStaffModalOpen"
      :staff="selectedStaffForView"
      @close="isViewStaffModalOpen = false"
      @edit="() => { isViewStaffModalOpen = false; /* Add logic to open edit modal */ }"
    />

    <DatMatKhau
      v-if="isResetPasswordModalOpen"
      :staff-name="selectedStaffForReset?.name"
      @close="isResetPasswordModalOpen = false"
      @reset="handleResetPasswordSubmit"
    />

    <ChiTietKhachHang
      v-if="isViewCustomerModalOpen"
      :customer="selectedCustomerForView"
      @close="isViewCustomerModalOpen = false"
    />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import ThemNhanVien from './ThemNhanVien/index.vue'
import ChiTietNhanVien from './ChiTietNhanVien/index.vue'
import DatMatKhau from './DatMatKhau/index.vue'
import ChiTietKhachHang from './ChiTietKhachHang/index.vue'

// Active Tab
const activeTab = ref('staff') // 'staff' or 'customer'
const isAddStaffModalOpen = ref(false)
const isViewStaffModalOpen = ref(false)
const selectedStaffForView = ref(null)
const isResetPasswordModalOpen = ref(false)
const selectedStaffForReset = ref(null)
const isViewCustomerModalOpen = ref(false)
const selectedCustomerForView = ref(null)

// Search Queries
const staffSearchQuery = ref('')
const customerSearchQuery = ref('')

// Icons (from Figma - expire in 7 days)
const iconPlus = "https://www.figma.com/api/mcp/asset/1861026e-bdeb-4bf2-a3d3-9ff21ab066b6"
const iconSearch = "https://www.figma.com/api/mcp/asset/6d0ae0ec-4e40-4fac-8e80-4f8fa582e4ae"
const iconChevronDown = "https://www.figma.com/api/mcp/asset/fee71b28-5724-4268-8040-7ba3bd25621c"
const iconCheck = "https://www.figma.com/api/mcp/asset/8ccdc7c5-0612-4096-932a-778665186719"
const iconX = "https://www.figma.com/api/mcp/asset/1d86c67f-830e-4ef0-a6fe-45849993acf4"
const iconEye = "https://www.figma.com/api/mcp/asset/5fd50ace-e27e-4604-a3cb-e9c8a84ce5dc"
const iconTrash = "https://www.figma.com/api/mcp/asset/10cae540-2b86-46b4-b088-6ba421a8adb2"
const iconChevronLeft = "https://www.figma.com/api/mcp/asset/34db4cab-de0b-4cf6-87d9-4fc3883b7cb3"
const iconChevronRight = "https://www.figma.com/api/mcp/asset/7425ae58-4a4a-478b-91c3-f77cea0d92aa"
const iconBan = "https://www.figma.com/api/mcp/asset/f4ce6ed5-a283-4323-9c1f-7f71b7840bd2"
const iconCircleX = "https://www.figma.com/api/mcp/asset/74180182-1e94-4e9e-8db7-439b21f1bc32"
const iconCircleCheck = "https://www.figma.com/api/mcp/asset/0ba993be-862d-4728-843e-bae67fc9d0f0"

// Staff List Data
const staffList = ref([
  {
    id: 1,
    name: 'BS. Nguyễn Văn A',
    avatar: 'https://www.figma.com/api/mcp/asset/dc21fb81-fb43-419f-96a7-a21fc6b10373',
    email: 'bsnguyen@vcms.vn',
    phone: '0901234567',
    roles: [{ name: 'Bác sĩ', color: 'blue' }],
    joinDate: '2024-01-15',
    status: 'active',
    lastLogin: 'Vừa xong'
  },
  {
    id: 2,
    name: 'Trần Thị B',
    avatar: 'https://www.figma.com/api/mcp/asset/a082ce65-1caa-4eab-8a20-a51f0f223c5e',
    email: 'tranb@vcms.vn',
    phone: '0907654321',
    roles: [
      { name: 'Điều dưỡng', color: 'green' },
      { name: 'Lễ tân / Thu ngân', color: 'purple' }
    ],
    joinDate: '2024-02-20',
    status: 'active',
    lastLogin: '2 giờ trước'
  },
  {
    id: 3,
    name: 'Admin Lê Văn C',
    avatar: 'https://www.figma.com/api/mcp/asset/2a15601f-8024-40ac-b8ef-c894005982eb',
    email: 'admin@vcms.vn',
    phone: '0909876543',
    roles: [{ name: 'Admin', color: 'red' }],
    joinDate: '2024-01-01',
    status: 'active',
    lastLogin: '1 ngày trước'
  },
  {
    id: 4,
    name: 'BS. Phạm Minh D',
    avatar: 'https://www.figma.com/api/mcp/asset/82cb5e4e-7e6c-4104-bcef-bfe225041610',
    email: 'bspham@vcms.vn',
    phone: '0905432109',
    roles: [{ name: 'Bác sĩ', color: 'blue' }],
    joinDate: '2024-03-10',
    status: 'locked',
    lastLogin: '15 ngày trước'
  },
  {
    id: 5,
    name: 'Ngô Thị E',
    avatar: 'https://www.figma.com/api/mcp/asset/8436495e-db6d-4375-9c7e-ec468e3de11a',
    email: 'ngoe@vcms.vn',
    phone: '0908765432',
    roles: [{ name: 'Điều dưỡng', color: 'green' }],
    joinDate: '2024-04-05',
    status: 'active',
    lastLogin: '5 giờ trước'
  }
])

// Customer List Data
const customerList = ref([
  {
    id: 1,
    name: 'Trần Thị Hương',
    phone: '0912345678',
    zalo: '0912345678',
    petCount: '2 bé',
    totalSpent: 5200000,
    joinDate: '2024-11-20',
    status: 'active',
    avatar: 'https://www.figma.com/api/mcp/asset/69ab4ed0-d5a9-4482-8a8e-baeaf0347487',
    email: 'huong.tran@email.com',
    rank: 'Gold',
    rankIcon: '🥇',
    address: '123 Lê Lợi, Quận 1, TP.HCM',
    pets: ['Milo', 'Luna'],
    recentVisits: [
      {
        service: 'Khám tổng quát',
        date: '15/11/2024',
        doctor: 'BS. Nguyễn Văn A',
        cost: 500000
      }
    ]
  },
  {
    id: 2,
    name: 'Nguyễn Văn Kiên',
    phone: '0923456789',
    zalo: null,
    petCount: '1 bé',
    totalSpent: 2800000,
    joinDate: '2024-10-15',
    status: 'active',
    avatar: 'https://www.figma.com/api/mcp/asset/69ab4ed0-d5a9-4482-8a8e-baeaf0347487',
    email: 'kien.nguyen@email.com',
    rank: 'Silver',
    rankIcon: '🥈',
    address: '456 Nguyễn Trãi, Quận 5, TP.HCM',
    pets: ['Lu'],
    recentVisits: [
      {
        service: 'Tiêm phòng',
        date: '10/10/2024',
        doctor: 'BS. Phạm Minh D',
        cost: 300000
      }
    ]
  },
  {
    id: 3,
    name: 'Lê Thị Mai',
    phone: '0934567890',
    zalo: '0934567890',
    petCount: '3 bé',
    totalSpent: 8900000,
    joinDate: '2024-09-01',
    status: 'active',
    avatar: 'https://www.figma.com/api/mcp/asset/69ab4ed0-d5a9-4482-8a8e-baeaf0347487',
    email: 'mai.le@email.com',
    rank: 'Gold',
    rankIcon: '🥇',
    address: '789 Võ Văn Kiệt, Quận 1, TP.HCM',
    pets: ['Mimi', 'Nunu', 'Kiki'],
    recentVisits: [
      {
        service: 'Spa trọn gói',
        date: '01/11/2024',
        doctor: 'KTV. Trần Thị B',
        cost: 800000
      }
    ]
  },
  {
    id: 4,
    name: 'Phạm Thanh Nam',
    phone: '0945678901',
    zalo: null,
    petCount: '1 bé',
    totalSpent: 450000,
    joinDate: '2024-11-10',
    status: 'blocked',
    avatar: 'https://www.figma.com/api/mcp/asset/69ab4ed0-d5a9-4482-8a8e-baeaf0347487',
    email: 'nam.pham@email.com',
    rank: 'Bronze',
    rankIcon: '🥉',
    address: '321 Điện Biên Phủ, Bình Thạnh, TP.HCM',
    pets: ['Rex'],
    recentVisits: [
      {
        service: 'Tư vấn dinh dưỡng',
        date: '10/11/2024',
        doctor: 'BS. Nguyễn Văn A',
        cost: 0
      }
    ]
  }
])

// Methods
const formatCurrency = (amount) => {
  return amount.toLocaleString('vi-VN') + ' ₫'
}

const handleAddStaff = (data) => {
  console.log('New staff data:', data)
  // Logic to add new staff goes here
  isAddStaffModalOpen.value = false
}

const handleViewStaff = (staff) => {
  selectedStaffForView.value = staff
  isViewStaffModalOpen.value = true
}

const handleOpenResetPassword = (staff) => {
  selectedStaffForReset.value = staff
  isResetPasswordModalOpen.value = true
}

const handleResetPasswordSubmit = (data) => {
  console.log('Reset password for', selectedStaffForReset.value?.name, data)
  // Logic to reset password goes here
  isResetPasswordModalOpen.value = false
}

const handleViewCustomer = (customer) => {
  selectedCustomerForView.value = customer
  isViewCustomerModalOpen.value = true
}
</script>

<style scoped>
/* Custom scrollbar for tables */
.overflow-x-auto::-webkit-scrollbar {
  height: 8px;
}

.overflow-x-auto::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

.overflow-x-auto::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

.overflow-x-auto::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>
