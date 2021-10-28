<template>
  <BaseMap />
</template>

<script>
import BaseMap from '../components/BaseMap.vue';

export default {
  name: 'HomePage',
  components: {
    BaseMap,
  },
  activated() {
    window.scrollTo(0, 0);
  },
  metaInfo() {
    return {
      title: this.$t('homePage.home'),
    };
  },
};
</script>
