<template>
  <BCol
    cols="10"
    md="5"
    lg="4"
    xl="3"
    class="position-absolute artwork-detail"
    :class="{['scaled'] : minimized}"
  >
    <div
      v-hammer:swipe="onSwipe"
      class="d-flex flex-column rounded bg-white border"
    >
      <div class="position-relative">
        <BImgLazy
          v-hammer:swipe="onSwipe"
          :src="artwork.photo.large.url"
          :alt="$t('mapPage.artworkDetail.photo')"
          :blank-height="250"
          :height="250"
          fluid
          blank-color="#f7f7f7"
          class="rounded-top w-100"
        />
        <div class="position-absolute fixed-bottom">
          <BButton
            size="sm"
            variant="link"
            class="float-left"
            @click="onPrevious"
          >
            <PhCaretCircleDoubleLeft
              :size="48"
              weight="thin"
            />
          </BButton>

          <BButton
            size="sm"
            variant="link"
            class="float-right"
            @click="onNext"
          >
            <PhCaretCircleDoubleRight
              :size="48"
              weight="thin"
            />
          </BButton>
        </div>

        <div class="position-absolute fixed-top">
          <BButton
            size="sm"
            variant="link"
            class="float-right"
            @click="onMinimized"
          >
            <PhArrowsOutSimple
              v-if="minimized"
              :size="32"
              weight="thin"
            />
            <PhArrowsInSimple
              v-else
              :size="32"
              weight="thin"
            />
          </BButton>
        </div>
      </div>

      <div
        v-show="!minimized"
        class="text-center bg-light border-top"
      >
        <h4 class="mt-4">
          {{ $t('mapPage.artworkDetail.title', { name: artwork.name }) }}
        </h4>

        <BButton
          variant="primary"
          pill
          class="mx-4 mb-4 shadow-lg"
          @click="showClaimModal"
        >
          {{ $t('mapPage.artworkDetail.claimIt') }}
        </BButton>

        <div class="bg-light p-2 border-top">
          <p class="mb-1 d-flex justify-content-between align-items-center px-2">
            <span>
              {{ $t('mapPage.artworkDetail.releaseDate') }}
            </span>

            <span class="text-muted font-italic">
              {{ artwork.createdAt | formatDate('L') }}
            </span>
          </p>

          <hr class="my-2">

          <p class="mb-1 d-flex justify-content-between align-items-center px-2">
            <span>
              {{ $t('mapPage.artworkDetail.carrier') }}
            </span>

            <span class="text-muted font-italic">
              {{ artwork.lastValidatedEvent.user.name }}
            </span>
          </p>

          <hr class="my-2">

          <p class="mb-1 d-flex justify-content-between align-items-center px-2">
            <span>
              {{ $t('mapPage.artworkDetail.currentLocation') }}
            </span>

            <span class="text-muted font-italic">
              {{ artwork.lastValidatedEvent.city }}
              ({{ artwork.lastValidatedEvent.country }})
            </span>
          </p>
        </div>
      </div>
    </div>
    <artwork-modal-claim
      ref="modalComponent"
      :artwork="artwork"
    />
  </BCol>
</template>

<script>
import { BImgLazy, BButton } from 'bootstrap-vue';
import {
  PhCaretCircleDoubleLeft,
  PhCaretCircleDoubleRight,
  PhArrowsInSimple,
  PhArrowsOutSimple,
} from 'phosphor-vue';

import { formatDate } from '../filters/format-date';
import ArtworkModalClaim from './ArtworkModalClaim.vue';

export default {
  name: 'ArtworkCard',
  filters: { formatDate },
  components: {
    BImgLazy,
    BButton,
    PhCaretCircleDoubleLeft,
    PhCaretCircleDoubleRight,
    PhArrowsInSimple,
    PhArrowsOutSimple,
    ArtworkModalClaim,
  },
  props: {
    artwork: {
      type: Object,
      default: () => {},
    },
    minimized: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    showClaimModal() {
      this.$refs.modalComponent.openModal();
    },
    onSwipe({ direction }) {
      if (direction === 4) {
        this.onNext();
      } else if (direction === 2) {
        this.onPrevious();
      }
    },
    onNext() {
      this.$emit('next');
    },
    onPrevious() {
      this.$emit('previous');
    },
    onMinimized() {
      this.$emit('minimized');
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

  &.scaled {
    transform: scale(0.5);
  }
}

</style>
