<template>
  <div class="page-container">
    <!-- Page Header -->
    <div class="page-header" style="align-items: start">
      <div class="header-content">
        <h1 class="page-title">Quản lý Dịch Vụ</h1>
      </div>
      <div class="header-subtitle">
        <p class="subtitle-text">Tổ chức và phân bổ nhân sự theo bộ phận</p>
      </div>
    </div>

    <!-- Card Container -->
    <div class="card-container">
      <!-- Card Header with Actions -->
      <div class="card-header">
        <div class="card-title-spacer"></div>
        <div class="card-actions">
          <button class="btn-secondary" @click="handleManageCategories">
            <img :src="iconFolder" alt="" class="btn-icon" />
            <span class="btn-text">Danh Mục Dịch Vụ</span>
          </button>
          <button class="btn-primary" @click="handleAddService">
            <img :src="iconPlus" alt="" class="btn-icon" />
            <span class="btn-text">Thêm dịch vụ</span>
          </button>
        </div>
      </div>

      <!-- Filters and Search -->
      <div class="filters-container">
        <div class="search-container">
          <img :src="iconSearch" alt="" class="search-icon" />
          <input
            v-model="searchQuery"
            type="text"
            class="search-input"
            placeholder="Tìm tên dịch vụ..."
          />
        </div>

        <button class="filter-button disabled" @click="toggleGroupFilter">
          <img :src="iconFilter" alt="" class="filter-icon" />
          <span class="filter-text">Tất cả Danh Mục</span>
          <img :src="iconChevronDown" alt="" class="chevron-icon" />
        </button>

        <button class="filter-button" @click="toggleStatusFilter">
          <img :src="iconFilter" alt="" class="filter-icon" />
          <span class="filter-text">Tất cả trạng thái</span>
          <img :src="iconChevronDown" alt="" class="chevron-icon" />
        </button>
      </div>

      <!-- Services Table -->
      <div class="table-wrapper">
        <table class="services-table">
          <thead>
            <tr>
              <th class="col-image">Ảnh</th>
              <th class="col-name">Tên dịch vụ</th>
              <th class="col-category">Phân loại</th>
              <th class="col-price">Giá bán</th>
              <th class="col-duration">Thời gian</th>
              <th class="col-status">Trạng thái</th>
              <th class="col-actions">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="service in services" :key="service.id" class="table-row">
              <!-- Image -->
              <td class="cell-image">
                <img :src="service.image" alt="" class="service-image" />
              </td>

              <!-- Name and Code -->
              <td class="cell-name">
                <div class="service-name-container">
                  <p class="service-name">{{ service.name }}</p>
                  <p class="service-code">(Mã: {{ service.code }})</p>
                </div>
              </td>

              <!-- Category -->
              <td class="cell-category">
                <div class="category-container">
                  <p class="category-name">{{ service.category }}</p>
                  <p class="category-department">{{ service.mo_ta }}</p>
                </div>
              </td>

              <!-- Price -->
              <td class="cell-price">
                <p class="price-text">{{ formatPrice(service.price) }}</p>
              </td>

              <!-- Duration -->
              <td class="cell-duration">
                <p class="duration-text">{{ service.duration }} phút</p>
              </td>

              <!-- Status -->
              <td class="cell-status">
                <span
                  class="status-badge"
                  :class="{
                    'status-active': service.status === 'active',
                    'status-inactive': service.status === 'inactive',
                  }"
                >
                  {{ service.status === "active" ? "Kinh doanh" : "Ngừng" }}
                </span>
              </td>

              <!-- Actions -->
              <td class="cell-actions">
                <div class="actions-container">
                  <button
                    class="action-button"
                    @click="handleEdit(service)"
                    :title="
                      service.status === 'active' ? 'Xem chi tiết' : 'Chỉnh sửa'
                    "
                  >
                    <img
                      :src="service.status === 'active' ? iconView : iconEdit"
                      alt=""
                      class="action-icon"
                    />
                  </button>
                  <button
                    class="action-button"
                    @click="handleDelete(service)"
                    title="Xóa"
                  >
                    <img :src="iconDelete" alt="" class="action-icon" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="pagination-container">
        <div class="pagination-info">
          <p class="info-text">
            Hiển thị
            <span v-if="totalItems === 0">0</span>
            <span v-else
              >{{ (currentPage - 1) * perPage + 1 }} -
              {{ Math.min(currentPage * perPage, totalItems) }}</span
            >
            của {{ totalItems }} dịch vụ
          </p>
        </div>
        <div class="pagination-controls">
          <button
            class="pagination-button"
            :class="{ disabled: currentPage <= 1 }"
            :disabled="currentPage <= 1 || loadingServices"
            @click="handlePrevPage"
          >
            <img :src="iconChevronLeft" alt="" class="pagination-icon" />
            <span class="pagination-text">Previous</span>
          </button>
          <template v-for="p in pages" :key="p">
            <button
              class="pagination-page"
              :class="{ active: p === currentPage }"
              @click="goToPage(p)"
              :disabled="p === currentPage || loadingServices"
            >
              {{ p }}
            </button>
          </template>
          <button
            class="pagination-button"
            :class="{ disabled: currentPage >= lastPage }"
            :disabled="currentPage >= lastPage || loadingServices"
            @click="handleNextPage"
          >
            <span class="pagination-text">Next</span>
            <img :src="iconChevronRight" alt="" class="pagination-icon" />
          </button>
        </div>
      </div>
    </div>
    <!-- Manage Categories Modal -->
    <DanhMucDichVu
      v-if="isManageCategoriesModalOpen"
      @close="isManageCategoriesModalOpen = false"
    />

    <!-- Add Service Modal -->
    <div
      v-if="isAddServiceModalOpen"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[1000] pt-24"
    >
      <div class="w-[600px] max-h-[85vh] flex flex-col shadow-xl">
        <ThemDichVu
          @close="isAddServiceModalOpen = false"
          @save="handleSaveService"
        />
      </div>
    </div>

    <!-- Edit Service Modal -->
    <div
      v-if="isEditServiceModalOpen"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[1000] pt-24"
    >
      <div class="w-[600px] max-h-[85vh] flex flex-col shadow-xl">
        <ChinhSuaDichVu
          :service="selectedServiceForEdit"
          @close="isEditServiceModalOpen = false"
          @update="handleUpdateService"
          @openCreateCategory="handleOpenCreateCategoryFromEdit"
        />
      </div>
    </div>

    <!-- Delete Service Modal -->
    <div
      v-if="isDeleteServiceModalOpen"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-[1000]"
    >
      <XoaDichVu
        :modal-type="deleteServiceModalType"
        :service="selectedServiceForDelete"
        :appointments="serviceAppointments"
        @close="isDeleteServiceModalOpen = false"
        @deleted="handleModalDeleted"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import api, { attachToken } from "@/utils/api";
import { showErrorToast } from "@/utils/toast";
import DanhMucDichVu from "./DanhMucDichVu/index.vue";
import ThemDichVu from "./ThemDichVu/index.vue";
import ChinhSuaDichVu from "./ChinhSuaDichVu/index.vue";
import XoaDichVu from "./XoaDichVu/index.vue";

const services = ref([]);
const loadingServices = ref(false);

// Pagination state
const currentPage = ref(1);
const perPage = ref(6); // show 6 per page by default
const totalItems = ref(0);
const lastPage = ref(1);

// API origin used to build absolute image URLs when backend returns relative paths
const API_BASE = import.meta.env.VITE_API_BASE || "http://127.0.0.1:8000/api";
const API_ORIGIN = API_BASE.replace(/\/api\/?$/, "");

const mapApiToView = (item) => {
  // decide image
  let img = item.anh_dich_vu || item.image || "";
  if (img && !/^https?:\/\//i.test(img)) {
    if (!img.startsWith("/")) img = "/" + img;
    img = API_ORIGIN + img;
  }

  return {
    id: item.id,
    name: item.ten || item.name || "",
    code: item.ma_dich_vu || item.code || "",
    category: item.ten_nhom || (item.danh_muc && item.danh_muc.ten_nhom) || "",
    mo_ta: item.mo_ta || item.description || "",
    price: item.gia_tien || 0,
    duration: item.thoi_gian_thuc_hien || item.duration || 0,
    status: item.trang_thai === "kinh_doanh" ? "active" : "inactive",
    image: img,
  };
};

const fetchServices = async (page = currentPage.value) => {
  loadingServices.value = true;
  try {
    // Request paginated list
    const res = await api.get(
      `/dich-vu?per_page=${perPage.value}&page=${page}`
    );
    const items = (res && res.data && res.data.data) || [];
    services.value = items.map(mapApiToView);

    // read pagination meta when provided by backend
    const meta = (res && res.data && res.data.meta) || null;
    if (meta) {
      currentPage.value = meta.current_page || page;
      perPage.value = meta.per_page || perPage.value;
      totalItems.value = meta.total || totalItems.value;
      lastPage.value = meta.last_page || lastPage.value;
    } else {
      // fallback: if backend returned array without meta, set defaults
      currentPage.value = page;
      totalItems.value = services.value.length;
      lastPage.value = 1;
    }
  } catch (e) {
    console.error("fetchServices error", e);
    // optional: show toast if utils/toast available
  } finally {
    loadingServices.value = false;
  }
};

onMounted(() => {
  fetchServices();
});

const handlePrevPage = () => {
  if (currentPage.value > 1) {
    fetchServices(currentPage.value - 1);
  }
};

const handleNextPage = () => {
  if (currentPage.value < lastPage.value) {
    fetchServices(currentPage.value + 1);
  }
};

const pages = computed(() => {
  const n = Number(lastPage.value) || 1;
  const arr = [];
  for (let i = 1; i <= n; i++) arr.push(i);
  return arr;
});

const goToPage = (p) => {
  if (p === currentPage.value || loadingServices.value) return;
  fetchServices(p);
};

const searchQuery = ref("");
const isManageCategoriesModalOpen = ref(false);
const isAddServiceModalOpen = ref(false);
const isEditServiceModalOpen = ref(false);
const selectedServiceForEdit = ref(null);
const isDeleteServiceModalOpen = ref(false);
const selectedServiceForDelete = ref(null);
const deleteServiceModalType = ref("confirm"); // 'error' or 'confirm'
const serviceAppointments = ref([]);

// Icon URLs from Figma (expire in 7 days)
const iconFolder =
  "https://www.figma.com/api/mcp/asset/a0ed0f4f-6ef3-4551-9156-ba6da5df0653";
const iconPlus =
  "https://www.figma.com/api/mcp/asset/5170a5d8-0d15-4cb9-b377-5b0d69005c9b";
const iconFilter =
  "https://www.figma.com/api/mcp/asset/0242ea48-73a1-4260-bf48-1299ef6b29ac";
const iconChevronDown =
  "https://www.figma.com/api/mcp/asset/3bbafe24-57e8-433c-be3b-fa608dce6e81";
const iconSearch =
  "https://www.figma.com/api/mcp/asset/b5edddae-5d34-4f6d-bdce-cce4b27387d3";
const iconView =
  "https://www.figma.com/api/mcp/asset/53d0ba8c-3289-4be6-b9ea-55a74008aa0b";
const iconEdit =
  "https://www.figma.com/api/mcp/asset/21ba0590-5c8a-422f-8e50-3212ef378ef1";
const iconDelete =
  "https://www.figma.com/api/mcp/asset/676e185d-491f-4f39-8a87-f81dbfb8dd14";
const iconChevronLeft =
  "https://www.figma.com/api/mcp/asset/85a17750-00e0-497e-944e-80c6a95bab60";
const iconChevronRight =
  "https://www.figma.com/api/mcp/asset/60ebc6a7-e00c-440f-96b5-a8f2d5fb6d49";

// Methods
const formatPrice = (price) => {
  return new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: "VND",
  })
    .format(price)
    .replace("₫", "₫");
};

const handleManageCategories = () => {
  isManageCategoriesModalOpen.value = true;
};

const handleAddService = () => {
  isAddServiceModalOpen.value = true;
};

const handleSaveService = (data) => {
  // data is the backend-created item (controller returns created resource)
  try {
    const view = mapApiToView(data);
    services.value.unshift(view);
    // update total count if we have a server-side total
    totalItems.value = (Number(totalItems.value) || 0) + 1;
  } catch (e) {
    console.error("handleSaveService mapping error", e);
  } finally {
    isAddServiceModalOpen.value = false;
  }
};

const toggleDepartmentFilter = () => {
  console.log("Toggle department filter");
};

const toggleGroupFilter = () => {
  console.log("Toggle group filter");
};

const toggleStatusFilter = () => {
  console.log("Toggle status filter");
};

const handleEdit = (service) => {
  selectedServiceForEdit.value = service;
  isEditServiceModalOpen.value = true;
};

const handleUpdateService = (data) => {
  try {
    const view = mapApiToView(data);
    const index = services.value.findIndex((s) => s.id === view.id);
    if (index !== -1) {
      services.value[index] = { ...services.value[index], ...view };
    }
  } catch (e) {
    console.error("handleUpdateService error", e);
  } finally {
    isEditServiceModalOpen.value = false;
  }
};

const handleOpenCreateCategoryFromEdit = () => {
  isEditServiceModalOpen.value = false;
  isManageCategoriesModalOpen.value = true;
};

const handleDelete = (service) => {
  selectedServiceForDelete.value = service;
  // Always allow deletion from the UI (open confirm modal)
  deleteServiceModalType.value = "confirm";
  serviceAppointments.value = [];
  isDeleteServiceModalOpen.value = true;
};

const handleSubmitDeleteService = async (data) => {
  try {
    try {
      attachToken();
    } catch (_) {}
    const res = await api.delete(`/dich-vu/${data.serviceId}`);
    if (res && res.data && res.data.status) {
      const index = services.value.findIndex((s) => s.id === data.serviceId);
      if (index !== -1) services.value.splice(index, 1);
      // decrement totalItems to keep pagination info in sync
      totalItems.value = Math.max((Number(totalItems.value) || 0) - 1, 0);
    } else {
      // Try to show backend message when delete failed
      const msg =
        (res && res.data && res.data.message) || "Có lỗi khi xóa dịch vụ.";
      showErrorToast("Lỗi", msg);
      console.warn("Delete failed", res);
    }
  } catch (e) {
    console.error("handleSubmitDeleteService error", e);
    // Extract message from error response if available and show to user
    const msg =
      e && e.response && e.response.data && e.response.data.message
        ? e.response.data.message
        : "Có lỗi khi xóa dịch vụ.";
    showErrorToast("Lỗi", msg);
  } finally {
    isDeleteServiceModalOpen.value = false;
  }
};

// Handler for when XoaDichVu emits 'deleted' after successful delete
const handleModalDeleted = (data) => {
  try {
    const id = data && data.serviceId;
    const index = services.value.findIndex((s) => s.id === id);
    if (index !== -1) services.value.splice(index, 1);
    // decrement totalItems so the UI shows the updated total
    totalItems.value = Math.max((Number(totalItems.value) || 0) - 1, 0);
  } catch (e) {
    console.error("handleModalDeleted error", e);
  } finally {
    isDeleteServiceModalOpen.value = false;
  }
};
</script>

<style scoped>
.page-container {
  display: flex;
  flex-direction: column;
  gap: 24px;
  padding: 24px;
  width: 100%;
  box-sizing: border-box;
}

/* Page Header */
.page-header {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}

.page-title {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 700;
  font-size: 20px;
  line-height: 24px;
  color: #000000;
  margin: 0;
}

.header-subtitle {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}

.subtitle-text {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 500;
  font-size: 14px;
  line-height: 20px;
  color: #6b7280;
  margin: 0;
}

/* Card Container */
.card-container {
  background: white;
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 14px;
  padding: 1px;
  min-height: 662px;
}

/* Card Header */
.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 36px;
  padding: 25px;
  gap: 649px;
}

.card-title-spacer {
  width: 113.344px;
  height: 16px;
}

.card-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

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

.btn-primary {
  background: #5a9690;
  border: none;
  border-radius: 8px;
  padding: 8px 12px;
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-primary:hover {
  background: #4a7f79;
}

.btn-icon {
  width: 16px;
  height: 16px;
}

.btn-text {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 500;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
}

.btn-secondary .btn-text {
  color: #009689;
}

.btn-primary .btn-text {
  color: white;
}

/* Filters */
.filters-container {
  display: flex;
  align-items: center;
  gap: 16px;
  height: 36px;
  padding: 0 24px;
  margin-top: 30px;
}

.search-container {
  position: relative;
  width: 382px;
  height: 36px;
}

.search-icon {
  position: absolute;
  left: 12px;
  top: 10px;
  width: 16px;
  height: 16px;
  pointer-events: none;
}

.search-input {
  background: #f3f3f5;
  border: none;
  border-radius: 8px;
  height: 36px;
  width: 100%;
  padding: 4px 12px 4px 40px;
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 14px;
  line-height: normal;
  letter-spacing: -0.1504px;
  color: #000000;
  outline: none;
}

.search-input::placeholder {
  color: #717182;
}

.filter-button {
  background: #f3f3f5;
  border: none;
  border-radius: 8px;
  height: 36px;
  padding: 1px 13px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.filter-button:hover:not(.disabled) {
  background: #e5e7eb;
}

.filter-button.disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.filter-icon {
  width: 16px;
  height: 16px;
}

.filter-text {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #09090b;
  white-space: nowrap;
}

.chevron-icon {
  width: 16px;
  height: 16px;
}

/* Table */
.table-wrapper {
  padding: 0 24px;
  margin-top: 24px;
  overflow: hidden;
  max-height: 429.5px;
}

.services-table {
  width: 100%;
  border-collapse: collapse;
}

.services-table thead tr {
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.services-table th {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 500;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #09090b;
  text-align: left;
  padding: 10.25px 8px;
  height: 40px;
}

.col-image {
  width: 91.555px;
}

.col-name {
  width: 291.383px;
}

.col-category {
  width: 167.813px;
}

.col-price {
  width: 119.219px;
}

.col-duration {
  width: 109.695px;
}

.col-status {
  width: 163.266px;
}

.col-actions {
  width: 143.07px;
  text-align: right;
}

.table-row {
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.services-table td {
  padding: 8.5px 8px;
  height: 65px;
  vertical-align: middle;
}

.cell-image {
  padding: 8.5px 8px;
}

.service-image {
  width: 48px;
  height: 48px;
  border-radius: 10px;
  object-fit: cover;
}

.service-name-container {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.service-name {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #101828;
  margin: 0;
}

.service-code {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 12px;
  line-height: 16px;
  color: #6a7282;
  margin: 0;
  white-space: pre-wrap;
}

.category-container {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.category-name {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #101828;
  margin: 0;
}

.category-department {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 12px;
  line-height: 16px;
  color: #6a7282;
  margin: 0;
  white-space: pre-wrap;
}

.price-text {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #101828;
  margin: 0;
}

.duration-text {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #4a5565;
  margin: 0;
  white-space: pre-wrap;
}

.status-badge {
  display: inline-block;
  padding: 3px 8px;
  border-radius: 8px;
  font-family: "Nunito Sans", sans-serif;
  font-weight: 500;
  font-size: 12px;
  line-height: 16px;
  text-align: center;
}

.status-active {
  background: #dcfce7;
  color: #008236;
}

.status-inactive {
  background: #f3f4f6;
  color: #364153;
}

.actions-container {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 8px;
}

.action-button {
  background: white;
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  width: 38px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.action-button:hover {
  background: #f9fafb;
}

.action-icon {
  width: 16px;
  height: 16px;
}

/* Pagination */
.pagination-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 40px;
  padding: 0 24px;
  margin-top: 24px;
}

.pagination-info {
  height: 40px;
  display: flex;
  align-items: center;
}

.info-text {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 400;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #4a5565;
  margin: 0;
}

.pagination-controls {
  display: flex;
  align-items: center;
  gap: 4px;
  height: 36px;
}

.pagination-button {
  background: transparent;
  border: none;
  border-radius: 8px;
  padding: 8px 12px;
  height: 36px;
  display: flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.pagination-button:hover:not(.disabled) {
  background: #f3f4f6;
}

.pagination-button.disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.pagination-icon {
  width: 16px;
  height: 16px;
}

.pagination-text {
  font-family: "Nunito Sans", sans-serif;
  font-weight: 500;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #09090b;
}

.pagination-page {
  background: white;
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-family: "Nunito Sans", sans-serif;
  font-weight: 500;
  font-size: 14px;
  line-height: 20px;
  letter-spacing: -0.1504px;
  color: #09090b;
  transition: background-color 0.2s;
}

.pagination-page:hover {
  background: #f9fafb;
}

.pagination-page.active {
  background: white;
  border-color: #5a9690;
}
</style>
