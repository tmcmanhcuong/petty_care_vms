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
        Schema::create('khoas', function (Blueprint $table) {
            $table->id();
            $table->string('ten_khoa');
            $table->text('mo_ta')->nullable();
            $table->string('chuyen_mon')->nullable();
            // trạng_thai: 1 = active, 0 = inactive
            $table->tinyInteger('trang_thai')->default(1);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('khoas');
    }
};
