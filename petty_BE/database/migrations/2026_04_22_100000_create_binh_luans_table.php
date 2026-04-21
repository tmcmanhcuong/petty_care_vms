<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('binh_luans', function (Blueprint $table) {
            $table->id();
            $table->text('noi_dung');
            $table->unsignedBigInteger('bai_viet_id')->index();
            $table->unsignedBigInteger('khach_hang_id')->nullable()->index();
            $table->unsignedBigInteger('nhan_vien_id')->nullable()->index();
            $table->unsignedBigInteger('parent_id')->nullable()->index(); // For nested replies
            $table->enum('trang_thai', ['active', 'hidden'])->default('active')->index();
            $table->timestamps();

            // Foreign keys
            $table->foreign('bai_viet_id')->references('id')->on('bai_viets')->onDelete('cascade');
            $table->foreign('khach_hang_id')->references('id')->on('khach_hangs')->onDelete('cascade');
            $table->foreign('nhan_vien_id')->references('id')->on('nhan_viens')->onDelete('cascade');
            $table->foreign('parent_id')->references('id')->on('binh_luans')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('binh_luans');
    }
};
