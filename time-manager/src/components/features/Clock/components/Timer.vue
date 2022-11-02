<template>
  <label for="toggle_button">
    <span>On</span>
    <span>Off</span>
    <h2>Maggle vla ta clock : {{ formatDate(date) }}</h2>
    <input type="checkbox" id="toggle_button">
  </label>
</template>
<script>
import {defineComponent} from "vue";
import moment from 'moment';

export default defineComponent({
  name: "Timer",
  props: {
    date: String,
  },
  methods: {
    formatDate: function (date) {
      console.log(date)
      if (date) {
        return moment(String(date)).format('MM/DD/YYYY, h:mm:ss a');
      } else {
        return "DJANGOaaaaaaa";
      }
    }
  }

})
</script>
