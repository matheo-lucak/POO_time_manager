<template>
  <div class="menu-item" @click="isOpen = !isOpen">
    <a href="#"><font-awesome-icon icon="fa-solid fa-user-secret" /></a>
    <div class="sub-menu" v-if="isOpen">
      <h2>Profile information</h2>
      <div class="menu-item">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" class="form-control" id="username" v-model="userStore.getUser.username">
      </div>
      </div>
      <div class="menu-item">
      <div class="form-group">
        <label for="email">Email</label>
        <input type="text" class="form-control" id="email" v-model="userStore.getUser.email">
      </div>
    </div>
      <button>Update profile</button>
  </div>
  </div>
</template>

<script lang="ts">
import {defineComponent} from "vue";
import {useUserStore} from "@/core/stores/user.store";

export default defineComponent({
  name: "Dropdown",
  data() {
    return {
      isOpen: false
    }
  },
  setup() {
    const userStore = useUserStore();
    return { userStore }
  },
})
</script>

<style scoped>


nav .menu-item .sub-menu {
  position: absolute;
  background-color: #222222;
  top: calc(100% + 18px);
  left: 50%;
  transform: translateX(-50%);
  width: max-content;
  border-radius: 0 0 16px 16px;
}
</style>
