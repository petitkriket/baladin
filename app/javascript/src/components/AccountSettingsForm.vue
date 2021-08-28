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
        size="lg"
        placeholder="Enter name"
        required
        trim
      />
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
        type="password"
        size="lg"
        autocomplete="new-password"
        :placeholder="$t('accountSettingsPage.password')"
      />
    </BFormGroup>

    <BFormGroup
      class="my-2"
      size="lg"
    >
      <BFormInput
        id="input-5"
        v-model="form.passwordConfirmation"
        type="password"
        size="lg"
        autocomplete="new-password"
        :placeholder="$t('accountSettingsPage.passwordConfirmation')"
      />
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
  BForm, BFormInput, BFormText, BFormSelect, BButton, BFormGroup,
} from 'bootstrap-vue';

export default {
  components: {
    BForm,
    BFormGroup,
    BFormInput,
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
  data() {
    return {
      form: {
        email: null,
        name: null,
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

        if (isUserFetched) this.loadExistingUser();
      },
    },
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();
      this.$emit('submission', this.form);
    },
    loadExistingUser() {
      const { user: { email, name, locale } } = this;
      this.form = { email, name, locale };
    },
  },
};
</script>
