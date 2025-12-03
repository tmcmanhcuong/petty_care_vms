<template>
  <div class="flex flex-col gap-6 h-full w-full">
    <!-- Page Header -->
    <div class="flex flex-col h-[60px]">
      <h1 class="text-[24px] font-medium leading-[36px] text-[#101828] tracking-[0.0703px]" style="font-family: 'Nunito Sans', 'Inter', sans-serif;">
        Lịch khám
      </h1>
      <p class="text-[16px] font-normal leading-6 text-[#4a5565] tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
        Quản lý lịch khám - Chỉ hiển thị ca khám được phân cho bạn
      </p>
    </div>

    <!-- Toolbar Card -->
    <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-4">
      <!-- Date Navigation and View Toggle -->
      <div class="flex items-center justify-between h-10 mb-4">
        <!-- Left: Date Navigation -->
        <div class="flex items-center gap-2 flex-1">
          <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50 transition-colors">
            <img :src="icons.chevronLeft" alt="" class="w-4 h-4" />
          </button>
          <div class="bg-gray-50 rounded-[10px] px-[34.6px] py-[10.5px] flex-1">
            <p class="text-[16px] font-normal leading-6 text-[#101828] text-center tracking-[-0.3125px]" style="font-family: 'Inter', sans-serif;">
              {{ currentDateText }}
            </p>
          </div>
          <button class="w-[38px] h-8 bg-white border border-[rgba(0,0,0,0.1)] rounded-lg flex items-center justify-center hover:bg-gray-50 transition-colors">
            <img :src="icons.chevronRight" alt="" class="w-4 h-4" />
          </button>
          <button class="h-9 px-4 py-2 bg-[#009689] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg hover:bg-[#00857a] transition-colors" style="font-family: 'Inter', sans-serif;">
            Hôm nay
          </button>
        </div>

        <!-- Right: View Toggle -->
        <div class="flex items-center gap-2">
          <button class="h-8 px-[10px] bg-[#155dfc] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-[#1447e6] transition-colors" style="font-family: 'Inter', sans-serif;">
            <img :src="icons.listView" alt="" class="w-4 h-4" />
            Danh sách
          </button>
          <button class="h-8 px-[11px] bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950 text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center gap-2 hover:bg-gray-50 transition-colors" style="font-family: 'Inter', sans-serif;">
            <img :src="icons.calendar" alt="" class="w-4 h-4" />
            Lịch biểu
          </button>
        </div>
      </div>

      <!-- Status Filter Tabs -->
      <div class="flex items-center gap-2 h-9">
        <button 
          v-for="tab in statusTabs" 
          :key="tab.value"
          :class="[
            'h-9 px-4 rounded-[10px] text-[14px] font-normal leading-5 tracking-[-0.1504px] transition-colors',
            activeTab === tab.value 
              ? 'bg-[#155dfc] text-white' 
              : 'bg-gray-100 text-[#364153] hover:bg-gray-200'
          ]"
          @click="activeTab = tab.value"
          style="font-family: 'Inter', sans-serif;"
        >
          {{ tab.label }}
          <span class="opacity-75">({{ tab.count }})</span>
        </button>
      </div>
    </div>

    <!-- Appointments List -->
    <div class="flex flex-col gap-4 overflow-y-auto" style="max-height: calc(100vh - 300px);">
      <!-- Appointment Card - Waiting (Red Border) -->
      <div class="bg-white border-l-4 border-[#fb2c36] border-t border-r border-b border-t-[rgba(0,0,0,0.1)] border-r-[rgba(0,0,0,0.1)] border-b-[rgba(0,0,0,0.1)] rounded-[14px] p-6">
        <div class="flex items-start gap-4">
          <!-- Time Section -->
          <div class="flex flex-col gap-3 w-[165px] border-r border-gray-200 pr-4">
            <div class="flex flex-col">
              <p class="text-[24px] font-normal leading-8 text-[#101828] tracking-[0.0703px]" style="font-family: 'Inter', sans-serif;">09:00</p>
              <p class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">30p</p>
            </div>
            <div class="bg-green-100 border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center gap-1 opacity-[0.655] w-fit">
              <img :src="icons.checkCircle" alt="" class="w-3 h-3" />
              <span class="text-[12px] font-medium leading-4 text-[#008236]" style="font-family: 'Inter', sans-serif;">Đã đến</span>
            </div>
            <div class="bg-[#ffedd4] border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center w-fit">
              <span class="text-[12px] font-medium leading-4 text-[#ca3500]" style="font-family: 'Inter', sans-serif;">⏳ Đang chờ</span>
            </div>
          </div>

          <!-- Pet Info Section -->
          <div class="flex items-start gap-4 flex-1">
            <div class="w-24 h-24 border-2 border-gray-200 rounded-[14px] overflow-hidden">
              <img :src="appointments[0].petImage" alt="" class="w-full h-full object-cover" />
            </div>
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-3">
                <h3 class="text-[18px] font-normal leading-7 text-[#101828] tracking-[-0.4395px]" style="font-family: 'Inter', sans-serif;">
                  <span class="font-bold">{{ appointments[0].petName }}</span>({{ appointments[0].petBreed }})
                </h3>
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">- {{ appointments[0].petAge }}</span>
              </div>
              <div class="flex items-center gap-2 mb-3">
                <p class="text-[14px] font-normal leading-5 text-[#364153] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  Chủ: <span class="font-bold">{{ appointments[0].ownerName }}</span>
                </p>
                <span class="text-[16px] font-normal leading-6 text-[#99a1af] tracking-[-0.3125px]">•</span>
                <div class="flex items-center gap-1">
                  <img :src="icons.phone" alt="" class="w-3 h-3" />
                  <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">{{ appointments[0].ownerPhone }}</span>
                </div>
              </div>
              <div class="bg-blue-50 border border-[#bedbff] rounded-lg px-2 py-[3px] inline-flex mb-3">
                <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">{{ appointments[0].service }}</span>
              </div>
              <div v-if="appointments[0].note" class="bg-amber-50 border border-[#fee685] rounded-[10px] p-[13px]">
                <p class="text-[14px] leading-5 text-[#7b3306] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  <span class="font-bold">📝 Ghi chú:</span> {{ appointments[0].note }}
                </p>
              </div>
            </div>
          </div>

          <!-- Action Button -->
          <button class="h-9 w-[255px] bg-[#155dfc] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center justify-center gap-2 hover:bg-[#1447e6] transition-colors" style="font-family: 'Inter', sans-serif;">
            <img :src="icons.playCircle" alt="" class="w-4 h-4" />
            BẮT ĐẦU
          </button>
        </div>
      </div>

      <!-- Appointment Card - In Progress (Blue Border) -->
      <div class="bg-white border-2 border-[#2b7fff] rounded-[14px] p-6">
        <div class="flex items-start gap-4">
          <!-- Time Section -->
          <div class="flex flex-col gap-3 w-[165px] border-r border-gray-200 pr-4">
            <div class="flex flex-col">
              <p class="text-[24px] font-normal leading-8 text-[#101828] tracking-[0.0703px]" style="font-family: 'Inter', sans-serif;">09:30</p>
              <p class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">30p</p>
            </div>
            <div class="bg-green-100 border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center gap-1 opacity-[0.655] w-fit">
              <img :src="icons.checkCircle" alt="" class="w-3 h-3" />
              <span class="text-[12px] font-medium leading-4 text-[#008236]" style="font-family: 'Inter', sans-serif;">Đã đến</span>
            </div>
            <div class="bg-blue-100 border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center w-fit">
              <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">🩺 Đang khám</span>
            </div>
          </div>

          <!-- Pet Info Section -->
          <div class="flex items-start gap-4 flex-1">
            <div class="w-24 h-24 border-2 border-gray-200 rounded-[14px] overflow-hidden">
              <img :src="appointments[1].petImage" alt="" class="w-full h-full object-cover" />
            </div>
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-3">
                <h3 class="text-[18px] font-normal leading-7 text-[#101828] tracking-[-0.4395px]" style="font-family: 'Inter', sans-serif;">
                  <span class="font-bold">{{ appointments[1].petName }}</span>({{ appointments[1].petBreed }})
                </h3>
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">- {{ appointments[1].petAge }}</span>
                <div class="bg-purple-100 border border-transparent rounded-lg px-[9px] py-[3px] inline-flex">
                  <span class="text-[12px] font-medium leading-4 text-[#8200db]" style="font-family: 'Inter', sans-serif;">NEW</span>
                </div>
              </div>
              <div class="flex items-center gap-2 mb-3">
                <p class="text-[14px] font-normal leading-5 text-[#364153] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  Chủ: <span class="font-bold">{{ appointments[1].ownerName }}</span>
                </p>
                <span class="text-[16px] font-normal leading-6 text-[#99a1af] tracking-[-0.3125px]">•</span>
                <div class="flex items-center gap-1">
                  <img :src="icons.phone" alt="" class="w-3 h-3" />
                  <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">{{ appointments[1].ownerPhone }}</span>
                </div>
              </div>
              <div class="bg-blue-50 border border-[#bedbff] rounded-lg px-2 py-[3px] inline-flex">
                <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">{{ appointments[1].service }}</span>
              </div>
            </div>
          </div>

          <!-- Action Button -->
          <button class="h-9 w-[255px] bg-[#f54900] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center justify-center hover:bg-[#ca3500] transition-colors" style="font-family: 'Inter', sans-serif;">
            🩺 TIẾP TỤC
          </button>
        </div>
      </div>

      <!-- Appointment Card - Completed (Gray Border) -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-6">
        <div class="flex items-start gap-4">
          <!-- Time Section -->
          <div class="flex flex-col gap-3 w-[165px] border-r border-gray-200 pr-4">
            <div class="flex flex-col">
              <p class="text-[24px] font-normal leading-8 text-[#101828] tracking-[0.0703px]" style="font-family: 'Inter', sans-serif;">10:00</p>
              <p class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">30p</p>
            </div>
            <div class="bg-green-100 border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center gap-1 opacity-[0.655] w-fit">
              <img :src="icons.checkCircle" alt="" class="w-3 h-3" />
              <span class="text-[12px] font-medium leading-4 text-[#008236]" style="font-family: 'Inter', sans-serif;">Đã đến</span>
            </div>
            <div class="bg-green-100 border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center w-fit">
              <span class="text-[12px] font-medium leading-4 text-[#008236]" style="font-family: 'Inter', sans-serif;">✅ Hoàn thành</span>
            </div>
          </div>

          <!-- Pet Info Section -->
          <div class="flex items-start gap-4 flex-1">
            <div class="w-24 h-24 border-2 border-gray-200 rounded-[14px] overflow-hidden">
              <img :src="appointments[2].petImage" alt="" class="w-full h-full object-cover" />
            </div>
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-3">
                <h3 class="text-[18px] font-normal leading-7 text-[#101828] tracking-[-0.4395px]" style="font-family: 'Inter', sans-serif;">
                  <span class="font-bold">{{ appointments[2].petName }}</span>({{ appointments[2].petBreed }})
                </h3>
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">- {{ appointments[2].petAge }}</span>
              </div>
              <div class="flex items-center gap-2 mb-3">
                <p class="text-[14px] font-normal leading-5 text-[#364153] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  Chủ: <span class="font-bold">{{ appointments[2].ownerName }}</span>
                </p>
                <span class="text-[16px] font-normal leading-6 text-[#99a1af] tracking-[-0.3125px]">•</span>
                <div class="flex items-center gap-1">
                  <img :src="icons.phone" alt="" class="w-3 h-3" />
                  <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">{{ appointments[2].ownerPhone }}</span>
                </div>
              </div>
              <div class="bg-blue-50 border border-[#bedbff] rounded-lg px-2 py-[3px] inline-flex">
                <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">{{ appointments[2].service }}</span>
              </div>
            </div>
          </div>

          <!-- Action Button -->
          <button class="h-9 w-[255px] bg-white border border-[rgba(0,0,0,0.1)] text-neutral-950 text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center justify-center gap-2 hover:bg-gray-50 transition-colors" style="font-family: 'Inter', sans-serif;">
            <img :src="icons.eyeIcon" alt="" class="w-4 h-4" />
            Xem lại
          </button>
        </div>
      </div>

      <!-- Appointment Card - Waiting (No Photo) -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-6">
        <div class="flex items-start gap-4">
          <!-- Time Section -->
          <div class="flex flex-col gap-3 w-[165px] border-r border-gray-200 pr-4">
            <div class="flex flex-col">
              <p class="text-[24px] font-normal leading-8 text-[#101828] tracking-[0.0703px]" style="font-family: 'Inter', sans-serif;">10:30</p>
              <p class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">30p</p>
            </div>
            <div class="bg-[#ffedd4] border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center w-fit">
              <span class="text-[12px] font-medium leading-4 text-[#ca3500]" style="font-family: 'Inter', sans-serif;">⏳ Đang chờ</span>
            </div>
          </div>

          <!-- Pet Info Section -->
          <div class="flex items-start gap-4 flex-1">
            <div class="w-24 h-24 border-2 border-gray-200 rounded-[14px] overflow-hidden bg-gray-100 flex items-center justify-center">
              <span class="text-[30px]">🐕</span>
            </div>
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-3">
                <h3 class="text-[18px] font-normal leading-7 text-[#101828] tracking-[-0.4395px]" style="font-family: 'Inter', sans-serif;">
                  <span class="font-bold">{{ appointments[3].petName }}</span>({{ appointments[3].petBreed }})
                </h3>
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">- {{ appointments[3].petAge }}</span>
              </div>
              <div class="flex items-center gap-2 mb-3">
                <p class="text-[14px] font-normal leading-5 text-[#364153] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  Chủ: <span class="font-bold">{{ appointments[3].ownerName }}</span>
                </p>
                <span class="text-[16px] font-normal leading-6 text-[#99a1af] tracking-[-0.3125px]">•</span>
                <div class="flex items-center gap-1">
                  <img :src="icons.phone" alt="" class="w-3 h-3" />
                  <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">{{ appointments[3].ownerPhone }}</span>
                </div>
              </div>
              <div class="bg-blue-50 border border-[#bedbff] rounded-lg px-2 py-[3px] inline-flex">
                <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">{{ appointments[3].service }}</span>
              </div>
            </div>
          </div>

          <!-- Action Button -->
          <button class="h-9 w-[255px] bg-[#155dfc] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center justify-center gap-2 hover:bg-[#1447e6] transition-colors" style="font-family: 'Inter', sans-serif;">
            <img :src="icons.calendarToday" alt="" class="w-4 h-4" />
            BẮT ĐẦU
          </button>
        </div>
      </div>

      <!-- Appointment Card - Waiting with Note -->
      <div class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[14px] p-6">
        <div class="flex items-start gap-4">
          <!-- Time Section -->
          <div class="flex flex-col gap-3 w-[165px] border-r border-gray-200 pr-4">
            <div class="flex flex-col">
              <p class="text-[24px] font-normal leading-8 text-[#101828] tracking-[0.0703px]" style="font-family: 'Inter', sans-serif;">11:00</p>
              <p class="text-[14px] font-normal leading-5 text-[#6a7282] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">60p</p>
            </div>
            <div class="bg-[#ffedd4] border border-transparent rounded-lg px-[9px] py-[3px] inline-flex items-center w-fit">
              <span class="text-[12px] font-medium leading-4 text-[#ca3500]" style="font-family: 'Inter', sans-serif;">⏳ Đang chờ</span>
            </div>
          </div>

          <!-- Pet Info Section -->
          <div class="flex items-start gap-4 flex-1">
            <div class="w-24 h-24 border-2 border-gray-200 rounded-[14px] overflow-hidden">
              <img :src="appointments[4].petImage" alt="" class="w-full h-full object-cover" />
            </div>
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-3">
                <h3 class="text-[18px] font-normal leading-7 text-[#101828] tracking-[-0.4395px]" style="font-family: 'Inter', sans-serif;">
                  <span class="font-bold">{{ appointments[4].petName }}</span>({{ appointments[4].petBreed }})
                </h3>
                <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">- {{ appointments[4].petAge }}</span>
              </div>
              <div class="flex items-center gap-2 mb-3">
                <p class="text-[14px] font-normal leading-5 text-[#364153] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  Chủ: <span class="font-bold">{{ appointments[4].ownerName }}</span>
                </p>
                <span class="text-[16px] font-normal leading-6 text-[#99a1af] tracking-[-0.3125px]">•</span>
                <div class="flex items-center gap-1">
                  <img :src="icons.phone" alt="" class="w-3 h-3" />
                  <span class="text-[14px] font-normal leading-5 text-[#4a5565] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">{{ appointments[4].ownerPhone }}</span>
                </div>
              </div>
              <div class="bg-blue-50 border border-[#bedbff] rounded-lg px-2 py-[3px] inline-flex mb-3">
                <span class="text-[12px] font-medium leading-4 text-[#1447e6]" style="font-family: 'Inter', sans-serif;">{{ appointments[4].service }}</span>
              </div>
              <div v-if="appointments[4].note" class="bg-amber-50 border border-[#fee685] rounded-[10px] p-[13px]">
                <p class="text-[14px] leading-5 text-[#7b3306] tracking-[-0.1504px]" style="font-family: 'Inter', sans-serif;">
                  <span class="font-bold">📝 Ghi chú:</span> {{ appointments[4].note }}
                </p>
              </div>
            </div>
          </div>

          <!-- Action Button -->
          <button class="h-9 w-[255px] bg-[#155dfc] text-white text-[14px] font-medium leading-5 tracking-[-0.1504px] rounded-lg flex items-center justify-center gap-2 hover:bg-[#1447e6] transition-colors" style="font-family: 'Inter', sans-serif;">
            <img :src="icons.calendarToday" alt="" class="w-4 h-4" />
            BẮT ĐẦU
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

// Icons from Figma
const icons = {
  chevronLeft: "https://www.figma.com/api/mcp/asset/dcda70b5-46a3-4c0f-a889-348b89df96b9",
  chevronRight: "https://www.figma.com/api/mcp/asset/e1aa7f82-33cb-4128-b2c5-56d7232ce76c",
  listView: "https://www.figma.com/api/mcp/asset/6f02bf87-a64e-4e6b-a300-98c985480d78",
  calendar: "https://www.figma.com/api/mcp/asset/db990fe5-eeda-4d7a-8bc4-0ad8373b2c1f",
  checkCircle: "https://www.figma.com/api/mcp/asset/702a1446-dc44-463a-9a81-499741bad4ca",
  phone: "https://www.figma.com/api/mcp/asset/52ad630b-cd0d-4286-b1dd-c58339a7e5dc",
  playCircle: "https://www.figma.com/api/mcp/asset/d25d6ebf-e2f5-467d-a889-01913a6f996a",
  eyeIcon: "https://www.figma.com/api/mcp/asset/a872ff23-fc92-4bde-8371-dd6a95d301e8",
  calendarToday: "https://www.figma.com/api/mcp/asset/4d700e36-04c0-465a-aa38-b18df8383b01"
};

// Current date
const currentDateText = ref('Thứ 2, 01/12/2025');

// Active tab
const activeTab = ref('all');

// Status tabs
const statusTabs = ref([
  { label: 'Tất cả', value: 'all', count: 5 },
  { label: '⏳ Đang chờ', value: 'waiting', count: 3 },
  { label: '🩺 Đang khám', value: 'examining', count: 1 },
  { label: '✅ Hoàn thành', value: 'completed', count: 1 }
]);

// Appointments data
const appointments = ref([
  {
    time: '09:00',
    duration: '30p',
    status: 'waiting',
    arrived: true,
    petName: 'Milo',
    petBreed: 'Golden Retriever',
    petAge: '2 tuổi',
    petImage: 'https://www.figma.com/api/mcp/asset/d5407383-5007-4d71-b56f-dc25ff3edbad',
    ownerName: 'Nguyễn Văn A',
    ownerPhone: '0901234567',
    service: 'Khám da liễu',
    note: 'Bé hơi dữ, cẩn thận khi tiếp xúc'
  },
  {
    time: '09:30',
    duration: '30p',
    status: 'examining',
    arrived: true,
    petName: 'Luna',
    petBreed: 'Mèo Ba Tư',
    petAge: '1 tuổi',
    petImage: 'https://www.figma.com/api/mcp/asset/85b46eea-5637-456e-a38e-14d4280cf26a',
    ownerName: 'Trần Thị B',
    ownerPhone: '0912345678',
    service: 'Tiêm phòng vắc-xin',
    isNew: true
  },
  {
    time: '10:00',
    duration: '30p',
    status: 'completed',
    arrived: true,
    petName: 'Max',
    petBreed: 'Chó Husky',
    petAge: '3 tuổi',
    petImage: 'https://www.figma.com/api/mcp/asset/90036aa7-c05d-4d2c-9626-b1121e0039f5',
    ownerName: 'Lê Văn C',
    ownerPhone: '0923456789',
    service: 'Khám tổng quát'
  },
  {
    time: '10:30',
    duration: '30p',
    status: 'waiting',
    arrived: false,
    petName: 'Bella',
    petBreed: 'Chó Poodle',
    petAge: '4 tuổi',
    petImage: null,
    ownerName: 'Phạm Thị D',
    ownerPhone: '0934567890',
    service: 'Cắt tỉa lông'
  },
  {
    time: '11:00',
    duration: '60p',
    status: 'waiting',
    arrived: false,
    petName: 'Rocky',
    petBreed: 'Chó Bulldog',
    petAge: '5 tuổi',
    petImage: 'https://www.figma.com/api/mcp/asset/ec0c8147-a467-46fc-a61d-0006c6610147',
    ownerName: 'Hoàng Văn E',
    ownerPhone: '0945678901',
    service: 'Phẫu thuật',
    note: 'Phẫu thuật sỏi thận - Cần chuẩn bị đặc biệt'
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
