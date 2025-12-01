<template>
  <div class="w-full min-h-screen p-6">
    <!-- Back Button (only show in detail view) -->
    <button
      v-if="selectedPatient"
      @click="selectedPatient = null"
      class="bg-white border border-black/10 rounded-lg h-9 px-[13px] mb-6 flex items-center gap-2 hover:bg-gray-50 transition-colors"
    >
      <img :src="iconBack" alt="Back" class="w-4 h-4" />
      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
        Quay lại danh sách
      </span>
    </button>

    <!-- Page Header (only show in list view) -->
    <div v-if="!selectedPatient" class="flex items-center justify-between h-[60px] mb-6">
      <div class="flex flex-col">
        <h1 class="font-nunito font-medium text-2xl leading-9 text-[#101828] tracking-[0.0703px]">
          Quản lý Hồ sơ Bệnh án
        </h1>
        <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
          Tìm kiếm và quản lý thông tin bệnh nhân
        </p>
      </div>
    </div>

    <!-- Patient Detail View -->
    <div v-if="selectedPatient" class="flex flex-col gap-6">
      <!-- Patient Info Card -->
      <div class="bg-white border border-black/10 rounded-[14px] p-6">
        <div class="flex items-start justify-between mb-4">
          <!-- Left: Patient Photo and Info -->
          <div class="flex gap-4">
            <img :src="selectedPatient.image" :alt="selectedPatient.name" class="w-24 h-24 rounded-full object-cover" />
            <div class="flex flex-col gap-2">
              <h2 class="font-nunito text-2xl leading-8 text-[#101828] tracking-[0.0703px]">
                {{ selectedPatient.name }}
              </h2>
              <div class="flex flex-col gap-1">
                <p class="font-nunito text-sm leading-5 text-[#364153] tracking-tight">
                  {{ selectedPatient.species }} {{ selectedPatient.breed }}
                </p>
                <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
                  Tuổi: {{ selectedPatient.age }} tuổi
                </p>
                <div class="flex items-center gap-1">
                  <img :src="iconWeight" alt="Weight" class="w-4 h-4" />
                  <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
                    Cân nặng: 28.5 kg
                  </p>
                </div>
                <p class="font-nunito text-xs leading-4 text-[#4a5565]">
                  Mã vi mạch: 982000123456789
                </p>
              </div>
            </div>
          </div>

          <!-- Right: Owner Info -->
          <div class="flex flex-col items-end gap-2">
            <div class="flex items-center gap-2">
              <img :src="iconUser" alt="Owner" class="w-4 h-4" />
              <p class="font-nunito text-base leading-6 text-[#101828] tracking-tight">
                {{ selectedPatient.owner }}
              </p>
            </div>
            <div class="flex items-center gap-2">
              <img :src="iconPhone" alt="Phone" class="w-4 h-4" />
              <a :href="'tel:' + selectedPatient.phone" class="font-nunito text-sm leading-5 text-[#009689] hover:underline">
                {{ selectedPatient.phone }}
              </a>
            </div>
            <div class="flex items-center gap-2">
              <img :src="iconLocation" alt="Address" class="w-4 h-4" />
              <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight text-right">
                123 Nguyễn Huệ, Q.1, TP.HCM
              </p>
            </div>
            <!-- <button class="bg-white border border-[#ffb86a] rounded-lg h-8 px-[10px] mt-2 flex items-center gap-1 hover:bg-orange-50 transition-colors">
              <img :src="iconWarning" alt="Warning" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-[#f54900] tracking-tight">
                Cảnh báo
              </span>
            </button> -->
          </div>
        </div>

        <!-- Warnings and Allergies -->
        <div class="border-t border-black/10 pt-4 flex flex-col gap-2">
          <div class="bg-orange-50 border border-[#ffd6a7] rounded-[10px] px-[13px] py-[13px]">
            <div class="flex items-center gap-2">
              <img :src="iconAlert" alt="Alert" class="w-4 h-4" />
              <p class="font-nunito font-bold text-sm leading-5 text-[#9f2d00] tracking-tight">
                Cảnh báo:
              </p>
              <p class="font-nunito text-sm leading-5 text-[#9f2d00] tracking-tight">
                Dễ cắn khi sợ hãi
              </p>
            </div>
          </div>
          <div class="bg-red-50 border border-[#ffc9c9] rounded-[10px] px-[13px] py-[13px]">
            <div class="flex items-center gap-2">
              <p class="font-nunito font-bold text-sm leading-5 text-[#9f0712] tracking-tight">
                Dị ứng:
              </p>
              <p class="font-nunito text-sm leading-5 text-[#9f0712] tracking-tight">
                Penicillin
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Medical History and Details Row -->
      <div class="grid grid-cols-[358px_1fr] gap-6">
        <!-- Left: Medical History -->
        <div class="bg-white border border-black/10 rounded-[14px] p-6">
          <h3 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight mb-6">
            Lịch sử khám
          </h3>
          <div class="flex flex-col gap-3">
            <button
              v-for="(visit, index) in medicalHistory"
              :key="index"
              @click="selectedVisit = visit"
              :class="[
                'rounded-[10px] p-[18px] text-left transition-colors',
                selectedVisit.date === visit.date ? 'bg-teal-50 border-2 border-[#00bba7]' : 'border-2 border-gray-200 hover:border-gray-300'
              ]"
            >
              <div class="flex gap-3">
                <img :src="iconCalendar" alt="Calendar" class="w-5 h-5 mt-[2px]" />
                <div class="flex flex-col gap-1">
                  <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    {{ visit.date }}
                  </p>
                  <p class="font-nunito text-xs leading-4 text-[#4a5565]">
                    {{ visit.reason }}
                  </p>
                  <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                    Bởi: {{ visit.doctor }}
                  </p>
                  
                </div>
              </div>
            </button>
          </div>
        </div>

        <!-- Right: Visit Details -->
        <div class="bg-white border border-black/10 rounded-[14px] p-6 flex flex-col gap-[30px]">
          <!-- Header with tabs -->
          <div class="flex items-center justify-between">
            <h3 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight">
              Chi tiết phiếu khám - {{ selectedVisit.date }}
            </h3>
            <!-- <span class="inline-flex items-center px-[9px] py-[3px] rounded-lg font-nunito font-medium text-xs leading-4 border border-black/10 text-neutral-950">
              {{ selectedVisit.department }}
            </span> -->
          </div>

          <!-- Tabs -->
          <div class="bg-[#ececf0] rounded-[14px] p-[3.5px] flex items-center gap-0">
            <button
              v-for="(tab, index) in tabs"
              :key="index"
              @click="activeTab = tab.id"
              :class="[
                'flex-1 h-[29px] rounded-[14px] flex items-center justify-center gap-2 transition-colors',
                activeTab === tab.id ? 'bg-white' : ''
              ]"
            >
              <img :src="tab.icon" :alt="tab.label" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                {{ tab.label }}
              </span>
            </button>
          </div>

          <!-- Tab Content -->
          <div v-if="activeTab === 'info'" class="flex flex-col gap-4">
            <!-- Doctor -->
            <div class="flex flex-col gap-1">
              <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                Bác sĩ phụ trách
              </label>
              <p class="font-nunito text-base leading-6 text-[#101828] tracking-tight">
                {{ selectedVisit.doctor }}
              </p>
            </div>

            <!-- Reason -->
            <div class="flex flex-col gap-1">
              <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                Triệu chứng
              </label>
              <p class="font-nunito text-base leading-6 text-[#101828] tracking-tight">
                {{ selectedVisit.reason }}
              </p>
            </div>

            <!-- Vital Signs -->
            <div class="flex flex-col gap-2">
              <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                Chỉ số sinh tồn
              </label>
              <div class="grid grid-cols-2 gap-4">
                <div class="bg-gray-50 rounded-[10px] p-3 flex items-center gap-2">
                  <img :src="iconTemp" alt="Temperature" class="w-5 h-5" />
                  <div class="flex flex-col">
                    <p class="font-nunito text-xs leading-4 text-[#4a5565]">Nhiệt độ</p>
                    <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">38.5°C</p>
                  </div>
                </div>
                <div class="bg-gray-50 rounded-[10px] p-3 flex items-center gap-2">
                  <img :src="iconHeart" alt="Heart Rate" class="w-5 h-5" />
                  <div class="flex flex-col">
                    <p class="font-nunito text-xs leading-4 text-[#4a5565]">Nhịp tim</p>
                    <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">90 bpm</p>
                  </div>
                </div>
                <div class="bg-gray-50 rounded-[10px] p-3 flex items-center gap-2">
                  <img :src="iconLungs" alt="Respiratory" class="w-5 h-5" />
                  <div class="flex flex-col">
                    <p class="font-nunito text-xs leading-4 text-[#4a5565]">Hô hấp</p>
                    <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">24 lần/phút</p>
                  </div>
                </div>
                <div class="bg-gray-50 rounded-[10px] p-3 flex items-center gap-2">
                  <img :src="iconScale" alt="Weight" class="w-5 h-5" />
                  <div class="flex flex-col">
                    <p class="font-nunito text-xs leading-4 text-[#4a5565]">Cân nặng</p>
                    <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">28.5 kg</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Diagnosis -->
            <div class="flex flex-col gap-1">
              <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                Chẩn đoán (Diagnosis)
              </label>
              <div class="bg-blue-50 border border-[#bedbff] rounded-[10px] p-[13px]">
                <p class="font-nunito text-base leading-6 text-[#101828] tracking-tight">
                  Sức khỏe tốt, tiêm vắc-xin phòng dại và bệnh Care
                </p>
              </div>
            </div>

            <!-- Notes -->
            <div class="flex flex-col gap-1">
              <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                Ghi chú nội bộ
              </label>
              <div class="bg-gray-50 rounded-[10px] p-3">
                <p class="font-nunito text-base leading-6 text-[#364153] tracking-tight">
                  Theo dõi sau tiêm 15 phút, không có phản ứng phụ
                </p>
              </div>
            </div>
          </div>

          <div v-else-if="activeTab === 'services'" class="flex flex-col gap-6">
            <!-- Performed Services Section -->
            <div class="flex flex-col gap-3">
              <div class="flex items-center justify-between h-8">
                <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                  Dịch vụ đã thực hiện
                </label>
                <!-- <button class="bg-white border border-black/10 rounded-lg h-8 px-[11px] flex items-center gap-1 hover:bg-gray-50 transition-colors">
                  <img :src="iconPlus" alt="Add" class="w-4 h-4" />
                  <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                    Thêm dịch vụ
                  </span>
                </button> -->
              </div>
              <div class="flex flex-col gap-2">
                <div class="bg-gray-50 border border-gray-200 rounded-[10px] px-[13px] py-[13px] flex flex-col gap-1">
                  <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    Tiêm phòng dại
                  </p>
                  <p class="font-nunito text-xs leading-4 text-[#4a5565]">
                    Vắc-xin phòng dại hàng năm
                  </p>
                </div>
                <div class="bg-gray-50 border border-gray-200 rounded-[10px] px-[13px] py-[13px] flex flex-col gap-1">
                  <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    Tiêm phòng Care
                  </p>
                  <p class="font-nunito text-xs leading-4 text-[#4a5565]">
                    Vắc-xin 7 trong 1
                  </p>
                </div>
              </div>
            </div>

            <!-- Prescription Section -->
            <div class="flex flex-col gap-3">
              <div class="flex items-center justify-between h-8">
                <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                  Đơn thuốc
                </label>
                <!-- <button class="bg-white border border-black/10 rounded-lg h-8 px-[11px] flex items-center gap-1 hover:bg-gray-50 transition-colors">
                  <img :src="iconPlus" alt="Add" class="w-4 h-4" />
                  <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                    Kê đơn
                  </span>
                </button> -->
              </div>
              <div class="h-[52px] flex items-center justify-center">
                <p class="font-nunito text-sm leading-5 text-[#6a7282] tracking-tight">
                  Chưa có đơn thuốc
                </p>
              </div>
            </div>
          </div>

          <div v-else-if="activeTab === 'images'" class="flex flex-col gap-4">
            <!-- Section Header -->
            <div class="flex items-center justify-between h-8">
              <label class="font-nunito font-medium text-sm leading-[14px] text-[#364153] tracking-tight">
                Hình ảnh & Kết quả xét nghiệm
              </label>
            </div>

            <!-- Upload Area - Empty State -->
            <div class="bg-gray-50 border-2 border-[#d1d5dc] border-dashed rounded-[10px] h-56 flex flex-col items-center justify-center gap-4">
              <img :src="iconImagePlaceholder" alt="No images" class="w-12 h-12" />
              <p class="font-nunito text-sm leading-5 text-[#6a7282] tracking-tight">
                Chưa có hình ảnh hoặc tài liệu nào
              </p>
              <!-- <button class="bg-white border border-black/10 rounded-lg h-8 px-[10px] flex items-center gap-1 hover:bg-gray-50 transition-colors">
                <img :src="iconPlus" alt="Add" class="w-4 h-4" />
                <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                  Upload file
                </span>
              </button> -->
            </div>
          </div>
        </div>
      </div>

      <!-- Re-examination Schedule Card -->
      <div class="bg-gradient-to-r from-[#eff6ff] to-[#faf5ff] border-2 border-[#8ec5ff] rounded-[14px] p-[26px] flex flex-col gap-[42px]">
        <!-- Card Title -->
        <div class="flex items-center gap-2">
          <img :src="iconClipboard" alt="Schedule" class="w-5 h-5" />
          <p class="font-nunito text-[16px] leading-[16px] text-[#1c398e] tracking-[-0.3125px]">
            📅 KẾ HOẠCH TÁI KHÁM & NHẮC LỊCH
          </p>
        </div>

        <!-- Schedule Content -->
        <div class="bg-white border-2 border-[#bedbff] rounded-[10px] p-[18px] flex flex-col gap-3">
          <!-- Date and Badge -->
          <div class="flex items-center justify-between">
            <div class="flex flex-col gap-1">
              <div class="flex items-baseline gap-2">
                <p class="font-nunito font-bold text-[18px] leading-[28px] text-[#101828] tracking-[-0.4395px]">
                  04/12/2025
                </p>
                <p class="font-nunito text-[16px] leading-[24px] text-[#4a5565] tracking-[-0.3125px]">
                  (Thứ Năm)
                </p>
              </div>
              <p class="font-nunito text-[14px] leading-[20px] text-[#6a7282] tracking-[-0.1504px]">
                Còn 3 ngày nữa
              </p>
            </div>
            <span class="inline-flex items-center px-[9px] py-[3px] rounded-lg font-nunito font-medium text-xs leading-4 bg-purple-100 border border-[#dab2ff] text-[#8200db]">
              💉 Tiêm phòng
            </span>
          </div>

          <!-- Note Box -->
          <div class="bg-blue-50 border border-[#bedbff] rounded-[10px] p-[13px] flex gap-3">
            <img :src="iconInfo" alt="Info" class="w-5 h-5 mt-[2px]" />
            <div class="flex flex-col gap-1">
              <p class="font-nunito text-[14px] leading-[20px] text-[#101828] tracking-[-0.1504px]">
                Hẹn tiêm mũi nhắc lại vắc-xin 7 bệnh (Mũi 3). Chủ nuôi nhớ mang theo sổ tiêm chủng.
              </p>
              <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                Ghi chú từ BS. Nguyễn Văn B
              </p>
            </div>
          </div>

          <!-- Status and Actions -->
          <div class="border-t border-gray-200 pt-[1px] flex items-center justify-between">
            <div class="flex items-center gap-2">
              <p class="font-nunito text-[14px] leading-[20px] text-[#4a5565] tracking-[-0.1504px]">
                Trạng thái:
              </p>
              <span class="inline-flex items-center px-[9px] py-[3px] rounded-lg font-nunito font-medium text-xs leading-4 bg-[#fef9c2] border border-[#ffdf20] text-[#a65f00]">
                🟡 Chờ xử lý
              </span>
            </div>
            <div class="flex items-center gap-2">
              <button class="bg-white border border-[#7bf1a8] rounded-lg h-8 px-[11px] flex items-center gap-1 hover:bg-green-50 transition-colors">
                <img :src="iconPhoneCheck" alt="Call" class="w-4 h-4" />
                <span class="font-nunito font-medium text-[14px] leading-[20px] text-[#00a63e] tracking-[-0.1504px]">
                  📞 Xác nhận đã gọi
                </span>
              </button>
              <button class="bg-[#155dfc] rounded-lg h-8 px-[10px] flex items-center gap-1 hover:bg-[#1350e0] transition-colors">
                <img :src="iconCalendarPlus" alt="Book" class="w-4 h-4" />
                <span class="font-nunito font-medium text-[14px] leading-[20px] text-white tracking-[-0.1504px]">
                  📅 Đặt lịch ngay
                </span>
              </button>
              <button class="bg-white border border-[#ffa2a2] rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-red-50 transition-colors">
                <img :src="iconTrash" alt="Delete" class="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Main Card (List View) -->
    <div v-else class="bg-white border border-black/10 rounded-[14px] p-6">
      <!-- Search and Filters -->
      <div class="flex flex-col gap-4 mb-6">
        <!-- Search Bar -->
        <div class="relative">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="🔍 Tìm theo tên Pet, tên Chủ, SĐT hoặc Mã vi mạch..."
            class="bg-[#f3f3f5] border border-transparent rounded-lg h-12 pl-12 pr-3 w-full font-nunito text-sm text-[#717182] tracking-tight focus:outline-none focus:ring-2 focus:ring-[#009689]"
          />
          <img :src="iconSearch" alt="Search" class="absolute left-4 top-[14px] w-5 h-5" />
        </div>

        <!-- Filter Dropdowns -->
        <div class="grid grid-cols-2 gap-4">
          <!-- Species Filter -->
          <div class="relative">
            <button class="bg-[#f3f3f5] border border-transparent rounded-lg h-9 px-[13px] py-px flex items-center justify-between w-full hover:bg-gray-200 transition-colors">
              <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">
                🐾 Tất cả
              </span>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </button>
          </div>

          <!-- Breed Filter -->
          <div class="relative">
            <button class="bg-[#f3f3f5] border border-transparent rounded-lg h-9 px-[13px] py-px flex items-center justify-between w-full opacity-50 hover:opacity-70 transition-opacity">
              <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">
                Tất cả giống
              </span>
              <img :src="iconChevronDown" alt="Dropdown" class="w-4 h-4" />
            </button>
          </div>
        </div>
      </div>

      <!-- Table -->
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead>
            <tr class="border-b border-black/10">
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Bệnh nhân
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Thông tin
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Chủ nuôi
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Lần khám cuối
              </th>
              <th class="text-left px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Trạng thái
              </th>
              <th class="text-right px-2 py-[10px] font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">
                Thao tác
              </th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(patient, index) in patients"
              :key="index"
              class="border-b border-black/10 hover:bg-gray-50 transition-colors"
            >
              <!-- Patient -->
              <td class="px-2 py-[8.5px]">
                <div class="flex items-center gap-3">
                  <img :src="patient.image" :alt="patient.name" class="w-12 h-12 rounded-full object-cover" />
                  <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    {{ patient.name }}
                  </p>
                </div>
              </td>

              <!-- Info -->
              <td class="px-2 py-[12.5px]">
                <div class="flex flex-col gap-1">
                  <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    {{ patient.species }} {{ patient.breed }}
                  </p>
                  <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                    Tuổi: {{ patient.age }} tuổi
                  </p>
                </div>
              </td>

              <!-- Owner -->
              <td class="px-2 py-[10.5px]">
                <div class="flex flex-col">
                  <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                    {{ patient.owner }}
                  </p>
                  <a :href="'tel:' + patient.phone" class="font-nunito text-xs leading-4 text-[#009689] hover:underline">
                    {{ patient.phone }}
                  </a>
                </div>
              </td>

              <!-- Last Visit -->
              <td class="px-2 py-[12.5px]">
                <div class="flex flex-col gap-1">
                  <div class="flex items-center gap-1">
                    <p class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">
                      {{ patient.lastVisitDate }}
                    </p>
                    <p class="font-nunito text-sm leading-5 text-[#6a7282] tracking-tight">
                      ({{ patient.lastVisitDaysAgo }})
                    </p>
                  </div>
                  <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                    Bởi: {{ patient.lastVisitDoctor }}
                  </p>
                </div>
              </td>

              <!-- Status -->
              <td class="px-2 py-[21.5px]">
                <span
                  :class="[
                    'inline-flex items-center px-2 py-[3px] rounded-lg font-nunito font-medium text-xs leading-4',
                    patient.status === 'normal' ? 'bg-green-100 text-[#008236]' :
                    patient.status === 'treatment' ? 'bg-[#ffe2e2] text-[#c10007]' :
                    'bg-purple-100 text-[#8200db]'
                  ]"
                >
                  {{ getStatusLabel(patient.status) }}
                </span>
              </td>

              <!-- Actions -->
              <td class="px-2 py-[16.5px]">
                <div class="flex items-center justify-end">
                  <button
                    @click="openMedicalRecord(patient)"
                    class="bg-[#009689] rounded-lg h-8 px-[10px] flex items-center gap-1 hover:bg-[#007d72] transition-colors"
                  >
                    <img :src="iconFolder" alt="Open" class="w-4 h-4" />
                    <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
                      Mở hồ sơ
                    </span>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Icons (from Figma - expire in 7 days)
const iconSearch = "https://www.figma.com/api/mcp/asset/1c51664a-f6bd-4bf2-86cc-42638e96b26a"
const iconChevronDown = "https://www.figma.com/api/mcp/asset/18f0890f-0a33-4f93-b72f-f3ae08008413"
const iconFolder = "https://www.figma.com/api/mcp/asset/147fcf64-5170-4671-bb69-0a4267685369"
const iconBack = "https://www.figma.com/api/mcp/asset/4ab4b914-6785-49c7-b04d-ff8a0192483b"
const iconWeight = "https://www.figma.com/api/mcp/asset/ca58f6e1-61e9-424c-add3-405ee13711c9"
const iconUser = "https://www.figma.com/api/mcp/asset/f4d78c69-f836-4b10-a671-e3f62937b86d"
const iconPhone = "https://www.figma.com/api/mcp/asset/d80f605e-ba76-472b-a4a5-288f20d3b629"
const iconLocation = "https://www.figma.com/api/mcp/asset/c09eef86-b430-491e-9e7a-d9ee707928b9"
const iconWarning = "https://www.figma.com/api/mcp/asset/c810cb56-ca3d-425f-b89a-2f190c13bd55"
const iconAlert = "https://www.figma.com/api/mcp/asset/ea36ae7b-a672-4357-9383-04d9f2dde2fa"
const iconCalendar = "https://www.figma.com/api/mcp/asset/dd634253-fea8-47da-949f-0912c6ec1f68"
const iconInfo = "https://www.figma.com/api/mcp/asset/be0020cc-20c7-4c90-bb69-4d5a39ac36e9"
const iconServices = "https://www.figma.com/api/mcp/asset/0ed0317d-2f15-4ee0-8a93-aa506c0ce0cd"
const iconImages = "https://www.figma.com/api/mcp/asset/984dd6a3-bbb2-4877-882c-57e01794ed69"
const iconTemp = "https://www.figma.com/api/mcp/asset/c2388239-23e1-4152-b258-7f201196c69f"
const iconHeart = "https://www.figma.com/api/mcp/asset/4f05fa02-1ee5-4be0-a73a-7d5fc3b5320d"
const iconLungs = "https://www.figma.com/api/mcp/asset/2253a098-eb59-4ee8-927c-02f41871caa7"
const iconScale = "https://www.figma.com/api/mcp/asset/abea2973-bdc1-4361-85ea-7e950004cdd3"
const iconPlus = "https://www.figma.com/api/mcp/asset/68e01bcc-9066-460d-bec2-8469281e6788"
const iconUpload = "https://www.figma.com/api/mcp/asset/f0ca3ca3-39cf-41c9-a8e7-ae3f945c53d4"
const iconImagePlaceholder = "https://www.figma.com/api/mcp/asset/b34534d4-96ca-4bb4-aaf9-85801b20c55f"
const iconClipboard = "https://www.figma.com/api/mcp/asset/bc9e4feb-a504-49e2-b9a8-ecaa8e247dd9"
const iconPhoneCheck = "https://www.figma.com/api/mcp/asset/a2d6229c-5bfc-4581-8d8d-1835060c47b5"
const iconCalendarPlus = "https://www.figma.com/api/mcp/asset/ec9c9a09-6781-485d-9c4e-9596d60ea7f3"
const iconTrash = "https://www.figma.com/api/mcp/asset/4394fffa-b9e9-4861-9796-7c6f6cac9986"

// Emits
const emit = defineEmits(['open-record'])

// Reactive state
const searchQuery = ref('')
const selectedPatient = ref(null)
const activeTab = ref('info')

// Tabs configuration
const tabs = ref([
  { id: 'info', label: 'Thông tin khám', icon: iconInfo },
  { id: 'services', label: 'Dịch vụ & Thuốc', icon: iconServices },
  { id: 'images', label: 'Hình ảnh & XN', icon: iconImages }
])

// Medical history
const medicalHistory = ref([
  {
    date: '19/11/2025',
    reason: 'Tiêm phòng định kỳ',
    doctor: 'BS. Nguyễn Văn B',
  },
  {
    date: '15/10/2025',
    reason: 'Khám tiêu hóa - Bỏ ăn, nôn mửa',
    doctor: 'BS. Trần Văn C'
  }
])

const selectedVisit = ref(medicalHistory.value[0])

// Sample Data
const patients = ref([
  {
    id: 1,
    name: 'Milo',
    image: 'https://www.figma.com/api/mcp/asset/338835fc-d9a8-4a14-8663-c7d6e83ddec3',
    species: '🐶',
    breed: 'Golden Retriever',
    age: 2,
    owner: 'Nguyễn Văn A',
    phone: '0901234567',
    lastVisitDate: '19/11/2025',
    lastVisitDaysAgo: 'Cách đây 1 ngày',
    lastVisitDoctor: 'BS. Nguyễn Văn B',
    status: 'normal'
  },
  {
    id: 2,
    name: 'Luna',
    image: 'https://www.figma.com/api/mcp/asset/6ef010eb-1724-4fb7-ba6e-e84132333e5e',
    species: '🐱',
    breed: 'Persian',
    age: 3,
    owner: 'Trần Thị B',
    phone: '0909876543',
    lastVisitDate: '18/11/2025',
    lastVisitDaysAgo: 'Cách đây 2 ngày',
    lastVisitDoctor: 'BS. Trần Văn C',
    status: 'treatment'
  },
  {
    id: 3,
    name: 'Max',
    image: 'https://www.figma.com/api/mcp/asset/f0c89c42-675f-42a2-b259-ad47d0644357',
    species: '🐶',
    breed: 'Husky',
    age: 4,
    owner: 'Lê Văn C',
    phone: '0912345678',
    lastVisitDate: '15/11/2025',
    lastVisitDaysAgo: 'Cách đây 5 ngày',
    lastVisitDoctor: 'BS. Nguyễn Văn B',
    status: 'normal'
  },
  {
    id: 4,
    name: 'Bella',
    image: 'https://www.figma.com/api/mcp/asset/71cf8008-bdd4-4b14-8d21-f744f5e24726',
    species: '🐱',
    breed: 'British Shorthair',
    age: 1,
    owner: 'Phạm Thị D',
    phone: '0923456789',
    lastVisitDate: '20/11/2025',
    lastVisitDaysAgo: 'Cách đây 0 ngày',
    lastVisitDoctor: 'BS. Hoàng Văn D',
    status: 'inpatient'
  },
  {
    id: 5,
    name: 'Rocky',
    image: 'https://www.figma.com/api/mcp/asset/83fed67f-e324-4350-835a-2b7e0d66a427',
    species: '🐶',
    breed: 'Bulldog',
    age: 5,
    owner: 'Đỗ Văn E',
    phone: '0934567890',
    lastVisitDate: '17/11/2025',
    lastVisitDaysAgo: 'Cách đây 3 ngày',
    lastVisitDoctor: 'BS. Nguyễn Văn B',
    status: 'treatment'
  }
])

// Methods
const getStatusLabel = (status) => {
  const labels = {
    'normal': 'Bình thường',
    'treatment': 'Đang điều trị',
    'inpatient': 'Nội trú'
  }
  return labels[status] || status
}

const openMedicalRecord = (patient) => {
  selectedPatient.value = patient
  emit('open-record', patient)
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
