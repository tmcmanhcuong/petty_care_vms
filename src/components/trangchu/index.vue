<template>
  <section class="flex gap-16 items-center justify-center px-[120px] py-[100px] w-full">
    <div class="flex flex-col gap-[22px] items-start w-[480px] shrink-0">
      <div class="inline-grid relative shrink-0">
        <h1 class="font-extrabold text-[64px] text-[#432323] leading-[72px] tracking-[0px] text-left">
          Đặt lịch dễ<br>Chăm sóc mê!
        </h1>
        <p class="font-medium text-[#393e46] w-[480px] text-left mt-6">
          <span class="text-[18px] leading-[24px]">Cùng bạn chăm sóc thú cưng tốt hơn – khám phá, đặt lịch và đồng hành cùng bác sĩ tại </span>
          <span class="font-black text-[#2f5755] text-[20px] leading-[24px]">Petty </span>
          <span class="text-[18px] leading-[24px]"> </span>
          <span class="font-medium text-[18px] leading-[24px]">nhé</span>
        </p>
      </div>

      <div class="flex gap-4 items-center">
        <a href="#" class="bg-[#5a9690] flex items-center justify-center px-6 py-3 rounded-2xl shadow-[0px_1px_2px_0px_rgba(0,0,0,0.1)] hover:shadow-lg transition-all">
          <span class="font-semibold text-[#eeeeee] text-[18px] leading-[20px] tracking-[0.4px]">
            Đặt Lịch Ngay
          </span>
        </a>
        <a href="#" class="border-2 border-[#5a9690] flex items-center justify-center px-6 py-3 rounded-2xl hover:bg-[#5a9690] transition-all group">
          <span class="font-semibold text-[#222831] group-hover:text-white text-[18px] leading-[20px] tracking-[0.4px]">
            Xem Dịch Vụ
          </span>
        </a>
      </div>

      <div class="inline-grid relative shrink-0">
        <div class="flex gap-3 items-center">
          <div class="flex items-center h-[39px] pr-[9.75px]">
            <div class="relative group/avatar mr-[-9.75px]">
              <div class="absolute inset-0 bg-[#5a9690] rounded-full blur-md opacity-0 group-hover/avatar:opacity-50 transition-opacity duration-300"></div>
              <img :src="avatarImages[0]" alt="Customer" class="relative w-[39px] h-[39px] rounded-full object-cover border-2 border-white aspect-square group-hover/avatar:scale-110 transition-transform duration-300">
            </div>
            <div class="relative group/avatar mr-[-9.75px]">
              <div class="absolute inset-0 bg-[#5a9690] rounded-full blur-md opacity-0 group-hover/avatar:opacity-50 transition-opacity duration-300"></div>
              <img :src="avatarImages[1]" alt="Customer" class="relative w-[39px] h-[39px] rounded-full object-cover border-2 border-white aspect-square group-hover/avatar:scale-110 transition-transform duration-300">
            </div>
            <div class="relative group/avatar mr-[-9.75px]">
              <div class="absolute inset-0 bg-[#5a9690] rounded-full blur-md opacity-0 group-hover/avatar:opacity-50 transition-opacity duration-300"></div>
              <img :src="avatarImages[2]" alt="Customer" class="relative w-[39px] h-[39px] rounded-full object-cover border-2 border-white aspect-square group-hover/avatar:scale-110 transition-transform duration-300">
            </div>
            <div class="relative group/avatar">
              <div class="absolute inset-0 bg-[#5a9690] rounded-full blur-md opacity-0 group-hover/avatar:opacity-50 transition-opacity duration-300"></div>
              <img :src="avatarImages[3]" alt="Customer" class="relative w-[39px] h-[39px] rounded-full object-cover border-2 border-white aspect-square group-hover/avatar:scale-110 transition-transform duration-300">
            </div>
          </div>
          <div class="leading-tight text-left ml-2 mt-2">
            <p class="font-medium text-[14px] leading-[18px] text-[#222831]">
              <span class="font-semibold">Chúng tôi có </span>
              <span class="font-extrabold text-[#5a9690]">10k+</span>
            </p>
            <p class="font-black text-[14px] leading-[18px] text-[#432323]">
              Khách Hàng tại Việt Nam
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="h-[480px] w-[700px] rounded-[28.77px] relative shrink-0 overflow-hidden shadow-2xl group">
      <img :src="heroImage" alt="PETTY VCMS Hero" class="absolute inset-0 w-full h-[150%] top-[-5.86%] object-cover transition-transform duration-700 group-hover:scale-110">
    </div>
  </section>

  <section id="services" class="bg-[#5a9690] py-16 full-width-section">
    <div class="flex flex-col gap-[60px] items-center mx-auto">
      <!-- Trust By -->
      <div class="flex flex-col gap-6 items-center w-full">
        <p class="text-2xl font-semibold text-white text-center">
          Được tin chọn bởi 1k+ khách hàng và đối tác thú y
        </p>
        <div class="flex gap-12 items-center justify-center w-full px-1">
          <div v-for="item in trustItems" :key="item.label"
            class="flex gap-3 items-center group hover:scale-110 transition-transform">
            <img :src="item.svg" alt="" class="w-[41px] h-[41px] object-contain ">
            <span class="text-4xl font-extrabold text-white whitespace-nowrap">{{ item.label }}</span>
          </div>
        </div>
      </div>

      <!-- Services Header -->
      <div class="flex flex-col gap-[38px] items-center w-full max-w-[544px]">
        <div class="inline-flex items-center gap-4 px-[6px] py-[6px] border-2 border-white rounded-full">
          <div class="w-[34px] h-[34px] bg-white rounded-full relative shadow-lg">
            <div class="w-32 h-32 flex items-center justify-center">
              <SunIcon class="w-full h-full text-[#2f5755]" />
            </div>
          </div>
          <span class="text-2xl font-bold text-white pr-2">Dịch Vụ</span>
        </div>
        <div class="flex flex-col gap-5 items-center text-center w-full">
          <h2 class="text-7xl font-semibold text-white leading-[60px]"> 
            <span>Dịch Vụ </span>
            <span class="italic">Chính</span>
          </h2>
          <p class="text-lg font-medium text-white leading-8">
            Chúng tôi cung cấp các dịch vụ thú y toàn diện, giúp thú cưng của bạn được chăm sóc tận tâm, an toàn và hiệu quả nhất
          </p>
        </div>
      </div>

      <!-- Service Cards -->
      <div class="flex gap-6 items-center justify-center w-full">
        <!-- Card 1 - Tiêm phòng Vaccine -->
        <div class="relative w-[448px] h-[288px] cursor-pointer group hover:shadow-2xl transition-all duration-300 rounded-2xl overflow-hidden">
          <img src="/src/assets/img_imports/public_img/hp-pic7.png" 
            alt="" class="absolute inset-0 w-full h-full object-cover">
          <div class="absolute inset-0 bg-gradient-to-r from-black/40 via-black/20 to-transparent"></div>
          
          <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 bg-[#EEE] backdrop-blur-sm rounded-xl px-6 py-3 w-[380px] shadow-lg" >
            <div class="flex gap-2 items-start">
              <div class="w-9 h-9 bg-[#432323] rounded-md flex items-center justify-center shrink-0 mr-4">
                <VaccineIcon class="text-[#EEEEEE]" />
              </div>
              <div class="flex flex-col gap-2 ">
                <h3 class="text-base font-extrabold text-[#432323] leading-tight">Tiêm phòng Vaccine</h3>
                <p class="text-xs font-medium text-[#393e46] leading-relaxed">
                  Kiểm tra sức khỏe toàn diện và tiêm phòng định kỳ để thú cưng luôn khỏe mạnh, an toàn
                </p>
              </div>
            </div>
          </div>
        </div>

        <!-- Card 2 - Phẫu thuật triệt sản -->
        <div class="relative w-[448px] h-[288px] cursor-pointer group hover:shadow-2xl transition-all duration-300 rounded-2xl overflow-hidden">
          <img src="/src/assets/img_imports/public_img/hp-pic2.png" 
            alt="" class="absolute inset-0 w-full h-full object-cover">
          <div class="absolute inset-0 bg-gradient-to-r from-black/40 via-black/20 to-transparent"></div>
          
          <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 bg-[#EEE] backdrop-blur-sm rounded-xl px-6 py-3 w-[380px] shadow-lg" >
            <div class="flex gap-2 items-start">
              <div class="w-9 h-9 bg-[#432323] rounded-md flex items-center justify-center shrink-0 mr-4">
                <VaccineIcon class="text-[#EEEEEE]" />
              </div>
              <div class="flex flex-col gap-2 ">
                <h3 class="text-base font-extrabold text-[#432323] leading-tight">Phẫu thuật triệt sản</h3>
                <p class="text-xs font-medium text-[#393e46] leading-relaxed">
                  Quy trình triệt sản an toàn, giúp thú cưng khỏe mạnh và sống vui hơn
                </p>
              </div>
            </div>
          </div>
        </div>

        <!-- Card 3 - Điều trị nội trú -->
        <div class="relative w-[448px] h-[288px] cursor-pointer group hover:shadow-2xl transition-all duration-300 rounded-2xl overflow-hidden">
          <img src="/src/assets/img_imports/public_img/hp-pic3.png" 
            alt="" class="absolute inset-0 w-full h-full object-cover">
          <div class="absolute inset-0 bg-gradient-to-r from-black/40 via-black/20 to-transparent"></div>
          
         <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 bg-[#EEE] backdrop-blur-sm rounded-xl px-6 py-3 w-[380px] shadow-lg" >
            <div class="flex gap-2 items-start">
              <div class="w-9 h-9 bg-[#432323] rounded-md flex items-center justify-center shrink-0 mr-4">
                <VaccineIcon class="text-[#EEEEEE]" />
              </div>
              <div class="flex flex-col gap-2 ">
                <h3 class="text-base font-extrabold text-[#432323] leading-tight">Điều trị nội trú</h3>
                <p class="text-xs font-medium text-[#393e46] leading-relaxed">
                  Chăm sóc toàn diện cho thú cưng trong môi trường an toàn và tiện nghi
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Khám phá -->
      <div class="inline-flex items-center gap-3 px-2 py-2 bg-white border-2 border-white rounded-full shadow-lg hover:shadow-xl hover:scale-105 transition-all cursor-pointer">
        <div class="w-[34px] h-[34px] bg-[#2f5755] rounded-full flex items-center justify-center shadow-md hover:bg-[#3a6b68] transition-colors">
          <svg class="w-5 h-5 text-white" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M5 12h14M12 5l7 7-7 7" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
        </div>
        <span class="text-2xl font-bold text-[#2f5755] pr-3">Khám phá thêm</span>
      </div>

      <!-- About Content -->
      <div class="flex items-center justify-center w-full mt-[44px]">
        <div class="w-[640px] h-[414px] rounded-[24px] overflow-hidden shadow-2xl -mr-24 z-10 relative">
          <img src="/src/assets/img_imports/public_img/hp-pic4.png"
            alt="About PETTY" class="w-full h-full object-cover">
        </div>
        <div class="bg-[#eeeeee] px-[33px] py-6 rounded-2xl shadow-xl w-[576px] h-auto -ml-24 z-20 flex flex-col gap-[10px] justify-center">
          <div class="flex flex-col gap-8 w-[384px]">
            <div class="inline-flex items-center gap-2 px-[10px] py-[6px] border-2 border-[#5a9690] rounded-full bg-[#eeeeee] w-fit">
              <div class="w-[34px] h-[34px] bg-[#2f5755] rounded-full flex items-center justify-center shadow-lg">
                <BriefcaseIcon class="w-6 h-6 text-white" />
              </div>
              <span class="text-base font-bold text-[#2f5755]">Về chúng tôi</span>
            </div>
            <div class="flex flex-col gap-1">
              <h2 class="text-4xl font-bold text-[#432323] leading-4 ">Sứ mệnh cốt lõi</h2>
              <p class="text-base font-semibold text-[#222831] leading-4 mt-4">Vì sức khỏe và hạnh phúc của từng thú cưng</p>
              <p class="text-sm font-light text-[#393e46] leading-4 ">
                Chúng tôi xây dựng hệ thống phòng khám thú y hiện đại – nơi công nghệ và chuyên môn kết hợp để mang đến quy trình chăm sóc, theo dõi và quản lý sức khỏe thú cưng toàn diện, minh bạch và tận tâm.
              </p>
            </div>
            <div class="inline-flex items-center gap-1 px-[10px] py-1 border-2 border-[#5a9690] rounded-full bg-[#2f5755] hover:bg-[#3a6b68] transition-all cursor-pointer w-fit">
              <div class="w-[34px] h-[34px] bg-[#5a9690] rounded-full flex items-center justify-center shadow-lg hover:bg-[#6ab0a8] transition-colors">
                <svg class="w-5 h-5 text-white" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M5 12h14M12 5l7 7-7 7" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
              </div>
              <span class="text-xs font-bold text-white pr-3">Biết Thêm</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Thống kê -->
      <div class="flex gap-20 justify-center items-center w-full">
        <div class="flex gap-9 items-center">
          <div class="flex flex-col gap-6 w-[184px]">
            <p class="text-5xl font-black text-[#eeeeee] leading-[48px]">30+</p>
            <div class="flex flex-col gap-0">
              <p class="text-xl font-bold text-[#e0d9d9] leading-5">Phòng khám đối tác</p>
              <p class="text-sm font-normal text-white leading-4">Kết nối trong hệ thống VCMS trên toàn quốc</p>
            </div>
          </div>
          <div class="w-px h-[152px] bg-white"></div>
        </div>
        <div class="flex gap-9 items-center">
          <div class="flex flex-col gap-6 w-[184px]">
            <p class="text-5xl font-black text-[#eeeeee] leading-[48px]">100+</p>
            <div class="flex flex-col gap-0">
              <p class="text-xl font-bold text-[#e0d9d9] leading-5">Bác sĩ & chuyên viên</p>
              <p class="text-sm font-normal text-white leading-4">Đồng hành mang đến giải pháp thú y chuẩn y khoa</p>
            </div>
          </div>
          <div class="w-px h-[152px] bg-white"></div>
        </div>
        <div class="flex gap-9 items-center">
          <div class="flex flex-col gap-6 w-[184px]">
            <p class="text-5xl font-black text-[#eeeeee] leading-[48px]">4.9★</p>
            <div class="flex flex-col gap-0">
              <p class="text-xl font-bold text-[#e0d9d9] leading-5">Mức độ hài lòng</p>
              <p class="text-sm font-normal text-white leading-4">Hàng nghìn chủ nuôi tin tưởng và quay lại</p>
            </div>
          </div>
          <div class="w-px h-[152px] bg-white"></div>
        </div>
        <div class="flex flex-col gap-6 w-[228px]">
          <p class="text-5xl font-black text-[#eeeeee] leading-[48px]">10.000+</p>
          <div class="flex flex-col gap-0">
            <p class="text-xl font-bold text-[#e0d9d9] leading-5">Thú cưng được chăm sóc</p>
            <p class="text-sm font-normal text-white leading-4">Mỗi ca khám là một hành trình tận tâm</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="bg-[#eeeeee] py-24 px-6 md:px-16 lg:px-32">
    <div class="text-center mb-16">
      <div class="inline-flex items-center gap-2 px-4 py-2 border-2 border-[#5a9690] rounded-full mb-10">
        <div class="w-9 h-9 bg-[#2f5755] rounded-full flex items-center justify-center shadow-lg">
          <img class="ml-3 w-30" src="/src/assets/img_import/1 (5).png" alt="">

        </div>
        <span class="text-2xl font-bold text-[#2f5755]">Chọn chúng tôi ?</span>
      </div>
      <h2 class="text-6xl md:text-7xl font-semibold text-[#5a9690] mb-6">
        Nên là <span class="font-black">Petty</span>
      </h2>
      <p class="text-base md:text-lg text-[#393e46] max-w-2xl mx-auto">
        Không chỉ là phòng khám, chúng tôi là người bạn đồng hành tận tâm – mang đến dịch vụ thú y chuẩn y khoa, trải
        nghiệm tiện lợi và sự an tâm tuyệt đối cho chủ nuôi
      </p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-12 lg:gap-16">
      <div
        class="bg-[#5a9690] p-6 rounded-2xl shadow-lg flex flex-col gap-16 min-h-56 transition-all hover:-translate-y-2 hover:shadow-xl">
        <div class="w-10 h-10 bg-white rounded flex items-center justify-center">
          <img src="/src/assets/img_import/goal.png" alt="" class="w-6 h-6">
        </div>
        <div>
          <h3 class="text-xl font-black text-white mb-2">Chuyên môn vững vàng</h3>
          <p class="text-sm text-white">Đội ngũ bác sĩ thú y giàu kinh nghiệm, tận tâm trong từng ca khám và điều trị
          </p>
        </div>
      </div>

      <div class="row-span-2 rounded-2xl overflow-hidden shadow-xl">
        <img src="/src/assets/img_import/001.png" alt="PETTY Services" class="w-full h-full object-cover">
      </div>

      <div
        class="bg-[#5a9690] p-6 rounded-2xl shadow-lg flex flex-col gap-16 min-h-56 transition-all hover:-translate-y-2 hover:shadow-xl">
        <div class="w-10 h-10 bg-white rounded flex items-center justify-center">
          <img src="/src/assets/img_import/certificate-2.png" alt="" class="w-6 h-6">
        </div>
        <div>
          <h3 class="text-xl font-black text-white mb-2">Quy trình minh bạch</h3>
          <p class="text-sm text-white">Từ chẩn đoán đến theo dõi, mọi bước đều được cập nhật rõ ràng trên hệ thống VCMS
          </p>
        </div>
      </div>

      <div
        class="bg-[#5a9690] p-6 rounded-2xl shadow-lg flex flex-col gap-16 min-h-56 transition-all hover:-translate-y-2 hover:shadow-xl">
        <div class="w-10 h-10 bg-white rounded flex items-center justify-center">
          <img src="/src/assets/img_import/hand-heart.png" alt="" class="w-6 h-6">
        </div>
        <div>
          <h3 class="text-xl font-black text-white mb-2">Chăm sóc kịp thời</h3>
          <p class="text-sm text-white">Đặt lịch, nhắc hẹn và theo dõi sức khỏe thú cưng dễ dàng, mọi lúc mọi nơi</p>
        </div>
      </div>

      <div
        class="bg-[#5a9690] p-6 rounded-2xl shadow-lg flex flex-col gap-16 min-h-56 transition-all hover:-translate-y-2 hover:shadow-xl">
        <div class="w-10 h-10 bg-white rounded flex items-center justify-center">
          <img src="/src/assets/img_import/dog.png" alt="" class="w-6 h-6">
        </div>
        <div>
          <h3 class="text-xl font-black text-white mb-2">Tận tâm với thú cưng</h3>
          <p class="text-sm text-white">Chúng tôi coi mỗi thú cưng như một người bạn – được yêu thương và chăm sóc chu
            đáo</p>
        </div>
      </div>
    </div>
  </section>

  <section class="bg-[#5a9690] py-24 px-6 md:px-16 lg:px-32">
    <div class="max-w-6xl mx-auto text-center space-y-16">
      <div class="space-y-8">
        <div
          class="inline-flex items-center gap-3 px-4 py-2 border-2 border-white rounded-full bg-white/10 backdrop-blur-sm">
          <div class="w-10 h-10 bg-white rounded-full flex items-center justify-center shadow-md">
            <svg class="w-6 h-6 text-[#5a9690]" viewBox="0 0 24 24" fill="currentColor">
              <path
                d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
          </div>
          <p class="text-white text-lg md:text-xl lg:text-2xl font-bold">Chuyên Nghiệp ?</p>
        </div>
        <h1 class="text-5xl md:text-6xl lg:text-7xl font-bold text-white">Chuyên Môn</h1>
        <p class="text-base md:text-lg lg:text-xl text-white/90 max-w-2xl mx-auto">
          Chúng tôi kết hợp chuyên môn thú y với công nghệ hiện đại để mang đến quy trình chăm sóc minh bạch, an toàn và
          hiệu quả cho cả phòng khám lẫn chủ nuôi
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 lg:gap-12">
        <div v-for="card in expertiseCards" :key="card.title"
          class="bg-[#eeeeee] border border-[#e0d9d9] rounded-2xl p-6 flex flex-col gap-5 h-full relative group hover:shadow-2xl hover:-translate-y-2 transition-all duration-300 cursor-pointer">
          <div class="w-8 h-8">
            <img :src="card.icon" alt="" class="w-full h-full object-contain">
          </div>
          <div class="flex-1">
            <h3 class="text-xl md:text-2xl font-bold text-[#432323] leading-tight">{{ card.title }}</h3>
            <p class="text-sm md:text-base text-[#393e46] leading-relaxed mt-2">{{ card.desc }}</p>
          </div>
          <div class="absolute top-3 right-3 w-4 h-4 opacity-0 group-hover:opacity-100 transition-opacity">
            <svg class="w-full h-full text-[#432323]" viewBox="0 0 16 16" fill="currentColor">
              <path d="M8 0l8 8-8 8-1.5-1.5L13 9H0V7h13L6.5 4.5 8 3z" />
            </svg>
          </div>
        </div>
      </div>

      <a href="#"
        class="inline-flex items-center gap-3 px-4 py-2 bg-white border-2 border-white rounded-full shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-300 group">
        <div
          class="w-10 h-10 bg-[#2f5755] rounded-full flex items-center justify-center shadow-md group-hover:bg-[#3a6b68] transition-colors">
          <svg class="w-6 h-6 text-white" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M5 12h14M12 5l7 7-7 7" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
        </div>
        <p class="text-xl md:text-2xl font-bold text-[#2f5755] pr-3">Khám phá thêm</p>
      </a>
    </div>
  </section>

  <section class="py-24 px-6 md:px-16 lg:px-32">
    <div class="max-w-7xl mx-auto space-y-24">

      <div class="space-y-16">
        <div class="text-center max-w-2xl mx-auto space-y-10">
          <div class="flex justify-center">
            <div
              class="flex items-center gap-3 px-4 py-2 border-2 border-[#5a9690] rounded-full shadow-sm hover:shadow-md transition-shadow">
              <div class="w-10 h-10 bg-[#2f5755] rounded-full flex items-center justify-center shadow-md">
                <img src="https://www.figma.com/api/mcp/asset/42f81a47-e6a0-4625-a075-57e62b7c867d" alt=""
                  class="w-8 h-8 object-contain">
              </div>
              <p class="text-[#2f5755] text-xl md:text-2xl font-medium">Phản Hồi</p>
            </div>
          </div>
          <div class="space-y-5">
            <h1 class="text-6xl md:text-7xl lg:text-8xl font-semibold text-[#5a9690]">Khách Hàng</h1>
            <p class="text-base md:text-lg text-[#393e46]">
              Những trải nghiệm thực tế từ các phòng khám và chủ nuôi tin tưởng sử dụng PETTY— niềm tin của bạn là động
              lực phát triển của chúng tôi
            </p>
          </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
          <div class="lg:col-span-5 space-y-6">
            <div
              class="bg-[#f7fee7] p-8 rounded-xl shadow-md flex flex-col items-end text-right group hover:shadow-xl hover:-translate-y-1 transition-all">
              <div class="bg-white px-3 py-1 rounded-full shadow text-xs font-bold text-[#393e46] mb-4">Phát Triển</div>
              <div class="text-8xl md:text-9xl font-bold text-[#432323]">95%</div>
              <p class="text-lg font-semibold text-[#393e46] mt-2">Mức độ hài lòng của khách hàng</p>
            </div>
            <div class="grid grid-cols-2 gap-6">
              <div
                class="bg-[#d6d3d1] p-6 rounded-xl shadow-md flex flex-col items-end text-right group hover:shadow-xl hover:-translate-y-1 transition-all">
                <div class="bg-white px-3 py-1 rounded-full shadow text-xs font-bold text-[#393e46] mb-3">Chi Nhánh
                </div>
                <div class="text-7xl font-bold text-[#222831]">30+</div>
                <p class="text-base font-semibold text-[#393e46] mt-1">Phòng khám sử dụng VCMS</p>
              </div>
              <div
                class="bg-[#d6d3d1] p-6 rounded-xl shadow-md flex flex-col items-end text-right group hover:shadow-xl hover:-translate-y-1 transition-all">
                <div class="bg-white px-3 py-1 rounded-full shadow text-xs font-bold text-[#393e46] mb-3">Người Dùng
                </div>
                <div class="text-7xl font-bold text-[#222831]">4.8</div>
                <p class="text-base font-semibold text-[#393e46] mt-1">4.8 sao đánh giá trên Google</p>
              </div>
            </div>
          </div>

          <div class="lg:col-span-7">
            <div
              class="bg-[#2f5755] p-8 md:p-10 rounded-xl shadow-md h-full flex flex-col justify-between text-white group hover:shadow-2xl hover:-translate-y-1 transition-all">
              <div class="flex justify-between items-start mb-6">
                <div class="bg-[#bef264] px-3 py-2 rounded flex items-center gap-1">
                  <img src="https://www.figma.com/api/mcp/asset/ae7dce54-9a45-42fc-9e61-917ba72fedaa" alt=""
                    class="w-3 h-3">
                  <span class="text-xl font-bold text-[#2f5755]">4.8</span>
                </div>
                <div class="bg-white px-3 py-1 rounded-full shadow">
                  <span class="text-xs font-bold text-[#393e46]">Phản Hồi</span>
                </div>
              </div>
              <p class="text-xl md:text-2xl font-semibold text-[#eeeeee] leading-relaxed flex-1">
                "Từ khi phòng khám dùng VCMS, việc đặt lịch và theo dõi sức khỏe cho bé cưng dễ hơn rất nhiều. Tôi có
                thể xem lịch tiêm, kết quả khám và ghi chú của bác sĩ ngay trên điện thoại – cực kỳ tiện và yên tâm !"
              </p>
              <div class="mt-8 space-y-6">
                <div class="flex items-center gap-4">
                  <img src="https://www.figma.com/api/mcp/asset/6be2acfb-bfdd-4f59-9098-964ee4e1b8c2" alt=""
                    class="w-14 h-14 rounded-full object-cover ring-4 ring-white/20">
                  <div>
                    <p class="font-bold text-base">Minh Anh</p>
                    <p class="text-sm text-[#eeeeee]/80">Chủ của mèo Miu Miu</p>
                  </div>
                </div>
                <div class="flex gap-4">
                  <button class="bg-[#eeeeee] p-3 rounded-xl hover:bg-white transition-colors">
                    <img src="https://www.figma.com/api/mcp/asset/c0831ccb-3de3-4fb7-a78a-93175d87042c" alt=""
                      class="w-3 h-3">
                  </button>
                  <button class="bg-[#eeeeee] p-3 rounded-xl hover:bg-white transition-colors">
                    <img src="https://www.figma.com/api/mcp/asset/c0831ccb-3de3-4fb7-a78a-93175d87042c" alt=""
                      class="w-3 h-3 rotate-180">
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="space-y-16">
        <div class="text-center max-w-3xl mx-auto space-y-10">
          <div class="flex justify-center">
            <div
              class="inline-flex items-center gap-3 px-5 py-2.5 border-2 border-[#5a9690] rounded-full shadow-sm hover:shadow-md transition-shadow">
              <div class="w-10 h-10 bg-[#2f5755] rounded-full flex items-center justify-center shadow-md">
                <img src="https://www.figma.com/api/mcp/asset/42f81a47-e6a0-4625-a075-57e62b7c867d" alt=""
                  class="w-8 h-8 object-contain">
              </div>
              <p class="text-[#2f5755] text-xl md:text-2xl font-medium">Câu Chuyện</p>
            </div>
          </div>
          <div class="space-y-5">
            <h1 class="text-6xl md:text-7xl lg:text-8xl font-semibold text-[#5a9690]">Khởi Nguồn</h1>
            <p class="text-lg md:text-xl text-[#393e46] max-w-2xl mx-auto">
              Từ công nghệ quản lý đến trải nghiệm thực tế – cùng khám phá cách PETTY giúp phòng khám thú y vận hành
              hiệu quả và mang lại sự an tâm cho chủ nuôi
            </p>
          </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 lg:gap-12">
          <div v-for="post in blogPosts" :key="post.id" class="group cursor-pointer">
            <div class="relative overflow-hidden rounded-3xl shadow-lg mb-5">
              <img :src="post.image" alt=""
                class="w-full h-64 md:h-72 object-cover group-hover:scale-105 transition-transform duration-500">
              <div
                class="absolute top-4 left-4 bg-white/90 backdrop-blur-sm px-3 py-1.5 rounded-full text-xs font-bold text-[#393e46] shadow">
                {{ post.badge }}
              </div>
            </div>
            <div class="space-y-3 text-center md:text-left">
              <p class="text-[#393e46] text-sm font-medium">{{ post.date }}</p>
              <h3 class="text-xl md:text-2xl font-bold text-[#432323] leading-tight line-clamp-2">{{ post.title }}</h3>
              <button
                class="inline-flex items-center gap-2 text-[#2f5755] font-semibold text-sm hover:gap-3 transition-all group">
                <span>Xem Thêm</span>
                <svg class="w-4 h-4 text-[#2f5755]" viewBox="0 0 16 16" fill="none" stroke="currentColor"
                  stroke-width="2">
                  <path d="M5 8h6m-3-3l3 3-3 3" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import SunIcon from '@/assets/svg/sun-medium.svg'
import VaccineIcon from '@/assets/svg/vaccine.svg'
import BriefcaseIcon from '@/assets/svg/briefcase.svg'  
const avatarImages = [
  "./src/assets/img_imports/public_img/hp-pic13.jpg",
  "./src/assets/img_imports/public_img/hp-pic14.jpg",
  "./src/assets/img_imports/public_img/hp-pic12.jpg",
  "./src/assets/img_imports/public_img/hp-pic11.jpg",
]

const heroImage = "/src/assets/img_imports/public_img/hp-pic6.png"
const trustItems = [
  { svg: '/src/assets/svg/hospital-circle.svg', label: 'Bệnh Viện' },
  { svg: '/src/assets/svg/users.svg', label: 'Khách Hàng' },
  { svg: '/src/assets/svg/brand-baidu.svg', label: 'Thương Hiệu' },
  { svg: '/src/assets/svg/stethoscope.svg', label: 'Bác Sĩ' }
]

const expertiseCards = [
  { icon: '/src/assets/img_import/Vector.png', title: 'Kinh nghiệm chuyên sâu trong ngành thú y', desc: 'Hơn 10 năm kinh nghiệm vận hành và đồng hành cùng hàng chục phòng khám trên toàn quốc' },
  { icon: '/src/assets/img_import/prong.png', title: 'Giải pháp quản lý tối ưu', desc: 'Tự động hóa quy trình khám, đặt lịch và hồ sơ bệnh án – giúp đội ngũ làm việc nhanh hơn, chính xác hơn' },
  { icon: '/src/assets/img_import/database-cog.png', title: 'Dữ liệu và phân tích chuyên sâu', desc: 'Theo dõi, đánh giá và tối ưu hiệu quả điều trị dựa trên dữ liệu thực tế.' },
  { icon: '/src/assets/img_import/user-up.png', title: 'Lấy khách hàng làm trung tâm', desc: 'Lắng nghe nhu cầu, tối ưu trải nghiệm – vì mỗi thú cưng đều xứng đáng được chăm sóc tốt nhất' },
  { icon: '/src/assets/img_import/brand-apple-news.png', title: 'Đổi mới và phát triển liên tục', desc: 'Ứng dụng công nghệ mới, cập nhật quy trình khám và điều trị chuẩn quốc tế' },
  { icon: '/src/assets/img_import/plug-connected.png', title: 'Kết nối toàn diện – từ phòng khám đến chủ nuôi', desc: 'Tạo nên hệ sinh thái thú y hiện đại, giúp mọi bên cùng đồng hành vì sức khỏe thú cưng' }
]

const blogPosts = [
  { id: 1, image: '/src/assets/img_import/002 (1).png', badge: 'Tối ưu vận hành phòng khám với hệ thống VCMS', date: 'Ngày: 25/09/2025', title: 'Tối ưu vận hành phòng khám với hệ thống VCMS' },
  { id: 2, image: '/src/assets/img_import/002 (2).png', badge: 'Chuyển đổi số trong chăm sóc thú y', date: 'Ngày: 10/09/2025', title: 'Chuyển đổi số trong chăm sóc thú y: Hành trình từ giấy tờ đến nền tảng số' },
  { id: 3, image: 'https://images.unsplash.com/photo-1581093450021-4a7360e9a6b5?w=800&h=600&fit=crop', badge: 'Xây dựng niềm tin với chủ nuôi', date: 'Ngày: 02/09/2025', title: 'Xây dựng niềm tin với chủ nuôi qua trải nghiệm kỹ thuật số' }
]
</script>

<style scoped>
@keyframes float {

  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-20px);
  }
}

.animate-float {
  animation: float 6s ease-in-out infinite;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* Ghi đè full-width lên các parent cha */
.full-width-section {
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
  width: 100vw;
  max-width: 100vw;
}

body {
  margin: 0;
  padding: 0;
}
</style>