import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    name: 'Eduardo',
    userID: 1,
  }),
  getters: {
    getName: (state) => state.name,
    getUserID: (state) => state.userID,
  },
  actions: {
    updateName(newName: string) {
      this.name = newName;
    },
  },
})
