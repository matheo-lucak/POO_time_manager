<template>

  <div id="clock">

    <h1>Hello {{ getUser.username }}! This is the clock page.</h1>
    <h2><Timer :date="clockStore.getClock.time" :status="clockStore.getClock.status"/> </h2>
    <div v-if="clockStore.getClock.status === true">ClockActivated</div>
    
    <div class="buttonbox">

      <button v-on:click="clockStore.refreshClock(getUser.id)">RefreshClock</button>

      <button v-on:click="clockStore.submitClock(getUser.id)">ClockIn</button>

    </div>

  </div>
</template>

<script lang="ts">

import { useClockStore } from "@/core/stores/clock.store";
import { useUserStore }  from "@/core/stores/user.store";
import { defineComponent } from "vue";
import Timer from "./components/Timer.vue";

export default defineComponent( {
  name: 'ClockManager',
  data() {
    return {

      clockIn: true
    }
  },
  setup()  {
    const clockStore = useClockStore();
    const { getUser } = useUserStore();
    return { clockStore, getUser }
  },

  components: {
    Timer
  },
  mounted() {
    const { fetchClock } = useClockStore();
    const { getUser } = useUserStore();

    fetchClock(getUser.id);
  },

  methods: {

  },
})

</script>

<style>
.buttonbox {
  width: 50%;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-around;
  transform: translateY(100px);
}
.buttonbox button
{
  padding: 16px;
  border-radius: 50%;
  display: flex;
  align-items: baseline;
}
</style>
