<template>
  <div id="app">
    <div id="nav">
      <TheLocaleSwitcher />
      <router-link to="/">
        Home
      </router-link> |
      <router-link to="/about">
        About
      </router-link>
    </div>
    <router-view />
  </div>
</template>

<script>
import TheLocaleSwitcher from '@/components/TheLocaleSwitcher.vue';

export default {
  components: {
    TheLocaleSwitcher,
  },
};
</script>
