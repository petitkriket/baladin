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
            <TheRegistrationForm @submit="handleRegistration" />
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import { BCard } from 'bootstrap-vue';
import { mapActions } from 'vuex';

import passengerService from '../api/models/passenger';
import { SIGN_UP_AND_CONTRIBUTE } from '../store/modules/user/actions-types';

import TheRegistrationForm from '../components/TheRegistrationForm.vue';

export default {
  components: {
    BCard,
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
  methods: {
    ...mapActions('user', [SIGN_UP_AND_CONTRIBUTE]),
    handleRegistration(registrationData) {
      const { artwork: { id }, $i18n } = this;
      const payload = { ...registrationData };

      payload.eventData.passengerId = id;
      payload.userData.locale = $i18n.locale;

      this[SIGN_UP_AND_CONTRIBUTE](registrationData)
        .then(() => {
          this.$router.push('/');
        }).catch((err) => {
          console.log(err);
        });
    },
    setArtwork(artwork) {
      this.artwork = artwork;
    },
  },
};
</script>
