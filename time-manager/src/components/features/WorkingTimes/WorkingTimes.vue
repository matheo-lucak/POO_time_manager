<template>
    <div class="flex-wrap feature-container">
        
        <WorkingTimeCard v-for="workingtime in workingtimes" :start="workingtime.start" :end="workingtime.end"/>

    </div>
</template>

<script lang="ts">
import WorkingTimeCard from './components/WorkingTimeCard.vue';

export default {
    data() {
        return {
            workingtimes: [{ start: "yeeeee", end: "boiiii" }, { start: "yeeeee", end: "boiiii" }, { start: "yeeeee", end: "boiiii" }, { start: "yeeeee", end: "boiiii" }, { start: "yeeeee", end: "boiiii" },]
        };
    },
    mounted() {
        // TODO get workingtimes
    },
    components: { WorkingTimeCard }
}

</script>

<style>

</style>