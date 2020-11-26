<template>
  <div>
    {{ artworks.list.length }} Artworks loaded...
  </div>
</template>

<script>
import { mapActions, mapGetters, mapState } from 'vuex';
import { FETCH_ARTWORKS } from '@/store/modules/artworks/actions-types';
import { ARTWORKS_CURRENT_EVENTS } from '@/store/modules/artworks/getters-types';

export default {
  computed: {
    ...mapState(['artworks', ['list'],
    ]),
    ...mapGetters('artworks', [
      ARTWORKS_CURRENT_EVENTS,
    ]),
  },
  mounted() {
    this[FETCH_ARTWORKS]();
  },
  methods: {
    ...mapActions('artworks', [FETCH_ARTWORKS]),
  },
};
</script>
