<template>
  <BOverlay
    :show="isLoading"
    opacity="0.05"
    spinner-variant="primary"
    :z-index="555"
    overlay-tag="samp"
    no-fade
  >
    <transition name="slide-fade">
      <ArtworkCard
        v-if="displayedArtwork"
        :key="$route.params.id"
        :artwork="displayedArtwork"
        :minimized="minimizedArtwork"
        @previous="cycleArtwork('previous')"
        @next="cycleArtwork('next')"
        @minimized="toggleArtworkCard"
      />
    </transition>
    <BaseMapContainer
      :last-position-markers="activeArtworks"
      :history-markers="history.events"
      :locale="$i18n.locale"
      :center="map.center"
      :zoom="map.zoom"
      :user-position="userPosition"
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
import ArtworkCard from './ArtworkCard.vue';

export default {
  components: { BOverlay, BaseMapContainer, ArtworkCard },
  data() {
    return {
      timeout: null,
      isLoading: true,
      minimizedArtwork: false,
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
    displayedArtwork() {
      const { id } = this.$route.params;
      if (id && this.artworks) {
        return this.artworks.artworks.find((artwork) => artwork.id === Number(id));
      }
      return null;
    },
    history() {
      const { id } = this.$route.params;
      if (typeof id === 'undefined') return [];
      return this.artworks.events
        .find((event) => event.id === Number(id)) || [];
    },
    userPosition() {
      if (this.map.userPosition) {
        return this.map.userPosition;
      }
      return null;
    },
  },
  watch: {
    $route: {
      immediate: true,
      deep: true,
      handler(route) {
        const { id } = route.params;
        if (id) {
          this[FETCH_ARTWORK_EVENTS]({ id: Number(id) });
        }
      },
    },
  },
  beforeMount() {
    this.displayIntroLoader();
    if (this.artworks?.artworks.length === 0) {
      this[FETCH_ARTWORKS]();
    }
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
    toggleArtworkCard() {
      this.minimizedArtwork = !this.minimizedArtwork;
    },
    cycleArtwork(direction) {
      const ids = this.artworks.artworks.map(({ id }) => id);
      const artworksCount = ids.length;
      const currentArtworkIndex = ids.findIndex((id) => id === Number(this.$route.params.id));

      const previous = ids[(currentArtworkIndex + artworksCount - 1) % artworksCount];
      const next = ids[(currentArtworkIndex + 1) % artworksCount];

      if (direction === 'previous' && previous) {
        this.$router.push({ path: `/passenger/${previous}` });
      }

      if (direction === 'next' && next) {
        this.$router.push({ path: `/passenger/${next}` });
      }
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

.slide-fade-enter-active {
  transition: all 800ms ease;
}

.slide-fade-leave-active {
  transition: all 0.8s cubic-bezier(1, 0.5, 0.8, 1);
}

.slide-fade-enter,
.slide-fade-leave-to {
  opacity: 0;
  transform: translateX(50%);
}
</style>
