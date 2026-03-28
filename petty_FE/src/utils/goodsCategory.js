import client from "./api";

const BASE = "/danh-muc-hang-hoa";

export async function listDanhMucGoods(params = {}) {
  const res = await client.get(BASE, { params });
  return res.data && res.data.data ? res.data.data : [];
}

export async function getDanhMucGoods(id) {
  const res = await client.get(`${BASE}/${id}`);
  return res.data && res.data.data ? res.data.data : null;
}

export async function createDanhMucGoods(payload) {
  // Map frontend-friendly keys to backend expected keys
  const body = {
    // backend expects 'ten_danh_muc_hang_hoa' for the name
    ten_danh_muc_hang_hoa:
      payload.ten_danh_muc_hang_hoa || payload.name || payload.ten || null,
    // common field name for description in Vietnamese (adjust if different)
    mo_ta: payload.mo_ta || payload.description || null,
  };

  const res = await client.post(BASE, body);
  return res.data && res.data.data ? res.data.data : null;
}

export async function updateDanhMucGoods(id, payload) {
  const body = {
    ten_danh_muc_hang_hoa:
      payload.ten_danh_muc_hang_hoa || payload.name || payload.ten || null,
    mo_ta: payload.mo_ta || payload.description || null,
  };

  const res = await client.put(`${BASE}/${id}`, body);
  return res.data && res.data.data ? res.data.data : null;
}

export async function deleteDanhMucGoods(id) {
  const res = await client.delete(`${BASE}/${id}`);
  return res.data || null;
}

export default {
  listDanhMucGoods,
  getDanhMucGoods,
  createDanhMucGoods,
  updateDanhMucGoods,
  deleteDanhMucGoods,
};
