

<template>

  <div id="clock">

    Today's getNow is
    <button v-on:click="clockInFunction">ClockIn</button>
    <img v-if="clockIn === true" :src=image alt="Clock is ticking"/>
  </div>
</template>

<script lang="ts">

// import clockInImage from "./assets/running-clock-02.gif";
// import {useClockStore} from "@/core/stores/clock.store";
// import type { Clock }  from "@/core/interfaces/clock.interface";
// import ClocksServices from "@/core/api/clocks.service"

export default {
  name: 'ClockManager',
  props: [
      "userID"
  ],
  data() {
    return {
      clock: {},
      userID: 0,
      clockIn: true
    }
  },
  mounted() {
    this.userID
  //     const today = new Date();
  //     const date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
  //     const time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
  //     const { initClock } = useClockStore();
  //
  //     const clockService = new ClocksServices();
  //
  //   clockService.getClock(this.userID).then((response : Clock) => {
  //       initClock(response);
  //     }).catch( error => {
  //       //TODO: handle error
  //       console.log("error");
  //     });
  // },
  // methods: {
  //
  }
}

</script>
