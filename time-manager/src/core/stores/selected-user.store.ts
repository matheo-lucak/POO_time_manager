import { ref, computed } from 'vue';
import { defineStore } from 'pinia';
import type {User, SelectedUserStore} from '@/core/interfaces/user.interface';
import UsersServices from "@/core/api/users.services";

export const useSelectedUserStore = defineStore('user', {

  // TODO: implement selected user CRUD and stuff (by a manager)
  state: (): SelectedUserStore => ({
    selectedUser: {
      username:"Eduardo",
      email: "eddy@eddy.fr",
      id: 0,
      role: ""
    },
    userServices: new UsersServices(),
    userList: [
        {
            username:"Eduardo",
            email: "eddy@eddy.fr",
            id: 0,
            role: ""
        }
    ],
  }),
  getters: {
    getUser : (state) => state.selectedUser,
  },
  actions: {
  

  },
})
