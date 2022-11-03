<template>

    <div class="chart-container">
        <TimePieChart />
    </div>

</template>

<script lang="ts">
import TimePieChart from '@/components/features/ChartManager/components/TimePieChart.vue';
import { defineComponent } from 'vue';

export default defineComponent({
    props: [

    ],
    data() {
        return {
             
        }
    },
    mounted() {
    },
    components: {
        TimePieChart
    }
})
</script>

<style scoped>

.chart-container {
    display: flex;
    flex-wrap: wrap;
    background-color: aqua;
    width: 300px;
    height: 100px;
}

</style>