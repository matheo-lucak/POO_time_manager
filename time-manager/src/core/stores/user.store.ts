import { ref, computed } from 'vue';
import { defineStore } from 'pinia';
import type {User, UserStore} from '@/core/interfaces/user.interface';
import UsersServices from "@/core/api/users.services";

export const useUserStore = defineStore('user', {

  state: (): UserStore => ({
    user: {
      username:"Eduardo",
      email: "eddy@eddy.fr",
      id: 0,
      role: ""
    },
    userServices: new UsersServices()
  }),
  getters: {
    getUser : (state) => state.user,
  },
  actions: {
    registerUser(email: string, username: string, password: string, password_confirmation: string) {
      this.userServices.registerUser(email, username, password, password_confirmation).then((response: User) => {
        this.user = response;
      }).catch((e) => e)
    },
    loginUser(email: string, password: string) {
      this.userServices.loginUser(email, password).then((response: User) => {
        this.user = response;
      }).catch((e) => e)
    },
    logoutUser() {
      localStorage.clear()
      this.user = { username:"", email:"", id:0, role: "" }
    }

  },
})
