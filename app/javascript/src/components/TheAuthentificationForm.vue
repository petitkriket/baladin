<template>
  <BForm @submit="onSubmit">
    <h2 class="py-4">
      {{ $t('authentificationPage.alreadyRegistered') }}
    </h2>
    {{ $t('authentificationPage.reservedToParticipants') }}
    <BInputGroup class="my-4">
      <BFormInput
        id="email"
        v-model.trim="form.email"
        type="email"
        autocomplete="username"
        size="lg"
        :placeholder="$t('authentificationPage.email')"
      />
    </BInputGroup>

    <BInputGroup class="my-4">
      <BFormInput
        id="password"
        v-model="form.password"
        type="password"
        autocomplete="on"
        size="lg"
        :placeholder="$t('authentificationPage.password')"
      />
    </BInputGroup>

    <BLink to="/password-recovery">
      <u>{{ recoverLinkLabel }}</u>
    </BLink>

    <p
      v-show="failed"
      class="text-danger mt-2 mb-0"
    >
      {{ $t('authentificationPage.loginFailed') }}
    </p>

    <hr>

    <BButton
      variant="primary"
      type="submit"
      size="lg"
      block
    >
      {{ $t('authentificationPage.signIn') }}
    </BButton>
  </BForm>
</template>

<script>
import {
  BForm, BFormInput, BInputGroup, BButton, BLink,
} from 'bootstrap-vue';

export default {
  name: 'TheAuthentificationForm',
  components: {
    BForm,
    BFormInput,
    BInputGroup,
    BButton,
    BLink,
  },
  props: {
    failed: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      form: {
        email: null,
        password: null,
      },
    };
  },
  computed: {
    recoverLinkLabel() {
      return this.failed ? this.$t('authentificationPage.changePassword') : this.$t('authentificationPage.forgottenPassword');
    },
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();
      this.$emit('submit', this.form);
    },
    handleFormReset() {
      this.form = { email: null, password: null };
    },
  },
};
</script>
