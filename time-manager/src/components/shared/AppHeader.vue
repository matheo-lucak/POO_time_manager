<template>
  <header class="header-container" >
    <div class="toolbar flex-row middle space-around">
      <AppSidebarMobile v-if="getIsMobile"/>
      <nav class="flex-row middle space-around">
        <RouterLink to="/">Time Manager</RouterLink>
        <router-link v-if="userStore.user.id === 0" to="/auth/login">Login
        </router-link>
        <button v-if="userStore.user.id !== 0" @click="userStore.logoutUser()">Logout
        </button>
      </nav>
      <User v-if="userStore.user.id !== 0"/>
    </div>
    <div class="toolbar-border"></div>
  </header>
</template>

<script lang="ts">
import AppSidebarMobile from '@/components/shared/AppSidebarMobile.vue';
import AppSidebar from '@/components/shared/AppSidebar.vue';
import User from '@/components/features/User/User.vue'
import { useMobileStore } from '@/core/stores/mobile';
import { useUserStore } from '@/core/stores/user.store'
import { defineComponent } from 'vue';
import {mapActions} from "pinia";

export default defineComponent({

  // TODO: CRUD or current user + login and register in a panel we can open from the header at any time

  setup() {
    const userStore = useUserStore();
    return { userStore }
  },
  data() {
    return {
      isMobile: false
    }
  },
  mounted() {
    const { getMobile } = useMobileStore();
    this.isMobile = getMobile;
  },
  computed: {
    getIsMobile() {
      const { getMobile } = useMobileStore();
      return getMobile;
    }
  },
  components: {
    AppSidebarMobile,
    AppSidebar,
    User,
  }
})
</script>

<style scoped>
.header-container {
  width: 100%;
  height: 100px;
  margin: 0 0 22px;
  background-color: #fff;
  position: fixed;
  z-index: 1000;
  top:0;
}

.toolbar {
  height: 100%;
  max-width: 1440px;
  margin: 0 auto;
}
.toolbar-border {
  width: 100%;
  height: 2px;
  opacity: 0.1;
  background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), linear-gradient(to bottom, rgba(255, 255, 255, 0.5), rgba(0, 0, 0, 0.5)), linear-gradient(to bottom, #000, rgba(0, 0, 0, 0));

}

a {
  text-decoration: none;
}

</style>
