<template>
    <v-chart class="chart" :option="option" />
</template>
  
<script lang="ts">
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart } from 'echarts/charts';
import {
    GridComponent,
    TitleComponent,
    TooltipComponent,
    LegendComponent,
} from 'echarts/components';
import VChart from 'vue-echarts';
import { ref, defineComponent } from 'vue';

use([
    GridComponent,
    CanvasRenderer,
    BarChart,
    TitleComponent,
    TooltipComponent,
    LegendComponent,
]);

export default defineComponent({
    components: {
        VChart,
    },
    props: {
        data: {
            type: Array<Number>,
            default: [820, 932, 901, 934, 1290, 1330, 1320]
        }
    },
    setup() {
        const option = ref({
            title: {
                text: 'Working Times'
            },
            tooltip: {},
            legend: {
                data: ['Never Gonna'],
            },
            xAxis: {
                data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            },
            yAxis: {},
            series: [{
                name: 'Never Gonna',
                type: "bar",
                data: [5, 20, 36, 10, 10, 20, 4]
            }]
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
  