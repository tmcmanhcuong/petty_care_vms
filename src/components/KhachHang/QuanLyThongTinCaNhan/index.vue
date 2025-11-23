<template>
  <div class="min-h-screen">
    <div class="container max-w-6xl mx-auto px-6 py-8 md:px-12 lg:px-20">
      <nav class="flex items-center gap-2 text-lg font-semibold mb-8">
        <img
          src="https://www.figma.com/api/mcp/asset/1d75c94f-d14c-428b-bb1d-c3790ef43737"
          alt="Home"
          class="w-5 h-5"
        />
        <span class="text-gray-400">Trang chủ</span>
        <span class="text-black text-2xl">/</span>
        <span class="underline text-black">Thông tin cá nhân</span>
      </nav>

      <div class="bg-white border border-gray-100 rounded-2xl p-8 mb-6">
        <div class="mb-8">
          <h1 class="text-2xl font-bold text-black mb-1">Thông tin cá nhân</h1>
          <p class="text-xl font-semibold text-gray-500">
            Quản lý thông tin tài khoản và cài đặt cá nhân của bạn
          </p>
        </div>

        <div class="flex flex-col lg:flex-row gap-8">
          <div class="flex flex-col items-center gap-4">
            <div
              class="w-32 h-32 bg-teal-200 rounded-full flex items-center justify-center text-2xl font-semibold text-[#2f5755] overflow-hidden"
            >
              <template v-if="avatarPreview">
                <img
                  :src="avatarPreview"
                  alt="avatar"
                  class="w-full h-full object-cover"
                />
              </template>
              <template v-else>
                <span>{{ initials }}</span>
              </template>
            </div>

            <div class="flex items-center gap-2">
              <input
                ref="fileInputRef"
                type="file"
                accept="image/*"
                class="hidden"
                @change="handleFileChange"
              />
              <button
                @click="onAvatarClick"
                class="flex items-center gap-3 px-4 py-2 border border-black/40 rounded-lg hover:bg-gray-100 transition"
              >
                <img
                  src="https://www.figma.com/api/mcp/asset/eb992b41-f02a-470f-a22e-4159ca1002da"
                  alt="Camera"
                  class="w-4 h-4"
                />
                <span class="font-semibold">Chọn ảnh</span>
              </button>

              <button
                v-if="avatarFile"
                @click="uploadAvatar"
                :disabled="avatarUploading"
                class="px-3 py-2 border rounded-lg bg-white hover:bg-gray-50 text-sm"
              >
                <span v-if="!avatarUploading">Tải lên</span>
                <span v-else>Đang tải...</span>
              </button>
            </div>
          </div>

          <form class="flex-1 space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block font-semibold text-lg mb-2"
                  >Họ và tên *</label
                >
                <input
                  ref="nameRef"
                  v-model="form.name"
                  type="text"
                  :readonly="!isEditing"
                  class="w-full h-11 bg-gray-200 border border-black/10 rounded-lg px-3 font-semibold text-base focus:outline-none focus:border-teal-600"
                  :class="{
                    'opacity-50': !isEditing,
                    'opacity-100': isEditing,
                  }"
                />
                <div class="mt-2 text-sm text-gray-600 flex gap-4">
                  <div>
                    <span class="font-medium">Họ lót:</span>
                    <span>{{ hoLot }}</span>
                  </div>
                  <div>
                    <span class="font-medium">Tên:</span> <span>{{ ten }}</span>
                  </div>
                </div>
              </div>
              <div>
                <label class="block font-semibold text-lg mb-2"
                  >Số điện thoại *</label
                >
                <input
                  ref="phoneRef"
                  v-model="form.phone"
                  type="tel"
                  :readonly="!isEditing"
                  class="w-full h-11 bg-gray-200 border border-black/10 rounded-lg px-3 font-semibold text-base focus:outline-none focus:border-teal-600"
                  :class="{
                    'opacity-50': !isEditing,
                    'opacity-100': isEditing,
                  }"
                />
                <p
                  v-if="errors.so_dien_thoai"
                  class="text-sm text-red-600 mt-1"
                >
                  {{ errors.so_dien_thoai[0] }}
                </p>
              </div>
            </div>

            <div>
              <label class="block font-semibold text-lg mb-2">Email *</label>
              <input
                ref="emailRef"
                v-model="form.email"
                type="email"
                :readonly="!isEditing"
                class="w-full h-11 bg-gray-200 border border-black/10 rounded-lg px-3 font-semibold text-base focus:outline-none focus:border-teal-600"
                :class="{ 'opacity-50': !isEditing, 'opacity-100': isEditing }"
              />
              <p v-if="errors.email" class="text-sm text-red-600 mt-1">
                {{ errors.email[0] }}
              </p>
            </div>

            <div>
              <label class="block font-semibold text-lg mb-2">Địa chỉ</label>
              <input
                ref="addressRef"
                v-model="form.address"
                type="text"
                :readonly="!isEditing"
                class="w-full h-11 bg-gray-200 border border-black/10 rounded-lg px-3 font-semibold text-base focus:outline-none focus:border-teal-600"
                :class="{ 'opacity-50': !isEditing, 'opacity-100': isEditing }"
              />
              <p v-if="errors.dia_chi" class="text-sm text-red-600 mt-1">
                {{ errors.dia_chi[0] }}
              </p>
            </div>

            <button
              type="button"
              @click="toggleEdit"
              :disabled="saving"
              class="px-5 py-2 border border-black/30 rounded-lg font-semibold text-lg hover:bg-gray-100 transition disabled:opacity-60"
            >
              <span v-if="!isEditing">Chỉnh sửa thông tin</span>
              <span v-else>{{ saving ? "Đang lưu..." : "Lưu thông tin" }}</span>
            </button>
          </form>
        </div>
      </div>

      <div class="bg-white border border-gray-100 rounded-2xl p-8 mb-6">
        <div class="mb-8">
          <h2 class="text-2xl font-bold text-black mb-1">Bảo mật tài khoản</h2>
          <p class="text-xl font-semibold text-gray-500">
            Quản lý mật khẩu và cài đặt bảo mật
          </p>
        </div>

        <div class="space-y-6">
          <div
            class="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 p-4 border border-gray-200 rounded-xl"
          >
            <div>
              <h3 class="font-semibold text-lg">Mật khẩu</h3>
              <p class="font-semibold text-gray-600">
                Thay đổi mật khẩu định kỳ để bảo vệ tài khoản
              </p>
            </div>
            <button
              @click="onChangePassword"
              class="flex items-center gap-2 px-4 py-2 border border-black/70 rounded-lg hover:bg-gray-100 transition"
            >
              <img
                src="https://www.figma.com/api/mcp/asset/8c4e111d-ff36-4599-a675-3d5b938ea571"
                alt="Key"
                class="w-4 h-4"
              />
              <span class="font-semibold">Đổi mật khẩu</span>
            </button>
          </div>

          <hr class="border-t border-black/10" />

          <div
            class="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 p-4 border border-gray-200 rounded-xl"
          >
            <div>
              <h3 class="font-semibold text-lg">
                Đăng xuất khỏi tất cả thiết bị
              </h3>
              <p class="font-semibold text-gray-600">
                Đăng xuất khỏi tất cả các phiên đăng nhập khác
              </p>
            </div>
            <button
              @click="onLogoutAll"
              class="flex items-center gap-2 px-4 py-2 border border-red-200 text-red-600 rounded-lg hover:bg-red-50 transition"
            >
              <img
                src="https://www.figma.com/api/mcp/asset/63132e90-e7db-435c-acbd-360a6e1a3fee"
                alt="Logout"
                class="w-4 h-4"
              />
              <span class="font-semibold">Đăng xuất tất cả</span>
            </button>
          </div>
        </div>
      </div>

      <div class="bg-white border border-gray-100 rounded-2xl p-8 mb-6">
        <div class="mb-8">
          <h2 class="text-2xl font-bold text-black mb-1">Tài khoản liên kết</h2>
          <p class="text-xl font-semibold text-gray-500">
            Quản lý các tài khoản mạng xã hội đã liên kết
          </p>
        </div>

        <div class="space-y-4">
          <div
            class="flex items-center justify-between p-4 border border-gray-200 rounded-xl"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-10 h-10 rounded-full bg-white flex items-center justify-center border"
              >
                <span class="text-sm font-bold text-red-500">G</span>
              </div>
              <div>
                <div class="font-semibold">Google</div>
                <div class="text-sm text-gray-500">
                  Đã liên kết - {{ form.email }}
                </div>
              </div>
            </div>
            <div>
              <button
                @click="onUnlinkGoogle"
                class="px-3 py-1.5 border rounded-md bg-white hover:bg-gray-50 text-sm"
              >
                Hủy liên kết
              </button>
            </div>
          </div>

          <div
            class="flex items-center justify-between p-4 border border-gray-200 rounded-xl"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center border"
              >
                <span class="text-sm font-bold text-blue-600">f</span>
              </div>
              <div>
                <div class="font-semibold">Facebook</div>
                <div class="text-sm text-gray-500">
                  Chưa liên kết với Facebook
                </div>
              </div>
            </div>
            <div>
              <button
                @click="onLinkFacebook"
                class="px-3 py-1.5 border rounded-md bg-white hover:bg-gray-50 text-sm"
              >
                Liên kết
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="bg-teal-50 border border-teal-200 rounded-2xl p-8">
        <div class="space-y-4">
          <div class="flex justify-between">
            <span class="font-medium">Loại tài khoản:</span>
            <span class="font-bold text-[#2f5755]">Khách hàng thường</span>
          </div>
          <div class="flex justify-between">
            <span class="font-medium">Ngày tham gia:</span>
            <span class="font-bold text-lime-800">15/01/2024</span>
          </div>
          <div class="flex justify-between">
            <span class="font-medium">Số thú cưng đã đăng ký:</span>
            <span class="font-bold">2 bé</span>
          </div>
          <div class="flex justify-between">
            <span class="font-medium">Tổng số lần khám:</span>
            <span class="font-bold text-teal-600">8 lần</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onBeforeUnmount } from "vue";
import axios from "axios";
import { useToast } from "vue-toastification";
import { getUser, logout, setAuth, getToken } from "../../../utils/auth";

const isEditing = ref(false);

const user = ref(getUser() || null);

const initialName = (() => {
  if (user.value) {
    if (user.value.ho_lot || user.value.ten) {
      const hoLotPart = String(user.value.ho_lot || "").trim();
      const tenPart = String(user.value.ten || "").trim();
      if (hoLotPart || tenPart) return `${hoLotPart} ${tenPart}`.trim();
    }
    if (user.value.ho_ten) return user.value.ho_ten;
    if (user.value.name) return user.value.name;
  }
  return "Nguyễn Văn A";
})();

const form = ref({
  name: initialName,
  phone: user.value?.so_dien_thoai || "0912345678",
  email: user.value?.email || "nguyen.a@email.com",
  address: user.value?.dia_chi || "123 Đường Nguyễn Huệ, Quận 1, TP.HCM",
});

const initials = computed(() => {
  const n = String(form.value.name || "").trim();
  if (!n) return "";
  const parts = n.split(/\s+/);
  if (parts.length === 1) return parts[0].slice(0, 2).toUpperCase();
  return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
});


function formatNameRaw(input) {
  if (!input) return "";
  const s = String(input).trim().replace(/\s+/g, " ");
  const parts = s.split(/\s+/).filter(Boolean);
  const formatted = parts
    .map((w) => {
      if (w === w.toUpperCase()) return w; 
      const lower = w.toLocaleLowerCase("vi");
      return lower.charAt(0).toLocaleUpperCase("vi") + lower.slice(1);
    })
    .join(" ");
  return formatted;
}

const hoLot = computed(() => {
  if (user.value && (user.value.ho_lot || user.value.ten)) {
    return String(user.value.ho_lot || "").trim();
  }
  const full = formatNameRaw(form.value.name || "").trim();
  if (!full) return "";
  const parts = full.split(/\s+/).filter(Boolean);
  if (parts.length <= 1) return "";
  return parts.slice(0, -1).join(" ");
});

const ten = computed(() => {
  if (user.value && (user.value.ho_lot || user.value.ten)) {
    return String(user.value.ten || "").trim();
  }
  const full = formatNameRaw(form.value.name || "").trim();
  if (!full) return "";
  const parts = full.split(/\s+/).filter(Boolean);
  return parts.length ? parts[parts.length - 1] : "";
});

const toggleEdit = () => {
  if (isEditing.value) {
    saveProfile();
    return;
  }
  isEditing.value = true;
};


const onChangePassword = () => {
  alert("Chuyển đến trang đổi mật khẩu...");
};

const onLogoutAll = () => {
  if (confirm("Bạn có chắc muốn đăng xuất khỏi tất cả thiết bị?")) {
    logout();
    alert("Đã đăng xuất khỏi tất cả thiết bị!");
  }
};

const onUnlinkGoogle = () => {
  if (confirm("Bạn muốn hủy liên kết Google?")) {
    alert("Đã hủy liên kết Google");
  }
};

const onLinkFacebook = () => {
  alert("Chuyển đến Facebook để liên kết...");
};

const toast = useToast();
const saving = ref(false);
const errors = ref<Record<string, string[]>>({});

const API_BASE = "http://127.0.0.1:8000/api/khach-hang";

const nameRef = ref<HTMLInputElement | null>(null);
const phoneRef = ref<HTMLInputElement | null>(null);
const emailRef = ref<HTMLInputElement | null>(null);
const addressRef = ref<HTMLInputElement | null>(null);
const fileInputRef = ref<HTMLInputElement | null>(null);
const avatarFile = ref<File | null>(null);
const avatarPreview = ref<string | null>(user.value?.anh_dai_dien || null);
const avatarLocalUrl = ref<string | null>(null); // object URL created for preview
const avatarUploading = ref(false);

function focusFirstError(errs: Record<string, any>) {
  const order = ["ho_ten", "email", "so_dien_thoai", "dia_chi"];
  for (const key of order) {
    if (errs && errs[key]) {
      try {
        if (
          key === "ho_ten" &&
          nameRef.value &&
          typeof nameRef.value.focus === "function"
        )
          return nameRef.value.focus();
        if (
          key === "email" &&
          emailRef.value &&
          typeof emailRef.value.focus === "function"
        )
          return emailRef.value.focus();
        if (
          key === "so_dien_thoai" &&
          phoneRef.value &&
          typeof phoneRef.value.focus === "function"
        )
          return phoneRef.value.focus();
        if (
          key === "dia_chi" &&
          addressRef.value &&
          typeof addressRef.value.focus === "function"
        )
          return addressRef.value.focus();
      } catch (e) {
      }
      break;
    }
  }
}

function onAvatarClick() {
  if (fileInputRef.value) fileInputRef.value.click();
}

function handleFileChange(e: Event) {
  const input = e.target as HTMLInputElement;
  const file = input?.files?.[0] || null;
  if (!file) return;
  if (!file.type.startsWith("image/")) {
    toast.error("Vui lòng chọn tệp ảnh (jpg, png, ...)");
    return;
  }
  avatarFile.value = file;
  if (avatarLocalUrl.value) {
    try {
      URL.revokeObjectURL(avatarLocalUrl.value);
    } catch (e) {
    }
  }
  const url = URL.createObjectURL(file);
  avatarLocalUrl.value = url;
  avatarPreview.value = url;
}

onBeforeUnmount(() => {
  if (avatarLocalUrl.value) {
    try {
      URL.revokeObjectURL(avatarLocalUrl.value);
    } catch (e) {
    }
    avatarLocalUrl.value = null;
  }
});

async function uploadAvatar() {
  if (!avatarFile.value) return;
  if (avatarUploading.value) return;
  avatarUploading.value = true;
  const base = API_BASE;
  try {
    const fd = new FormData();
    fd.append("anh_dai_dien", avatarFile.value as Blob);
    fd.append("ho_ten", form.value.name || "");
    fd.append("email", form.value.email || "");
    fd.append("so_dien_thoai", form.value.phone || "");
    fd.append("dia_chi", form.value.address || "");

    const res = await axios.post(`${base}/cap-nhat`, fd, {
      headers: { "Content-Type": "multipart/form-data" },
    });

    const updatedUser = res?.data?.user || res?.data?.data || res?.data;
    if (updatedUser) {
      user.value = updatedUser;
      if (updatedUser.anh_dai_dien) {
        avatarPreview.value = updatedUser.anh_dai_dien;
      }
      try {
        const token = getToken();
        if (token) setAuth(token, updatedUser, true);
      } catch (e) {
      }
    }

    toast.success("Ảnh đại diện đã được cập nhật");
    avatarFile.value = null;
    if (avatarLocalUrl.value) {
      try {
        URL.revokeObjectURL(avatarLocalUrl.value);
      } catch (e) {
      }
      avatarLocalUrl.value = null;
    }
  } catch (e: any) {
    const msg = e?.response?.data?.message || e?.message || "Tải ảnh thất bại";
    if (e?.response?.status === 422) {
      const respErrors = e.response.data.errors || {};
      const first = respErrors?.anh_dai_dien || Object.values(respErrors)[0];
      if (first && Array.isArray(first)) toast.error(first[0]);
      else toast.error(msg);
    } else if (e?.response?.status === 401) {
      toast.error("Phiên hết hạn. Vui lòng đăng nhập lại.");
      logout();
    } else {
      toast.error(msg);
    }
    console.error("uploadAvatar error", e);
  } finally {
    avatarUploading.value = false;
  }
}

async function saveProfile() {
  if (saving.value) return;
  saving.value = true;
  const payload = {
    ho_ten: form.value.name,
    email: form.value.email,
    so_dien_thoai: form.value.phone,
    dia_chi: form.value.address,
  };

  const base = "http://127.0.0.1:8000/api/khach-hang";
  try {
    errors.value = {};
    let res = null;
    try {
      res = await axios.post(`${base}/cap-nhat`, payload);
    } catch (err) {
      const status = err?.response?.status;
      if (status === 404 || status === 405 || status === 422) {
        const id = user.value?.id || user.value?.ma || user.value?.user_id;
        if (id) {
          res = await axios.put(`${base}/${id}`, payload);
        } else throw err;
      } else {
        throw err;
      }
    }

    const updatedUser = res?.data?.user || res?.data?.data || res?.data;
    try {
      const token = getToken();
      if (token) setAuth(token, updatedUser, true);
    } catch (e) {
    }

    if (updatedUser) {
      user.value = updatedUser;
      if (updatedUser.ho_lot || updatedUser.ten) {
        const ho = String(updatedUser.ho_lot || "").trim();
        const t = String(updatedUser.ten || "").trim();
        form.value.name = `${ho} ${t}`.trim();
      } else {
        form.value.name =
          updatedUser.ho_ten || updatedUser.name || form.value.name;
      }
      form.value.phone =
        updatedUser.so_dien_thoai || updatedUser.phone || form.value.phone;
      form.value.email = updatedUser.email || form.value.email;
      form.value.address =
        updatedUser.dia_chi || updatedUser.address || form.value.address;
    }

    toast.success("Thông tin đã được cập nhật");
    isEditing.value = false;
  } catch (e: any) {
    const msg = e?.response?.data?.message || e?.message || "Cập nhật thất bại";
    if (e?.response?.status === 422) {
      const respErrors = e.response.data.errors || {};
      errors.value = respErrors;
      focusFirstError(respErrors);
      const first = Object.values(respErrors)[0];
      if (first && Array.isArray(first)) {
        toast.error(first[0]);
      } else {
        toast.error(msg);
      }
    } else if (e?.response?.status === 401) {
      toast.error(
        "Bạn chưa đăng nhập hoặc phiên đã hết hạn. Vui lòng đăng nhập lại."
      );
      logout();
    } else {
      toast.error(msg);
    }
    console.error("saveProfile error", e);
  } finally {
    saving.value = false;
  }
}
</script>

<style scoped></style>
