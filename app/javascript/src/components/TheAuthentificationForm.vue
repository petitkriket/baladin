<template>
  <BForm @submit="onSubmit">
    <h2 class="py-4">
      {{ $t('authentificationPage.alreadyRegistered') }}
    </h2>
    {{ $t('authentificationPage.reservedToParticipants') }}
    <BInputGroup class="my-4">
      <BFormInput
        id="email"
        v-model.trim="$v.form.email.$model"
        :state="validateInput('email')"
        type="email"
        autocomplete="username"
        size="lg"
        :placeholder="$t('authentificationPage.email')"
      />
    </BInputGroup>

    <BInputGroup class="my-4">
      <BFormInput
        id="password"
        v-model="$v.form.password.$model"
        :state="validateInput('password')"
        type="password"
        autocomplete="on"
        size="lg"
        :placeholder="$t('authentificationPage.password')"
      />
    </BInputGroup>

    <BLink to="/password-recovery">
      <u>
        {{ $t('authentificationPage.forgottenPassword') }}
      </u>
    </BLink>

    <p
      v-if="failed"
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
import { required, minLength, email } from 'vuelidate/lib/validators';

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
  validations: {
    form: {
      email: {
        required,
        email,
      },
      password: {
        required,
        minLength: minLength(6),
      },
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
  methods: {
    validateInput(name) {
      const { $dirty, $error } = this.$v.form[name];
      return $dirty ? !$error : null;
    },
    onSubmit(event) {
      event.preventDefault();
      this.$v.form.$touch();
      if (this.$v.form.$anyError) {
        return;
      }

      this.$emit('submit', this.form);
    },
    handleFormReset() {
      this.form = { email: null, password: null };

      this.$nextTick(() => {
        this.$v.$reset();
      });
    },
  },
};
</script>
