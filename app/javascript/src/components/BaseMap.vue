<template>
  <BOverlay
    :show="isLoading"
    opacity="0.05"
    spinner-variant="primary"
    :z-index="555"
    overlay-tag="samp"
    no-fade
  >
    <BaseMapContainer
      :last-position-markers="activeArtworks"
      :history-markers="history.events"
      :locale="$i18n.locale"
      :center="map.center"
      :zoom="map.zoom"
      @center="onCenterUpdate"
      @zoom="onZoomUpdate"
    />
  </BOverlay>
</template>

<script>
import { BOverlay } from 'bootstrap-vue';
import {
  mapGetters,
  mapState,
  mapActions,
  mapMutations,
} from 'vuex';

import { FETCH_ARTWORKS, FETCH_ARTWORK_EVENTS } from '../store/modules/artworks/actions';
import { ARTWORKS_CURRENT_EVENTS } from '../store/modules/artworks/getters';

import BaseMapContainer from './BaseMapContainer.vue';

export default {
  components: { BOverlay, BaseMapContainer },
  data() {
    return {
      timeout: null,
      isLoading: true,
    };
  },
  computed: {
    ...mapState([
      'map',
      'artworks', ['events'],
      'user', ['settings'],
    ]),
    ...mapGetters('artworks', [
      ARTWORKS_CURRENT_EVENTS,
    ]),
    activeArtworks() {
      const { id } = this.$route.params;
      return this[ARTWORKS_CURRENT_EVENTS].map((obj) => {
        const isFocused = obj.passengerId.toString() === id;
        return { ...obj, isFocused };
      });
    },
    history() {
      const { id } = this.$route.params;
      if (typeof id === 'undefined') return [];
      return this.artworks.events
        .find((event) => event.id === Number(id)) || [];
    },
  },
  watch: {
    $route: {
      immediate: true,
      deep: true,
      handler(route) {
        this[FETCH_ARTWORKS]();
        const { id } = route.params;
        if (id) {
          this[FETCH_ARTWORK_EVENTS]({ id: Number(id) });
        }
      },
    },
  },
  beforeMount() {
    this.displayIntroLoader();
  },
  beforeDestroy() {
    this.clearTimeout();
  },
  methods: {
    displayIntroLoader() {
      this.isLoading = true;
      this.setTimeout(() => {
        this.isLoading = false;
      });
    },
    setTimeout(callback) {
      this.clearTimeout();
      this.timeout = setTimeout(() => {
        this.clearTimeout();
        callback();
      }, 2500);
    },
    clearTimeout() {
      if (this.timeout) {
        clearTimeout(this.timeout);
        this.timeout = null;
      }
    },
    ...mapActions('artworks', [FETCH_ARTWORKS, FETCH_ARTWORK_EVENTS]),
    ...mapMutations('map', ['setCenter', 'setZoom']),
    onCenterUpdate(coordinates) {
      this.setCenter(coordinates);
    },
    onZoomUpdate(value) {
      this.setZoom(value);
    },
  },
};
</script>

<style lang="scss">
/* used a distinctive html tag since css module is not supported */
samp {
  -webkit-backdrop-filter: blur(4px);
  backdrop-filter: blur(4px);
}
</style>
