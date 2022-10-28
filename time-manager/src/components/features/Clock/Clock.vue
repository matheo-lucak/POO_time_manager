

<template>

  <div id="clock">

    <h1>Hello!</h1>
    <h2><Timer  :date="clockStore.getClock.time"/> </h2>
    <div v-if="clockStore.getClock.status === true">ClockActivated</div>
    <div v-if="clockStore.clock.status === true">WithoutGetter</div>
    <button v-on:click="clockStore.submitClock(this.userID)">Submit</button>
  </div>
</template>

<script lang="ts">

import { useClockStore } from "@/core/stores/clock.store";
import { useUserStore }  from "@/core/stores/user.store"
import { defineComponent } from "vue"
import Timer from "./components/Timer.vue"

export default defineComponent( {
  name: 'ClockManager',
  data() {
    return {
      userID: 1,
      clockIn: true
    }
  },
  setup()  {
    const clockStore = useClockStore();
    return { clockStore }
  },

  components: {
    Timer
  },
  beforeMount() {
    const { fetchClock } = useClockStore();
    const { getUserID } = useUserStore();
    this.userID = getUserID;
    fetchClock(this.userID);
  },
})

</script>
