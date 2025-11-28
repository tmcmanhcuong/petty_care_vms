<template>
  <!-- Make inner container transparent so variant background (success/error/etc.) from the toast wrapper is visible -->
  <div
    class="toast-container bg-transparent rounded-lg w-full max-w-[488px] shadow-lg overflow-hidden pointer-events-auto"
  >
    <div class="flex gap-3 items-start p-4 relative">
      <!-- Content -->
      <div class="flex flex-1 items-start justify-between min-w-0">
        <!-- Icon + Content -->
        <div class="flex gap-3 items-start flex-1 min-w-0">
          <!-- Icon -->
          <div class="flex-shrink-0 w-5 h-5">
            <img
              v-if="type === 'success'"
              src="https://www.figma.com/api/mcp/asset/43a15868-7fcf-487b-ad7f-3c8568e2b337"
              alt="Success"
              class="w-full h-full"
            />
            <img
              v-else-if="type === 'error'"
              src="https://www.figma.com/api/mcp/asset/09288516-18e8-43d5-847e-8739497ed26b"
              alt="Error"
              class="w-full h-full"
            />
            <img
              v-else
              src="https://www.figma.com/api/mcp/asset/43a15868-7fcf-487b-ad7f-3c8568e2b337"
              alt="Info"
              class="w-full h-full"
            />
          </div>

          <!-- Title + Description -->
          <div class="flex flex-col gap-1 flex-1 min-w-0">
            <p class="text-base font-semibold leading-5" style="color: #ffffff">
              {{ title }}
            </p>
            <p
              class="text-sm font-normal leading-5 whitespace-pre-wrap"
              v-html="message"
              style="color: rgba(255, 255, 255, 0.9)"
            ></p>
          </div>
        </div>

        <!-- Close Button -->
        <button
          @click.stop="$emit('close-toast')"
          class="flex-shrink-0 p-1 rounded-md hover:bg-gray-100 transition"
        >
          <img
            src="https://www.figma.com/api/mcp/asset/49f78819-105c-45d8-8483-0997990ee4e9"
            alt="Close"
            class="w-[10.667px] h-[10.667px]"
            style="filter: invert(1) brightness(2)"
          />
        </button>
      </div>
    </div>
    <!-- Progress Bar -->
    <div
      class="toast-progress absolute bottom-0 left-0 h-1.5 z-10"
      :style="{
        width: '100%',
        animation: `progress-bar ${duration}ms linear forwards`,
        background: 'rgba(255,255,255,0.25)',
      }"
    ></div>
  </div>
</template>

<style>
@keyframes progress-bar {
  from {
    width: 100%;
  }
  to {
    width: 0%;
  }
}

.toast-container:hover .toast-progress {
  animation-play-state: paused !important;
}
</style>

<script setup>
defineProps({
  type: {
    type: String,
    default: "success",
  },
  title: {
    type: String,
    default: "",
  },
  message: {
    type: String,
    default: "",
  },
  duration: {
    type: Number,
    default: 4000,
  },
});

defineEmits(["close-toast"]);
</script>

<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Nunito+Sans:ital,wght@0,400;0,500;0,600;0,700;0,800;1,700&family=Nunito:wght@400&display=swap");
</style>
