<template>

  <div id="clock">

    <!-- <h1>Hello {{ this.user.username }}! This is the clock page.</h1> -->
    <h2><Timer :date="clockStore.getClock.time" :status="clockStore.getClock.status"/> </h2>
    <div v-if="clockStore.getClock.status === true">ClockActivated</div>
    <div class="buttonbox">
      <button v-on:click="clockStore.refreshClock(user.id)">RefreshClock</button>

      <button v-on:click="clockStore.submitClock(user.id)">ClockIn</button>

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
      user: {username:"", email:"", id:0, role:""},
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
  mounted() {
    const { fetchClock } = useClockStore();
    const { getUser } = useUserStore();
    this.user = getUser;
    fetchClock(this.user.id);
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
