<template>
  <BCard
    bg-variant="white"
    class="mb-4"
    body-class="d-flex"
  >
    <template v-if="contribution.published">
      <BImgLazy
        :src="contribution.photo.medium.url"
        class="contribution-image"
        :width="210"
        :height="210"
        blank-color="#f2f2f2"
        fluid
        blank
      />
      <BCol>
        <p class="font-weight-bold m-0">
          {{ $tc('artworksPage.name', contribution.passenger.name) }}
        </p>
        <p class="m-0">
          {{ $t('contributionsPage.localisation') }}
          {{ contribution.address }},
          {{ contribution.city }},
          {{ contribution.country }}
        </p>
        <p class="m-0">
          {{ $t('contributionsPage.registredAt') }}
          {{ contribution.createdAt | formatDate('LL') }}
        </p>
        <BButton
          class="mt-4"
          variant="primary"
          size="lg"
          :to="{ path: `/dashboard/contributions/${contribution.id}/edit` }"
        >
          {{ $t('contributionsPage.edit') }}
        </BButton>
      </BCol>
    </template>

    <template v-else>
      {{ $t('contributionsPage.pendingValidation') }}
    </template>
  </BCard>
</template>

<script>
import { BImgLazy, BCard, BButton } from 'bootstrap-vue';

import { formatDate } from '../filters/format-date';

export default {
  filters: { formatDate },
  components: {
    BImgLazy,
    BCard,
    BButton,
  },
  props: {
    contribution: {
      type: Object,
      default: () => {},
    },
  },
};
</script>

<style lang="scss">
img.contribution-image {
  object-fit: cover;
  max-height: 210px;
}
</style>
