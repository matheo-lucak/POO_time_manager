<template>
  <div>
    <nav>
      <Dropdown />
    </nav>
  </div>
</template>


<script lang="ts">
import { defineComponent } from 'vue';
import {useUserStore} from "@/core/stores/user.store";
import Dropdown from "@/components/shared/Dropdown.vue";

export default defineComponent({
  name: 'User',
  components: {Dropdown},
  // TODO: wrap login register + crud user in here, openable from header

  // TODO: components we'll wrap in the sidebar, if current user is general manager promote / demote routes implemented, if not just regular statistics + crud for the selected user
  setup() {
    const userStore = useUserStore();
    return { userStore }
  },
  data() {
    return {

    }
  },
  beforeMount() {

  },
  computed: {

  },
  methods: {

  }
})
</script>

<style scoped>
nav .menu-item {
  color: #ffffff;
  padding: 10px 20px;
  position: relative;
  text-align: center;
  border-bottom: 3px solid transparent;
  display: flex;
  transition: 0.4s;
}

div. menu-item.active,
div. menu-item:hover {
  background-color: #3c4462;
  border-bottom-color: #a94442;
}

nav .menu-item a {
  color: inherit;
  text-decoration: none;
}
</style>
