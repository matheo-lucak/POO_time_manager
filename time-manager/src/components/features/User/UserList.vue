<template>

    <div v-for="user in users" >
        <UserListCard :id="user.id" :username="user.username" :email="user.email"/>
    </div>

</template>

<script lang="ts">
import { defineComponent } from 'vue';
import UserListCard from './components/UserListCard.vue';
 
export default defineComponent({

    data() {
        return {
            users: [{
                id: "1",
                username: "Jean",
                email: "jeanpeuplu@mail.com"
            }]
        }
    },
    components: {
        UserListCard
    }

})

</script>

<style scoped>


</style>