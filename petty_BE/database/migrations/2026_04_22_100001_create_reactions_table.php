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
        Schema::create('reactions', function (Blueprint $table) {
            $table->id();
            $table->enum('loai', ['like', 'dislike']); // Type of reaction
            $table->morphs('reactionable'); // For polymorphic relation (bai_viet or binh_luan)
            $table->unsignedBigInteger('khach_hang_id')->nullable()->index();
            $table->unsignedBigInteger('nhan_vien_id')->nullable()->index();
            $table->timestamps();

            // Foreign keys
            $table->foreign('khach_hang_id')->references('id')->on('khach_hangs')->onDelete('cascade');
            $table->foreign('nhan_vien_id')->references('id')->on('nhan_viens')->onDelete('cascade');

            // Unique constraint: one reaction per user per item
            $table->unique(['reactionable_type', 'reactionable_id', 'khach_hang_id', 'nhan_vien_id'], 'unique_reaction');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reactions');
    }
};
