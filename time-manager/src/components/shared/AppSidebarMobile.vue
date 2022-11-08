<template>
    <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
        Menu
    </button>

    <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasExampleLabel">Time Manager</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <div class="mobile-sidebar">
        <h2></h2>
        <div class="flex-col gap-2 middle center">
            <button :class="activeWorkingtimes"><RouterLink to="/">Working Times</RouterLink></button>
            <button :class="activeClocks"><RouterLink to="/clocks">Clock !</RouterLink></button>
            <button :class="activeCharts"><RouterLink to="/charts">See your charts</RouterLink></button>
        </div>
    </div>
    </div>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    data() {
        return {
            currentPath: this.$route.path
        }
    },
    computed: {
        activeClocks() {
            if(this.currentPath.includes('clocks'))
                return "active";
            return "";
        },
        activeCharts() {
            if(this.currentPath.includes('charts'))
                return "active";
            return "";
        }, 
        activeWorkingtimes() {
            if(this.currentPath.includes('workingtime'))
                return "active";
            return "";
        }
    },
    mounted() {
    },
    watch: {
        '$route'(to, from) {
            this.currentPath = to.path;
        }
    },
})
</script>

<style>
.mobile-sidebar {
    background-color: #f9f9fb;
}
</style>