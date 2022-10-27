

<template>

  <div id="clock">

    Today's getNow is {{ startDateTime }}
    <button v-on:click="clockInFunction">ClockIn</button>
    <img v-if="clockIn === true" :src=image alt="Clock is ticking"/>
  </div>
</template>

<script>
import axios from 'axios'
import clockInImage from "./assets/running-clock-02.gif"

export default {
  name: 'ClockManager',
  props: [
      "userID"
  ],
  data() {
    return {
      startDateTime: "",
      image: clockInImage,
      clockIn: true
    }
  },
  mounted() {
      const today = new Date();
      const date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
      const time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
      let timestamp = date + ' ' + time;
      this.startDateTime = timestamp
  },
  methods: {
    refresh: function() {

    },
    clockInFunction: function() {
      this.clockIn = !this.clockIn

    },
  }
}
</script>
