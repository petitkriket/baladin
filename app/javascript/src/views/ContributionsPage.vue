<template>
  <BCol>
    <h1 class="py-4">
      {{ $tc('contributionsPage.yourContributions', user.contributions) }}
    </h1>
    <div>
      <ContributionCard
        v-for="contribution in user.contributions"
        :key="contribution.id"
        :contribution="contribution"
      />
    </div>
  </BCol>
</template>

<script>
import { mapActions, mapState } from 'vuex';

import { BCol } from 'bootstrap-vue';
import ContributionCard from '../components/ContributionCard.vue';
import { FETCH_USER_CONTRIBUTIONS } from '../store/modules/user/actions-types';

export default {
  components: { BCol, ContributionCard },
  metaInfo() {
    return {
      title: this.$tc('contributionsPage.yourContributions', this.user.contributions),
    };
  },
  computed: {
    ...mapState(['user', ['contributions']]),
  },
  mounted() {
    this.handleContributionFetching();
  },
  methods: {
    ...mapActions('user', [FETCH_USER_CONTRIBUTIONS]),
    handleContributionFetching() {
      this[FETCH_USER_CONTRIBUTIONS]();
    },
  },
};
</script>
