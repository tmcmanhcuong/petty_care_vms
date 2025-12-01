<template>
  <div class="flex flex-col gap-4 w-full h-full" style="font-family: 'Nunito Sans', sans-serif;">
    <!-- Header Section -->
    <div class="flex flex-col gap-2 w-full">
      <!-- Back Button -->
      <div class="h-[60px] relative w-[286.914px]">
        <div class="flex gap-3 h-[60px] items-center">
          <button 
            class="bg-white border border-black/10 h-8 rounded-lg flex items-center gap-2 px-3 hover:bg-gray-50 transition-colors"
            @click="goBack"
          >
            <svg class="w-4 h-4" viewBox="0 0 16 16" fill="none">
              <path d="M10 12L6 8L10 4" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <span class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Quay lại DS</span>
          </button>
        </div>
      </div>

      <!-- Title Section -->
      <div class="w-full">
        <h1 class="font-medium text-2xl text-[#101828] leading-9 tracking-[0.0703px]">Khám bệnh</h1>
        <p class="font-normal text-base text-[#4a5565] leading-6 tracking-[-0.3125px]">Phiếu khám lâm sàng</p>
      </div>
    </div>

    <!-- Main Content Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-[268px_1fr_363px] gap-4 w-full">
      <!-- Left Column - Patient Info & History -->
      <div class="flex flex-col gap-4">
        <!-- Patient Info Card -->
        <div class="bg-white border border-black/10 rounded-[14px] p-6">
          <h3 class="font-medium text-sm text-gray-950 tracking-[-0.1504px] mb-6">Thông tin Bệnh nhân</h3>
          
          <!-- Patient Image -->
          <div class="w-full aspect-square rounded-[10px] overflow-hidden mb-4">
            <img 
              :src="patientInfo.image || 'https://via.placeholder.com/300'" 
              alt="Patient" 
              class="w-full h-full object-cover"
            />
          </div>

          <!-- Patient Details -->
          <div class="space-y-4">
            <div>
              <p class="text-xs text-[#4a5565] leading-4">Tên</p>
              <p class="text-base text-[#101828] leading-6 tracking-[-0.3125px]">{{ patientInfo.name }}</p>
            </div>

            <p class="text-xs text-[#4a5565] leading-4">Loài/Giống</p>

            <div class="grid grid-cols-2 gap-2">
              <div>
                <p class="text-xs text-[#4a5565] leading-4">Tuổi</p>
                <p class="text-sm text-[#101828] leading-5 tracking-[-0.1504px]">{{ patientInfo.age }}</p>
              </div>
              <div>
                <p class="text-xs text-[#4a5565] leading-4">Giới tính</p>
                <p class="text-sm text-[#101828] leading-5 tracking-[-0.1504px]">{{ patientInfo.gender }}</p>
              </div>
            </div>

            <div>
              <p class="text-xs text-[#4a5565] leading-4">Cân nặng</p>
              <div class="flex items-center gap-1">
                <svg class="w-3 h-3" viewBox="0 0 12 12" fill="currentColor">
                  <path d="M6 1L7.5 4.5H11L8 7L9 10.5L6 8.5L3 10.5L4 7L1 4.5H4.5L6 1Z"/>
                </svg>
                <span class="text-sm text-[#101828] leading-5 tracking-[-0.1504px]">{{ patientInfo.weight }}</span>
              </div>
            </div>
          </div>

          <!-- Owner Info -->
          <div class="border-t border-black/10 pt-3 mt-4 space-y-2">
            <p class="text-xs text-[#4a5565] leading-4">Chủ nuôi</p>
            <p class="text-sm text-[#101828] leading-5 tracking-[-0.1504px]">{{ patientInfo.ownerName }}</p>
            <p class="text-sm text-[#4a5565] leading-5 tracking-[-0.1504px]">{{ patientInfo.ownerPhone }}</p>
          </div>
        </div>

        <!-- Medical History Card -->
        <div class="bg-white border border-black/10 rounded-[14px] p-6 flex-1">
          <div class="flex items-center gap-2 mb-6">
            <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
              <path d="M3 4h10M3 8h10M3 12h10" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <h3 class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Lịch sử khám</h3>
          </div>

          <div class="space-y-3 overflow-y-auto max-h-[300px]">
            <div 
              v-for="(history, index) in medicalHistory" 
              :key="index"
              class="bg-gray-50 rounded-[10px] p-3 cursor-pointer hover:bg-gray-100 transition-colors"
            >
              <div class="flex items-center gap-2 mb-2">
                <svg class="w-3 h-3" viewBox="0 0 12 12" fill="currentColor">
                  <path d="M6 1C3.24 1 1 3.24 1 6s2.24 5 5 5 5-2.24 5-5-2.24-5-5-5zm0 9c-2.21 0-4-1.79-4-4s1.79-4 4-4 4 1.79 4 4-1.79 4-4 4zm.5-7H5.5v3.25l2.75 1.65.4-.65-2.15-1.28V3z"/>
                </svg>
                <span class="text-xs text-[#4a5565] leading-4">{{ history.date }}</span>
              </div>
              <p class="text-sm text-[#101828] leading-5 tracking-[-0.1504px] mb-2">{{ history.treatment }}</p>
              <p class="text-xs text-[#6a7282] leading-4">{{ history.doctor }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Middle Column - Current Examination Form -->
      <div class="bg-white border border-black/10 rounded-[14px] p-6">
        <div class="flex items-center gap-2 mb-6">
          <svg class="w-5 h-5 text-blue-500" viewBox="0 0 20 20" fill="currentColor">
            <path d="M10 2a8 8 0 100 16 8 8 0 000-16zm1 11H9v-2h2v2zm0-4H9V5h2v4z"/>
          </svg>
          <h2 class="text-base text-gray-950 leading-4 tracking-[-0.3125px]">Phiếu Khám Hiện tại</h2>
        </div>

        <div class="space-y-4 overflow-y-auto max-h-[calc(100vh-200px)]">
          <!-- Vitals Section -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">Sinh hiệu (Vitals)</label>
            <div class="grid grid-cols-3 gap-3">
              <div class="space-y-1">
                <label class="font-medium text-xs text-[#4a5565] leading-4">Nhiệt độ (°C)</label>
                <input 
                  v-model="examination.temperature"
                  type="text" 
                  placeholder="38.5"
                  class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              <div class="space-y-1">
                <label class="font-medium text-xs text-[#4a5565] leading-4">Nhịp tim (bpm)</label>
                <input 
                  v-model="examination.heartRate"
                  type="text" 
                  placeholder="120"
                  class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
              <div class="space-y-1">
                <label class="font-medium text-xs text-[#4a5565] leading-4">Hô hấp (bpm)</label>
                <input 
                  v-model="examination.respiration"
                  type="text" 
                  placeholder="25"
                  class="w-full h-9 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>
            </div>
          </div>

          <!-- Clinical Symptoms -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">Triệu chứng lâm sàng</label>
            <textarea 
              v-model="examination.symptoms"
              placeholder="Mô tả triệu chứng quan sát được..."
              class="w-full h-16 px-3 py-2 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] leading-5 tracking-[-0.1504px] resize-none focus:outline-none focus:ring-2 focus:ring-blue-500"
            ></textarea>
          </div>

          <!-- Diagnosis -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">Chẩn đoán (Diagnosis)</label>
            <textarea 
              v-model="examination.diagnosis"
              placeholder="Nhập chẩn đoán hoặc chọn từ danh mục bệnh..."
              class="w-full h-16 px-3 py-2 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] leading-5 tracking-[-0.1504px] resize-none focus:outline-none focus:ring-2 focus:ring-blue-500"
            ></textarea>
          </div>

          <!-- Doctor's Notes -->
          <div class="space-y-2">
            <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">Lời dặn bác sĩ</label>
            <textarea 
              v-model="examination.notes"
              placeholder="Ghi chú cho chủ nuôi (chăm sóc, tái khám...)..."
              class="w-full h-16 px-3 py-2 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] leading-5 tracking-[-0.1504px] resize-none focus:outline-none focus:ring-2 focus:ring-blue-500"
            ></textarea>
          </div>

          <!-- Treatment Plan & Appointment -->
          <div class="border-t border-black/10 pt-4 space-y-4">
            <div class="flex items-center justify-between">
              <label class="font-medium text-sm text-[#101828] tracking-[-0.1504px]">🩺 KẾ HOẠT ĐIỀU TRỊ & HẸN LỊCH</label>
              <button 
                @click="toggleTreatmentPlan"
                :class="[
                  'w-8 h-[18.398px] rounded-full transition-colors',
                  treatmentPlanEnabled ? 'bg-[#030213]' : 'bg-[#cbced4]'
                ]"
              >
                <div :class="[
                  'w-4 h-4 bg-white rounded-full transition-transform',
                  treatmentPlanEnabled ? 'translate-x-[15px]' : 'translate-x-[1px]'
                ]"></div>
              </button>
            </div>

            <!-- Treatment Plan Content -->
            <transition name="fade">
              <div v-if="treatmentPlanEnabled" class="bg-teal-50 border border-[#96f7e4] rounded-[10px] p-4 space-y-4">
                <!-- Appointment Type -->
                <div class="space-y-2">
                  <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Loại nhắc hẹn</label>
                  <div class="flex flex-wrap gap-2">
                    <button 
                      @click="appointmentType = 'recheck'"
                      :class="[
                        'h-[38px] px-3 rounded-[10px] flex items-center gap-2 text-sm tracking-[-0.1504px] transition-colors',
                        appointmentType === 'recheck' 
                          ? 'bg-[#009689] text-white' 
                          : 'bg-white border border-black/10 text-[#364153]'
                      ]"
                    >
                      <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                        <path d="M8 2a6 6 0 00-6 6h2a4 4 0 014-4V2z"/>
                      </svg>
                      Tái khám
                    </button>
                    <button 
                      @click="appointmentType = 'vaccine'"
                      :class="[
                        'h-[38px] px-3 rounded-[10px] flex items-center gap-2 text-sm tracking-[-0.1504px] transition-colors',
                        appointmentType === 'vaccine' 
                          ? 'bg-[#009689] text-white' 
                          : 'bg-white border border-black/10 text-[#364153]'
                      ]"
                    >
                      <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                        <path d="M8 1l1.5 3h3.5l-2.5 2 1 3.5-3-2-3 2 1-3.5-2.5-2h3.5z"/>
                      </svg>
                      Tiêm Vắc-xin
                    </button>
                    <button 
                      @click="appointmentType = 'spa'"
                      :class="[
                        'h-[38px] px-3 rounded-[10px] flex items-center gap-2 text-sm tracking-[-0.1504px] transition-colors',
                        appointmentType === 'spa' 
                          ? 'bg-[#009689] text-white' 
                          : 'bg-white border border-black/10 text-[#364153]'
                      ]"
                    >
                      <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                        <circle cx="8" cy="8" r="6"/>
                      </svg>
                      Tẩy giun/Spa
                    </button>
                  </div>
                </div>

                <!-- Duration -->
                <div class="space-y-2">
                  <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Bao lâu nữa?</label>
                  <div class="flex gap-2 mb-2">
                    <button 
                      v-for="option in durationOptions" 
                      :key="option.value"
                      @click="duration = option.value"
                      :class="[
                        'h-8 px-3 rounded-lg border border-black/10 bg-white text-sm font-medium text-gray-950 tracking-[-0.1504px] hover:bg-gray-50 transition-colors',
                        duration === option.value && 'ring-2 ring-blue-500'
                      ]"
                    >
                      {{ option.label }}
                    </button>
                  </div>
                  <input 
                    v-model="customDuration"
                    type="text" 
                    placeholder="Hoặc nhập thời gian tùy chỉnh..."
                    class="w-full h-9 px-3 py-1 bg-white border-0 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                  />
                </div>

                <!-- Message Content -->
                <div class="space-y-2">
                  <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Nội dung nhắn cho khách (Zalo/SMS)</label>
                  <textarea 
                    v-model="reminderMessage"
                    placeholder="Nhập nội dung nhắc nhở..."
                    class="w-full h-16 px-3 py-2 bg-white border-0 rounded-lg text-sm text-[#717182] leading-5 tracking-[-0.1504px] resize-none focus:outline-none focus:ring-2 focus:ring-blue-500"
                  ></textarea>
                </div>

                <!-- Send Method -->
                <div class="space-y-2">
                  <label class="font-medium text-sm text-gray-950 tracking-[-0.1504px]">Hình thức gửi</label>
                  <div class="flex gap-3">
                    <label class="flex items-center gap-2 cursor-pointer">
                      <input 
                        v-model="sendMethods" 
                        type="checkbox" 
                        value="zalo"
                        class="w-4 h-4 bg-[#030213] border-[#030213] rounded text-[#030213] focus:ring-2 focus:ring-blue-500"
                      />
                      <span class="text-sm text-[#364153] tracking-[-0.1504px]">Gửi Zalo</span>
                    </label>
                    <label class="flex items-center gap-2 cursor-pointer">
                      <input 
                        v-model="sendMethods" 
                        type="checkbox" 
                        value="sms"
                        class="w-4 h-4 bg-[#f3f3f5] border-black/10 rounded text-[#030213] focus:ring-2 focus:ring-blue-500"
                      />
                      <span class="text-sm text-[#364153] tracking-[-0.1504px]">Gửi SMS</span>
                    </label>
                    <label class="flex items-center gap-2 cursor-pointer">
                      <input 
                        v-model="sendMethods" 
                        type="checkbox" 
                        value="call"
                        class="w-4 h-4 bg-[#030213] border-[#030213] rounded text-[#030213] focus:ring-2 focus:ring-blue-500"
                      />
                      <span class="text-sm text-[#364153] tracking-[-0.1504px]">Gọi điện</span>
                    </label>
                  </div>
                </div>

                <!-- Auto Send -->
                <div class="border-t border-[#46ecd5] pt-3">
                  <label class="flex items-center gap-2 cursor-pointer">
                    <input 
                      v-model="autoSend" 
                      type="checkbox"
                      class="w-4 h-4 bg-[#030213] border-[#030213] rounded text-[#030213] focus:ring-2 focus:ring-blue-500"
                    />
                    <span class="text-xs text-[#0b4f4a] leading-4">Tự động gửi tin nhắn nhắc trước 1 ngày</span>
                  </label>
                </div>
              </div>
            </transition>

            <p v-if="!treatmentPlanEnabled" class="text-sm text-[#6a7282] tracking-[-0.1504px]">
              Hẹn tái khám hoặc Nhắc lịch tiêm chủng/Spa
            </p>
          </div>
        </div>
      </div>

      <!-- Right Column - Services & Prescriptions -->
      <div class="bg-white border border-black/10 rounded-[14px] p-6">
        <h3 class="font-medium text-sm text-gray-950 tracking-[-0.1504px] mb-6">Chỉ định & Kê đơn</h3>

        <div class="space-y-6">
          <!-- Tabs -->
          <div class="bg-[#ececf0] h-9 rounded-[14px] p-[3px] grid grid-cols-2 gap-1">
            <button 
              @click="activeTab = 'services'"
              :class="[
                'h-[29px] rounded-[14px] text-sm font-medium text-gray-950 tracking-[-0.1504px] transition-colors',
                activeTab === 'services' ? 'bg-white' : ''
              ]"
            >
              Dịch vụ
            </button>
            <button 
              @click="activeTab = 'medicines'"
              :class="[
                'h-[29px] rounded-[14px] text-sm font-medium text-gray-950 tracking-[-0.1504px] transition-colors',
                activeTab === 'medicines' ? 'bg-white' : ''
              ]"
            >
              Đơn thuốc
            </button>
          </div>

          <!-- Services Tab Content -->
          <div v-if="activeTab === 'services'" class="space-y-3">
            <div 
              v-for="(service, index) in services" 
              :key="index"
              @click="toggleService(index)"
              :class="[
                'border rounded-[10px] p-3 cursor-pointer transition-all',
                service.selected 
                  ? 'bg-blue-50 border-[#2b7fff]' 
                  : 'bg-white border-gray-200'
              ]"
            >
              <div class="flex items-center justify-between">
                <div class="flex items-center gap-2">
                  <div :class="[
                    'w-4 h-4 rounded border flex items-center justify-center',
                    service.selected 
                      ? 'bg-[#155dfc] border-[#155dfc]' 
                      : 'border-[#d1d5dc]'
                  ]">
                    <svg v-if="service.selected" class="w-3 h-3 text-white" viewBox="0 0 12 12" fill="currentColor">
                      <path d="M10 3L4.5 8.5L2 6"/>
                    </svg>
                  </div>
                  <span class="text-sm text-[#101828] tracking-[-0.1504px]">{{ service.name }}</span>
                </div>
                <span class="text-sm text-[#4a5565] tracking-[-0.1504px]">{{ service.price }}</span>
              </div>
            </div>

            <button 
              class="w-full h-9 bg-[#155dfc] text-white rounded-lg flex items-center justify-center gap-2 text-sm font-medium tracking-[-0.1504px] hover:bg-[#0d4fd4] transition-colors"
              @click="sendServiceOrder"
            >
              <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                <path d="M2 3l12 5-12 5 2-5-2-5z"/>
              </svg>
              🚀 Gửi phiếu chỉ định ({{ selectedServicesCount }})
            </button>
          </div>

          <!-- Medicines Tab Content -->
          <div v-if="activeTab === 'medicines'" class="space-y-3">
            <!-- Search Medicine -->
            <div class="relative">
              <input 
                v-model="medicineSearch"
                type="text" 
                placeholder="Tìm thuốc..."
                class="w-full h-9 pl-9 pr-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
              <svg class="w-4 h-4 absolute left-3 top-2.5 text-gray-400" viewBox="0 0 16 16" fill="currentColor">
                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
              </svg>
            </div>

            <!-- Medicine Item -->
            <div 
              v-for="(medicine, index) in prescriptions" 
              :key="index"
              class="bg-gray-50 rounded-[10px] p-3 space-y-2"
            >
              <div class="bg-[#f3f3f5] border-0 h-9 rounded-lg px-3 flex items-center justify-between">
                <span class="text-sm text-gray-950 tracking-[-0.1504px]">{{ medicine.name }}</span>
                <button @click="removeMedicine(index)" class="text-gray-400 hover:text-red-500">
                  <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                    <path d="M4 4l8 8m0-8l-8 8" stroke="currentColor" stroke-width="2"/>
                  </svg>
                </button>
              </div>
              <input 
                v-model="medicine.dosage"
                type="text" 
                placeholder="Liều lượng (VD: Sáng 1, Tối 1)"
                class="w-full h-8 px-3 py-1 bg-[#f3f3f5] border-0 rounded-lg text-sm text-[#717182] tracking-[-0.1504px] focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <!-- Add Medicine Button -->
            <button 
              class="w-full h-8 bg-white border border-black/10 rounded-lg flex items-center justify-center gap-2 text-sm font-medium text-gray-950 tracking-[-0.1504px] hover:bg-gray-50 transition-colors"
              @click="addMedicine"
            >
              <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                <path d="M8 2v12M2 8h12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
              </svg>
              Thêm thuốc
            </button>
          </div>

          <!-- Total & Submit -->
          <div class="border-t border-black/10 pt-4 space-y-3">
            <div class="flex items-center justify-between">
              <span class="text-sm text-[#4a5565] tracking-[-0.1504px]">Tổng tạm tính:</span>
              <span class="text-lg text-[#155dfc] tracking-[-0.4395px]">{{ totalAmount }}M</span>
            </div>
            <button 
              class="w-full h-10 bg-[#155dfc] text-white rounded-lg flex items-center justify-center gap-2 text-sm font-medium tracking-[-0.1504px] hover:bg-[#0d4fd4] transition-colors"
              @click="completeAndTransfer"
            >
              <svg class="w-4 h-4" viewBox="0 0 16 16" fill="currentColor">
                <path d="M13 3l-8 8-3-3" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
              </svg>
              Hoàn tất & Chuyển Thu ngân
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PhieuKhamBenh',
  data() {
    return {
      // Patient Info
      patientInfo: {
        image: 'https://www.figma.com/api/mcp/asset/a0df8e9e-1ca7-4fe0-b35f-6c5fd774be91',
        name: 'Luna',
        age: '1.5 tuổi',
        gender: 'Cái',
        weight: '12 kg',
        ownerName: 'Trần Thị B',
        ownerPhone: '0912345678'
      },

      // Medical History
      medicalHistory: [
        {
          date: '10/10/2024',
          treatment: 'Tiêm phòng vắc-xin 6 bệnh',
          doctor: 'BS. Nguyễn A'
        },
        {
          date: '01/01/2024',
          treatment: 'Viêm da - Điều trị kháng sinh',
          doctor: 'BS. Trần B'
        },
        {
          date: '15/08/2023',
          treatment: 'Khám tổng quát - Bình thường',
          doctor: 'BS. Nguyễn A'
        }
      ],

      // Current Examination
      examination: {
        temperature: '',
        heartRate: '',
        respiration: '',
        symptoms: '',
        diagnosis: '',
        notes: ''
      },

      // Treatment Plan
      treatmentPlanEnabled: false,
      appointmentType: 'recheck',
      duration: '',
      customDuration: '',
      durationOptions: [
        { value: '3days', label: '3 ngày' },
        { value: '5days', label: '5 ngày' },
        { value: '1week', label: '1 tuần' },
        { value: '1month', label: '1 tháng' }
      ],
      reminderMessage: '',
      sendMethods: ['zalo', 'call'],
      autoSend: true,

      // Services & Prescriptions
      activeTab: 'services',
      services: [
        { name: 'Siêu âm', price: '300K', selected: false },
        { name: 'X-Quang', price: '400K', selected: false },
        { name: 'Xét nghiệm máu', price: '500K', selected: false },
        { name: 'Xét nghiệm nước tiểu', price: '200K', selected: false }
      ],
      prescriptions: [
        { name: 'Vắc-xin Rabies', dosage: '' }
      ],
      medicineSearch: ''
    };
  },

  computed: {
    selectedServicesCount() {
      return this.services.filter(s => s.selected).length;
    },

    totalAmount() {
      let total = 0;
      
      // Calculate services total
      this.services.forEach(service => {
        if (service.selected) {
          const price = parseFloat(service.price.replace('K', '')) / 1000;
          total += price;
        }
      });

      // Add medicine costs (would need prices from database)
      // For demo purposes, assuming 0.3M per medicine
      total += this.prescriptions.length * 0.3;

      return total.toFixed(1);
    }
  },

  methods: {
    goBack() {
      this.$router.go(-1);
    },

    toggleTreatmentPlan() {
      this.treatmentPlanEnabled = !this.treatmentPlanEnabled;
    },

    toggleService(index) {
      this.services[index].selected = !this.services[index].selected;
    },

    sendServiceOrder() {
      const selectedServices = this.services.filter(s => s.selected);
      console.log('Sending service order:', selectedServices);
      // TODO: Implement service order submission
    },

    addMedicine() {
      this.prescriptions.push({ name: '', dosage: '' });
    },

    removeMedicine(index) {
      this.prescriptions.splice(index, 1);
    },

    completeAndTransfer() {
      const examinationData = {
        patient: this.patientInfo,
        examination: this.examination,
        services: this.services.filter(s => s.selected),
        prescriptions: this.prescriptions,
        total: this.totalAmount,
        treatmentPlan: this.treatmentPlanEnabled ? {
          type: this.appointmentType,
          duration: this.duration || this.customDuration,
          message: this.reminderMessage,
          sendMethods: this.sendMethods,
          autoSend: this.autoSend
        } : null
      };

      console.log('Completing examination and transferring to cashier:', examinationData);
      // TODO: Implement submission and navigation to cashier
    }
  }
};
</script>

<style scoped>
/* Import Nunito Sans font */
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;500;600;700&display=swap');

/* Fade transition for treatment plan */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease, max-height 0.3s ease;
}

.fade-enter-from, .fade-leave-to {
  opacity: 0;
  max-height: 0;
  overflow: hidden;
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
</style>