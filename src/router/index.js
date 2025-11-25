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
  //********************** Bác Sĩ ************************* */

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
