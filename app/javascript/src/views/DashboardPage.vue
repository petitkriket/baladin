<template>
  <BRow>
    <transition
      name="fade"
      mode="out-in"
    >
      <router-view />
    </transition>
  </BRow>
</template>

<script>
import { BRow } from 'bootstrap-vue';

export default {
  components: {
    BRow,
  },
};
</script>
<style lang="scss">
.fade-enter-active,
.fade-leave-active {
  transition: opacity 150ms ease;
}

.fade-enter,
.fade-leave-active {
  opacity: 0;
}
</style>
