<template>
  <div class="login">
    <h1>Login</h1>
    <form @submit.prevent="Login">
      <input name="email" type="text" placeholder="Email" v-model="email" />
      <input name="password" type="password" placeholder="Password" v-model="password"  />
      <input name="connexion" type="submit" value="Login" />
      <p>Need an account? <router-link to="/register">Register here!</router-link></p>
    </form>
</div>
</template>
<script lang="ts">

import {defineComponent, ref} from "vue";
import {useUserStore} from "@/core/stores/user.store";
import router from '@/router';

export default defineComponent({
  name: "Login",
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    Login: function() {
      const { loginUser } = useUserStore();
      loginUser(this.email, this.password).then((response: any) => {
        router.push('/workingtimes');
      })
      .catch(e => e);
    }
  }
})
</script>
<style>

</style>
