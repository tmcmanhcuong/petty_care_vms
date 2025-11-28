<template>
  <div class="flex flex-col gap-6 w-full h-full font-nunitoSans">
    <!-- Header Section -->
    <div class="flex flex-col items-start">
      <h1 class="font-medium text-[24px] leading-[36px] tracking-[0.0703px] text-[#101828]">
        Báo cáo Doanh thu
      </h1>
      <p class="font-normal text-[16px] leading-[24px] tracking-[-0.3125px] text-[#4a5565]">
        Phân tích hiệu quả kinh doanh và xu hướng doanh thu
      </p>
    </div>

    <!-- Filter Card -->
    <div class="bg-white border border-gray-300 rounded-[14px] p-6">
      <div class="flex items-center justify-between w-full gap-4">
        <button class="flex items-center justify-between px-4 py-2 bg-gray-100 rounded-[8px] flex-1">
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
            Tháng này
          </span>
          <img :src="iconChevron" alt="" class="w-[16px] h-[16px]" />
        </button>

        <button class="flex items-center justify-between px-4 py-2 bg-gray-100 rounded-[8px] flex-1">
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
            Tất cả
          </span>
          <img :src="iconChevron" alt="" class="w-[16px] h-[16px]" />
        </button>

        <button class="flex items-center justify-center gap-[8px] px-4 py-2 bg-green-600 rounded-[8px] min-w-[180px]">
          <img :src="iconDownload" alt="" class="w-[16px] h-[16px]" />
          <span class="font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-white">
            Xuất báo cáo Excel
          </span>
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-4 gap-6">
      <!-- Card 1: Tổng Doanh thu -->
      <div class="bg-white border border-gray-300 rounded-[14px] p-[24px] flex flex-col gap-[16px]">
        <div class="flex items-start justify-between">
          <div class="flex flex-col gap-[4px]">
            <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#4a5565]">
              Tổng Doanh thu
            </p>
            <p class="text-[12px] leading-[16px] text-[#6a7282]">
              Gross Revenue
            </p>
          </div>
          <div class="w-[48px] h-[48px] bg-green-100 rounded-[10px] flex items-center justify-center">
            <img :src="iconRevenue" alt="" class="w-[24px] h-[24px]" />
          </div>
        </div>
        <p class="text-[30px] leading-[36px] tracking-[0.3955px] text-green-600">
          315.1M
        </p>
        <div class="flex items-center gap-[4px]">
          <img :src="iconUp" alt="" class="w-[16px] h-[16px]" />
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-green-600">
            +15.3%
          </span>
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#6a7282]">
            so với tháng trước
          </span>
        </div>
      </div>

      <!-- Card 2: Lợi nhuận gộp -->
      <div class="bg-white border border-gray-300 rounded-[14px] p-[24px] flex flex-col gap-[16px]">
        <div class="flex items-start justify-between">
          <div class="flex flex-col gap-[4px]">
            <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#4a5565]">
              Lợi nhuận gộp
            </p>
            <p class="text-[12px] leading-[16px] text-[#6a7282]">
              Gross Profit
            </p>
          </div>
          <div class="w-[48px] h-[48px] bg-[#cbfbf1] rounded-[10px] flex items-center justify-center">
            <img :src="iconProfit" alt="" class="w-[24px] h-[24px]" />
          </div>
        </div>
        <p class="text-[30px] leading-[36px] tracking-[0.3955px] text-[#009689]">
          208.2M
        </p>
        <div class="flex items-center gap-[4px]">
          <img :src="iconUp" alt="" class="w-[16px] h-[16px]" />
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-green-600">
            +12.8%
          </span>
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#6a7282]">
            so với tháng trước
          </span>
        </div>
      </div>

      <!-- Card 3: Số lượng đơn hàng -->
      <div class="bg-white border border-gray-300 rounded-[14px] p-[24px] flex flex-col gap-[16px]">
        <div class="flex items-start justify-between">
          <div class="flex flex-col gap-[4px]">
            <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#4a5565]">
              Số lượng đơn hàng
            </p>
            <p class="text-[12px] leading-[16px] text-[#6a7282]">
              Transactions
            </p>
          </div>
          <div class="w-[48px] h-[48px] bg-blue-100 rounded-[10px] flex items-center justify-center">
            <img :src="iconOrder" alt="" class="w-[24px] h-[24px]" />
          </div>
        </div>
        <p class="text-[30px] leading-[36px] tracking-[0.3955px] text-blue-600">
          918
        </p>
        <div class="flex items-center gap-[4px]">
          <img :src="iconDown" alt="" class="w-[16px] h-[16px]" />
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-red-600">
            -5.2%
          </span>
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#6a7282]">
            so với tháng trước
          </span>
        </div>
      </div>

      <!-- Card 4: Giá trị TB đơn -->
      <div class="bg-white border border-gray-300 rounded-[14px] p-[24px] flex flex-col gap-[16px]">
        <div class="flex items-start justify-between">
          <div class="flex flex-col gap-[4px]">
            <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#4a5565]">
              Giá trị TB đơn
            </p>
            <p class="text-[12px] leading-[16px] text-[#6a7282]">
              AOV (Average Order Value)
            </p>
          </div>
          <div class="w-[48px] h-[48px] bg-[#fef3c6] rounded-[10px] flex items-center justify-center">
            <img :src="iconAOV" alt="" class="w-[24px] h-[24px]" />
          </div>
        </div>
        <p class="text-[30px] leading-[36px] tracking-[0.3955px] text-[#e17100]">
          343.2K
        </p>
        <div class="flex items-center gap-[4px]">
          <img :src="iconUp" alt="" class="w-[16px] h-[16px]" />
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-green-600">
            +8.4%
          </span>
          <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#6a7282]">
            so với tháng trước
          </span>
        </div>
      </div>
    </div>

    <!-- Chart and Donut Section -->
    <div class="flex gap-6 h-[528px]">
      <!-- Chart Card -->
      <div class="bg-white border border-gray-300 rounded-[14px] flex-1 flex flex-col gap-[24px] p-[24px]">
        <div class="flex flex-col gap-[6px]">
          <h2 class="text-[16px] leading-[16px] tracking-[-0.3125px] text-neutral-950">
            Xu hướng Doanh thu
          </h2>
          <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#4a5565]">
            Biểu đồ theo dõi doanh thu và lợi nhuận theo thời gian
          </p>
        </div>
        
        <div class="flex-1 flex flex-col gap-[16px]">
          <div class="h-[350px] w-full overflow-hidden">
            <img :src="chartImage" alt="Chart" class="w-full h-full object-contain" />
          </div>
          
          <div class="bg-blue-50 border border-[#bedbff] rounded-[10px] p-[13px]">
            <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#193cb8]">
              💡 <span class="font-bold">Click vào cột</span> để xem chi tiết hóa đơn của ngày đó
            </p>
          </div>
        </div>
      </div>

      <!-- Donut Card -->
      <div class="bg-white border border-gray-300 rounded-[14px] w-[357px] flex flex-col gap-[24px]">
        <div class="p-[24px] pb-0">
          <h2 class="text-[16px] leading-[16px] tracking-[-0.3125px] text-neutral-950 mb-[16px]">
            Cơ cấu nguồn thu
          </h2>
          <div class="flex items-center gap-[8px]">
            <button class="px-[12px] h-[32px] bg-teal-600 text-white rounded-[8px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px]">
              Theo Khoa
            </button>
            <button class="px-[13px] h-[32px] bg-white border border-gray-300 text-neutral-950 rounded-[8px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px]">
              Theo PT Thanh toán
            </button>
          </div>
        </div>

        <div class="px-[24px] flex flex-col gap-[16px]">
          <div class="h-[250px] w-full overflow-hidden flex items-center justify-center">
            <img :src="donutChart" alt="Donut Chart" class="max-w-full max-h-full" />
          </div>

          <div class="flex flex-col gap-[8px]">
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-[8px]">
                <div class="w-[12px] h-[12px] bg-teal-600 rounded-full"></div>
                <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#364153]">
                  Lâm sàng
                </span>
              </div>
              <div class="flex flex-col items-end">
                <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#101828]">
                  40%
                </p>
                <p class="text-[12px] leading-[16px] text-[#6a7282]">
                  200.0M
                </p>
              </div>
            </div>

            <div class="flex items-center justify-between">
              <div class="flex items-center gap-[8px]">
                <div class="w-[12px] h-[12px] bg-amber-500 rounded-full"></div>
                <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#364153]">
                  Spa
                </span>
              </div>
              <div class="flex flex-col items-end">
                <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#101828]">
                  35%
                </p>
                <p class="text-[12px] leading-[16px] text-[#6a7282]">
                  175.0M
                </p>
              </div>
            </div>

            <div class="flex items-center justify-between">
              <div class="flex items-center gap-[8px]">
                <div class="w-[12px] h-[12px] bg-blue-500 rounded-full"></div>
                <span class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#364153]">
                  Petshop
                </span>
              </div>
              <div class="flex flex-col items-end">
                <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#101828]">
                  25%
                </p>
                <p class="text-[12px] leading-[16px] text-[#6a7282]">
                  125.0M
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Table Card -->
    <div class="bg-white border border-gray-300 rounded-[14px] flex flex-col gap-[24px] h-[621.5px]">
      <div class="p-[24px] pb-0">
        <h2 class="text-[16px] leading-[16px] tracking-[-0.3125px] text-neutral-950">
          Chi tiết doanh thu theo ngày
        </h2>
        <p class="text-[14px] leading-[20px] tracking-[-0.1504px] text-[#4a5565] mt-[6px]">
          Bảng dữ liệu chi tiết để đối chiếu và phân tích
        </p>
      </div>

      <div class="px-[24px] flex flex-col gap-[16px]">
        <div class="overflow-y-auto h-[409.5px]">
          <table class="w-full">
            <thead>
              <tr class="border-b border-gray-300">
                <th class="text-left px-[8px] py-[10px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
                  Thời gian
                </th>
                <th class="text-right px-[8px] py-[10px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
                  Số đơn hàng
                </th>
                <th class="text-right px-[8px] py-[10px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
                  Doanh thu
                </th>
                <th class="text-right px-[8px] py-[10px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
                  Giá vốn (COGS)
                </th>
                <th class="text-right px-[8px] py-[10px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
                  Lợi nhuận gộp
                </th>
                <th class="text-right px-[8px] py-[10px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
                  Thu tiền mặt
                </th>
                <th class="text-right px-[8px] py-[10px] font-medium text-[14px] leading-[20px] tracking-[-0.1504px] text-neutral-950">
                  Thu Online
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="row in tableData" :key="row.date" class="border-b border-gray-300">
                <td class="px-[8px] py-[10px] text-[14px] leading-[20px] tracking-[-0.1504px] text-[#101828]">
                  {{ row.date }}
                </td>
                <td class="px-[8px] py-[10px] text-right text-[14px] leading-[20px] tracking-[-0.1504px] text-[#101828]">
                  {{ row.orders }} đơn
                </td>
                <td class="px-[8px] py-[10px] text-right text-[14px] leading-[20px] tracking-[-0.1504px] text-[#101828]">
                  {{ row.revenue }} ₫
                </td>
                <td class="px-[8px] py-[10px] text-right text-[14px] leading-[20px] tracking-[-0.1504px] text-[#4a5565]">
                  {{ row.cogs }} ₫
                </td>
                <td class="px-[8px] py-[10px] text-right text-[14px] leading-[20px] tracking-[-0.1504px] text-green-600">
                  {{ row.profit }} ₫
                </td>
                <td class="px-[8px] py-[10px] text-right text-[14px] leading-[20px] tracking-[-0.1504px] text-[#e17100]">
                  {{ row.cash }} ₫
                </td>
                <td class="px-[8px] py-[10px] text-right text-[14px] leading-[20px] tracking-[-0.1504px] text-blue-600">
                  {{ row.online }} ₫
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="bg-gray-50 rounded-[10px] p-[16px]">
          <div class="grid grid-cols-4 gap-[16px]">
            <div class="flex flex-col gap-[4px]">
              <p class="text-[12px] leading-[16px] text-[#4a5565]">
                Tổng đơn hàng
              </p>
              <p class="text-[18px] leading-[28px] tracking-[-0.4395px] text-[#101828]">
                918 đơn
              </p>
            </div>
            <div class="flex flex-col gap-[4px]">
              <p class="text-[12px] leading-[16px] text-[#4a5565]">
                Tổng doanh thu
              </p>
              <p class="text-[18px] leading-[28px] tracking-[-0.4395px] text-green-600">
                315.1M
              </p>
            </div>
            <div class="flex flex-col gap-[4px]">
              <p class="text-[12px] leading-[16px] text-[#4a5565]">
                Tổng lợi nhuận
              </p>
              <p class="text-[18px] leading-[28px] tracking-[-0.4395px] text-[#009689]">
                208.2M
              </p>
            </div>
            <div class="flex flex-col gap-[4px]">
              <p class="text-[12px] leading-[16px] text-[#4a5565]">
                AOV trung bình
              </p>
              <p class="text-[18px] leading-[28px] tracking-[-0.4395px] text-[#e17100]">
                343.2K
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

// Icon URLs from Figma
const iconChevron = "https://www.figma.com/api/mcp/asset/b19e8885-b191-4b58-937c-d3c7da0f3560";
const iconDownload = "https://www.figma.com/api/mcp/asset/f72168b2-f8e2-4fc7-a2ef-a2648471dfc2";
const iconRevenue = "https://www.figma.com/api/mcp/asset/a0efef7c-7f90-48d0-b2f0-624304f9dccb";
const iconProfit = "https://www.figma.com/api/mcp/asset/46d3451b-7edf-464e-9a88-4997a6c92d8a";
const iconOrder = "https://www.figma.com/api/mcp/asset/c6535cbd-75a2-4f23-be79-e17cd6f10d12";
const iconAOV = "https://www.figma.com/api/mcp/asset/432c111c-d84a-46da-bf02-29650dcb795c";
const iconUp = "https://www.figma.com/api/mcp/asset/ebf04af6-a622-40b5-b79b-21e46325f07b";
const iconDown = "https://www.figma.com/api/mcp/asset/7b156a71-55e7-4946-8cfa-c0a23a081d4d";
const chartImage = "https://www.figma.com/api/mcp/asset/ee1c8aed-7f4a-4229-b3b9-6df067bbd143";
const donutChart = "https://www.figma.com/api/mcp/asset/d7475dc8-6010-468b-9fb7-780781e255ff";

// Table data
const tableData = ref([
  {
    date: '01/11/2025',
    orders: '42',
    revenue: '14.200.000',
    cogs: '4.800.000',
    profit: '9.400.000',
    cash: '2.800.000',
    online: '11.400.000'
  },
  {
    date: '02/11/2025',
    orders: '38',
    revenue: '12.600.000',
    cogs: '4.200.000',
    profit: '8.400.000',
    cash: '2.500.000',
    online: '10.100.000'
  },
  {
    date: '03/11/2025',
    orders: '45',
    revenue: '15.800.000',
    cogs: '5.400.000',
    profit: '10.400.000',
    cash: '3.200.000',
    online: '12.600.000'
  },
  {
    date: '04/11/2025',
    orders: '51',
    revenue: '17.200.000',
    cogs: '5.800.000',
    profit: '11.400.000',
    cash: '3.400.000',
    online: '13.800.000'
  },
  {
    date: '05/11/2025',
    orders: '48',
    revenue: '16.400.000',
    cogs: '5.600.000',
    profit: '10.800.000',
    cash: '3.300.000',
    online: '13.100.000'
  },
  {
    date: '06/11/2025',
    orders: '43',
    revenue: '14.800.000',
    cogs: '5.000.000',
    profit: '9.800.000',
    cash: '3.000.000',
    online: '11.800.000'
  },
  {
    date: '07/11/2025',
    orders: '40',
    revenue: '13.500.000',
    cogs: '4.600.000',
    profit: '8.900.000',
    cash: '2.700.000',
    online: '10.800.000'
  },
  {
    date: '08/11/2025',
    orders: '46',
    revenue: '15.600.000',
    cogs: '5.300.000',
    profit: '10.300.000',
    cash: '3.100.000',
    online: '12.500.000'
  },
  {
    date: '09/11/2025',
    orders: '49',
    revenue: '16.800.000',
    cogs: '5.700.000',
    profit: '11.100.000',
    cash: '3.400.000',
    online: '13.400.000'
  },
  {
    date: '10/11/2025',
    orders: '44',
    revenue: '15.000.000',
    cogs: '5.100.000',
    profit: '9.900.000',
    cash: '3.000.000',
    online: '12.000.000'
  }
]);
</script>

<style scoped>
/* Custom scrollbar for table */
::-webkit-scrollbar {
  width: 6px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}

::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 3px;
}

::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style>
