import { createRouter, createWebHistory } from "vue-router"; // cài vue-router: npm install vue-router@next --save
import { getToken } from "../utils/auth";

const routes = [
  /********************** Trang Chủ ************************* */
  {
    path: "/",
    component: () => import("../components/trangchu/index.vue"),
    meta: { layout: "trangchu" },
  },
  /********************** Khách Hàng ************************* */
  {
    path: "/khach-hang/dang-ky",
    component: () => import("../components/KhachHang/DangKi/index.vue"),
    meta: { layout: "dangki_dangnhap" },
  },
  {
    path: "/khach-hang/dang-nhap",
    component: () => import("../components/KhachHang/DangNhap/index.vue"),
    meta: { layout: "dangki_dangnhap" },
  },
  {
    path: "/auth/callback",
    component: () => import("../components/Auth/Callback.vue"),
    meta: { layout: "dangki_dangnhap" },
  },
  {
    path: "/khach-hang/trang-cua-toi",
    component: () => import("../components/KhachHang/QuanLyTaiKhoan/index.vue"),
    meta: { layout: "dangki_dangnhap", requiresAuth: true },
  },
  {
    path: "/khach-hang/quan-ly-thong-tin-ca-nhan",
    component: () =>
      import("../components/KhachHang/QuanLyThongTinCaNhan/index.vue"),
    meta: { layout: "trangchu", requiresAuth: true },
  },
  {
    path: "/khach-hang/tro-giup-lien-he",
    component: () => import("../components/KhachHang/TroGiupLienHe/index.vue"),
    meta: { layout: "dangki_dangnhap", requiresAuth: true },
  },
  {
    path: "/khach-hang/thanh-toan",
    component: () => import("../components/KhachHang/ThanhToan/index.vue"),
    meta: { layout: "dangki_dangnhap", requiresAuth: true },
  },
  {
    path: "/khach-hang/lich-hen",
    component: () => import("../components/KhachHang/LichHen/index.vue"),
    meta: { layout: "dangki_dangnhap", requiresAuth: true },
  },
  {
    path: "/khach-hang/thu-cung-cua-toi",
    component: () => import("../components/KhachHang/ThuCungCuaToi/index.vue"),
    meta: { layout: "dangki_dangnhap", requiresAuth: true },
  },

  //********************** Admin ************************* */
  {
    path: "/admin/dang-nhap",
    component: () => import("../components/Admin/DangNhap/index.vue"),
    meta: { layout: "dangki_dangnhap" },
  },
  {
    path: "/admin/dashboard",
    component: () => import("../components/Admin/Dashboard/index.vue"),
    meta: { layout: "sidebar" },
  },

  {
    path: "/admin/quan-ly-khoa",
    component: () => import("../components/Admin/TaiNguyen/QuanLyKhoa/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/quan-ly-dich-vu",
    component: () => import("../components/Admin/TaiNguyen/QuanLyDichVu/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/kho-thuoc-vat-tu",
    component: () => import("../components/Admin/TaiNguyen/QuanLyKhoThuocVatTu/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/tai-khoan",
    component: () => import("../components/Admin/NhanSu/QuanLyTaiKhoan/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/lich-lam-viec",
    component: () => import("../components/Admin/NhanSu/QuanLyLichLamViec/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/quan-ly-lich-hen",
    component: () => import("../components/Admin/VanHanh/QuanLyLichHen/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/ho-so-benh-an",
    component: () => import("../components/Admin/VanHanh/HoSoBenhAn/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/danh-sach-hoa-don",
    component: () => import("../components/Admin/TaiChinhHoaDon/DanhSachHoaDon/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/phieu-chi",
    component: () => import("../components/Admin/TaiChinhHoaDon/PhieuChi/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/bai-viet",
    component: () => import("../components/Admin/TruyenThong/BaiViet/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/bai-viet/them-moi",
    component: () => import("../components/Admin/TruyenThong/BaiViet/ThemBaiMoi/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/bai-viet/chinh-sua/:id",
    component: () => import("../components/Admin/TruyenThong/BaiViet/ChinhSuaBaiViet/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/khuyen-mai",
    component: () => import("../components/Admin/TruyenThong/KhuyenMai/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/khuyen-mai/them-moi",
    component: () => import("../components/Admin/TruyenThong/KhuyenMai/TaoKhuyenMai/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/khuyen-mai/chinh-sua/:id",
    component: () => import("../components/Admin/TruyenThong/KhuyenMai/ChinhSuaKhuyenMai/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/bao-cao-doanh-thu",
    component: () => import("../components/Admin/BaoCao/DoanhThu/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/bao-cao-hieu-suat",
    component: () => import("../components/Admin/BaoCao/HieuSuat/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/bao-cao-thuoc-vat-tu",
    component: () => import("../components/Admin/BaoCao/KhoThuoc&VatTu/index.vue"),
    meta: { layout: "sidebar" },
  },
  {
    path: "/admin/cau-hinh",
    component: () => import("../components/Admin/CauHinh/index.vue"),
    meta: { layout: "sidebar" },
  },
  //********************** Bác Sĩ ************************* */s

  //********************** Y Tá ************************* */
];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});

// Global navigation guard: redirect to login when a route requires auth
router.beforeEach((to, from, next) => {
  const token = getToken();
  const requiresAuth = to.matched.some(
    (record) => record.meta && record.meta.requiresAuth
  );
  if (requiresAuth && !token) {
    // preserve intended route so we can redirect after login
    next({ path: "/khach-hang/dang-nhap", query: { redirect: to.fullPath } });
    return;
  }
  next();
});

export default router;
