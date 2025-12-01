<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <!-- Upload Mode Modal -->
    <div 
      v-if="mode === 'upload'" 
      class="bg-white rounded-[10px] shadow-[0px_20px_25px_-5px_rgba(0,0,0,0.1),0px_8px_10px_-6px_rgba(0,0,0,0.1)] p-6 w-[768px] max-h-[90vh] overflow-y-auto"
    >
      <!-- Header -->
      <div class="flex flex-col gap-0 mb-4">
        <div class="flex items-center gap-2 mb-1">
          <svg class="w-5 h-5" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M3 8L10 3L17 8V17C17 17.5304 16.7893 18.0391 16.4142 18.4142C16.0391 18.7893 15.5304 19 15 19H5C4.46957 19 3.96086 18.7893 3.58579 18.4142C3.21071 18.0391 3 17.5304 3 17V8Z" stroke="#101828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M7 19V10H13V19" stroke="#101828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <h2 class="text-[18px] font-normal text-[#101828] leading-[28px] tracking-[-0.4395px]">
            Kết quả Siêu âm - {{ patientName }}
          </h2>
        </div>
        <p class="text-[14px] text-[#4a5565] leading-[20px] tracking-[-0.1504px]">
          Hồ sơ: {{ recordId }}
        </p>
      </div>

      <!-- Upload Section -->
      <div class="mb-6">
        <div class="flex items-start gap-1 mb-2">
          <label class="text-[14px] font-medium text-[#101828] leading-[14px] tracking-[-0.1504px]">
            Ảnh/File đính kèm
          </label>
          <span class="text-[14px] font-medium text-[#fb2c36] leading-[14px] tracking-[-0.1504px]">*</span>
        </div>

        <!-- Drop Zone -->
        <div 
          class="relative bg-gray-50 border-2 border-[#d1d5dc] border-dashed rounded-[10px] h-[232px] flex flex-col items-center justify-center mb-4 cursor-pointer hover:bg-gray-100 transition-colors"
          @click="triggerFileInput"
          @dragover.prevent="isDragging = true"
          @dragleave.prevent="isDragging = false"
          @drop.prevent="handleDrop"
        >
          <svg class="w-12 h-12 mb-4 text-gray-400" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M24 34V14M24 14L14 24M24 14L34 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M42 34V38C42 39.0609 41.5786 40.0783 40.8284 40.8284C40.0783 41.5786 39.0609 42 38 42H10C8.93913 42 7.92172 41.5786 7.17157 40.8284C6.42143 40.0783 6 39.0609 6 38V34" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <p class="text-[16px] text-[#364153] text-center leading-[24px] tracking-[-0.3125px] mb-1">
            Kéo thả ảnh vào đây hoặc click để chọn
          </p>
          <p class="text-[14px] text-[#6a7282] text-center leading-[20px] tracking-[-0.1504px] mb-3">
            Hỗ trợ: JPG, PNG, PDF (Tối đa 10MB)
          </p>
          <button 
            class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[8px] px-3 py-2 flex items-center gap-2 hover:bg-gray-50 transition-colors"
            type="button"
            @click.stop="triggerFileInput"
          >
            <svg class="w-4 h-4" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M14 10V12.6667C14 13.0203 13.8595 13.3594 13.6095 13.6095C13.3594 13.8595 13.0203 14 12.6667 14H3.33333C2.97971 14 2.64057 13.8595 2.39052 13.6095C2.14048 13.3594 2 13.0203 2 12.6667V10M11.3333 5.33333L8 2M8 2L4.66667 5.33333M8 2V10" stroke="#101828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <span class="text-[14px] font-medium text-[#101828] leading-[20px] tracking-[-0.1504px]">
              Chọn file
            </span>
          </button>
          <input 
            ref="fileInput"
            type="file" 
            class="hidden" 
            multiple
            accept="image/jpeg,image/png,application/pdf"
            @change="handleFileSelect"
          >
        </div>

        <!-- Preview Images -->
        <div v-if="uploadedFiles.length > 0" class="grid grid-cols-3 gap-4">
          <div 
            v-for="(file, index) in uploadedFiles" 
            :key="index"
            class="relative border border-gray-200 rounded-[10px] aspect-square overflow-hidden group"
          >
            <img 
              v-if="file.preview"
              :src="file.preview" 
              :alt="file.name"
              class="w-full h-full object-cover"
            >
            <div 
              v-else
              class="w-full h-full bg-gray-100 flex items-center justify-center"
            >
              <svg class="w-16 h-16 text-gray-400" viewBox="0 0 88 88" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M44 88C68.3005 88 88 68.3005 88 44C88 19.6995 68.3005 0 44 0C19.6995 0 0 19.6995 0 44C0 68.3005 19.6995 88 44 88Z" fill="#E5E7EB"/>
              </svg>
            </div>
            <button
              class="absolute top-2 right-2 w-6 h-6 bg-[#fb2c36] rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity"
              @click="removeFile(index)"
            >
              <svg class="w-4 h-4" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 4L4 12M4 4L12 12" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </button>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="flex items-center justify-end gap-2">
        <button
          class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[8px] px-[17px] py-[9px] text-[14px] font-medium text-[#101828] leading-[20px] tracking-[-0.1504px] hover:bg-gray-50 transition-colors"
          @click="$emit('close')"
        >
          Hủy
        </button>
        <button
          class="bg-[#155dfc] rounded-[8px] px-[17px] py-[9px] flex items-center gap-2 text-[14px] font-medium text-white leading-[20px] tracking-[-0.1504px] hover:bg-[#1350e0] transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          :disabled="uploadedFiles.length === 0"
          @click="handleSave"
        >
          <svg class="w-4 h-4" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M13.3333 7.38667V12.6667C13.3333 13.0203 13.193 13.3594 12.9429 13.6095C12.6929 13.8595 12.3537 14 12 14H4C3.64638 14 3.30724 13.8595 3.05719 13.6095C2.80714 13.3594 2.66667 13.0203 2.66667 12.6667V4C2.66667 3.64638 2.80714 3.30724 3.05719 3.05719C3.30724 2.80714 3.64638 2.66667 4 2.66667H9.28M13.3333 7.38667L14.6667 6.05333M13.3333 7.38667L8.66667 12.0533C8.44836 12.2716 8.1582 12.3938 7.85533 12.3933L5.66667 12.38L5.68 10.1913C5.68055 9.88847 5.80272 9.59831 6.021 9.38L10.6877 4.71333M13.3333 7.38667L10.6877 4.71333M10.6877 4.71333L12.0213 3.38C12.2714 3.12991 12.6105 2.98944 12.9641 2.98944C13.3177 2.98944 13.6569 3.12991 13.907 3.38L14.6663 4.13933C14.9164 4.38942 15.0569 4.72858 15.0569 5.08217C15.0569 5.43575 14.9164 5.77491 14.6663 6.025L13.333 7.35867L10.6877 4.71333Z" stroke="white" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          Lưu & Hoàn tất
        </button>
      </div>
    </div>

    <!-- View Mode Modal -->
    <div 
      v-else
      class="bg-white rounded-[10px] shadow-[0px_20px_25px_-5px_rgba(0,0,0,0.1),0px_8px_10px_-6px_rgba(0,0,0,0.1)] p-6 w-[768px] max-h-[90vh] overflow-y-auto"
    >
      <!-- Header -->
      <div class="flex flex-col gap-0 mb-4">
        <div class="flex items-center gap-2 mb-1">
          <svg class="w-5 h-5" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M1 12C1 12 4 5 10 5C16 5 19 12 19 12C19 12 16 19 10 19C4 19 1 12 1 12Z" stroke="#101828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M10 14C11.6569 14 13 12.6569 13 11C13 9.34315 11.6569 8 10 8C8.34315 8 7 9.34315 7 11C7 12.6569 8.34315 14 10 14Z" stroke="#101828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
          <h2 class="text-[18px] font-normal text-[#101828] leading-[28px] tracking-[-0.4395px]">
            Kết quả Siêu âm - {{ patientName }}
          </h2>
        </div>
        <p class="text-[14px] text-[#4a5565] leading-[20px] tracking-[-0.1504px]">
          Hồ sơ: {{ recordId }}
        </p>
      </div>

      <!-- View Section -->
      <div class="mb-6">
        <label class="text-[14px] font-medium text-[#101828] leading-[14px] tracking-[-0.1504px] block mb-4">
          Ảnh/File đính kèm
        </label>

        <!-- Image Grid -->
        <div class="grid grid-cols-3 gap-4 mb-6">
          <div 
            v-for="(image, index) in resultData.images" 
            :key="index"
            class="relative border border-gray-200 rounded-[10px] aspect-square overflow-hidden group cursor-pointer"
            @click="previewImage(index)"
          >
            <img 
              v-if="image.url"
              :src="image.url" 
              :alt="`Ultrasound ${index + 1}`"
              class="w-full h-full object-cover"
            >
            <div 
              v-else
              class="w-full h-full bg-gray-100 flex items-center justify-center"
            >
              <svg class="w-16 h-16 text-gray-400" viewBox="0 0 88 88" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M44 88C68.3005 88 88 68.3005 88 44C88 19.6995 68.3005 0 44 0C19.6995 0 0 19.6995 0 44C0 68.3005 19.6995 88 44 88Z" fill="#E5E7EB"/>
              </svg>
            </div>
            <div 
              class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-50 transition-opacity flex items-center justify-center opacity-0 group-hover:opacity-100"
            >
              <svg class="w-8 h-8" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M1.33334 16C1.33334 16 6.66667 5.33333 16 5.33333C25.3333 5.33333 30.6667 16 30.6667 16C30.6667 16 25.3333 26.6667 16 26.6667C6.66667 26.6667 1.33334 16 1.33334 16Z" stroke="white" stroke-width="2.66667" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M16 20C18.2091 20 20 18.2091 20 16C20 13.7909 18.2091 12 16 12C13.7909 12 12 13.7909 12 16C12 18.2091 13.7909 20 16 20Z" stroke="white" stroke-width="2.66667" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </div>
          </div>
        </div>

        <!-- Info Card -->
        <div class="bg-blue-50 border border-blue-100 rounded-[10px] p-[17px]">
          <div class="grid grid-cols-3 gap-4">
            <div class="flex flex-col items-center">
              <p class="text-[14px] text-[#4a5565] leading-[20px] tracking-[-0.1504px] mb-1">
                Số ảnh
              </p>
              <p class="text-[16px] text-[#101828] leading-[24px] tracking-[-0.3125px]">
                {{ resultData.imageCount }}
              </p>
            </div>
            <div class="flex flex-col items-center">
              <p class="text-[14px] text-[#4a5565] leading-[20px] tracking-[-0.1504px] mb-1">
                Thực hiện bởi
              </p>
              <p class="text-[16px] text-[#101828] leading-[24px] tracking-[-0.3125px]">
                {{ resultData.performedBy }}
              </p>
            </div>
            <div class="flex flex-col items-center">
              <p class="text-[14px] text-[#4a5565] leading-[20px] tracking-[-0.1504px] mb-1">
                Thời gian
              </p>
              <p class="text-[16px] text-[#101828] leading-[24px] tracking-[-0.3125px]">
                {{ resultData.time }}
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="flex justify-end">
        <button
          class="bg-white border border-[rgba(0,0,0,0.1)] rounded-[8px] px-[17px] py-[9px] text-[14px] font-medium text-[#101828] leading-[20px] tracking-[-0.1504px] hover:bg-gray-50 transition-colors"
          @click="$emit('close')"
        >
          Đóng
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'KetQuaSieuAm',
  props: {
    mode: {
      type: String,
      default: 'upload', // 'upload' or 'view'
      validator: (value) => ['upload', 'view'].includes(value)
    },
    patientName: {
      type: String,
      default: 'Milo'
    },
    recordId: {
      type: String,
      default: 'HSBA-001'
    },
    // For view mode
    resultData: {
      type: Object,
      default: () => ({
        images: [
          {
            url: 'https://www.figma.com/api/mcp/asset/f6410787-2d39-4a52-a8c6-1e433253e05b',
            name: 'Ultrasound 1'
          },
          {
            url: null,
            name: 'Ultrasound 2'
          }
        ],
        imageCount: 2,
        performedBy: 'BS. Nguyễn B',
        time: '10:30 hôm nay'
      })
    }
  },
  data() {
    return {
      uploadedFiles: [],
      isDragging: false
    };
  },
  methods: {
    triggerFileInput() {
      this.$refs.fileInput.click();
    },
    handleFileSelect(event) {
      const files = Array.from(event.target.files);
      this.processFiles(files);
    },
    handleDrop(event) {
      this.isDragging = false;
      const files = Array.from(event.dataTransfer.files);
      this.processFiles(files);
    },
    processFiles(files) {
      const validFiles = files.filter(file => {
        const isValidType = ['image/jpeg', 'image/png', 'application/pdf'].includes(file.type);
        const isValidSize = file.size <= 10 * 1024 * 1024; // 10MB
        
        if (!isValidType) {
          console.warn(`File ${file.name} không đúng định dạng`);
          return false;
        }
        if (!isValidSize) {
          console.warn(`File ${file.name} vượt quá 10MB`);
          return false;
        }
        return true;
      });

      validFiles.forEach(file => {
        const fileData = {
          file: file,
          name: file.name,
          preview: null
        };

        // Create preview for images only
        if (file.type.startsWith('image/')) {
          const reader = new FileReader();
          reader.onload = (e) => {
            fileData.preview = e.target.result;
          };
          reader.readAsDataURL(file);
        }

        this.uploadedFiles.push(fileData);
      });

      // Reset input
      if (this.$refs.fileInput) {
        this.$refs.fileInput.value = '';
      }
    },
    removeFile(index) {
      this.uploadedFiles.splice(index, 1);
    },
    handleSave() {
      if (this.uploadedFiles.length === 0) {
        return;
      }

      // TODO: Upload files to server
      console.log('Uploading files:', this.uploadedFiles);

      // Emit save event with file data
      this.$emit('save', {
        files: this.uploadedFiles,
        patientName: this.patientName,
        recordId: this.recordId
      });

      // Close modal
      this.$emit('close');
    },
    previewImage(index) {
      // TODO: Open image in fullscreen preview
      console.log('Preview image:', index, this.resultData.images[index]);
      
      // Emit preview event
      this.$emit('preview', {
        index: index,
        image: this.resultData.images[index]
      });
    }
  }
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;500;600;700&display=swap');

* {
  font-family: 'Nunito Sans', sans-serif;
}
</style>
