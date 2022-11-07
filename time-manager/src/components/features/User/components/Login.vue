<template>
  <div class="login">
    <h1>Login</h1>
    <form @submit.prevent="Login">
      <input type="text" placeholder="Email" v-model="email" />
      <input type="text" placeholder="Password" v-model="password" />
      <input type="submit" value="Login" />
      <p>Need an account? <router-link to="/auth/register">Register here!
      </router-link></p>
    </form>
</div>
</template>
<script lang="ts">

import {defineComponent, ref} from "vue";

export default defineComponent({
  name: "Login",
  setup() {
    const email = ref("");
    const password = ref("");

    const Login = () => {

    }
    return {
      Login,
      email,
      password
    }
  },
})
</script>
<style>

</style>
