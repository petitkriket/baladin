<template>
  <BCol
    sm="12"
    md="5"
    lg="4"
    xl="3"
    class="position-absolute artwork-detail"
  >
    <div
      class="d-flex flex-column rounded bg-white border"
    >
      <template>
        <BImgLazy
          :src="artwork.photo.large.url"
          :alt="$t('mapPage.artworkDetail.photo')"
          blank-color="#f2f2f2"
          :blank-height="250"
          :height="250"
          fluid
        />
        <h4 class="m-4">
          {{ $tc('mapPage.artworkDetail.title', artwork.name) }}
        </h4>

        <BButton
          class="mx-4 mb-4"
          variant="primary"
          pill
          @click="showClaimModal"
        >
          {{ $t('mapPage.artworkDetail.claimIt') }}
        </BButton>

        <div class="bg-light p-4 border-top font-weight-light">
          <p class="mb-1 d-flex justify-content-between align-items-center px-3">
            <span class="text-uppercase">
              {{ $t('mapPage.artworkDetail.releaseDate') }}
            </span>

            <span class="text-muted font-italic">
              {{ artwork.createdAt | formatDate('L') }}
            </span>
          </p>
          <hr>
          <p class="mb-1 d-flex justify-content-between align-items-center px-3">
            <span class="text-uppercase">
              {{ $t('mapPage.artworkDetail.carrier') }}
            </span>

            <span class="text-muted font-italic">
              {{ artwork.lastValidatedEvent.user.name }}
            </span>
          </p>
          <hr>
          <p class="mb-1 d-flex justify-content-between align-items-center px-3">
            <span class="text-uppercase">
              {{ $t('mapPage.artworkDetail.currentLocation') }}
            </span>

            <span class="text-muted font-italic">
              {{ artwork.lastValidatedEvent.city }}
              ({{ artwork.lastValidatedEvent.country }})
            </span>
          </p>
        </div>

        <artwork-modal-claim
          ref="modalComponent"
          :artwork="artwork"
        />
      </template>
    </div>
  </BCol>
</template>

<script>
import { BImgLazy, BButton } from 'bootstrap-vue';

import { formatDate } from '../filters/format-date';
import ArtworkModalClaim from './ArtworkModalClaim.vue';

export default {
  filters: { formatDate },
  components: { BImgLazy, BButton, ArtworkModalClaim },
  props: {
    artwork: {
      type: Object,
      default: () => {},
    },
  },
  methods: {
    showClaimModal() {
      this.$refs.modalComponent.openModal();
    },
  },
};
</script>

<style lang="scss" scoped>
.artwork-detail {
  top: 15px;
  right: 0;
  z-index: 401;

  img {
    object-fit: cover;
    height: 250px;
  }
}

</style>
