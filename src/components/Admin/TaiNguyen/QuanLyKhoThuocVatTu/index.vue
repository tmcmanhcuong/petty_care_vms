<template>
  <div class="relative w-full h-full">
    <!-- Header -->
    <div class="flex flex-col gap-0 h-[60px]">
      <h1 class="font-nunito font-medium text-2xl leading-9 text-[#101828] tracking-wide">
        Kho thuốc & Vật tư
      </h1>
      <p class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">
        Quản lý hàng hóa, tồn kho và nhập xuất
      </p>
    </div>

    <!-- Tabs and Content -->
    <div class="flex flex-col gap-8 mt-6">
      <!-- Tab List -->
      <div class="bg-[#f3f4f6] flex items-center p-1 rounded-[10px] shadow-sm w-fit">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          @click="activeTab = tab.id"
          :class="activeTab === tab.id ? 'bg-white shadow-md text-[#0d9488]' : 'text-[#4b5563]'"
          class="font-nunito font-medium text-sm leading-5 px-6 py-2.5 rounded-lg transition-all"
        >
          {{ tab.name }}
        </button>
      </div>

      <!-- Tab Content -->
      <!-- Danh sách & Tồn kho Tab -->
      <div v-if="activeTab === 'danh-sach'" class="flex flex-col gap-6">
        <!-- Statistics Cards -->
        <div class="grid grid-cols-4 gap-4 h-[90px]">
          <div
            v-for="stat in inventoryStats"
            :key="stat.id"
            class="bg-white border border-gray-200/60 rounded-[14px] p-[17px] flex items-center gap-3"
          >
            <div class="size-12 rounded-[10px] flex items-center justify-center" :class="stat.bgColor">
              <img :src="stat.icon" alt="" class="w-6 h-6" />
            </div>
            <div class="flex flex-col gap-0">
              <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ stat.label }}</p>
              <p class="font-nunito text-base leading-6 tracking-tight" :class="stat.textColor">{{ stat.count }}</p>
            </div>
          </div>
        </div>

        <!-- Main Content Card -->
        <div class="bg-white border border-gray-200/60 rounded-[14px] p-6">
          <div class="flex flex-col gap-6">
            <!-- Header -->
            <div class="flex items-center justify-between h-9">
              <h3 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight">
                Danh sách hàng hóa
              </h3>
              <div class="flex items-center gap-3">
                <button class="btn-secondary" @click="handleManageCategories">
                  <img :src="iconFolder" alt="" class="btn-icon" />
                  <span class="btn-text">Danh Mục Hàng Hoá</span>
                </button>
                <button 
                  class="bg-[#5a9690] rounded-lg h-9 px-3 py-2 flex items-center gap-2 hover:bg-[#4a8580] transition-colors"
                  @click="isAddModalOpen = true"
                >
                  <img :src="iconAddItem" alt="" class="w-4 h-4" />
                  <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
                    Thêm Hàng Hoá
                  </span>
                </button>
              </div>
            </div>

            <!-- Search and Filters -->
            <div class="flex items-center gap-4 h-9">
              <!-- Search -->
              <div class="relative flex-1">
                <img :src="iconSearchList" alt="" class="absolute left-3 top-[10px] w-4 h-4" />
                <input
                  v-model="searchInventory"
                  type="text"
                  placeholder="Tìm tên thuốc, mã thuốc, hoạt chất..."
                  class="bg-[#f3f3f5] border-none rounded-lg h-9 w-full pl-10 pr-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
                />
              </div>

              <!-- Category Filter -->
              <button class="bg-[#f3f3f5] border-none rounded-lg h-9 w-48 px-[13px] py-0.5 flex items-center justify-between hover:bg-gray-200 transition-colors">
                <img :src="iconFilterList" alt="" class="w-4 h-4" />
                <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">{{ filterCategory }}</span>
                <img :src="iconChevronDown" alt="" class="w-4 h-4" />
              </button>

              <!-- Unit Filter -->
              <button class="bg-[#f3f3f5] border-none rounded-lg h-9 w-48 px-[13px] py-0.5 flex items-center justify-between hover:bg-gray-200 transition-colors">
                <img :src="iconFilterList" alt="" class="w-4 h-4" />
                <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">{{ filterUnit }}</span>
                <img :src="iconChevronDown" alt="" class="w-4 h-4" />
              </button>

              <!-- Status Filter -->
              <button class="bg-[#f3f3f5] border-none rounded-lg h-9 w-48 px-[13px] py-0.5 flex items-center justify-between hover:bg-gray-200 transition-colors">
                <img :src="iconFilterList" alt="" class="w-4 h-4" />
                <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">{{ filterStatus }}</span>
                <img :src="iconChevronDown" alt="" class="w-4 h-4" />
              </button>
            </div>

            <!-- Table -->
            <div class="overflow-hidden">
              <table class="w-full">
                <thead>
                  <tr class="border-b border-gray-200/60">
                    <th class="text-left py-[10px] px-2">
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Ảnh & Tên</span>
                    </th>
                    <th class="text-left py-[10px] px-2">
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Phân loại</span>
                    </th>
                    <th class="text-left py-[10px] px-2">
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Đơn vị</span>
                    </th>
                    <th class="text-left py-[10px] px-2">
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Giá vốn / Giá bán</span>
                    </th>
                    <th class="text-left py-[10px] px-2">
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tồn kho</span>
                    </th>
                    <th class="text-left py-[10px] px-2">
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Hạn sử dụng</span>
                    </th>
                    <th class="text-right py-[10px] px-2">
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thao tác</span>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="item in inventoryList"
                    :key="item.id"
                    class="border-b border-gray-200/60"
                  >
                    <!-- Image & Name -->
                    <td class="py-2 px-2">
                      <div class="flex items-center gap-3 h-12">
                        <div class="size-12 rounded-[10px] bg-gray-100 overflow-hidden flex items-center justify-center">
                          <img v-if="item.image" :src="item.image" alt="" class="w-full h-full object-cover" />
                        </div>
                        <div class="flex flex-col gap-0">
                          <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ item.name }}</span>
                          <span class="font-nunito text-xs leading-4 text-[#6a7282]">Mã: {{ item.code }}</span>
                        </div>
                      </div>
                    </td>

                    <!-- Category -->
                    <td class="py-2 px-2">
                      <span class="inline-block px-2 py-[3px] border border-gray-200/60 rounded-lg text-xs font-medium text-neutral-950">
                        {{ item.category }}
                      </span>
                    </td>

                    <!-- Unit -->
                    <td class="py-2 px-2">
                      <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ item.unit }}</span>
                    </td>

                    <!-- Prices -->
                    <td class="py-2 px-2">
                      <div class="flex flex-col gap-0">
                        <span class="font-nunito text-base leading-6 text-[#4a5565] tracking-tight">{{ formatCurrency(item.costPrice) }}</span>
                        <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ formatCurrency(item.salePrice) }}</span>
                      </div>
                    </td>

                    <!-- Stock -->
                    <td class="py-2 px-2">
                      <div class="flex items-center gap-2">
                        <span
                          class="font-nunito text-sm leading-5 tracking-tight"
                          :class="item.stockStatus === 'low' || item.stockStatus === 'out' ? 'text-[#e7000b]' : 'text-[#101828]'"
                        >
                          {{ item.stock }}
                        </span>
                        <img v-if="item.stockStatus === 'low' || item.stockStatus === 'out'" :src="iconWarning" alt="" class="w-4 h-4" />
                      </div>
                    </td>

                    <!-- Expiry Date -->
                    <td class="py-2 px-2">
                      <span
                        class="inline-block px-2 py-[3px] rounded-lg text-xs font-medium"
                        :class="item.expiryBadgeClass"
                      >
                        {{ item.expiryDate }}
                      </span>
                    </td>

                    <!-- Actions -->
                    <td class="py-2 px-2 text-right">
                      <button 
                        class="bg-white border border-gray-200/60 rounded-lg h-8 px-[10px] py-[7px] flex items-center gap-2 hover:bg-gray-50 transition-colors ml-auto"
                        @click="handleOpenTheKho(item)"
                      >
                        <img :src="iconEyeList" alt="" class="w-4 h-4" />
                        <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thẻ kho</span>
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            <!-- Pagination -->
            <div class="flex items-center justify-between h-10">
              <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
                Hiển thị 1 - 4 của 4 hàng hóa
              </p>
              <div class="flex items-center gap-1">
                <button class="flex items-center gap-2 px-3 py-2 rounded-lg opacity-50" disabled>
                  <img :src="iconChevronLeft" alt="" class="w-4 h-4" />
                  <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Previous</span>
                </button>
                <button class="bg-white border border-gray-200/60 rounded-lg w-9 h-9 flex items-center justify-center">
                  <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">1</span>
                </button>
                <button class="flex items-center gap-2 px-3 py-2 rounded-lg opacity-50" disabled>
                  <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Next</span>
                  <img :src="iconChevronRight" alt="" class="w-4 h-4" />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Nhập kho Tab -->
      <div v-if="activeTab === 'nhap-kho'" class="bg-white border border-gray-200/60 rounded-[14px] p-6">
        <div class="flex flex-col gap-[30px]">
          <!-- Header -->
          <div class="flex items-center justify-between h-9">
            <h3 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight">
              Lịch sử Nhập kho
            </h3>
            <button 
              class="bg-[#009689] rounded-lg h-9 px-3 py-2 flex items-center gap-2 hover:bg-[#007d72] transition-colors"
              @click="isTaoPhieuNhapModalOpen = true"
            >
              <img :src="iconPlus" alt="" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
                Tạo phiếu nhập
              </span>
            </button>
          </div>

          <!-- Table -->
          <div class="overflow-hidden">
            <table class="w-full">
              <thead>
                <tr class="border-b border-gray-200/60">
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Mã phiếu nhập</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Nhà cung cấp</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Ngày nhập</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Người nhập</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tổng tiền</span>
                  </th>
                  <th class="text-right py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thao tác</span>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="record in importRecords"
                  :key="record.id"
                  class="border-b border-gray-200/60"
                >
                  <td class="py-[15px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ record.code }}</span>
                  </td>
                  <td class="py-[15px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ record.supplier }}</span>
                  </td>
                  <td class="py-[15px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ record.date }}</span>
                  </td>
                  <td class="py-[15px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ record.user }}</span>
                  </td>
                  <td class="py-[15px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#009689] tracking-tight">{{ formatCurrency(record.total) }}</span>
                  </td>
                  <td class="py-[15px] px-2 text-right">
                    <button 
                      class="bg-white border border-gray-200/60 rounded-lg h-8 px-[10px] py-[7px] flex items-center gap-2 hover:bg-gray-50 transition-colors ml-auto"
                      @click="handleOpenChiTietPhieuNhap(record)"
                    >
                      <img :src="iconEye" alt="" class="w-4 h-4" />
                      <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Chi tiết</span>
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Kiểm kê Tab -->
      <div v-else-if="activeTab === 'kiem-ke'" class="bg-white border border-gray-200/60 rounded-[14px] p-6">
        <div class="flex flex-col gap-[30px]">
          <!-- Header -->
          <div class="flex items-center justify-between h-10">
            <div class="flex flex-col gap-1">
              <h3 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight">
                Kiểm kê Kho
              </h3>
              <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
                Đối chiếu số lượng thực tế với hệ thống
              </p>
            </div>
            <button class="bg-[#009689] rounded-lg h-9 px-4 py-2 hover:bg-[#007d72] transition-colors">
              <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
                Cân bằng kho
              </span>
            </button>
          </div>

          <!-- Table -->
          <div class="overflow-hidden">
            <table class="w-full">
              <thead>
                <tr class="border-b border-gray-200/60">
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tên hàng hóa</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tồn trên máy</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thực tế kiểm</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Chênh lệch</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Lý do</span>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="item in inventoryItems"
                  :key="item.id"
                  class="border-b border-gray-200/60"
                >
                  <td class="py-[17px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ item.name }}</span>
                  </td>
                  <td class="py-[17px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ item.systemQty }}</span>
                  </td>
                  <td class="py-[17px] px-2">
                    <input
                      v-model.number="item.actualQty"
                      type="number"
                      class="bg-[#f3f3f5] border-none rounded-lg h-9 w-24 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none"
                    />
                  </td>
                  <td class="py-[17px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ item.difference }}</span>
                  </td>
                  <td class="py-[17px] px-2">
                    <button
                      class="bg-[#f3f3f5] border-none rounded-lg h-9 w-40 px-[13px] py-0.5 flex items-center justify-between opacity-50"
                      :disabled="item.difference === 0"
                    >
                      <span class="font-nunito text-sm leading-5 text-[#717182] tracking-tight">Chọn lý do</span>
                      <img :src="iconChevronDown" alt="" class="w-4 h-4" />
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Nhà cung cấp Tab -->
      <div v-else-if="activeTab === 'nha-cung-cap'" class="bg-white border border-gray-200/60 rounded-[14px] p-6">
        <div class="flex flex-col gap-6">
          <!-- Header -->
          <div class="flex items-center justify-between h-9">
            <h3 class="font-nunito text-base leading-4 text-neutral-950 tracking-tight">
              Danh sách Nhà cung cấp
            </h3>
            <button 
              class="bg-[#009689] rounded-lg h-9 px-3 py-2 flex items-center gap-2 hover:bg-[#007d72] transition-colors"
              @click="isThemDoiTacModalOpen = true"
            >
              <img :src="iconPlus" alt="" class="w-4 h-4" />
              <span class="font-nunito font-medium text-sm leading-5 text-white tracking-tight">
                Thêm Nhà cung cấp
              </span>
            </button>
          </div>

          <!-- Search and Filter -->
          <div class="flex items-center gap-4 h-9">
            <div class="relative flex-1">
              <img :src="iconSearch" alt="" class="absolute left-3 top-[10px] w-4 h-4" />
              <input
                v-model="searchQuery"
                type="text"
                placeholder="Tìm tên công ty, SĐT, người liên hệ..."
                class="bg-[#f3f3f5] border-none rounded-lg h-9 w-full pl-10 pr-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182]"
              />
            </div>
            <button class="bg-[#f3f3f5] border-none rounded-lg h-9 w-48 px-[13px] py-0.5 flex items-center justify-between hover:bg-gray-200 transition-colors">
              <img :src="iconFilter" alt="" class="w-4 h-4" />
              <span class="font-nunito text-sm leading-5 text-neutral-950 tracking-tight">Tất cả</span>
              <img :src="iconChevronDown" alt="" class="w-4 h-4" />
            </button>
          </div>

          <!-- Table -->
          <div class="overflow-hidden">
            <table class="w-full">
              <thead>
                <tr class="border-b border-gray-200/60">
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Mã NCC</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Tên Nhà cung cấp</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Liên hệ</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Địa chỉ</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Công nợ hiện tại</span>
                  </th>
                  <th class="text-left py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Trạng thái</span>
                  </th>
                  <th class="text-right py-[10px] px-2">
                    <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Thao tác</span>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="supplier in suppliers"
                  :key="supplier.id"
                  class="border-b border-gray-200/60"
                >
                  <td class="py-[17px] px-2">
                    <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ supplier.code }}</span>
                  </td>
                  <td class="py-[17px] px-2">
                    <span class="font-nunito text-base leading-6 text-[#101828] tracking-tight">{{ supplier.name }}</span>
                  </td>
                  <td class="py-[17px] px-2">
                    <div class="flex flex-col gap-0.5">
                      <span class="font-nunito text-sm leading-5 text-[#101828] tracking-tight">{{ supplier.phone }}</span>
                      <span class="font-nunito text-xs leading-4 text-[#6a7282]">({{ supplier.contact }})</span>
                    </div>
                  </td>
                  <td class="py-[17px] px-2 overflow-hidden">
                    <span class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">{{ supplier.address }}</span>
                  </td>
                  <td class="py-[17px] px-2">
                    <span
                      class="font-nunito text-sm leading-5 tracking-tight"
                      :class="supplier.debt > 0 ? 'text-[#f54900]' : 'text-[#101828]'"
                    >
                      {{ formatCurrency(supplier.debt) }}
                    </span>
                  </td>
                  <td class="py-[17px] px-2">
                    <span
                      class="inline-flex items-center px-2 py-0.5 rounded-lg text-xs font-medium leading-4"
                      :class="supplier.status === 'active' ? 'bg-green-100 text-[#008236]' : 'bg-gray-100 text-[#364153]'"
                    >
                      {{ supplier.status === 'active' ? ' Hợp tác' : ' Ngừng' }}
                    </span>
                  </td>
                  <td class="py-[17px] px-2">
                    <div class="flex items-center gap-2 justify-end">
                      <button 
                        class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
                        @click="handleEditSupplier(supplier)"
                      >
                        <img :src="iconView" alt="" class="w-4 h-4" />
                      </button>
                      <button class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors">
                        <img :src="iconEdit" alt="" class="w-4 h-4" />
                      </button>
                      <button 
                        class="bg-white border border-gray-200/60 rounded-lg w-[38px] h-8 flex items-center justify-center hover:bg-gray-50 transition-colors"
                        @click="handleDeleteSupplier(supplier)"
                      >
                        <img :src="iconDelete" alt="" class="w-4 h-4" />
                      </button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Pagination -->
          <div class="flex items-center justify-between h-10">
            <p class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight">
              Hiển thị 1 - 5 của 5 nhà cung cấp
            </p>
            <div class="flex items-center gap-1">
              <button class="flex items-center gap-2 px-3 py-2 rounded-lg opacity-50" disabled>
                <img :src="iconChevronLeft" alt="" class="w-4 h-4" />
                <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Previous</span>
              </button>
              <button class="bg-white border border-gray-200/60 rounded-lg w-9 h-9 flex items-center justify-center">
                <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">1</span>
              </button>
              <button class="flex items-center gap-2 px-3 py-2 rounded-lg opacity-50" disabled>
                <span class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight">Next</span>
                <img :src="iconChevronRight" alt="" class="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modals -->
    <ThemThuocVatTu
      v-if="isAddModalOpen"
      @close="isAddModalOpen = false"
      @save="handleSaveInventory"
    />

    <TheKho
      v-if="isTheKhoModalOpen"
      :product="selectedItemForTheKho"
      :stock-data="{ quantity: selectedItemForTheKho?.stock, unit: selectedItemForTheKho?.unit, lotNumber: 'LOT2024001' }"
      @close="isTheKhoModalOpen = false"
    />

    <TaoPhieuNhap
      v-if="isTaoPhieuNhapModalOpen"
      @close="isTaoPhieuNhapModalOpen = false"
      @save="handleSavePhieuNhap"
    />

    <ChiTietPhieuNhap
      v-if="isChiTietPhieuNhapModalOpen"
      :receipt="selectedReceiptForDetail"
      @close="isChiTietPhieuNhapModalOpen = false"
    />

    <ThemDoiTacCungCap
      v-if="isThemDoiTacModalOpen"
      @close="isThemDoiTacModalOpen = false"
      @save="handleSaveDoiTac"
    />

    <SuaNhaCungCap
      v-if="isSuaNhaCungCapModalOpen"
      :supplier="selectedSupplierForEdit"
      @close="isSuaNhaCungCapModalOpen = false"
      @save="handleSaveEditedSupplier"
    />

    <XoaNhaCungCap
      v-if="isXoaNhaCungCapModalOpen"
      :supplier-name="selectedSupplierForDelete?.name"
      :related-receipts="relatedReceiptsForDelete"
      @close="isXoaNhaCungCapModalOpen = false"
      @delete="handleConfirmDeleteSupplier"
      @deactivate="handleDeactivateSupplier"
    />

    <DanhMucHangHoa
      v-if="isManageCategoriesModalOpen"
      @close="isManageCategoriesModalOpen = false"
    />
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import ThemThuocVatTu from './ThemThuocVatTu/index.vue'
import TheKho from './TheKho/index.vue'
import TaoPhieuNhap from './TaoPhieuNhap/index.vue'
import ChiTietPhieuNhap from './ChiTietPhieuNhap/index.vue'
import ThemDoiTacCungCap from './ThemDoiTacCungCap/index.vue'
import SuaNhaCungCap from './SuaNhaCungCap/index.vue'
import XoaNhaCungCap from './XoaNhaCungCap/index.vue'
import DanhMucHangHoa from './DanhMucHangHoa/index.vue'

// State
const activeTab = ref('danh-sach')
const searchQuery = ref('')
const searchInventory = ref('')
const filterCategory = ref('Tất cả')
const filterUnit = ref('Tất cả')
const filterStatus = ref('Tất cả')
const isAddModalOpen = ref(false)
const isTheKhoModalOpen = ref(false)
const selectedItemForTheKho = ref(null)
const isTaoPhieuNhapModalOpen = ref(false)
const isChiTietPhieuNhapModalOpen = ref(false)
const selectedReceiptForDetail = ref(null)
const isThemDoiTacModalOpen = ref(false)
const isSuaNhaCungCapModalOpen = ref(false)
const selectedSupplierForEdit = ref(null)
const isXoaNhaCungCapModalOpen = ref(false)
const selectedSupplierForDelete = ref(null)
const relatedReceiptsForDelete = ref([])
const isManageCategoriesModalOpen = ref(false)

const tabs = [
  { id: 'danh-sach', name: 'Danh sách & Tồn kho' },
  { id: 'nhap-kho', name: 'Nhập kho' },
  { id: 'kiem-ke', name: 'Kiểm kê' },
  { id: 'nha-cung-cap', name: 'Nhà cung cấp' }
]

// Sample Data - Danh sách & Tồn kho
const inventoryStats = [
  {
    id: 1,
    label: 'Hết hàng',
    count: '1 mặt hàng',
    bgColor: 'bg-[#ffe2e2]',
    textColor: 'text-[#e7000b]',
    icon: iconStockOut
  },
  {
    id: 2,
    label: 'Sắp hết hàng',
    count: '1 mặt hàng',
    bgColor: 'bg-[#ffedd4]',
    textColor: 'text-[#f54900]',
    icon: iconLowStock
  },
  {
    id: 3,
    label: 'Sắp hết hạn',
    count: '1 mặt hàng',
    bgColor: 'bg-[#fef9c2]',
    textColor: 'text-[#d08700]',
    icon: iconExpiring
  },
  {
    id: 4,
    label: 'Tổng giá trị kho',
    count: '11.125.000 ₫',
    bgColor: 'bg-[#cbfbf1]',
    textColor: 'text-[#009689]',
    icon: iconTotalValue
  }
]

const inventoryList = [
  {
    id: 1,
    name: 'Zoletil 50',
    code: 'MED001',
    image: imgProduct1,
    category: 'Thuốc',
    unit: 'Lọ',
    costPrice: 50000,
    salePrice: 150000,
    stock: 5,
    stockStatus: 'low',
    expiryDate: 'Sắp hết hạn',
    expiryStatus: 'warning',
    expiryBadgeClass: 'bg-[#ffedd4] text-[#ca3500]'
  },
  {
    id: 2,
    name: 'Vắc-xin 7 bệnh',
    code: 'VAC001',
    image: imgProduct2,
    category: 'Vắc-xin',
    unit: 'Liều',
    costPrice: 80000,
    salePrice: 200000,
    stock: 120,
    stockStatus: 'good',
    expiryDate: 'Đã hết hạn',
    expiryStatus: 'expired',
    expiryBadgeClass: 'bg-[#ffe2e2] text-[#c10007]'
  },
  {
    id: 3,
    name: 'Bông băng y tế',
    code: 'SUP001',
    image: imgProduct3,
    category: 'Vật tư tiêu hao',
    unit: 'Cuộn',
    costPrice: 15000,
    salePrice: 35000,
    stock: 85,
    stockStatus: 'good',
    expiryDate: '2026-06-20',
    expiryStatus: 'good',
    expiryBadgeClass: 'bg-green-100 text-[#008236]'
  },
  {
    id: 4,
    name: 'Kháng sinh Amoxicillin',
    code: 'MED002',
    image: null,
    category: 'Thuốc',
    unit: 'Viên',
    costPrice: 500,
    salePrice: 2000,
    stock: 0,
    stockStatus: 'out',
    expiryDate: 'Đã hết hạn',
    expiryStatus: 'expired',
    expiryBadgeClass: 'bg-[#ffe2e2] text-[#c10007]'
  }
]

// Sample Data - Nhập kho
const importRecords = [
  {
    id: 1,
    code: 'PN001',
    supplier: 'Công ty TNHH Dược phẩm ABC',
    date: '2024-11-01',
    user: 'Nguyễn Văn A',
    total: 5500000
  },
  {
    id: 2,
    code: 'PN002',
    supplier: 'Công ty Vắc-xin Việt Nam',
    date: '2024-11-05',
    user: 'Trần Văn B',
    total: 9600000
  }
]

// Sample Data - Kiểm kê
const inventoryItems = reactive([
  {
    id: 1,
    name: 'Vắc-xin 7 bệnh',
    systemQty: 120,
    actualQty: 120,
    difference: 0
  },
  {
    id: 2,
    name: 'Zoletil 50',
    systemQty: 5,
    actualQty: 5,
    difference: 0
  },
  {
    id: 3,
    name: 'Bông băng y tế',
    systemQty: 85,
    actualQty: 85,
    difference: 0
  }
])

// Sample Data - Nhà cung cấp
const suppliers = [
  {
    id: 1,
    code: 'SUP001',
    name: 'Công ty TNHH Dược phẩm ABC',
    phone: '0909123456',
    contact: 'Nguyễn Văn An',
    address: '123 Đường A, Quận 1, TP.HCM',
    debt: 15000000,
    status: 'active'
  },
  {
    id: 2,
    code: 'SUP002',
    name: 'Công ty Vắc-xin Việt Nam',
    phone: '0912345678',
    contact: 'Trần Thị Bình',
    address: '456 Đường B, Quận 3, TP.HCM',
    debt: 0,
    status: 'active'
  },
  {
    id: 3,
    code: 'SUP003',
    name: 'Công ty Vật tư Y tế Đông Nam',
    phone: '0923456789',
    contact: 'Lê Văn Cường',
    address: '789 Đường C, Quận 5, TP.HCM',
    debt: 5000000,
    status: 'active'
  },
  {
    id: 4,
    code: 'SUP004',
    name: 'Công ty Thiết bị Y tế Minh Khang',
    phone: '0934567890',
    contact: 'Phạm Thị Dung',
    address: '321 Đường D, Quận 10, TP.HCM',
    debt: 0,
    status: 'inactive'
  },
  {
    id: 5,
    code: 'SUP005',
    name: 'Công ty Thú Y Sài Gòn',
    phone: '0945678901',
    contact: 'Hoàng Văn Em',
    address: '654 Đường E, Quận 7, TP.HCM',
    debt: 2500000,
    status: 'active'
  }
]

// Icon URLs from Figma (expire in 7 days)
const iconStockOut = "https://www.figma.com/api/mcp/asset/dc66625c-ee38-4195-8991-e79261d28e11"
const iconLowStock = "https://www.figma.com/api/mcp/asset/9c43b4e1-d4e2-4e83-ab92-4873bcefc6b6"
const iconExpiring = "https://www.figma.com/api/mcp/asset/991c4435-2ad6-46da-9e16-2de8a915874c"
const iconTotalValue = "https://www.figma.com/api/mcp/asset/7f6357dd-4f2f-4cb9-b539-84a3a8148cbc"
const iconAddItem = "https://www.figma.com/api/mcp/asset/0a9a1906-a81f-4ccb-a798-7269ee7f26d5"
const iconFilterList = "https://www.figma.com/api/mcp/asset/b0533f6c-44cd-440a-9e72-b9c556dce9d4"
const iconSearchList = "https://www.figma.com/api/mcp/asset/4d6aa7a6-6c43-4944-aa02-a1f4c1cb77fa"
const iconWarning = "https://www.figma.com/api/mcp/asset/2305cbc5-ff43-49a4-b99a-aabc274a9bec"
const iconEyeList = "https://www.figma.com/api/mcp/asset/d4747055-e52c-44fd-a2c9-ee4471ff82b6"
const imgProduct1 = "https://www.figma.com/api/mcp/asset/96b8daf7-a913-40e8-ba03-325034721605"
const imgProduct2 = "https://www.figma.com/api/mcp/asset/908d1703-82d8-4cc4-bdfe-80e9dee83841"
const imgProduct3 = "https://www.figma.com/api/mcp/asset/0e69a3f9-b9f9-478b-900a-2810a6630076"
const iconPlus = "https://www.figma.com/api/mcp/asset/f6842dcf-ccf9-45ea-99b7-e6c4e4affc61"
const iconEye = "https://www.figma.com/api/mcp/asset/0d3fb76d-9c10-43ec-8cd6-535123639beb"
const iconChevronDown = "https://www.figma.com/api/mcp/asset/2dc96151-300a-4d43-97fa-1b1f8dc13efb"
const iconFilter = "https://www.figma.com/api/mcp/asset/226a7a77-aed1-47aa-9821-d83e78112106"
const iconChevronDown2 = "https://www.figma.com/api/mcp/asset/10307674-3571-4970-a22f-49fd3ec79376"
const iconSearch = "https://www.figma.com/api/mcp/asset/ffbbe0e1-efcb-46ca-b836-b930da441b68"
const iconView = "https://www.figma.com/api/mcp/asset/a852fd94-3f29-4a09-ac91-a9a675900216"
const iconEdit = "https://www.figma.com/api/mcp/asset/573f95f2-4c6a-475b-b38c-0cf28529aca8"
const iconDelete = "https://www.figma.com/api/mcp/asset/db259098-cbc5-4ede-9aac-244844d1ba0a"
const iconChevronLeft = "https://www.figma.com/api/mcp/asset/6d46ecce-c14a-4ba9-afc1-b477dd7c7a66"
const iconChevronRight = "https://www.figma.com/api/mcp/asset/dec0f180-4a84-46dc-8ecb-737a257369ae"
const iconFolder = "https://www.figma.com/api/mcp/asset/d6fa9f58-18e9-46fb-a4c7-d6d5ac16c30b"

// Methods
const formatCurrency = (amount) => {
  return `${amount.toLocaleString('vi-VN')} ₫`
}

const handleSaveInventory = (data) => {
  console.log('New inventory item:', data)
  // Logic to save new item goes here
  isAddModalOpen.value = false
}

const handleOpenTheKho = (item) => {
  selectedItemForTheKho.value = item
  isTheKhoModalOpen.value = true
}

const handleSavePhieuNhap = (data) => {
  console.log('New import record:', data)
  // Logic to save new import record goes here
  isTaoPhieuNhapModalOpen.value = false
}

const handleOpenChiTietPhieuNhap = (record) => {
  selectedReceiptForDetail.value = record
  isChiTietPhieuNhapModalOpen.value = true
}

const handleSaveDoiTac = (data) => {
  console.log('New supplier:', data)
  // Logic to save new supplier goes here
  isThemDoiTacModalOpen.value = false
}

const handleEditSupplier = (supplier) => {
  selectedSupplierForEdit.value = supplier
  isSuaNhaCungCapModalOpen.value = true
}

const handleSaveEditedSupplier = (data) => {
  console.log('Updated supplier:', data)
  // Logic to update supplier goes here
  isSuaNhaCungCapModalOpen.value = false
}

const handleDeleteSupplier = (supplier) => {
  selectedSupplierForDelete.value = supplier
  
  // Mock logic to check for related receipts
  // For demonstration, let's say supplier with ID 2 has related receipts
  if (supplier.id === 2) {
    relatedReceiptsForDelete.value = [
      { id: 'PN002', code: 'PN002', date: '2024-11-05', amount: 9600000 }
    ]
  } else {
    relatedReceiptsForDelete.value = []
  }
  
  isXoaNhaCungCapModalOpen.value = true
}

const handleConfirmDeleteSupplier = () => {
  console.log('Deleted supplier:', selectedSupplierForDelete.value)
  // Logic to delete supplier goes here
  isXoaNhaCungCapModalOpen.value = false
}

const handleDeactivateSupplier = () => {
  console.log('Deactivated supplier:', selectedSupplierForDelete.value)
  // Logic to deactivate supplier goes here
  isXoaNhaCungCapModalOpen.value = false
}

const handleManageCategories = () => {
  isManageCategoriesModalOpen.value = true
}

const handleAddInventory = () => {
  isAddModalOpen.value = true
}
</script>

<style scoped>
/* Remove number input arrows */
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  appearance: none;
  margin: 0;
}

input[type="number"] {
  -moz-appearance: textfield;
  appearance: textfield;
}

/* Button Styles */
.btn-secondary {
  background: white;
  border: 1px solid #5a9690;
  border-radius: 8px;
  padding: 8px 12px;
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-secondary:hover {
  background: #f9fafb;
}

.btn-icon {
  width: 16px;
  height: 16px;
}

.btn-text {
  font-family: 'Nunito Sans', sans-serif;
  font-weight: 500;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #009689;
}
</style>
