<template>
  <div class="timebox">
    <p>Current time :<br><b>{{ formatDate(currentTime) }}</b></p>

    <p>Start time :<br> <b v-if="status">{{ formatDate(date) }}</b> <b v-else>-</b></p>
  </div>
  <div  class="timebox">
    <p>Elapsed time : {{ getElapsedTime(date) }}</p>
  </div>
</template>

<script lang="ts">

import { defineComponent } from "vue";
import moment from 'moment';

export default defineComponent({
  name: "Timer",
  data()
  {
    return {
      currentTime: new Date().toString(),
    }
  },
  props: {
    date: {
     type: String,
     required: true
    },
    status:  {
      type: Boolean
    }
  },
  mounted() {
    setInterval(() => {
      this.getCurrentTime();
      this.getElapsedTime(this.currentTime);
    }, 1)
  },
  methods: {
    formatDate(date : string) {
      if (date) {
        return moment(date).format('h:mm:ss');
      } else {
        return "-";
      }
    },
    getElapsedTime(date : string) {
      var a = moment(date);
      var b = moment(this.currentTime);
      if (date && this.status) {
        var c = moment(b.diff(a))
        return c.format('mm:ss') ;
      }
    },
    getCurrentTime()  {
      this.currentTime = Date().toString()
    }
  }

})
</script>
<style>
.timebox {
  width: 50%;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-around;
  transform: translateY(100px);
}
.timebox p {
  width: max-content;
  height: max-content;
  line-height: 100%;
  border-radius: 10px;
  background-color: ghostwhite;
  box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
  font-weight: bold;
  font-size: 1.0em;
}
.timebox b
{
  width: max-content;
  height: max-content;
  line-height: 100%;
  border-radius: 10px;
  background-color: ghostwhite;
  box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
  font-weight: bold;
  font-size: 0.8em;
  margin-left: 40px;
}
</style>
