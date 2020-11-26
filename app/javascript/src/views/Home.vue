<template>
  <div class="home">
    <h1>
      {{ $t('project_title') }}
    </h1>
    <BaseMap />
  </div>
</template>

<script>
import BaseMap from '@/components/BaseMap.vue';

export default {
  components: {
    BaseMap,
  },
};
</script>
<style>
.home {
  padding-top: 10px;
}
</style>
