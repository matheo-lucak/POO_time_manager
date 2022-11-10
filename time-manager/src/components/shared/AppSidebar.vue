<template>
    <div class="fixed-sidebar">
        <h2></h2>
        <div class="flex-col gap-2 middle center">
            <button :class="activeWorkingtimes"><RouterLink to="/">Working Times</RouterLink></button>
            <button :class="activeClocks"><RouterLink to="/clocks">Clock !</RouterLink></button>
            <button :class="activeCharts"><RouterLink to="/charts">See your charts</RouterLink></button>
        </div>
    </div>
</template>

<script lang="ts">

export default {
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
    beforeMount() {
        // TODO: if manager or general manager, access list of users in sidebar
    },
    watch: {
        '$route'(to, from) {
            this.currentPath = to.path;
        }
    },


}

</script>

<style scoped>
.fixed-sidebar {
    width: 350px;
    height: 100%;
    background-color: #f9f9fb;
}

button {
    background-color: #f9f9fb;
    border: none;
    font-weight: bold;
}

.active {
 background-color: #3c44628a;
 color: white;
}
</style>