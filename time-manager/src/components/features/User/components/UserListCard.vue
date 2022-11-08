<template>
    <div class="flex-row space-around">
        <div>
            <h3>Username</h3>
            {{username}}
        </div>
        <div>
            <h3>Username</h3>
            {{email}}
        </div>
        <div>
            <button>Select user</button>
        </div>
    </div>
    
</template>


<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({

    data() {
        return {

        }
    },
    props: {
        username: {
            type: String,
            required: true
        },
        email: {
            type: String,
            required: true
        },
        id: {
            type: String,
            required: true
        },
    },
    beforeMount() {
        
    }
})
</script>
