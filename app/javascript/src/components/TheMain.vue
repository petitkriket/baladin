<template>
  <BContainer
    :style="{ marginTop: '41px'}"
    :class="{ 'px-0': isFullwidth }"
    :fluid="isFullwidth"
  >
    <transition
      name="fade"
      mode="out-in"
    >
      <router-view />
    </transition>
  </BContainer>
</template>

<script>
import { BContainer } from 'bootstrap-vue';

export default {
  components: {
    BContainer,
  },
  computed: {
    isFullwidth() {
      return this.$route.meta.isFullwidth;
    },
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
