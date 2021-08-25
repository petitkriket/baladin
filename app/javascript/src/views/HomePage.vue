<template>
  <BaseMap />
</template>

<script>
import BaseMap from '../components/BaseMap.vue';

export default {
  components: {
    BaseMap,
  },
  metaInfo() {
    return {
      title: this.$t('homePage.home'),
    };
  },
};
</script>
