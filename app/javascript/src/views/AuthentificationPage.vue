<template>
  <BRow>
    <BCol>
      <h1 class="py-4">
        {{ $t('authentificationPage.signIn') }}
      </h1>

      <BCard
        bg-variant="white"
        class="mb-4"
      >
        <BCol class="mb-4">
          <h2 class="mb-4">
            {{ $t('authentificationPage.howToParticipate') }}
          </h2>
          <BRow>
            <BCol
              lg="7"
              tag="p"
            >
              {{ $t('authentificationPage.askSomeone') }}
            </BCol>
            <BCol
              lg="4"
              class="mt-sm-4 mt-lg-0"
            >
              <BButton
                variant="outline-info"
                size="sm"
                pill
                @click="findNearestContribution"
              >
                {{ $t('authentificationPage.findClosestArtwork') }}
              </BButton>
            </BCol>
          </BRow>
        </BCol>

        <hr class="w-75 mx-auto">

        <BCol>
          <TheAuthentificationForm @submit="handleAuthentification" />
        </BCol>
      </BCard>
    </Bcol>
  </BRow>
</template>

<script>
import { mapActions } from 'vuex';
import {
  BRow, BCol, BCard, BButton,
} from 'bootstrap-vue';

import { SIGN_IN } from '../store/modules/user/actions-types';
import TheAuthentificationForm from '../components/TheAuthentificationForm.vue';
import findNearestContributionMixin from '../mixins/find-nearest-contribution';

export default {
  components: {
    BRow,
    BCol,
    BCard,
    BButton,
    TheAuthentificationForm,
  },
  mixins: [findNearestContributionMixin],
  metaInfo() {
    return {
      title: this.$t('authentificationPage.signIn'),
    };
  },
  methods: {
    ...mapActions('user', [SIGN_IN]),
    handleAuthentification(authentificationData) {
      const payload = { user: { ...authentificationData } };
      this[SIGN_IN](payload).then(() => {
        this.$router.push('/dashboard/contributions');
      });
    },
  },
};
</script>
