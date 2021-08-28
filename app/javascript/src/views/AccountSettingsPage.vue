<template>
  <BContainer>
    <BCol>
      <h1 class="py-4">
        {{ $t('accountSettingsPage.accountSettings') }}
      </h1>

      <BCard
        bg-variant="white"
        class="mb-4"
      >
        <AccountSettingsForm
          :user="user.user"
          :pending="isLoading"
          @submission="handleUserEdit"
        />
      </BCard>

      <BCard
        bg-variant="white"
        class="mb-4"
      >
        <BButton
          variant="danger"
          @click="onDeletionRequest"
        >
          {{ $t('accountSettingsPage.deleteAccount') }}
        </BButton>
      </BCard>
    </BCol>
  </BContainer>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import { BCard, BButton } from 'bootstrap-vue';

import { UPDATE_USER_ACCOUNT, DELETE_USER_ACCOUNT } from '../store/modules/user/actions-types';
import AccountSettingsForm from '../components/AccountSettingsForm.vue';

export default {
  components: {
    BCard,
    BButton,
    AccountSettingsForm,
  },
  metaInfo() {
    return {
      title: this.$t('accountSettingsPage.accountSettings'),
    };
  },
  data() {
    return {
      isLoading: false,
    };
  },
  computed: {
    ...mapState(['user', ['user']]),
  },
  methods: {
    ...mapActions('user', [UPDATE_USER_ACCOUNT, DELETE_USER_ACCOUNT]),
    handleUserEdit(form) {
      const user = { user: { ...form } };
      this[UPDATE_USER_ACCOUNT](user);
    },
    onDeletionRequest() {
      this.$bvModal.msgBoxConfirm(this.$t('accountSettingsPage.deleteAccountWarning'), {
        okVariant: 'danger',
        title: this.$t('accountSettingsPage.deleteAccount'),
        cancelTitle: this.$t('accountSettingsPage.cancelDelete'),
        okTitle: this.$t('accountSettingsPage.confirmDelete'),
        hideHeaderClose: false,
        centered: true,
        noFade: false,
      }).then((value) => {
        if (!value) return;
        this.deleteUserAccount();
      });
    },
    deleteUserAccount() {
      this[DELETE_USER_ACCOUNT]().then(() => {
        this.$router.push('/');
      }).catch((err) => {
        console.log(err);
      });
    },
  },
};
</script>
