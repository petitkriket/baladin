<template>
  <p>
    {{ message }}
  </p>
</template>

<script>
import { ref } from 'vue';

export default {
  name: 'App',
  setup() {
    const message = ref('Coucou toi !');

    return {
      message,
    };
  },
};
</script>
