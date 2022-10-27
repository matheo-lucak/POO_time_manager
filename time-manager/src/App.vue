<script lang="ts">
import { RouterView } from 'vue-router';
import AppHeader from '@/components/shared/AppHeader.vue';
import AppFooter from '@/components/shared/AppFooter.vue';
import AppSidebar from '@/components/shared/AppSidebar.vue';

export default {
    data() {
        return {
            isMobile: false
        }
    },
    components: {
        AppHeader,
        AppFooter,
        AppSidebar,
    }
}
</script>

<template>

    <div class="main-container">
        <AppHeader />
        <div class="main flex-row space-between">
            <AppSidebar v-if="!isMobile"/>
            <div class="main-content">
                <RouterView />
            </div>
        </div>
        
        
        <div class="footer-container">
            <AppFooter />
        </div>
        
    </div>
    

</template>

<style>


</style>
