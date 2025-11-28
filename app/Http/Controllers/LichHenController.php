<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreLichHenRequest;
use App\Models\LichHen;
use App\Models\ThuCung;
use Illuminate\Validation\ValidationException;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class LichHenController extends Controller
{
    /**
     * Store a newly created appointment in storage.
     */
    public function store(StoreLichHenRequest $request): JsonResponse
    {
        $data = $request->validated();

        // normalize ngay_gio to proper datetime string if present
        if (!empty($data['ngay_gio'])) {
            $data['ngay_gio'] = Carbon::parse($data['ngay_gio'])->format('Y-m-d H:i:s');
        }

        // assign the authenticated customer id as khach_hang_id if available
        $user = $request->user();
        if ($user) {
            $data['khach_hang_id'] = $user->id;

            // owner-check: ensure the pet belongs to the authenticated customer
            $owns = ThuCung::where('id', $data['thu_cung_id'])
                ->where('khach_hang_id', $user->id)
                ->exists();

            if (! $owns) {
                throw ValidationException::withMessages([
                    'thu_cung_id' => [\Illuminate\Support\Facades\Lang::get('messages.pet_not_owner')],
                ]);
            }
        }

        $lichHen = LichHen::create($data);

        return response()->json([
            'status' => true,
            'data' => $lichHen->load(['thuCung', 'dichVu', 'khachHang']),
        ], 201);
    }

    /**
     * Display a listing of the authenticated customer's appointments.
     */
    public function index(Request $request): JsonResponse
    {
        $user = $request->user();
        $query = LichHen::with(['thuCung', 'dichVu', 'nhanVien', 'thanhToan'])
            ->where('khach_hang_id', $user->id);

        // Filter by pet name (thu_cung.ten_thu_cung)
        if ($request->filled('pet_name')) {
            $petName = $request->get('pet_name');
            $query->whereHas('thuCung', function ($q) use ($petName) {
                $q->where('ten_thu_cung', 'like', '%' . $petName . '%');
            });
        }

        // Filter by service id or service name
        if ($request->filled('dich_vu_id')) {
            $query->where('dich_vu_id', $request->get('dich_vu_id'));
        } elseif ($request->filled('dich_vu_name')) {
            $dvName = $request->get('dich_vu_name');
            $query->whereHas('dichVu', function ($q) use ($dvName) {
                $q->where('ten', 'like', '%' . $dvName . '%');
            });
        }

        // Filter by trạng thái
        if ($request->filled('trang_thai')) {
            $query->where('trang_thai', $request->get('trang_thai'));
        }

        // Filter by time range: from_date and to_date (accepts date or datetime)
        try {
            $from = $request->filled('from_date') ? Carbon::parse($request->get('from_date')) : null;
            $to = $request->filled('to_date') ? Carbon::parse($request->get('to_date')) : null;
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => \Illuminate\Support\Facades\Lang::get('messages.invalid_date_format'),
            ], 422);
        }

        if ($from && $to) {
            // include whole day for to date if only date provided
            $query->whereBetween('ngay_gio', [$from->format('Y-m-d H:i:s'), $to->format('Y-m-d H:i:s')]);
        } elseif ($from) {
            $query->where('ngay_gio', '>=', $from->format('Y-m-d H:i:s'));
        } elseif ($to) {
            $query->where('ngay_gio', '<=', $to->format('Y-m-d H:i:s'));
        }

        $query->orderBy('ngay_gio', 'asc');

        // pagination or full list
        if ($request->has('per_page')) {
            $perPage = (int) $request->get('per_page', 15);
            $data = $query->paginate($perPage);
        } else {
            $data = $query->get();
        }

        return response()->json([
            'status' => true,
            'data' => $data,
        ]);
    }

    /**
     * Display the specified appointment (must belong to authenticated customer).
     */
    public function show(Request $request, LichHen $lichHen): JsonResponse
    {
        $user = $request->user();
        if ($lichHen->khach_hang_id !== $user->id) {
            return response()->json([
                'status' => false,
                'message' => \Illuminate\Support\Facades\Lang::get('messages.appointment_unauthorized_view')
            ], 403);
        }

        return response()->json([
            'status' => true,
            'data' => $lichHen->load(['thuCung', 'dichVu', 'nhanVien', 'thanhToan', 'khachHang']),
        ]);
    }

    /**
     * Update only the ngay_gio (date/time) of the appointment.
     */
    public function updateNgayGio(Request $request, LichHen $lichHen): JsonResponse
    {
        $user = $request->user();
        if ($lichHen->khach_hang_id !== $user->id) {
            return response()->json([
                'status' => false,
                'message' => \Illuminate\Support\Facades\Lang::get('messages.appointment_unauthorized_update')
            ], 403);
        }

        $validated = $request->validate([
            'ngay_gio' => ['required', 'date'],
        ]);

        $lichHen->ngay_gio = Carbon::parse($validated['ngay_gio'])->format('Y-m-d H:i:s');
        $lichHen->save();

        return response()->json([
            'status' => true,
            'data' => $lichHen->fresh()->load(['thuCung', 'dichVu', 'khachHang']),
        ]);
    }

    /**
     * Remove the specified appointment (only owner can delete).
     */
    public function destroy(Request $request, LichHen $lichHen): JsonResponse
    {
        $user = $request->user();
        if ($lichHen->khach_hang_id !== $user->id) {
            return response()->json([
                'status' => false,
                'message' => \Illuminate\Support\Facades\Lang::get('messages.appointment_unauthorized_delete')
            ], 403);
        }

        $lichHen->delete();

        return response()->json([
            'status' => true,
            'message' => \Illuminate\Support\Facades\Lang::get('messages.appointment_deleted_success'),
        ]);
    }
}
