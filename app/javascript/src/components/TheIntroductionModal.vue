<template>
  <b-modal
    id="introduction-modal"
    ref="introduction-modal"
    content-class="p-4"
    size="lg"
    centered
    no-fade
    hide-header-close
    no-close-on-esc
    no-close-on-backdrop
  >
    <template #modal-header>
      <h1>{{ $t('projectTitle') }}</h1>
    </template>
    <p class="lead">
      {{ $t('introductionModal.firstParagraph') }}
    </p>
    <br>
    <p class="lead">
      {{ $t('introductionModal.secondParagraph') }}
    </p>

    <template #modal-footer>
      <div class="w-100">
        <b-button
          variant="primary"
          size="lg"
          @click="closeModal"
        >
          {{ $t('introductionModal.confirm') }}
        </b-button>
      </div>
    </template>
  </b-modal>
</template>

<script>
import { BModal, VBModal, BButton } from 'bootstrap-vue';

export default {
  directives: { 'b-modal': VBModal },
  components: {
    BModal,
    BButton,
  },
  methods: {
    openModal() {
      this.$refs['introduction-modal'].show();
    },
    closeModal() {
      this.$emit('consent'); // TODO: RGPD Consent should be explicit and optional
      this.$refs['introduction-modal'].hide();
    },
  },
};
</script>
