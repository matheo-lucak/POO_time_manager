<template>
    <header class="header-container" >
      <div class="toolbar flex-row middle space-around">
        <AppSidebarMobile v-if="isMobile"/>
        <nav>
          <RouterLink to="/">Home</RouterLink>
        </nav>
      </div>
      <div class="toolbar-border"></div>
    </header>
</template>

<script lang="ts">
import AppSidebarMobile from '@/components/shared/AppSidebarMobile.vue';
import AppSidebar from '@/components/shared/AppSidebar.vue';
import { mobileStore } from '@/core/stores/mobile';

export default {
    data() {
        return {
            isMobile: false
        }
    },
    mounted() {
        // mobileStore.getMobile()
    },
    components: {
        AppSidebarMobile,
        AppSidebar
    }
}
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

</style>