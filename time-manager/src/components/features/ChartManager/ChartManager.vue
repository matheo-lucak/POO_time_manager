<template>

    <div>

        <div class="date-selection flex-row middle center">
            <span>
                Start
                <Datepicker v-model="start" minimumView="time" maximumView="day"/>
                <span>{{getStartTime}}</span>
            </span>
            <span>
                End
                <Datepicker v-model="end" minimumView="time" maximumView="day"/>
                <span>{{getEndTime}}</span>
            </span>
            <span class="mt-4">
                <button class="btn btn-info" @click="fetchChartWorkingtimesByDate">Filtrer</button>
            </span>
        </div>

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

    </div>
    
    

</template>

<script lang="ts">
import Datepicker from 'vue3-datepicker';
import TimePieChart from '@/components/features/ChartManager/components/TimePieChart.vue';
import TimeLineChart from '@/components/features/ChartManager/components/TimeLineChart.vue';
import TimeBarChart from '@/components/features/ChartManager/components/TimeBarChart.vue';
import { defineComponent } from 'vue';
import { useChartStore } from '@/core/stores/chart.store';
import { useUserStore } from '@/core/stores/user.store';

export default defineComponent({
    data() {
        return {
            start: new Date(),
            end: new Date()
        }
    },
    mounted() {
    },
    methods: {
        fetchChartWorkingtimesByDate: function() {
            const chartStore = useChartStore();
            const userStore = useUserStore();
            chartStore.fetchWorkingtimesByDate(userStore.getConnectedAs.id, this.start.toISOString(), this.end.toISOString());
        }
    },
    computed: {
        getStartTime() {
            return this.start.toLocaleTimeString();
        },
        getEndTime() {
            return this.end.toLocaleTimeString();
        },
    },
    components: {
        TimePieChart,
        TimeBarChart,
        TimeLineChart,
        Datepicker
    },
})
</script>

<style scoped>

.chart-container {
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    height: 100%;
}

.date-selection {
    width: 100%;
    margin: 0 0 78px 0;
}
.date-selection span {
    padding: 1rem;
}

.chart {
    width: 600px;
    height: 350px;
}

</style>