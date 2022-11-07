<template>
  <div class="register">
    <h1>Register</h1>
    <form @submit.prevent="Register">
      <input type="text" placeholder="Email" v-model="email" />
      <input type="text" placeholder="Username" v-model="username" />
      <input type="text" placeholder="Password" v-model="password" />
      <input type="submit" value="Register" />
      <p>Have an account? <router-link to="/auth/login">Login here!
      </router-link></p>
    </form>
  </div>
</template>
<script lang="ts">

import {defineComponent, ref} from "vue";
import {useUserStore} from "@/core/stores/user.store";

export default defineComponent({
  name: "Register",
  setup() {
    const email = ref("");
    const username = ref("");
    const password = ref("");
    const userStore = useUserStore();

    const Register = () => {
      userStore.registerUser(email.value, username.value, password.value);
    }
    return {
      Register,
      email,
      username,
      password
    }
  },
})
</script>
<style>

</style>
