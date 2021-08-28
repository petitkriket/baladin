<template>
  <BContainer>
    <BRow>
      <transition
        name="fade"
        mode="out-in"
      >
        <router-view />
      </transition>
    </BRow>
  </BContainer>
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
