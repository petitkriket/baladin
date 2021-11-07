<template>
  <b-modal
    id="artwork-claim-modal"
    ref="artwork-claim-modal"
    content-class="p-4"
    size="lg"
    centered
    no-fade
    no-close-on-esc
    no-close-on-backdrop
  >
    <template #modal-header="{ close }">
      <h4>
        {{ $t('claimModal.claim') }}
      </h4>
      <b-link @click="close">
        {{ $t('claimModal.close') }}
      </b-link>
    </template>

    <div>
      <span
        v-if="!isLoading && !claimWasMade"
        class="lead"
      >
        {{ hint }}
      </span>

      <b-alert
        v-if="claimWasMade"
        v-bind="alertProps"
        show
      >
        {{ alertProps.message }}
      </b-alert>
    </div>

    <ArtworkClaimForm
      ref="form"
      @submission="handleClaim"
    />

    <template #modal-footer>
      <div class="d-flex">
        <b-button
          variant="outline-secondary"
          size="lg"
          class="mr-4"
          @click="closeModal"
        >
          {{ $t('claimModal.cancel') }}
        </b-button>

        <BaseLoaderButton
          :variant="buttonProps.variant"
          :loading="isLoading"
          size="lg"
          v-on="buttonProps.on"
        >
          {{ buttonProps.label }}
        </BaseLoaderButton>
      </div>
    </template>
  </b-modal>
</template>

<script>
import {
  BModal, VBModal, BButton, BAlert, BLink,
} from 'bootstrap-vue';

import passengerService from '../api/models/passenger';
import ArtworkClaimForm from './ArtworkClaimForm.vue';
import BaseLoaderButton from './BaseLoaderButton.vue';

export default {
  directives: { 'b-modal': VBModal },
  components: {
    BModal,
    BButton,
    BLink,
    BAlert,
    ArtworkClaimForm,
    BaseLoaderButton,
  },
  props: {
    artwork: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      isLoading: false,
      claimWasMade: false,
      claimWasSuccess: false,
    };
  },
  computed: {
    hint() {
      const dataIsAvailable = Object.keys(this.artwork).length > 0;
      if (dataIsAvailable) {
        const { name } = this.artwork.lastValidatedEvent.user;
        const { city, country } = this.artwork.lastValidatedEvent;
        return this.$t('claimModal.help', {
          name,
          city,
          country,
        });
      }
      return '';
    },
    claimSucceed() {
      return this.claimWasSuccess === true && !this.isLoading;
    },
    claimFailed() {
      return this.claimWasSuccess === false && !this.isLoading;
    },
    alertProps() {
      return this.claimSucceed && this.claimWasMade ? {
        variant: 'success',
        message: this.$t('claimModal.messageSent'),
      } : {
        variant: 'danger',
        message: this.$t('claimModal.messageFailed'),
      };
    },
    buttonProps() {
      if (!this.claimWasMade) {
        return {
          variant: this.isLoading ? 'success' : 'primary',
          label: this.isLoading ? this.$t('claimModal.inProgress') : this.$t('claimModal.send'),
          on: {
            click: this.triggerForm,
          },
        };
      }
      return this.claimSucceed && this.claimWasMade ? {
        variant: 'success',
        label: this.$t('claimModal.close'),
        on: {
          click: this.closeModal,
        },
      } : {
        variant: 'danger',
        label: this.$t('claimModal.retry'),
        on: {
          click: this.triggerForm,
        },
      };
    },
  },
  methods: {
    openModal() {
      this.$refs['artwork-claim-modal'].show();
    },
    closeModal() {
      this.$emit('closed');
      this.$refs['artwork-claim-modal'].hide();
    },
    triggerForm() {
      this.$refs.form.emitSubmission();
    },
    handleClaim(formData) {
      const { id } = this.$route.params;
      const claim = { ...formData };

      this.isLoading = true;

      passengerService.claim(id, claim)
        .then(() => {
          this.claimWasSuccess = true;
          this.refs.form.cleanForm();
        }).catch(() => {
          this.claimWasFailure = true;
        }).finally(() => {
          setTimeout(() => {
            this.claimWasMade = true;
            this.isLoading = false;
          }, 500);
        });
    },
  },
};
</script>
