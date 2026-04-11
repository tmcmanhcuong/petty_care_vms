import axios from "axios";
import { getToken } from "./auth";

const API_BASE = import.meta.env.VITE_API_BASE || "http://127.0.0.1:8000/api";

const client = axios.create({
  baseURL: API_BASE,
});

// Interceptor để tự động thêm token
client.interceptors.request.use(
  (config) => {
    const token = getToken();
    if (token) {
      config.headers["Authorization"] = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

/**
 * Tạo thanh toán MoMo
 * @param {Object} data - Dữ liệu thanh toán { order_id, amount }
 */
export async function createMoMoPayment(data) {
  try {
    const response = await client.post("/payment/momo/create", data);
    return response.data;
  } catch (error) {
    console.error("Error creating MoMo payment:", error);
    throw error;
  }
}

/**
 * Lấy danh sách hóa đơn thanh toán của khách hàng
 * @param {Object} params - Query parameters
 */
export async function getPaymentInvoices(params = {}) {
  try {
    const response = await client.get("/lich-hen", { params });
    console.log('Raw API response:', response);
    return response.data;
  } catch (error) {
    console.error("Error fetching payment invoices:", error);
    throw error;
  }
}

/**
 * Lấy chi tiết hóa đơn
 * @param {number} id - ID của hóa đơn
 */
export async function getInvoiceDetail(id) {
  try {
    const response = await client.get(`/lich-hen/${id}`);
    return response.data;
  } catch (error) {
    console.error("Error fetching invoice detail:", error);
    throw error;
  }
}
