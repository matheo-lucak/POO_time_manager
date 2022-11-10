import { ref, computed } from 'vue';
import { defineStore } from 'pinia';
import type {User, UserStore} from '@/core/interfaces/user.interface';
import UsersServices from "@/core/api/users.services";
import jwt_decode from "jwt-decode";
import router from '@/router';

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
      }).catch((e) => e);
    },
    loginUser(email: string, password: string) {
      return this.userServices.loginUser(email, password);
    },
    logoutUser() {
      localStorage.clear()
      this.user = { username:"", email:"", id:0, role: "" }
      router.push('/login');
    },
    updateUser(email: string, username: string) {
      this.userServices.putUser(this.user.id, email, username).then((response: User) => {
        this.user = response;
      }).catch((e) => e);
    },
    deleteUser() {
      this.userServices.deleteUser(this.user.id).then((response: User) => {
        this.logoutUser();
      }).catch((e) => e);
    },
    getUserFromToken() {
      let token = localStorage.getItem('token');
      if (token) {
        let decoded : any = jwt_decode(token);
        this.userServices.getUser(decoded.user_id).then((response: User) => {
          this.user = response;
        }).catch((e) => e)
        return;
      }
      router.push('/login');
    },
    
  }

})
