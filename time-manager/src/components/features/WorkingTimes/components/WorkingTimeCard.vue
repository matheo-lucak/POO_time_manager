<template>

    <div class="custom-card-calendar app-card-small">

        <div class="card-header">
            <div class="title-border"></div>
            <h2 class="title">{{getWeekDay}}</h2>
            <div class="title-border"></div>
        </div>



        <div class="dates flex-col middle">
            <span>
                {{getStartDate}}
            </span>
            <span>
                {{getEndDate}}
            </span>
        </div>

        <div class="hours-worked flex-row center">
            <span>
                <p>{{getWorkedHours}}</p>
            </span>
        </div>
        <div class="flex-row center" width="100%">
            <button><router-link :to="{ name: 'workingtime', params: { userId: userId, id: id } }">Update</router-link></button>
        </div>
        
    </div>

</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
    data() {
        return {
            weekDays: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        }
    },
    props: {
        start: {
            type: String,
            required: true
        },
        end: {
            type: String,
            required: true
        },
        id: {
            type: Number,
            required: true
        },
        userId: {
            type: Number,
            required: true
        }
        
    },
    computed: {
        getStartDate() {
            let date = new Date(this.start);
            return date.toLocaleString();
        },
        getEndDate() {
            let date = new Date(this.end);
            return date.toLocaleString();
        }, 
        getWorkedHours() {
            let hours = this.hoursBetween(this.start, this.end)
            return hours;
        },
        getWeekDay() {
            let weekDay = new Date(this.start).getDay(); 
            return this.weekDays[weekDay];
        }
    },
    methods: {
        treatAsUTC(date: string) {
            let result = new Date(date);
            result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
            return result;
        },
        hoursBetween(startDate: string, endDate: string) {
            let millisecondsPerHour = 60 * 60 * 1000;
            let diff = this.treatAsUTC(endDate).getTime() - this.treatAsUTC(startDate).getTime();
            if(diff > millisecondsPerHour)
                return diff / millisecondsPerHour + ' h';
            return diff / (millisecondsPerHour / 60) + ' min';
        }
    }

})
</script>

<style scoped>
.title {
  color: #3c4462;
  font-size: 14px;
  font-weight: bold;
  font-stretch: normal;
  font-style: normal;
  line-height: normal;
  letter-spacing: 1px;
  text-align: center;
  margin: 0 24px;
  width: fit-content;
  height: 24px;
  flex-shrink: 0;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  margin-bottom: 10px;
}

.title-border {
  height: 1px;
  width: 100%;
  background-color: #dee2f3;
}

button {
  background-color: #fff;
  border: none;
  border-radius: 7px;
}

.dates span {
    padding: 10px;
}

.hours-worked {
    width: 100%;
    color: #00E676;
    font-weight: bold;
    font-size: 24px;
}
</style>