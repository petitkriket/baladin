<template>
  <div :style="{ marginTop: '41px'}">
    <transition
      name="fade"
      mode="out-in"
    >
      <keep-alive :include="['HomePage','BaseMap']">
        <router-view />
      </keep-alive>
    </transition>
  </div>
</template>

<script>
export default {};
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
