<template>

    <div class="feature-container">

        <div class="time-pick" id="start">
            <div>
                <h2>Start</h2>
                <Datepicker v-model="startDate" minimumView="time" maximumView="day"/>
                <span>{{getStartTime}}</span>
            </div>
        </div>

        <div class="time-pick" id="end">
            <div>
                <h2>End</h2>
                <Datepicker v-model="endDate" minimumView="time" maximumView="day"/>
                <span>{{getEndTime}}</span>
            </div>
        </div>

        <div class="total">
            Heures travaillées : {{hoursBetween}}
        </div>

    </div>
    
</template>

<script lang="ts">
import Datepicker from 'vue3-datepicker';
import { ref, defineComponent } from 'vue';

export default defineComponent({
    data() {
        return {
            id: 0,
        }
    },
    setup() {
        const startDate = ref(new Date());
        const endDate = ref(new Date());
        
        return {
            startDate,
            endDate
        }
    },
    computed: {
        getStartTime() {
            return this.startDate.toLocaleTimeString();
        },
        getEndTime() {
            return this.endDate.toLocaleTimeString();
        },
        hoursBetween() {
            let millisecondsPerHour = 60 * 60 * 1000;
            let diff = this.treatAsUTC(this.endDate.toString()).getTime() - this.treatAsUTC(this.startDate.toString()).getTime();
            if(diff > millisecondsPerHour)
                return diff / millisecondsPerHour + ' h';
            return diff / (millisecondsPerHour / 60) + ' min';
        }
    },
    components: {
        Datepicker
    },
    methods: {
        treatAsUTC(date: string) {
            let result = new Date(date);
            result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
            return result;
        },
        
    }
})
</script>

<style>
.time-pick {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    padding:21px;
}


</style>