<template>
    <v-chart class="chart" :option="option" />
</template>
  
<script lang="ts">
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { PieChart } from 'echarts/charts';
import {
    TitleComponent,
    TooltipComponent,
    LegendComponent,
} from 'echarts/components';
import VChart from 'vue-echarts';
import { ref, defineComponent } from 'vue';
import { useUserStore } from '@/core/stores/user.store';
import { useChartStore } from '@/core/stores/chart.store';
import type { Workingtime } from '@/core/interfaces/workingtime.interface';

use([
    CanvasRenderer,
    PieChart,
    TitleComponent,
    TooltipComponent,
    LegendComponent,
]);

export default defineComponent({
    components: {
        VChart,
    },
    setup() {

        const chartStore = useChartStore();
        const userStore = useUserStore();

        // //filter data for charts
        const computeWorkingtimesByDays = () => {
            let computedWorkingtimes = chartStore.getWorkingtimes.filter((workingtime: Workingtime) => {

            })
            return computedWorkingtimes;
        }

        const seriesData = computeWorkingtimesByDays();

        const option = ref({
            title: {
                text: 'Working Times',
                left: 'center',
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)',
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['Never', 'Gonna', 'Give', 'You', 'Up'],
            },
            series: [
                {
                    name: 'Working Times',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [
                        { value: 335, name: 'Never' },
                        { value: 310, name: 'Gonna' },
                        { value: 234, name: 'Give' },
                        { value: 135, name: 'You' },
                        { value: 1548, name: 'Up' },
                        // seriesData
                    ],
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)',
                        },
                    },
                },
            ],
        });

        return { option };
    },
});
</script>
  
<style scoped>
.chart {
    height: 100%;
    width: 100%;
}
</style>
  