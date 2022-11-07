<template>
  <div class="register">
    <h1>Register</h1>
    <form @submit.prevent="Register">
      <input type="text" placeholder="Email" v-model="email" />
      <input type="text" placeholder="Username" v-model="username" />
      <input type="password" placeholder="Password" v-model="password" />
      <input type="password" placeholder="Password Confirmation" v-model="password_confirmation" />
      <input type="submit" value="Register" />
      <p>Have an account? <router-link to="/auth/login">Login here!
      </router-link></p>
    </form>
  </div>
</template>
<script lang="ts">

import {defineComponent, ref} from "vue";
import {useUserStore} from "@/core/stores/user.store";
import router from "@/router";

export default defineComponent({
  name: "Register",
  setup() {
    const email = ref("");
    const username = ref("");
    const password = ref("");
    const password_confirmation = ref("");
    const userStore = useUserStore();

    const Register = () => {
      userStore.registerUser(email.value, username.value, password.value, password_confirmation.value);
////      router.push('/');
    }
    return {
      Register,
      email,
      username,
      password,
      password_confirmation
    }
  },
})
</script>
<style>

</style>
