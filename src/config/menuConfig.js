/**
 * Menu Configuration for different user roles
 * Supports: admin, doctor
 */

export const menuConfig = {
  admin: {
    title: 'Petty Admin',
    subtitle: 'Quản trị hệ thống',
    menuItems: [
      {
        key: 'dashboard',
        label: 'Dashboard',
        icon: 'https://www.figma.com/api/mcp/asset/de829f5f-9250-441a-a9ed-1d80054e1c1a',
        path: '/admin/dashboard',
        type: 'single'
      },
      {
        key: 'taiNguyen',
        label: 'Tài nguyên',
        icon: 'https://www.figma.com/api/mcp/asset/bb90decb-1ed7-40e9-8d18-1420a1ac4fa1',
        type: 'group',
        children: [
          { 
            key: 'quanLyDichVu', 
            label: 'Quản lý Dịch vụ', 
            path: '/admin/quan-ly-dich-vu' 
          },
          { 
            key: 'khoThuocVatTu', 
            label: 'Kho thuốc & Vật tư', 
            path: '/admin/kho-thuoc-vat-tu' 
          }
        ]
      },
      {
        key: 'nhanSu',
        label: 'Nhân sự',
        icon: 'https://www.figma.com/api/mcp/asset/88e96d06-b45f-4d93-aa39-5544f66e5d85',
        type: 'group',
        children: [
          { 
            key: 'nhanSu_Item1', 
            label: 'Tài Khoản', 
            path: '/admin/tai-khoan' 
          },
          { 
            key: 'nhanSu_Item2', 
            label: 'Lịch Làm Việc', 
            path: '/admin/lich-lam-viec' 
          }
        ]
      },
      {
        key: 'vanHanh',
        label: 'Vận hành',
        icon: 'https://www.figma.com/api/mcp/asset/6413c5d7-d9de-47f7-adb1-60d9c6fc64f0',
        type: 'group',
        children: [
          { 
            key: 'vanHanh_Item1', 
            label: 'Quản lý lịch hẹn', 
            path: '/admin/quan-ly-lich-hen' 
          },
          { 
            key: 'vanHanh_Item2', 
            label: 'Hồ sơ bệnh án', 
            path: '/admin/ho-so-benh-an' 
          }
        ]
      },
      {
        key: 'taiChinh',
        label: 'Tài chính & Hóa đơn',
        icon: 'https://www.figma.com/api/mcp/asset/78f6f448-fb75-4de8-a234-173bbebee868',
        type: 'group',
        children: [
          { 
            key: 'taiChinh_Item1', 
            label: 'Danh sách hóa đơn', 
            path: '/admin/danh-sach-hoa-don' 
          },
          { 
            key: 'taiChinh_Item2', 
            label: 'Phiếu chi', 
            path: '/admin/phieu-chi' 
          }
        ]
      },
      {
        key: 'truyenThong',
        label: 'Truyền thông',
        icon: 'https://www.figma.com/api/mcp/asset/420d4dcc-ebcb-4c4c-af6b-e3ef6d80dad3',
        type: 'group',
        children: [
          { 
            key: 'truyenThong_Item1', 
            label: 'Bài viết', 
            path: '/admin/bai-viet' 
          },
          { 
            key: 'truyenThong_Item2', 
            label: 'Khuyến Mãi', 
            path: '/admin/khuyen-mai' 
          }
        ]
      },
      {
        key: 'baoCao',
        label: 'Báo cáo',
        icon: 'https://www.figma.com/api/mcp/asset/decd1476-2ded-4433-b7a9-727fd8bb498e',
        type: 'group',
        children: [
          { 
            key: 'baoCao_Item1', 
            label: 'Doanh thu', 
            path: '/admin/bao-cao-doanh-thu' 
          },
          { 
            key: 'baoCao_Item2', 
            label: 'Hiệu suất', 
            path: '/admin/bao-cao-hieu-suat' 
          },
          { 
            key: 'baoCao_Item3', 
            label: 'Thuốc & Vật Tư', 
            path: '/admin/bao-cao-thuoc-vat-tu' 
          }
        ]
      },
      {
        key: 'config',
        label: 'Cấu hình',
        icon: 'https://www.figma.com/api/mcp/asset/736ac9f6-dd30-419c-a308-56fafcbf1393',
        path: '/admin/cau-hinh',
        type: 'single'
      }
    ]
  },

  doctor: {
    title: 'Petty Doctor',
    subtitle: 'Hệ thống Bác sĩ',
    menuItems: [
      {
        key: 'dashboard',
        label: 'Dashboard',
        icon: 'https://www.figma.com/api/mcp/asset/7a583d8e-ed96-463a-ac5b-438fab8ba969',
        path: '/doctor/dashboard',
        type: 'single'
      },
      {
        key: 'lichKham',
        label: 'Lịch khám',
        icon: 'https://www.figma.com/api/mcp/asset/76c679db-203c-4084-b717-f43fa7e417f4',
        path: '/doctor/lich-kham',
        type: 'single'
      },
      {
        key: 'benhNhan',
        label: 'Bệnh nhân & HSBA',
        icon: 'https://www.figma.com/api/mcp/asset/fa838dd6-b6d7-41bc-8be4-d8cfc7b095ee',
        path: '/doctor/benh-nhan',
        type: 'single'
      },
      {
        key: 'canLamSang',
        label: 'Cận lâm sàng',
        icon: 'https://www.figma.com/api/mcp/asset/d1cbc4bd-ea24-44d1-9608-e2eff73743e7',
        path: '/doctor/can-lam-sang',
        type: 'single'
      },
      {
        key: 'khoThuoc',
        label: 'Kho thuốc',
        icon: 'https://www.figma.com/api/mcp/asset/7a0d98a5-2dfb-4c54-949d-034a26c434b7',
        path: '/doctor/kho-thuoc',
        type: 'single'
      },
      {
        key: 'caNhan',
        label: 'Lịch Làm Việc',
        icon: 'https://www.figma.com/api/mcp/asset/256654dc-1ff0-4db3-963c-1a5c47cb7984',
        path: '/doctor/ca-nhan',
        type: 'single'
      }
    ]
  }
};

// Icon URLs - shared between roles
export const sharedIcons = {
  logo: 'https://www.figma.com/api/mcp/asset/fae20d1b-2870-422a-b6b3-19faaf6051ee',
  chevron: 'https://www.figma.com/api/mcp/asset/a133d436-5c70-4a4b-964c-aeee989f483b',
  logout: 'https://www.figma.com/api/mcp/asset/35d9a009-5d0e-4369-a8f1-1e8b002fcb3b'
};

/**
 * Get menu configuration by role
 * @param {string} role - User role (admin, doctor)
 * @returns {object} Menu configuration object
 */
export function getMenuByRole(role = 'admin') {
  return menuConfig[role] || menuConfig.admin;
}
