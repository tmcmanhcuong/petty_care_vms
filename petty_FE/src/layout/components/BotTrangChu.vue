<template>
  <footer class="relative w-full min-h-[700px] overflow-hidden bg-[#5a9690]">
    <!-- Clean Background with Subtle Gradient -->
    <div class="absolute inset-0 z-0 bg-[radial-gradient(circle_at_30%_20%,rgba(255,255,255,0.05)_0%,transparent_50%)]"></div>

    <!-- Main Content -->
    <div
      class="relative z-10 min-h-[700px] flex flex-col items-center justify-between px-6 py-20 md:px-16 lg:px-32">
      
      <!-- CTA Section -->
      <div class="flex w-full max-w-5xl flex-col items-center gap-10 text-center py-12">
        <div class="flex flex-col items-center gap-6">
          <div class="inline-flex items-center rounded-full border border-white/30 bg-white/10 px-5 py-2 text-white backdrop-blur-sm">
            <span class="font-nunito font-bold text-xs tracking-[0.2em] uppercase">Bắt Đầu Ngay</span>
          </div>

          <div class="flex flex-col items-center gap-6 max-w-4xl">
            <h2 class="text-5xl font-extrabold text-white md:text-6xl lg:text-7xl leading-tight font-nunito">
              Chăm sóc thú cưng <br/> dễ dàng hơn với <span class="text-[#2f5755]">PETTY</span>
            </h2>
            <p class="font-dmSans text-base leading-relaxed text-gray-100 md:text-xl max-w-2xl opacity-90">
              Từ đặt lịch, tra cứu hồ sơ đến theo dõi sức khỏe – tất cả chỉ trong một nền tảng chuyên nghiệp.
            </p>
          </div>

          <!-- CTA Button -->
          <button
            class="group flex items-center gap-3 rounded-2xl bg-white px-5 py-4 shadow-xl transition-all duration-300 hover:-translate-y-2 hover:shadow-2xl active:scale-95">
            <Rocket class="h-6 w-6 text-[#5a9690]" />
            <span class="font-nunitoSans text-xl font-black text-[#5a9690]">Đặt lịch ngay</span>
          </button>
        </div>
      </div>

      <!-- Footer Info -->
      <div class="w-full grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-16 pt-20 border-t border-white/10">
        <!-- Brand Section -->
        <div class="flex flex-col gap-8">
          <div class="w-52 bg-white/95 p-4 rounded-2xl shadow-lg">
            <img src="/src_assets/img_imports/Petty Logo.png" alt="Petty Logo" class="w-full" loading="lazy" />
          </div>
          <p class="font-nunitoSans text-sm leading-relaxed text-white/80">
            Sứ mệnh của chúng tôi là mang lại trải nghiệm chăm sóc thú cưng toàn diện và hiện đại nhất cho mọi chủ nuôi.
          </p>
          <!-- Social Links -->
          <div class="flex gap-4">
            <a v-for="social in socials" :key="social.label" :href="social.link" :aria-label="social.label"
              class="group w-11 h-11 flex items-center justify-center rounded-xl bg-white/10 hover:bg-white text-white hover:text-[#5a9690] transition-all duration-300">
              <svg v-if="social.label === 'Facebook'" class="w-5 h-5 fill-current" viewBox="0 0 24 24"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
              <svg v-else-if="social.label === 'Instagram'" class="w-5 h-5 fill-current" viewBox="0 0 24 24"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
              <svg v-else-if="social.label === 'YouTube'" class="w-5 h-5 fill-current" viewBox="0 0 24 24"><path d="M19.615 3.184c-3.604-.246-11.631-.245-15.23 0-3.897.266-4.356 2.62-4.385 8.816.029 6.185.484 8.549 4.385 8.816 3.6.245 11.626.246 15.23 0 3.897-.266 4.356-2.62 4.385-8.816-.029-6.185-.484-8.549-4.385-8.816zm-10.615 12.816v-8l8 3.993-8 4.007z"/></svg>
            </a>
          </div>
        </div>

        <!-- Links Columns -->
        <div v-for="section in [ { title: 'Liên Kết Nhanh', links: quickLinks }, { title: 'Tài nguyên', links: resources } ]" 
          :key="section.title" class="flex flex-col gap-6">
          <h3 class="font-nunito text-lg font-black text-white tracking-wider border-b border-white/10 pb-2 uppercase">{{ section.title }}</h3>
          <nav class="flex flex-col gap-3">
            <a v-for="link in section.links" :key="link.text" href="#" 
              class="group flex items-center gap-2 text-white/70 hover:text-white transition-all duration-300">
              <span class="text-sm font-medium">{{ link.text }}</span>
            </a>
          </nav>
        </div>

        <!-- Newsletter -->
        <div class="flex flex-col gap-6">
          <h3 class="font-nunito text-lg font-black text-white tracking-wider border-b border-white/10 pb-2 uppercase">Nhận Tin Mới</h3>
          <form class="flex flex-col gap-4" @submit.prevent>
            <p class="text-xs text-white/70 leading-relaxed italic">Đăng ký để nhận những thông tin hữu ích nhất cho thú cưng của bạn.</p>
            <div class="flex flex-col gap-3">
              <input type="email" placeholder="Email của bạn"
                class="w-full rounded-xl bg-white/10 border border-white/20 py-3 px-5 text-sm text-white placeholder:text-white/40 focus:outline-none focus:ring-1 focus:ring-yellow-400/50 transition-all" />
              <button class="w-full py-3 bg-yellow-400 hover:bg-yellow-300 text-[#2f5755] font-black rounded-xl transition-all shadow-md text-sm uppercase">
                Đăng Ký
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- Copyright -->
      <div class="w-full py-10 mt-16 border-t border-white/5 text-center">
        <p class="text-xs text-white/40 font-nunitoSans tracking-widest">
          &copy; 2026 PETTY VMCS PLATFORM. ALL RIGHTS RESERVED.
        </p>
      </div>
    </div>
  </footer>
</template>

<script setup>
import Rocket from "@/assets/svg/rocket.svg";

const socials = [
  { label: 'Facebook', link: '#' },
  { label: 'Instagram', link: '#' },
  { label: 'YouTube', link: '#' }
];

const quickLinks = [
  { text: 'Trang Chủ' }, { text: 'Dịch Vụ' }, { text: 'Giới Thiệu' }, { text: 'Chính Sách' }, { text: 'Diễn Đàn' }
];

const resources = [
  { text: 'Câu hỏi thường gặp (FAQ)' }, { text: 'Case Study' }, { text: 'Chính sách bảo mật' }, { text: 'Điều khoản dịch vụ' }
];
</script>

<style scoped>
.font-nunito { font-family: 'Nunito', sans-serif; }
.font-dmSans { font-family: 'DM Sans', sans-serif; }
.font-nunitoSans { font-family: 'Nunito Sans', sans-serif; }
</style>