import { defineStore } from 'pinia';

export const useMobileStore = defineStore('mobile', {
  state: () => ({ 
    isMobile: false 
  }),
  getters: {
    getMobile: (state) => state.isMobile,
  },
  actions: {
    updateIsMobile(newStatus: boolean) {
      this.isMobile = newStatus;
    },
  },
})
