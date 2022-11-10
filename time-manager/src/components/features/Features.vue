<script lang="ts">
import { RouterView } from 'vue-router';
import AppHeader from '@/components/shared/AppHeader.vue';
import AppFooter from '@/components/shared/AppFooter.vue';
import AppSidebar from '@/components/shared/AppSidebar.vue';
import { defineComponent } from 'vue';
import { useMobileStore } from '@/core/stores/mobile.store.store';

export default defineComponent({
    data() {
        return {
            isMobile: false
        }
    },
    components: {
        AppHeader,
        AppFooter,
        AppSidebar,
    },
    computed:  {
        getIsMobile() {
            const { getMobile } = useMobileStore();
            return getMobile;
        }
    },
    beforeMount() {
        const mobileStore = useMobileStore();
        if(window.innerWidth < 720) {
            mobileStore.updateIsMobile(true);
        }
        window.onresize = () => {
            if(window.innerWidth < 720) {
                mobileStore.updateIsMobile(true);
                return;
            }
            mobileStore.updateIsMobile(false);
        }
    }
})
</script>

<template>

    <div class="main-container">
        <AppHeader />
        <div class="main flex-row space-between">
            <AppSidebar v-if="!getIsMobile"/>
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
