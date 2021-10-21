<template>
  <BContainer>
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
              <BCol lg="7">
                {{ $t('authentificationPage.askSomeone') }}
              </BCol>
              <BCol
                lg="4"
                class="mt-sm-4 mt-lg-0"
              >
                <BaseLoaderButton
                  variant="outline-info"
                  size="sm"
                  pill
                  :loading="pendingForGeolocation"
                  @click="findNearestContribution"
                >
                  {{ $t('authentificationPage.findClosestArtwork') }}
                </BaseLoaderButton>
              </BCol>
            </BRow>
          </BCol>

          <hr class="w-75 mx-auto">

          <BCol>
            <TheAuthentificationForm
              :failed="loginHasFailed"
              @submit="handleAuthentification"
            />
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import { mapActions } from 'vuex';
import { BCard } from 'bootstrap-vue';

import { SIGN_IN } from '../store/modules/user/actions-types';

import TheAuthentificationForm from '../components/TheAuthentificationForm.vue';
import BaseLoaderButton from '../components/BaseLoaderButton.vue';
import findNearestContributionMixin from '../mixins/find-nearest-contribution';

export default {
  name: 'AuthentificationPage',
  components: {
    BCard,
    BaseLoaderButton,
    TheAuthentificationForm,
  },
  mixins: [findNearestContributionMixin],
  metaInfo() {
    return {
      title: this.$t('authentificationPage.signIn'),
    };
  },
  data() {
    return {
      form: {
        email: null,
      },
      loginHasFailed: false,
    };
  },
  beforeDestroy() {
    this.resetLoginStatus();
  },
  methods: {
    ...mapActions('user', [SIGN_IN]),
    resetLoginStatus() {
      this.loginHasFailed = false;
    },
    handleAuthentification(authentificationData) {
      const payload = { user: { ...authentificationData } };
      this[SIGN_IN](payload).then(() => {
        this.$router.push(this.$route.query.redirectTo || '/dashboard/contributions');
      }).catch(() => {
        this.loginHasFailed = true;
      });
    },
  },
};
</script>
