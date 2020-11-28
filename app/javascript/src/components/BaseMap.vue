<template>
  <BaseMapContainer
    :last-position-markers="activeArtworks"
    :history-markers="history.events"
    :locale="user.settings.locale"
  />
</template>

<script>
import { mapActions, mapGetters, mapState } from 'vuex';
import { FETCH_ARTWORKS, FETCH_ARTWORK_EVENTS } from '@/store/modules/artworks/actions';
import { ARTWORKS_CURRENT_EVENTS } from '@/store/modules/artworks/getters';
import BaseMapContainer from '@/components/BaseMapContainer.vue';

export default {
  components: { BaseMapContainer },
  computed: {
    ...mapState([
      'artworks', ['events'],
      'user', ['settings'],
    ]),
    ...mapGetters('artworks', [
      ARTWORKS_CURRENT_EVENTS,
    ]),
    activeArtworks() {
      // const { id } = this.$route.params;
      // const activeArtwork = this[ARTWORKS_CURRENT_EVENTS]
      //   .filter((artwork) => artwork.id === Number(id));
      // if (id && this[ARTWORKS_CURRENT_EVENTS] && activeArtwork) {
      //   return [activeArtwork];
      // }
      // if (this[ARTWORKS_CURRENT_EVENTS]) {
      return this[ARTWORKS_CURRENT_EVENTS];
      // }
      // return [];
    },
    history() {
      const { id } = this.$route.params;
      if (id && this.artworks.events) {
        return this.artworks.events
          .find((event) => event.id === Number(id));
      }
      return [];
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
  methods: {
    ...mapActions('artworks', [FETCH_ARTWORKS, FETCH_ARTWORK_EVENTS]),
  },
};
</script>
