<template>
  <BCol>
    <h1 class="py-4">
      {{ $tc('contributionEditPage.title', passengerName) }}
    </h1>

    <BCard
      bg-variant="white"
      class="mb-4"
    >
      <ContributionEditForm
        ref="form"
        @submission="handleContributionSubmission"
      />
    </Bcard>

    <BCard
      bg-variant="light border-0"
      class="mb-4"
    >
      <BButton
        variant="primary"
        size="lg"
        @click="triggerSubmission"
      >
        {{ $t('contributionEditPage.save') }}
      </BButton>

      <BButton
        variant="outline-secondary"
        size="lg"
        class="ml-2"
        @click="cancelEdition"
      >
        {{ $t('contributionEditPage.cancel') }}
      </BButton>
    </BCard>
  </BCol>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import { BCol, BCard, BButton } from 'bootstrap-vue';

import { UPDATE_USER_CONTRIBUTION } from '../store/modules/user/actions-types';
import ContributionEditForm from '../components/ContributionEditForm.vue';

export default {
  components: {
    BCol, BCard, BButton, ContributionEditForm,
  },
  metaInfo() {
    return {
      titleTemplate: null,
      title: this.$t('contributionsPage.edition'),
    };
  },
  computed: {
    ...mapState(['user', ['contributions']]),
    passengerName() {
      const { id: contributionId } = this.$route.params;
      const event = this.user.contributions
        .find((obj) => obj.id === Number(contributionId));

      const passengerName = event?.passenger?.name;

      return passengerName || null;
    },
  },
  methods: {
    ...mapActions('user', [UPDATE_USER_CONTRIBUTION]),
    triggerSubmission() {
      this.$refs.form.emitSubmission();
    },
    handleContributionSubmission(contribution) {
      const { id } = this.$route.params;
      const event = { id, ...contribution };
      this[UPDATE_USER_CONTRIBUTION](event);
    },
    cancelEdition() {
      this.$router.push({ name: 'Contribution List' });
    },
  },
};
</script>
