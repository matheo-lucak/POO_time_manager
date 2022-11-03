<template>
    <v-chart class="chart" :option="option" />
</template>
  
<script lang="ts">
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { LineChart } from 'echarts/charts';
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
    LineChart,
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
    setup(props) {
        const option = ref({
            title: {
                text: 'Working Times',
            },
            tooltip: {},
            legend: {},
            xAxis: {
                type: 'category',
                boundaryGap: false,
                axisTick: {
                    show: true,
                },
                axisLabel: {
                    color: "#6470A0",
                    fontSize: '13',
                },
                axisLine: {
                    lineStyle: {
                        color: "#3C4462",
                        width: '2',
                    },
                },

                data: ['Monday', 'Tuesday', 'Never', ' Gonna', 'Give', 'You', 'Up'],
            },
            yAxis: {
                type: 'value',
                
                axisTick: {
                    show: true,
                },
                splitLine: {
                    lineStyle: {
                        type: 'dashed',
                        color:'#dee2f3',
                        width: '1',
                    },
                },
            },
            series: [
                {
                    type: 'line',
                    smooth: false,
                    symbolSize: 10,
                    emphasis: {
                        itemStyle: {
                            fill: "#f588b0",
                            stroke: "#f588b0",
                            opacity: 0.5,
                        },
                    },
                    lineStyle: {
                        width: 3,
                        color: "#f588b0",
                    },
                    itemStyle: {
                        color: "#f588b0",
                    },
                    data: [820, 932, 901, 934, 1290, 1330, 1320],
                    // [props.data]
                }

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
  