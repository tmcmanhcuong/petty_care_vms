import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import Default from "./layout/wrapper/index.vue";
import trangchu from "./layout/wrapper/layout_rong.vue";
import dangki_dangnhap from "./layout/wrapper/layout_dangki_dangnhap.vue";

import "./assets/css/main.css";

// Toast plugin
// npm install --save vue-toastification
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";
import axios from "axios";
import {
  logout as authLogout,
  getToken as authGetToken,
  getUser as authGetUser,
} from "./utils/auth";

const app = createApp(App);

// install router and toast plugin
app.use(router);
app.use(Toast, {
  // optional default options
  position: "top-right",
  timeout: 4000,
  closeOnClick: true,
  pauseOnHover: true,
});

const existingToken =
  localStorage.getItem("auth_token") || sessionStorage.getItem("auth_token");
if (existingToken) {
  axios.defaults.headers.common["Authorization"] = `Bearer ${existingToken}`;
}

// expose simple auth helper on globalProperties for components: this.$auth.logout(router)
app.config.globalProperties.$auth = {
  logout: (router) => authLogout(router),
  getToken: authGetToken,
  getUser: authGetUser,
};

app.component("default-layout", Default);
app.component("trangchu-layout", trangchu);
app.component("dangki_dangnhap-layout", dangki_dangnhap);

app.mount("#app");
