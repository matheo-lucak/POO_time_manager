import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useCounterStore = defineStore('user', {
  state: () => ({ 
    name: 'Eduardo' 
  }),
  getters: {
    getName: (state) => state.name,
  },
  actions: {
    updateName(newName: string) {
      this.name = newName;
    },
  },
})
