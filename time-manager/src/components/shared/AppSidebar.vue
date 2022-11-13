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
                return "active btn btn-info";
            return "";
        },
        activeCharts() {
            if(this.currentPath.includes('charts'))
                return "active btn btn-info";
            return "";
        }, 
        activeWorkingtimes() {
            if(this.currentPath.includes('workingtime'))
                return "active btn btn-info";
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
    background-color: #2f3136;
}

button {
    background-color: #2f3136;
    border: none;
    font-weight: bold;
    height: 35px;
    width: 80%;
    border-radius: 0.25rem;
}

a {
    text-decoration: none;
    color: #fff;
    height: 35px;
    width: 80%;
}

.active {
    background-color: #17a2b8;
}
</style>