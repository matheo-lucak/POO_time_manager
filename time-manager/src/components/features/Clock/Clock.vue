

<template>

  <div id="clock">

    <div v-if="clockStore.clock.status === true">ClockActivated</div>
    <button v-on:click="clockInFunction">ClockIn</button>
    <img v-if="clockIn === true" :src=image alt="Clock is ticking"/>
  </div>
</template>

<script lang="ts">

import { useClockStore } from "@/core/stores/clock.store";
import { defineComponent } from "vue"
import ClocksServices from "@/core/api/clocks.service";
import type {Clock} from "@/core/interfaces/clock.interface";

export default defineComponent( {
  name: 'ClockManager',
  props: [
      "userID"
  ],
  data() {
    return {
      userID: 0,
      clockIn: true
    }
  },
  setup()  {
    const clockStore = useClockStore();
    return { clockStore }
  },

  methods: {

  }
})

</script>
