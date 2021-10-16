<template>
  <BForm @submit="onSubmit">
    <BFormGroup
      id="input-group-1"
      :label="$t('accountSettingsPage.name')"
      label-for="input-1"
      :description="$t('accountSettingsPage.nameHelp')"
      size="lg"
    >
      <BFormInput
        id="input-1"
        v-model="form.name"
        :state="validateInput('name')"
        :placeholder="$t('accountSettingsPage.name')"
        size="lg"
        required
        trim
      />

      <b-form-invalid-feedback :state="!!$v.form.name.required">
        {{ $t('accountSettingsPage.fieldIsRequired') }}
      </b-form-invalid-feedback>
    </BFormGroup>

    <BFormGroup
      id="input-group-2"
      :label="$t('accountSettingsPage.email')"
      label-for="input-2"
      size="lg"
    >
      <BFormInput
        id="input-2"
        v-model="form.email"
        :state="validateInput('email')"
        type="email"
        size="lg"
        autocomplete="username"
        required
        trim
      />

      <BFormText id="input-2-help-1">
        {{ $t('accountSettingsPage.emailHelp') }}
      </BFormText>

      <BFormText id="input-2-help-2">
        {{ $t('accountSettingsPage.emailHelp2') }}
      </BFormText>

      <b-form-invalid-feedback :state="!!$v.form.email.required">
        {{ $t('accountSettingsPage.fieldIsRequired') }}
      </b-form-invalid-feedback>

      <b-form-invalid-feedback :state="!!$v.form.email.email">
        {{ $t('accountSettingsPage.emailIsInvalid') }}
      </b-form-invalid-feedback>
    </BFormGroup>

    <BFormGroup
      id="input-group-3"
      :label="$t('accountSettingsPage.language')"
      :description="$t('accountSettingsPage.preferedLanguage')"
      label-for="input-3"
      size="lg"
    >
      <BFormSelect
        id="input-3"
        v-model="form.locale"
        :options="localeOptions"
        size="lg"
        required
      />
    </BFormGroup>

    <BFormGroup
      id="input-group-4"
      :label="$t('accountSettingsPage.editPassword')"
      label-for="input-4"
      size="lg"
    >
      <BFormInput
        id="input-4"
        v-model="form.password"
        :state="validateInput('password')"
        type="password"
        size="lg"
        autocomplete="new-password"
        :placeholder="$t('accountSettingsPage.password')"
      />

      <b-form-invalid-feedback :state="!!$v.form.password.minLength">
        {{ $t('accountSettingsPage.passwordTooShort') }}
      </b-form-invalid-feedback>
    </BFormGroup>

    <BFormGroup
      class="my-2"
      size="lg"
    >
      <BFormInput
        id="input-5"
        v-model="form.passwordConfirmation"
        :state="validateInput('passwordConfirmation')"
        type="password"
        size="lg"
        autocomplete="new-password"
        :placeholder="$t('accountSettingsPage.passwordConfirmation')"
      />

      <b-form-invalid-feedback :state="!!$v.form.passwordConfirmation.sameAsPassword">
        {{ $t('accountSettingsPage.passwordIsDifferent') }}
      </b-form-invalid-feedback>
    </BFormGroup>

    <BButton
      type="submit"
      variant="primary"
    >
      {{ $t('accountSettingsPage.save') }}
    </BButton>
  </BForm>
</template>

<script>
import {
  BForm, BFormInput, BFormText, BFormSelect, BButton, BFormGroup, BFormInvalidFeedback,
} from 'bootstrap-vue';
import {
  required, email, minLength, sameAs,
} from 'vuelidate/lib/validators';

export default {
  components: {
    BForm,
    BFormGroup,
    BFormInput,
    BFormInvalidFeedback,
    BFormText,
    BFormSelect,
    BButton,
  },
  props: {
    user: {
      type: Object,
      default: () => {},
    },
    pending: {
      type: Boolean,
      default: false,
    },
  },
  validations: {
    form: {
      name: {
        required,
      },
      email: {
        required,
        email,
      },
      password: {
        minLength: minLength(6),
      },
      passwordConfirmation: {
        sameAsPassword: sameAs('password'),
      },
    },
  },
  data() {
    return {
      form: {
        name: null,
        email: null,
        locale: null,
        password: null,
        passwordConfirmation: null,
      },
    };
  },
  computed: {
    localeOptions() {
      return this.$i18n.availableLocales.map((locale) => ({
        text: locale.toUpperCase(),
        value: locale,
      }));
    },
  },
  watch: {
    user: {
      immediate: true,
      deep: true,
      handler(userObject) {
        const isUserFetched = userObject
        && Object.keys(userObject).length !== 0
        && userObject.constructor === Object;

        if (isUserFetched) this.fillForm();
      },
    },
  },
  beforeDestroy() {
    this.resetForm();
  },
  methods: {
    fillForm() {
      const { user: { email: userEmail, name, locale } } = this;
      this.form = { email: userEmail, name, locale };
    },
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
      this.$emit('submission', this.form);
    },
    resetForm() {
      this.form = {
        name: null, email: null, locale: null, password: null, passwordConfirmation: null,
      };

      this.$nextTick(() => {
        this.$v.$reset();
      });
    },
  },
};
</script>
