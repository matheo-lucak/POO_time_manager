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
            <RouterLink :class="activeWorkingtimes" to="/">Working Times</RouterLink>
            <RouterLink :class="activeClocks" to="/clocks">Clock !</RouterLink>
            <RouterLink :class="activeCharts" to="/charts">See your charts</RouterLink>
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

<style scoped>
a {
    text-decoration: none;
    color: #fff;
    width: 100%;
    height: 100%;
    background-color: #2f3136;
    border: none;
    font-weight: bold;
    height: 35px;
    width: 80%;
    border-radius: 0.25rem;
}

.active {
    background-color: #17a2b8;
}
.mobile-sidebar {
    width: 350px;
    height: 100%;
    background-color: #2f3136;
}
</style>