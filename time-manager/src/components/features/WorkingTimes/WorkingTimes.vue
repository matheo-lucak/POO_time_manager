<template>
    <RouterLink :to="`/workingtime/${userId}`"> Register new working times </RouterLink> 
    <div class="flex-wrap feature-container">

        <WorkingTimeCard v-for="workingtime in workingtimeStore.workingtimes" :userId="userId" :id="workingtime.id" :start="workingtime.start" :end="workingtime.end"/>

    </div>
    
</template>

<script lang="ts">
import { useWorkingtimesStore } from '@/core/stores/workingtimes';
import { defineComponent } from 'vue';
import WorkingTimeCard from './components/WorkingTimeCard.vue';

export default defineComponent({
    data() {
        return {
            userId: 1,
        };
    },
    setup() {
        const workingtimeStore = useWorkingtimesStore();
        return {
            workingtimeStore
        }
    },
    beforeMount() {
        const workingtimeStore = useWorkingtimesStore();

        workingtimeStore.fetchWorkingtimes(this.userId);      
    },
    components: { WorkingTimeCard }
})

</script>

<style>

</style>