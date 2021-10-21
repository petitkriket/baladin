<template>
  <BContainer>
    <BRow>
      <BCol>
        <h1 class="py-4">
          {{ $t('contributionCreatePage.registerYourContribution') }}
        </h1>

        <BCard
          bg-variant="white"
          class="mb-4"
        >
          <BCol>
            <ContributionEditForm
              ref="form"
              @submission="handleContributionSubmission"
            />

            <BButton
              variant="primary"
              type="submit"
              size="lg"
              block
              @click="triggerForm"
            >
              {{ $t('contributionCreatePage.register') }}
            </BButton>
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import { BCard, BButton } from 'bootstrap-vue';
import { mapActions } from 'vuex';

import passengerService from '../api/models/passenger';
import { CREATE_USER_CONTRIBUTION } from '../store/modules/user/actions-types';

import ContributionEditForm from '../components/ContributionEditForm.vue';

export default {
  name: 'ContributionNewPage',
  components: {
    BCard,
    BButton,
    ContributionEditForm,
  },
  metaInfo() {
    return {
      title: this.$t('contributionCreatePage.registerYourContribution'),
    };
  },
  beforeRouteEnter(to, from, next) {
    const { shortcode } = to.query;
    passengerService.findByShortcut(shortcode)
      .then((response) => {
        const foundAMatch = response.data !== null;
        if (foundAMatch) {
          next((vm) => vm.setArtwork(response.data));
        } else {
          next({ name: 'NotFound' });
        }
      })
      .catch(() => {
        next({ name: 'NotFound' });
      });
  },
  data() {
    return {
      artwork: null,
    };
  },
  methods: {
    ...mapActions('user', [CREATE_USER_CONTRIBUTION]),
    setArtwork(artwork) {
      this.artwork = artwork;
    },
    triggerForm() {
      this.$refs.form.emitSubmission();
    },
    handleContributionSubmission(contributionData) {
      const { shortcode } = this.$route.query;

      if (!shortcode) {
        this.onSubmissionError();
        return;
      }
      const payload = { event: { ...contributionData }, passenger: { shortcode } };
      this[CREATE_USER_CONTRIBUTION](payload)
        .then(() => {
          this.onSubmissionSuccess();
        }).catch(() => {
          this.onSubmissionError();
        });
    },
    onSubmissionSuccess() {
      this.$root.$bvToast.toast(this.$t('contributionCreatePage.contributionPendingValidation'), { variant: 'success', title: this.$t('contributionCreatePage.congrats') });
      this.$router.push('/dashboard/contributions');
    },
    onSubmissionError() {
      // TODO: add sentry notification
      // TODO: chat with the team ?
      const supportEmail = 'contact@francoismaurin.com';
      this.$root.$bvToast.toast(this.$t('contributionCreatePage.submissionError', { supportEmail }), {
        variant: 'danger',
        autoHideDelay: 10000,
        href: `mailto:${supportEmail}`,
      });
    },
  },
};
</script>
