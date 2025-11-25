<template>
  <div class="min-h-screen flex items-center justify-center p-5">
    <div
      class="bg-white rounded-3xl shadow-2xl p-14 w-full max-w-6xl flex flex-col lg:flex-row items-center justify-center gap-10"
    >
      <div
        class="relative w-full max-w-lg h-96 lg:h-auto flex-shrink-0 rounded-2xl overflow-hidden group cursor-pointer"
      >
        <img
          src="../../../assets/img_imports/sign_in_up_img/sign-img1.png"
          alt="PETTY - Chăm sóc thú cưng"
          class="w-full h-full object-cover transition-transform duration-500 ease-out group-hover:scale-105"
        />

        <div
          class="absolute inset-x-4 bottom-6 lg:inset-x-6 lg:bottom-8 max-w-xs mx-auto"
        >
          <div
            class="bg-white/50 backdrop-blur-sm border border-white/20 rounded-lg p-3 shadow-md transition-all duration-300 ease-out group-hover:bg-white/80 group-hover:backdrop-blur-md group-hover:shadow-xl group-hover:scale-105 group-hover:border-white/40 group-hover:-translate-y-1"
          >
            <div class="space-y-3">
              <p
                class="text-gray-800 text-xs font-medium leading-tight italic group-hover:text-gray-900 transition-colors duration-300"
              >
                "Trước đây mỗi lần đưa Bún đi khám là phải chờ khá lâu, nhưng từ
                khi có PETTY, tôi chỉ cần đặt lịch trước vài phút là có lịch
                ngay..."
              </p>
              <div
                class="border-t border-gray-300/40 pt-2 group-hover:border-gray-400/60 transition-colors duration-300"
              >
                <p
                  class="text-gray-900 font-semibold text-xs group-hover:text-gray-950 transition-colors duration-300"
                >
                  Ngọc Trâm
                </p>
                <p
                  class="text-gray-600 text-xs italic group-hover:text-gray-700 transition-colors duration-300"
                >
                  chủ của chú chó Bún
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="w-full max-w-sm space-y-6">
        <div class="text-center space-y-3">
          <h1
            class="text-4xl font-bold text-teal-800 font-['Montserrat_Alternates']"
          >
            PETTY Xin Chào
          </h1>
          <p class="text-sm text-gray-700 font-medium">
            Bắt đầu trải nghiệm các dịch vụ tại PETTY ngay nào
          </p>
        </div>

        <form @submit.prevent="handleLogin" class="space-y-5">
          <div>
            <label class="block text-sm font-medium text-gray-800">
              Email <span class="text-red-600">*</span>
            </label>
            <div class="relative mt-1">
              <img
                src="https://www.figma.com/api/mcp/asset/9ce8dfae-0136-43d1-8f27-28fd8dd0b6bb"
                alt="Email"
                class="absolute left-4 top-1/2 transform -translate-y-1/2 w-4 h-4"
              />
              <input
                v-model="form.email"
                ref="emailInput"
                type="email"
                placeholder="Nhập email"
                autocomplete="email"
                class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-teal-600"
                :class="{ 'border-red-500': errors.email }"
                aria-invalid="errors.email ? 'true' : 'false'"
                aria-describedby="email-error"
                required
              />
              <!-- suggestion when stored user email matches typed email -->
              <div
                v-if="showStoredSuggestion"
                class="mt-2 text-xs text-gray-600 flex items-center gap-2"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4 text-teal-600"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M12 11c0 1.657-1.343 3-3 3s-3-1.343-3-3 1.343-3 3-3 3 1.343 3 3z"
                  />
                </svg>
                <span>Phát hiện tài khoản đã ghi nhớ. </span>
                <button
                  @click="useRememberedAccount"
                  type="button"
                  class="ml-2 text-teal-700 font-medium hover:underline"
                >
                  Sử dụng mật khẩu đã lưu
                </button>
              </div>
              <p
                v-if="errors.email"
                id="email-error"
                class="mt-1 text-sm text-red-600"
              >
                {{ errors.email[0] }}
              </p>
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-800">
              Mật Khẩu <span class="text-red-600">*</span>
            </label>
            <div class="relative mt-1">
              <img
                src="https://www.figma.com/api/mcp/asset/8fdef1a1-4093-4a2a-9e3b-9f7fbedfc358"
                alt="Lock"
                class="absolute left-4 top-1/2 transform -translate-y-1/2 w-4 h-4"
              />
              <input
                v-model="form.password"
                ref="passwordInput"
                type="password"
                placeholder="Nhập mật khẩu"
                autocomplete="current-password"
                class="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-teal-600"
                :class="{ 'border-red-500': errors.password }"
                aria-invalid="errors.password ? 'true' : 'false'"
                aria-describedby="password-error"
                required
              />
              <p
                v-if="errors.password"
                id="password-error"
                class="mt-1 text-sm text-red-600"
              >
                {{ errors.password[0] }}
              </p>
            </div>
          </div>

          <div class="flex justify-between items-center text-xs">
            <a href="#" class="text-gray-500 hover:text-teal-700"
              >Quên Mật Khẩu?</a
            >
            <div class="flex items-center gap-2">
              <span class="text-gray-500">Ghi nhớ đăng nhập</span>
              <button
                type="button"
                @click="toggleRemember"
                :class="[
                  'w-12 h-6 rounded-full p-1 transition flex items-center',
                  rememberMe
                    ? 'bg-gradient-to-r from-teal-500 to-teal-700 justify-end'
                    : 'bg-gray-300 justify-start',
                ]"
              >
                <div class="w-4 h-4 bg-white rounded-full shadow"></div>
              </button>
            </div>
          </div>

          <button
            type="submit"
            class="w-full bg-teal-600 hover:bg-teal-700 text-white font-semibold py-2 rounded-2xl transition shadow-sm"
          >
            Đăng Nhập
          </button>
        </form>

        <div class="relative text-center text-xs text-gray-500 my-4">
          <div class="absolute inset-0 flex items-center">
            <div class="w-full border-t border-gray-300"></div>
          </div>
          <span class="relative bg-gray-50 px-2">Hoặc</span>
        </div>

        <div class="flex justify-center gap-4">
          <button
            @click="handleGoogleLogin"
            class="p-2.5 bg-gray-200 rounded-xl hover:scale-105 transition"
          >
            <img
              src="https://www.figma.com/api/mcp/asset/958d2025-8fe1-4ea3-ad0e-929d8d91f90f"
              alt="Gmail"
              class="w-7 h-7"
            />
          </button>
          <button
            @click="handleFacebookLogin"
            class="p-2.5 bg-gray-200 rounded-xl hover:scale-105 transition"
          >
            <img
              src="https://www.figma.com/api/mcp/asset/8f334b9f-7acf-41e1-8499-5d83274f6f5e"
              alt="Facebook"
              class="w-7 h-7"
            />
          </button>
        </div>

        <p class="text-center text-sm">
          <span class="text-gray-600">Chưa có tài khoản?</span>
          <router-link to="/khach-hang/dang-ky">
            <a
              href="/khach-hang/dang-ky"
              class="text-blue-600 font-medium hover:underline ml-1"
              >Đăng Ký</a
            >
          </router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup>
// Import các thư viện cần thiết
import { ref, nextTick, watch } from "vue";
import { useRouter, useRoute } from "vue-router";
import axios from "axios";
import { useToast } from "vue-toastification";

const router = useRouter();
const route = useRoute();
const toast = useToast();

const form = ref({
  email: "",
  password: "",
});

const errors = ref({});
const isSubmitting = ref(false);
const rememberMe = ref(true);

const emailInput = ref(null);
const passwordInput = ref(null);
const agreeRef = ref(null);

// Lấy thông tin user đã lưu (nếu có)
let storedUser = null;
try {
  const su = localStorage.getItem("auth_user");
  storedUser = su ? JSON.parse(su) : null;
} catch (e) {
  storedUser = null;
}

if (storedUser?.email) {
  form.value.email = storedUser.email;
}

const showStoredSuggestion = ref(false);

const focusByKey = async (key) => {
  await nextTick();
  if (key === "email") emailInput.value?.focus();
  else if (key === "password") passwordInput.value?.focus();
};

const checkShowSuggestion = () => {
  const e = (form.value.email || "").toLowerCase();
  showStoredSuggestion.value =
    storedUser && storedUser.email && e === storedUser.email.toLowerCase();
};

// Kiểm tra xem đã đăng nhập chưa
const existingToken =
  localStorage.getItem("auth_token") || sessionStorage.getItem("auth_token");
if (existingToken) {
  axios.defaults.headers.common["Authorization"] = `Bearer ${existingToken}`;
  router.push("/");
}

// If user was redirected here because they tried to access a protected page,
// show an informational toast asking them to login first.
if (route.query && route.query.redirect) {
  toast.info("Vui lòng đăng nhập để tiếp tục");
}

// Xử lý đăng nhập
const handleLogin = async () => {
  errors.value = {};
  isSubmitting.value = true;

  if (!form.value.email) {
    toast.error("Vui lòng nhập email");
    await nextTick();
    emailInput.value?.focus();
    isSubmitting.value = false;
    return;
  }
  if (!form.value.password) {
    toast.error("Vui lòng nhập mật khẩu");
    await nextTick();
    passwordInput.value?.focus();
    isSubmitting.value = false;
    return;
  }

  try {
    const payload = {
      email: form.value.email,
      password: form.value.password,
    };
    const res = await axios.post(
      "http://127.0.0.1:8000/api/khach-hang/dang-nhap",
      payload
    );
    if (res.data && res.data.status) {
      toast.success(res.data.message || "Đăng nhập thành công");
      const token = res.data.token;
      if (token) {
        if (rememberMe.value) {
          localStorage.setItem("auth_token", token);
          sessionStorage.removeItem("auth_token");
        } else {
          sessionStorage.setItem("auth_token", token);
          localStorage.removeItem("auth_token");
        }

        axios.defaults.headers.common["Authorization"] = `Bearer ${token}`;

        if (res.data.data) {
          const userStr = JSON.stringify(res.data.data);
          if (rememberMe.value) {
            localStorage.setItem("auth_user", userStr);
            sessionStorage.removeItem("auth_user");
          } else {
            sessionStorage.setItem("auth_user", userStr);
            localStorage.removeItem("auth_user");
          }
        }
      }

      // After login, redirect to original page if provided
      const redirectPath =
        route.query && route.query.redirect
          ? String(route.query.redirect)
          : null;
      if (redirectPath && redirectPath.startsWith("/")) {
        router.push(redirectPath);
      } else {
        router.push("/");
      }
    } else {
      toast.error(res.data.message || "Đăng nhập thất bại");
    }
  } catch (err) {
    if (err.response?.status === 422) {
      errors.value = err.response.data.errors || {};
      toast.error("Vui lòng kiểm tra lại thông tin đăng nhập");
      if (errors.value.email) focusByKey("email");
      else if (errors.value.password) focusByKey("password");
    } else {
      toast.error(err.response?.data?.message || "Đã có lỗi xảy ra");
    }
  } finally {
    isSubmitting.value = false;
  }
};

const toggleRemember = () => {
  rememberMe.value = !rememberMe.value;
};

const useRememberedAccount = async () => {
  await nextTick();
  passwordInput.value?.focus();

  const token =
    localStorage.getItem("auth_token") || sessionStorage.getItem("auth_token");
  if (token) {
    axios.defaults.headers.common["Authorization"] = `Bearer ${token}`;
    router.push("/");
  }
};

watch(
  () => form.value.email,
  () => {
    checkShowSuggestion();
  }
);

// Xử lý đăng nhập Google
const handleGoogleLogin = () => {
  window.location.href = "http://127.0.0.1:8000/api/auth/google";
};

// Xử lý đăng nhập Facebook
const handleFacebookLogin = () => {
  window.location.href = "http://127.0.0.1:8000/api/auth/facebook";
};
</script>

<style scoped>
@font-face {
  font-family: "Montserrat Alternates";
  src: url("https://fonts.googleapis.com/css2?family=Montserrat+Alternates:wght@700&display=swap")
    format("woff2");
  font-weight: 700;
  font-display: swap;
}
</style>
