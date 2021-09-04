<template>
  <BButton
    v-bind="$attrs"
    :disabled="loading"
    v-on="$listeners"
  >
    <span class="d-inline-flex align-items-center">
      <span>
        <slot />
      </span>

      <b-spinner
        v-show="loading"
        class="mx-2"
        small
      />
    </span>
  </BButton>
</template>

<script>
import { BButton, BSpinner } from 'bootstrap-vue';

export default {
  components: { BButton, BSpinner },
  props: {
    loading: {
      type: Boolean,
      default: false,
    },
  },
};
</script>
