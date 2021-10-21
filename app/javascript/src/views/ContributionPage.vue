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
            <BRow>
              <BCol>
                <p
                  v-if="artwork"
                  class="lead"
                >
                  {{ $t('contributionCreatePage.congratulations', { n: artwork.name }) }}
                  <br>
                  {{ $t('contributionCreatePage.explaination') }}
                </p>
                <p class="py-4 text-muted">
                  {{ $t('contributionCreatePage.alreadyContributed') }}
                  <br>
                  <BLink
                    class="text-warning"
                    @click="onReccuringContributon"
                  >
                    {{ $t('contributionCreatePage.loginFirst') }}
                  </BLink>
                </p>
              </BCol>
              <BCol
                sm="3"
                offset-md="2"
              >
                <TheLocaleSelect size="sm" />
              </BCol>
            </BRow>

            <TheRegistrationForm @submit="handleRegistration" />
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import { BCard, BLink } from 'bootstrap-vue';
import { mapActions, mapGetters } from 'vuex';

import passengerService from '../api/models/passenger';
import { SIGN_UP_AND_CONTRIBUTE } from '../store/modules/user/actions-types';
import { IS_AUTHENTIFIED } from '../store/modules/user/getters';

import TheLocaleSelect from '../components/TheLocaleSelect.vue';
import TheRegistrationForm from '../components/TheRegistrationForm.vue';

export default {
  components: {
    BCard,
    BLink,
    TheLocaleSelect,
    TheRegistrationForm,
  },
  metaInfo() {
    return {
      title: this.$t('contributionCreatePage.registerYourContribution'),
    };
  },
  beforeRouteEnter(to, from, next) {
    const { shortcode } = to.params;
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
  computed: {
    ...mapGetters('user', [IS_AUTHENTIFIED]),
  },
  beforeMount() {
    if (this[IS_AUTHENTIFIED]) {
      this.onReccuringContributon();
    }
  },
  methods: {
    ...mapActions('user', [SIGN_UP_AND_CONTRIBUTE]),
    handleRegistration(registrationData) {
      const { artwork: { id }, $i18n } = this;
      if (!id) {
        this.onSubmissionError();
        return;
      }

      const payload = { ...registrationData };
      payload.eventData.passengerId = id;
      payload.userData.locale = $i18n.locale;

      this[SIGN_UP_AND_CONTRIBUTE](registrationData)
        .then(() => {
          this.onSubmissionSuccess();
        }).catch(() => {
          this.onSubmissionError();
        });
    },
    setArtwork(artwork) {
      this.artwork = artwork;
    },
    onReccuringContributon() {
      const { shortcode } = this.$route.params;
      this.$router.push({
        path: '/dashboard/contributions/new',
        query: { shortcode },
      });
    },
    onSubmissionSuccess() {
      this.$root.$bvToast.toast(this.$t('contributionCreatePage.emailSent'), { variant: 'success', title: this.$t('contributionCreatePage.congrats') });
      this.$router.push('/');
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
