<template>
    <RouterLink :to="`/workingtime/${userStore.user.id}`"> Register new working times </RouterLink>
    <div class="flex-wrap feature-container">

        <WorkingTimeCard v-for="workingtime in workingtimeStore.workingtimes" :userId="userStore.user.id" :id="workingtime.id" :start="workingtime.start" :end="workingtime.end"/>

    </div>

</template>

<script lang="ts">
import { useUserStore } from '@/core/stores/user.store';
import { useWorkingtimesStore } from '@/core/stores/workingtimes.store';
import { defineComponent } from 'vue';
import WorkingTimeCard from './components/WorkingTimeCard.vue';

export default defineComponent({
    data() {
        return {

        };
    },
    setup() {
        const workingtimeStore = useWorkingtimesStore();
        const userStore = useUserStore();
        return {
            workingtimeStore,
            userStore
        }
    },
    beforeMount() {
        const workingtimeStore = useWorkingtimesStore();
        const userStore = useUserStore();
        workingtimeStore.fetchWorkingtimes(userStore.user.id);
    },
    components: { WorkingTimeCard }
})

</script>

<style>

</style>
