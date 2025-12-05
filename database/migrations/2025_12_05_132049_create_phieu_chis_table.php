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
        Schema::create('phieu_chis', function (Blueprint $table) {
            $table->id();
            $table->string('ma_phieu_chi', 50)->unique();
            $table->decimal('so_tien', 15, 2);
            $table->text('ly_do');
            $table->date('ngay_chi');
            $table->string('nguoi_nhan');
            $table->text('ghi_chu');
            $table->enum('trang_thai', ['cho_duyet', 'da_duyet', 'tu_choi'])->default('cho_duyet');
            $table->foreignId('nhan_vien_id')->constrained('nhan_viens')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('phieu_chis');
    }
};
