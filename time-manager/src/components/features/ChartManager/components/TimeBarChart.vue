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
    setup() {
        const option = ref({
            title: {
                text: 'Working Times'
            },
            tooltip: {},
            legend: {},
            xAxis: {
                data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            },
            yAxis: {},
            series: [{
                name: "Working Times",
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
  