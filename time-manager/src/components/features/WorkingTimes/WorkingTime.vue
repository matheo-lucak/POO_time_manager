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
        <div class="update-button">
            <button v-if="update" @click="updateWorkingtime">Save</button>
            <button v-if="!update" @click="postWorkingtime">Save</button>
        </div>
    </div>
    
</template>

<script lang="ts">
import Datepicker from 'vue3-datepicker';
import { defineComponent } from 'vue';
import { useWorkingtimesStore } from '@/core/stores/workingtimes';
// import { useRoute } from 'vue-router';

export default defineComponent({
    data() {
        return {
            id: "",
            userId: "",
            workingTime: {
                start: "",
                end: ""
            },
            startDate: new Date(),
            endDate: new Date(),
            update: false
        }
    },
    setup() {
        
        // const { getWorkingtime } = useWorkingtimesStore();

        // const route = useRoute();
        // const id = <string>route.params.userId;
        // const userId = <string>route.params.id;

        // var response: any;
        // getWorkingtime(userId, id).then((res: any) => {
        //     response = res;
        // })

        // const startDate = ref(new Date(workingTime.start));
        // const endDate = ref(new Date(workingTime.end));


        // return {
        //     startDate,
        //     endDate,
        // }
    },
    beforeMount() {
        const { getWorkingtime } = useWorkingtimesStore();

        this.id = <string>this.$route.params.id;
        this.userId = <string>this.$route.params.userId;
        
        if(!this.id) return;
        
        this.update = true;
        getWorkingtime(this.userId, this.id).then((response: any) => {
            
            if(!response.data.data) return;

            this.workingTime = response.data.data;
            this.startDate = new Date(this.workingTime.start);
            this.endDate = new Date(this.workingTime.end);

        }).catch(error => console.log(error));

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
        updateWorkingtime() {
            
        },
        postWorkingtime() {

        }
        
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