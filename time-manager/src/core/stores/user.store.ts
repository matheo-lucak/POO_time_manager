import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
import type {User, UserStore} from '@/core/interfaces/user.interface'
import UsersServices from "@/core/api/users.services";

export const useUserStore = defineStore('user', {
  state: (): UserStore => ({
    user: {
      username:"Eduardo",
      email: "eddy@eddy.fr",
      userID: 0,
      role: ""
    },
    userServices: new UsersServices()
  }),
  getters: {
    getUser(state) {
      return this.user;
    }
  },
  actions: {
    registerUser(email: string, username: string, password: string) {
      this.userServices.registerUser(email, username, password).then((response: User) => {
        this.user = response;
      }).catch((e) => {
        console.log(e);
      })
    },
    loginUser(email: string, password: string) {
      this.userServices.loginUser(email, password).then((response: User) => {
        this.user = response;
      }).catch((e) => {
        console.log(e);
      })
    },

  },
})
