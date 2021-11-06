<template>
  <BCol>
    <h1 class="py-4">
      {{ $t('contributionEditPage.title', { name: passengerName }) }}
    </h1>

    <BCard
      bg-variant="white"
      class="mb-4"
    >
      <ContributionEditForm
        ref="form"
        :contribution="contribution"
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
        @click="toContributions"
      >
        {{ $t('contributionEditPage.cancel') }}
      </BButton>
    </BCard>
  </BCol>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import { BCard, BButton } from 'bootstrap-vue';

import { FETCH_USER_CONTRIBUTIONS, UPDATE_USER_CONTRIBUTION } from '../store/modules/user/actions-types';
import ContributionEditForm from '../components/ContributionEditForm.vue';

export default {
  name: 'ContributionEditPage',
  components: {
    BCard, BButton, ContributionEditForm,
  },
  metaInfo() {
    return {
      title: this.$t('contributionsPage.edition'),
    };
  },
  computed: {
    ...mapState(['user', ['contributions']]),
    contribution() {
      const { id } = this.$route.params;
      return this.user.contributions
        .find((contribution) => contribution.id === Number(id));
    },
    passengerName() {
      return this.contribution?.passenger?.name;
    },
  },
  created() {
    this[FETCH_USER_CONTRIBUTIONS]();
  },
  methods: {
    ...mapActions('user', [UPDATE_USER_CONTRIBUTION, FETCH_USER_CONTRIBUTIONS]),
    triggerSubmission() {
      this.$refs.form.emitSubmission();
    },
    handleContributionSubmission(contribution) {
      const { id } = this.$route.params;
      const event = { id, ...contribution };
      this[UPDATE_USER_CONTRIBUTION](event).then(() => {
        this.confirmEdition();
      }).catch((err) => {
        this.handleFailure(err);
      });
    },
    toContributions() {
      this.$router.push({ name: 'Contribution List' });
    },
    confirmEdition() {
      // circumvent bug: toast not displayed if route and toast are triggered at same time
      const delayInMs = 1;
      this.toContributions();
      setTimeout(() => {
        this.$bvToast.toast(this.$t('contributionEditPage.editsSaved'), { variant: 'success' });
      }, delayInMs);
    },
    handleFailure(err) {
      this.$bvToast.toast(err, { variant: 'danger' });
    },
  },
};
</script>
