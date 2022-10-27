<template>

<div class="chart-container">

</div>

</template>

<script lang="ts">

export default {
    props: [

    ],
    data() {
        return {
            mounted: 'HOY'  
        }
    },
    mounted() {
        console.log(this.mounted)
    }
}
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