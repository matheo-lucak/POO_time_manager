<template>

    <div class="chart-container">
        <div class="chart">
            <TimePieChart />
        </div>
        <div class="chart">
            <TimeBarChart />
        </div>
        <div class="chart">
            <TimeLineChart />
        </div>
    </div>
    

</template>

<script lang="ts">
import TimePieChart from '@/components/features/ChartManager/components/TimePieChart.vue';
import TimeLineChart from '@/components/features/ChartManager/components/TimeLineChart.vue';
import TimeBarChart from '@/components/features/ChartManager/components/TimeBarChart.vue';
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
        TimePieChart,
        TimeBarChart,
        TimeLineChart
    }
})
</script>

<style scoped>

.chart-container {
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    height: 100%;
}

.chart {
    width: 600px;
    height: 350px;
}

</style>