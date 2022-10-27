<script setup lang="ts">
import { RouterView } from 'vue-router';
import AppHeader from '@/components/shared/AppHeader.vue';
import AppFooter from '@/components/shared/AppFooter.vue';
</script>

<template>

    <div class="main-container">
        <AppHeader />
        
        <div class="main-content">
            <RouterView />
        </div>
        
        <div class="footer-container">
            <AppFooter />
        </div>
        
    </div>
    

</template>

<style>


</style>
