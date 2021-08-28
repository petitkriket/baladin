<template>
  <BContainer>
    <BRow>
      <BCol>
        <h1 class="py-4">
          {{ $t('artworksPage.objects') }}
        </h1>
      </BCol>

      <div class="w-100" />

      <BCol
        v-for="artwork in artworks.artworks"
        :key="artwork.id"
        cols="4"
        class="pb-3"
      >
        <BImgLazy
          :src="artwork.photo.medium.url"
          class="artwork-image"
          :width="210"
          :height="140"
          blank-color="#f2f2f2"
          fluid
          blank
        />
        <p class="font-weight-bold mb-0">
          {{ $tc('artworksPage.name', artwork.name) }}
        </p>
        <span class="small">
          {{ artwork.createdAt | formatDate('YYYY') }}
        </span>
      </BCol>
    </BRow>
  </BContainer>
</template>

<script>
import { mapState } from 'vuex';
import { BImgLazy } from 'bootstrap-vue';

import { formatDate } from '../filters/format-date';

export default {
  filters: { formatDate },
  components: {
    BImgLazy,
  },
  metaInfo() {
    return {
      title: this.$t('artworksPage.objects'),
    };
  },
  computed: {
    ...mapState([
      'artworks', ['artworks'],
    ]),
  },
};
</script>

<style lang="scss">
img.artwork-image {
  object-fit: cover;
  max-height: 140px;
}
</style>
