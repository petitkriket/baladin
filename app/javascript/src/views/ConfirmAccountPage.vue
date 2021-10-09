<template>
  <BContainer>
    <BRow>
      <BCol>
        <h1 class="py-4">
          {{ $t('confirmAccountPage.accountConfirmation') }}
        </h1>

        <BCard
          bg-variant="white"
          class="mb-4"
        >
          <BCol>
            <PhCheckCircle
              :size="64"
              class="mr-2"
            />
            <span class="lead">
              {{ $t('confirmAccountPage.confirmed') }}
            </span>
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import { BCard } from 'bootstrap-vue';
import { PhCheckCircle } from 'phosphor-vue';
import { mapMutations } from 'vuex';

import userAccountService from '../api/models/user-account';
import { SET_USER, SET_TOKEN } from '../store/modules/user/mutations-types';

export default {
  name: 'ConfirmAccountPage',
  components: {
    BCard,
    PhCheckCircle,
  },
  metaInfo() {
    return {
      title: this.$t('confirmAccountPage.accountConfirmation'),
    };
  },
  data() {
    return {
      redirectionTimeOut: null,
    };
  },
  created() {
    this.confirmAccount();
  },
  methods: {
    ...mapMutations('user', [SET_USER, SET_TOKEN]),
    confirmAccount() {
      const params = { confirmation_token: this.$route.query.confirmation_token };
      userAccountService.confirm(params).then((response) => {
        this[SET_USER](response.data.user);
        this[SET_TOKEN](response.headers.authorization);
        this.toContributions();
      }).catch(() => {
        this.toAuthentification();
      });
    },
    toContributions() {
      const delayInMs = 2500;
      setTimeout(() => {
        this.$router.push({ path: '/dashboard/contributions' });
      }, delayInMs);
    },
    toAuthentification() {
      this.$bvToast.toast(this.$t('confirmAccountPage.alreadyConfirmed'));
      this.$router.push({ path: '/authentification' });
    },
  },
};
</script>
