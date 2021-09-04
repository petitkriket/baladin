<template>
  <BContainer>
    <BRow>
      <BCol>
        <h1 class="py-4">
          {{ $t('notFoundPage.pageNotFound') }}
        </h1>

        <BCard
          bg-variant="white"
          class="mb-4"
        >
          <BCol>
            {{ $t('notFoundPage.doesNotExist') }}
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import { BCard } from 'bootstrap-vue';

export default {
  components: {
    BCard,
  },
  metaInfo() {
    return {
      title: this.$t('notFoundPage.pageNotFound'),
    };
  },
};
</script>
