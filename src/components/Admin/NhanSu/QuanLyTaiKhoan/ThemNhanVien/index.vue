<template>
  <div
    class="fixed inset-0 bg-black bg-opacity-50 flex items-start justify-center z-[1000] pt-24"
  >
    <div
      class="bg-white border border-gray-200/60 rounded-[10px] shadow-xl w-[495px] max-h-[85vh] overflow-y-auto"
    >
      <div class="p-6 flex flex-col gap-4">
        <!-- Header -->
        <div class="flex flex-col gap-2">
          <h2
            class="font-nunito font-semibold text-lg leading-[18px] text-neutral-950 tracking-tight"
          >
            Thêm nhân viên mới
          </h2>
          <p
            class="font-nunito text-sm leading-5 text-[#717182] tracking-tight"
          >
            Tạo tài khoản và cấp quyền truy cập cho nhân viên
          </p>
        </div>

        <!-- Form Fields -->
        <div class="flex flex-col gap-4">
          <!-- Full Name -->
          <div class="flex flex-col gap-0">
            <label
              class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0"
            >
              Họ và tên *
            </label>
            <input
              v-model="formData.fullName"
              type="text"
              placeholder="VD: BS. Nguyễn Văn A"
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
            />
          </div>

          <!-- Email & Phone -->
          <div class="grid grid-cols-2 gap-4">
            <div class="flex flex-col gap-0">
              <label
                class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0"
              >
                Email (Tên đăng nhập) *
              </label>
              <input
                v-model="formData.email"
                type="email"
                placeholder="email@vcms.vn"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>
            <div class="flex flex-col gap-0">
              <label
                class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0"
              >
                Số điện thoại *
              </label>
              <input
                v-model="formData.phone"
                type="tel"
                placeholder="0901234567"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
              />
            </div>
          </div>

          <!-- Address -->
          <div class="flex flex-col gap-0">
            <label
              class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0"
            >
              Địa chỉ
            </label>
            <input
              v-model="formData.address"
              type="text"
              placeholder="VD: 123 Nguyễn Huệ, Quận 1, TP.HCM"
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
            />
          </div>

          <!-- Avatar Upload -->
          <div class="flex flex-col gap-0">
            <label
              class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[8px]"
            >
              Ảnh đại diện
            </label>
            <div class="flex items-center gap-3">
              <button
                type="button"
                @click="triggerAvatarInput"
                class="bg-white border border-gray-200/60 rounded-lg h-9 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors"
              >
                <img :src="iconUpload" alt="Upload" class="w-4 h-4" />
                <span
                  class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight"
                  >Chọn ảnh</span
                >
              </button>
              <div v-if="avatarPreview" class="text-sm text-[#4a5565]">
                {{ avatarName }}
              </div>
            </div>
            <input
              ref="avatarInput"
              type="file"
              accept="image/*"
              class="hidden"
              @change="handleAvatarChange"
            />
            <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-[4px]">
              JPG, PNG (Tối đa 2MB)
            </p>
          </div>

          <!-- System Roles -->
          <div class="flex flex-col gap-0">
            <label
              class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0"
            >
              Vai trò hệ thống (System Roles) *
            </label>
            <div class="flex flex-col gap-3 mt-0">
              <!-- Role options as pills -->
              <div class="flex flex-wrap gap-2">
                <button
                  v-for="role in roleOptions"
                  :key="role"
                  @click.prevent="toggleRole(role)"
                  :class="
                    formData.selectedRoles.includes(role)
                      ? 'bg-[#009689] text-white px-3 py-1 rounded-lg'
                      : 'bg-[#f3f3f5] text-[#364153] px-3 py-1 rounded-lg'
                  "
                >
                  <span class="font-nunito text-sm">{{ role }}</span>
                </button>
              </div>

              <!-- Selected Roles Display -->
              <div
                v-if="formData.selectedRoles.length > 0"
                class="bg-gray-50 border border-gray-200 rounded-[10px] p-3 flex flex-wrap gap-2"
              >
                <span
                  v-for="(role, index) in formData.selectedRoles"
                  :key="index"
                  class="bg-green-100 border border-[#b9f8cf] rounded-lg px-3 py-[1px] h-[34px] flex items-center gap-1.5"
                >
                  <span
                    class="font-nunito text-sm leading-5 text-[#008236] tracking-tight"
                    >{{ role }}</span
                  >
                  <button
                    @click="removeRole(index)"
                    class="w-3.5 h-3.5 flex items-center justify-center"
                  >
                    <img :src="iconX" alt="Remove" class="w-full h-full" />
                  </button>
                </span>
              </div>

              <p class="font-nunito text-xs leading-4 text-[#6a7282]">
                Chọn vai trò: Bác sĩ hoặc Y tá.
              </p>
            </div>
          </div>

          <!-- Position -->
          <div class="flex flex-col gap-0">
            <label
              class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0"
            >
              Chức danh
            </label>
            <input
              v-model="formData.position"
              type="text"
              placeholder="VD: Trưởng khoa"
              class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] mt-0"
            />
          </div>

          <!-- Education & Experience Section -->
          <div
            class="border-t border-gray-200/60 pt-[17px] flex flex-col gap-4"
          >
            <h3
              class="font-nunito text-sm leading-5 text-[#364153] tracking-tight"
            >
              Trình độ & Kinh nghiệm
            </h3>

            <!-- Years of Experience -->
            <div class="flex flex-col gap-0">
              <label
                class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-0"
              >
                Năm kinh nghiệm
              </label>
              <div class="flex items-center gap-2">
                <input
                  v-model.number="formData.yearsOfExperience"
                  type="number"
                  placeholder="VD: 5"
                  class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] w-32"
                />
                <span
                  class="font-nunito text-sm leading-5 text-[#4a5565] tracking-tight"
                  >năm</span
                >
              </div>
            </div>

            <!-- Practice Certificate -->
            <div class="flex flex-col gap-0">
              <label
                class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[8px]"
              >
                Chứng chỉ hành nghề
              </label>
              <div class="flex items-center gap-3">
                <button
                  type="button"
                  @click="triggerPracticeInput"
                  class="bg-white border border-gray-200/60 rounded-lg h-9 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors"
                >
                  <img :src="iconUpload" alt="Upload" class="w-4 h-4" />
                  <span
                    class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight"
                    >Tải lên file</span
                  >
                </button>
                <div v-if="practiceFileName" class="text-sm text-[#4a5565]">
                  {{ practiceFileName }}
                </div>
              </div>
              <input
                ref="practiceInput"
                type="file"
                accept="application/pdf,image/*"
                class="hidden"
                @change="handlePracticeChange"
              />
              <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-[4px]">
                PDF, JPG, PNG (Tối đa 5MB)
              </p>
            </div>

            <!-- Professional Degree -->
            <div class="flex flex-col gap-0">
              <label
                class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight mb-[8px]"
              >
                Bằng cấp chuyên môn
              </label>
              <div class="flex items-center gap-3">
                <button
                  type="button"
                  @click="triggerDegreeInput"
                  class="bg-white border border-gray-200/60 rounded-lg h-9 px-3 flex items-center gap-2 w-fit hover:bg-gray-50 transition-colors"
                >
                  <img :src="iconUpload" alt="Upload" class="w-4 h-4" />
                  <span
                    class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight"
                    >Tải lên file</span
                  >
                </button>
                <div v-if="degreeFileName" class="text-sm text-[#4a5565]">
                  {{ degreeFileName }}
                </div>
              </div>
              <input
                ref="degreeInput"
                type="file"
                accept="application/pdf,image/*"
                class="hidden"
                @change="handleDegreeChange"
              />
              <p class="font-nunito text-xs leading-4 text-[#6a7282] mt-[4px]">
                PDF, JPG, PNG (Tối đa 5MB)
              </p>
            </div>
          </div>

          <!-- Initial Password -->
          <div
            class="border-t border-gray-200/60 pt-[17px] flex flex-col gap-2"
          >
            <label
              class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight"
            >
              Mật khẩu khởi tạo
            </label>
            <div class="flex items-center gap-2">
              <input
                v-model="formData.password"
                type="password"
                placeholder="Nhập mật khẩu khởi tạo"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] w-full"
              />
            </div>
            <p class="font-nunito text-xs leading-4 text-[#6a7282]">
              Mật khẩu tối thiểu 8 ký tự. Hệ thống sẽ dùng mật khẩu này làm mật
              khẩu khởi tạo cho tài khoản.
            </p>

            <!-- Confirm Password -->
            <div class="flex items-center gap-2 mt-2">
              <input
                v-model="formData.passwordConfirmation"
                type="password"
                placeholder="Xác nhận mật khẩu"
                class="bg-[#f3f3f5] border-none rounded-lg h-9 px-3 py-1 font-nunito text-sm text-neutral-950 tracking-tight outline-none placeholder:text-[#717182] w-full"
              />
            </div>
            <p
              v-if="
                formData.passwordConfirmation &&
                formData.password !== formData.passwordConfirmation
              "
              class="font-nunito text-xs leading-4 text-[#e53e3e]"
            >
              Xác nhận mật khẩu không khớp.
            </p>
          </div>

          <!-- Account Status -->
          <div
            class="border-t border-gray-200/60 pt-[12px] flex flex-col gap-2"
          >
            <label
              class="font-nunito font-medium text-sm leading-[14px] text-neutral-950 tracking-tight"
            >
              Trạng thái tài khoản
            </label>
            <div class="flex items-center gap-3 mt-1">
              <label class="inline-flex items-center cursor-pointer">
                <input
                  type="radio"
                  v-model="formData.status"
                  value="active"
                  class="hidden"
                />
                <span
                  :class="
                    formData.status === 'active'
                      ? 'bg-[#009689] text-white px-3 py-1 rounded-lg'
                      : 'bg-[#f3f3f5] text-[#364153] px-3 py-1 rounded-lg'
                  "
                  >Hoạt động</span
                >
              </label>

              <label class="inline-flex items-center cursor-pointer">
                <input
                  type="radio"
                  v-model="formData.status"
                  value="locked"
                  class="hidden"
                />
                <span
                  :class="
                    formData.status === 'locked'
                      ? 'bg-[#e53e3e] text-white px-3 py-1 rounded-lg'
                      : 'bg-[#f3f3f5] text-[#364153] px-3 py-1 rounded-lg'
                  "
                  >Đã khóa</span
                >
              </label>
            </div>
            <p class="font-nunito text-xs leading-4 text-[#6a7282]">
              Chọn trạng thái cho tài khoản khi tạo.
            </p>
          </div>
        </div>

        <!-- Footer Buttons -->
        <div class="flex items-center justify-end gap-2 mt-2">
          <button
            @click="$emit('close')"
            class="bg-white border border-gray-200/60 rounded-lg h-9 px-[17px] py-[9px] hover:bg-gray-50 transition-colors"
          >
            <span
              class="font-nunito font-medium text-sm leading-5 text-neutral-950 tracking-tight"
              >Hủy</span
            >
          </button>
          <button
            @click="handleSubmit"
            class="bg-[#009689] rounded-lg h-9 px-4 py-2 hover:bg-[#007d72] transition-colors"
            :disabled="!isFormValid"
            :class="{ 'opacity-50 cursor-not-allowed': !isFormValid }"
          >
            <span
              class="font-nunito font-medium text-sm leading-5 text-white tracking-tight"
              >Tạo tài khoản</span
            >
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";
import api, { attachToken } from "@/utils/api";
import { createNhanVien } from "@/utils/nhanVien";
import { showSuccessToast, showErrorToast } from "@/utils/toast";

// Emits
const emit = defineEmits(["close", "submit"]);

// Icons (from Figma - expire in 7 days)
const iconUpload =
  "https://www.figma.com/api/mcp/asset/ac3b14ff-9b65-40de-814c-7485b9cb246e";
const iconChevronDown =
  "https://www.figma.com/api/mcp/asset/01da1adc-0fe6-4647-ab0c-b8f938f03b86";
const iconX =
  "https://www.figma.com/api/mcp/asset/7aabb16d-9bbd-4b42-8e59-b92fc982e8aa";
const iconCheck =
  "https://www.figma.com/api/mcp/asset/0ff2272d-970d-484f-8ee5-78a87be20090";

// Form Data
const formData = ref({
  fullName: "",
  email: "",
  phone: "",
  address: "",
  avatar: null,
  selectedRoles: [], // selected roles (empty by default)
  department: "",
  position: "",
  yearsOfExperience: null,
  practiceCertificate: null,
  professionalDegree: null,
  password: "",
  passwordConfirmation: "",
  status: "active",
});

// Role options
const roleOptions = ["Bác sĩ", "Y tá"];

// Computed
const isFormValid = computed(() => {
  return (
    formData.value.fullName &&
    formData.value.email &&
    formData.value.phone &&
    formData.value.selectedRoles.length > 0 &&
    formData.value.password &&
    formData.value.password.length >= 8 &&
    formData.value.passwordConfirmation &&
    formData.value.password === formData.value.passwordConfirmation
  );
});

// Methods
const isSubmitting = ref(false);

// File input refs and previews
const avatarInput = ref(null);
const avatarPreview = ref(null);
const avatarName = ref("");
const practiceInput = ref(null);
const practiceFileName = ref("");
const degreeInput = ref(null);
const degreeFileName = ref("");

const toggleRole = (role) => {
  const idx = formData.value.selectedRoles.indexOf(role);
  if (idx === -1) formData.value.selectedRoles.push(role);
  else formData.value.selectedRoles.splice(idx, 1);
};
const removeRole = (index) => {
  formData.value.selectedRoles.splice(index, 1);
};

const triggerAvatarInput = () => avatarInput.value?.click();
const triggerPracticeInput = () => practiceInput.value?.click();
const triggerDegreeInput = () => degreeInput.value?.click();

const handleAvatarChange = (e) => {
  const file = e.target.files?.[0];
  if (!file) return;
  // limit 2MB
  if (file.size > 2 * 1024 * 1024) {
    showErrorToast("Lỗi", "Ảnh phải nhỏ hơn 2MB");
    return;
  }
  formData.value.avatar = file;
  avatarName.value = file.name;
  const reader = new FileReader();
  reader.onload = (ev) => (avatarPreview.value = ev.target.result);
  reader.readAsDataURL(file);
};

const handlePracticeChange = (e) => {
  const file = e.target.files?.[0];
  if (!file) return;
  if (file.size > 5 * 1024 * 1024) {
    showErrorToast("Lỗi", "File phải nhỏ hơn 5MB");
    return;
  }
  formData.value.practiceCertificate = file;
  practiceFileName.value = file.name;
};

const handleDegreeChange = (e) => {
  const file = e.target.files?.[0];
  if (!file) return;
  if (file.size > 5 * 1024 * 1024) {
    showErrorToast("Lỗi", "File phải nhỏ hơn 5MB");
    return;
  }
  formData.value.professionalDegree = file;
  degreeFileName.value = file.name;
};

const handleSubmit = async () => {
  if (!isFormValid.value || isSubmitting.value) return;
  isSubmitting.value = true;
  try {
    // attach token
    try {
      attachToken();
    } catch (e) {}

    // If files present, upload and replace with returned URLs before calling createNhanVien
    // Upload avatar
    if (formData.value.avatar) {
      try {
        const fd = new FormData();
        fd.append("file", formData.value.avatar);
        const upRes = await api.post("/upload", fd, {
          headers: { "Content-Type": "multipart/form-data" },
        });
        let avatarPath = null;
        if (upRes && upRes.data) {
          avatarPath =
            (upRes.data.data &&
              (upRes.data.data.path || upRes.data.data.url)) ||
            upRes.data.path ||
            upRes.data.url ||
            null;
        }
        if (avatarPath && !/^https?:\/\//i.test(avatarPath)) {
          const API_BASE =
            import.meta.env.VITE_API_BASE || "http://127.0.0.1:8000/api";
          const API_ORIGIN = API_BASE.replace(/\/api\/?$/, "");
          if (!avatarPath.startsWith("/")) avatarPath = "/" + avatarPath;
          avatarPath = API_ORIGIN + avatarPath;
        }
        formData.value.avatar = avatarPath;
      } catch (ue) {
        showErrorToast("Lỗi upload", "Không thể tải ảnh đại diện lên.");
        isSubmitting.value = false;
        return;
      }
    }

    // Upload practice certificate
    if (formData.value.practiceCertificate) {
      try {
        const fd = new FormData();
        fd.append("file", formData.value.practiceCertificate);
        const upRes = await api.post("/upload", fd, {
          headers: { "Content-Type": "multipart/form-data" },
        });
        let pPath = null;
        if (upRes && upRes.data)
          pPath =
            (upRes.data.data &&
              (upRes.data.data.path || upRes.data.data.url)) ||
            upRes.data.path ||
            upRes.data.url ||
            null;
        if (pPath && !/^https?:\/\//i.test(pPath)) {
          const API_BASE =
            import.meta.env.VITE_API_BASE || "http://127.0.0.1:8000/api";
          const API_ORIGIN = API_BASE.replace(/\/api\/?$/, "");
          if (!pPath.startsWith("/")) pPath = "/" + pPath;
          pPath = API_ORIGIN + pPath;
        }
        formData.value.practiceCertificate = pPath;
      } catch (ue) {
        showErrorToast("Lỗi upload", "Không thể tải chứng chỉ hành nghề lên.");
        isSubmitting.value = false;
        return;
      }
    }

    // Upload professional degree
    if (formData.value.professionalDegree) {
      try {
        const fd = new FormData();
        fd.append("file", formData.value.professionalDegree);
        const upRes = await api.post("/upload", fd, {
          headers: { "Content-Type": "multipart/form-data" },
        });
        let dPath = null;
        if (upRes && upRes.data)
          dPath =
            (upRes.data.data &&
              (upRes.data.data.path || upRes.data.data.url)) ||
            upRes.data.path ||
            upRes.data.url ||
            null;
        if (dPath && !/^https?:\/\//i.test(dPath)) {
          const API_BASE =
            import.meta.env.VITE_API_BASE || "http://127.0.0.1:8000/api";
          const API_ORIGIN = API_BASE.replace(/\/api\/?$/, "");
          if (!dPath.startsWith("/")) dPath = "/" + dPath;
          dPath = API_ORIGIN + dPath;
        }
        formData.value.professionalDegree = dPath;
      } catch (ue) {
        showErrorToast("Lỗi upload", "Không thể tải bằng cấp lên.");
        isSubmitting.value = false;
        return;
      }
    }

    const res = await createNhanVien(formData.value);
    showSuccessToast("Thành công", "Tạo nhân viên thành công.");
    // emit submit with returned data if available
    emit("submit", res && res.data ? res.data : formData.value);
    // close modal
    emit("close");
  } catch (err) {
    const msg =
      err && err.response && err.response.data && err.response.data.message
        ? err.response.data.message
        : "Có lỗi xảy ra khi tạo nhân viên.";
    showErrorToast("Lỗi", msg);
    console.error("createNhanVien error", err);
  } finally {
    isSubmitting.value = false;
  }
};
</script>

<style scoped>
/* Custom scrollbar for modal */
div::-webkit-scrollbar {
  width: 8px;
}

div::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

div::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

div::-webkit-scrollbar-thumb:hover {
  background: #555;
}

/* Custom checkbox styling */
input[type="checkbox"] {
  appearance: none;
  -webkit-appearance: none;
  width: 16px;
  height: 16px;
  border: 1px solid #030213;
  border-radius: 4px;
  background-color: white;
  cursor: pointer;
  position: relative;
}

input[type="checkbox"]:checked {
  background-color: #030213;
  border-color: #030213;
}

input[type="checkbox"]:checked::after {
  content: "";
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 14px;
  height: 14px;
  background-image: url("https://www.figma.com/api/mcp/asset/0ff2272d-970d-484f-8ee5-78a87be20090");
  background-size: contain;
  background-repeat: no-repeat;
}
</style>
