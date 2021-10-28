<template>
  <div id="app">
    <TheNavigationBar />
    <TheMain />
    <TheIntroductionModal
      ref="modalComponent"
      @consent="setVisitCookie"
    />
  </div>
</template>

<script>
import TheNavigationBar from './components/TheNavigationBar.vue';
import TheMain from './components/TheMain.vue';
import TheIntroductionModal from './components/TheIntroductionModal.vue';

export default {
  name: 'App',
  metaInfo() {
    return {
      titleTemplate: `%s | ${this.$t('projectTitle')}`,
    };
  },
  components: {
    TheNavigationBar,
    TheMain,
    TheIntroductionModal,
  },
  mounted() {
    this.checkForVisitCookie();
  },
  methods: {
    checkForVisitCookie() {
      const isFirstVisit = !this.$cookies.isKey('visited');
      if (isFirstVisit) this.showIntroductionModal();
    },
    showIntroductionModal() {
      this.$refs.modalComponent.openModal();
    },
    setVisitCookie() {
      this.$cookies.set('visited', 'true', '1d');
    },
  },
};
</script>
