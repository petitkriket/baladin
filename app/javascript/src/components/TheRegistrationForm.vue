<template>
  <BForm @submit="onSubmit">
    <h2 class="py-2">
      {{ $t('contributionCreatePage.aboutTheObject') }}
    </h2>

    <BFormGroup
      id="input-group-1"
      :label="$t('contributionCreatePage.location')"
      label-for="location"
      :description="$t('contributionCreatePage.locationHelp')"
      size="lg"
    >
      <BaseLocationInput
        id="location"
        v-model.trim="$v.form.address.$model"
        :state="validateInput('address')"
        :placeholder="$t('contributionCreatePage.location')"
        size="lg"
      />
    </BFormGroup>

    <BFormGroup
      id="input-group-2"
      class="my-4"
      :label="$t('contributionCreatePage.photo')"
      label-for="input-2"
      :description="$t('contributionCreatePage.photoHelp')"
      size="lg"
    >
      <BFormFile
        id="input-2"
        ref="fileInput"
        v-model="form.photo"
        :state="isPhotoValid"
        accept="image/jpeg, image/png, image/gif"
        size="lg"
        capture
      />
      <b-form-invalid-feedback :state="isPhotoValid">
        {{ $t('contributionCreatePage.fileSizeError') }}
      </b-form-invalid-feedback>
    </BFormGroup>

    <h2 class="py-2">
      {{ $t('contributionCreatePage.aboutYou') }}
    </h2>

    <BFormGroup class="my-4">
      <BFormInput
        id="name"
        v-model.trim="$v.form.name.$model"
        :state="validateInput('name')"
        size="lg"
        :placeholder="$t('contributionCreatePage.name')"
      />
    </BFormGroup>

    <BFormGroup class="my-4">
      <BFormInput
        id="email"
        v-model.trim="$v.form.email.$model"
        :state="validateInput('email')"
        type="email"
        size="lg"
        :placeholder="$t('contributionCreatePage.email')"
      />
    </BFormGroup>

    <BFormGroup class="my-4">
      <BFormInput
        id="password"
        v-model="$v.form.password.$model"
        :state="validateInput('password')"
        type="password"
        size="lg"
        autocomplete="on"
        :placeholder="$t('contributionCreatePage.password')"
      />
    </BFormGroup>

    <BFormGroup class="my-4">
      <BFormInput
        id="password-confirmation"
        v-model="$v.form.passwordConfirmation.$model"
        :state="validateInput('passwordConfirmation')"
        type="password"
        size="lg"
        autocomplete="on"
        :placeholder="$t('contributionCreatePage.passwordConfirmation')"
      />
    </BFormGroup>

    <BFormGroup class="my-4">
      <BFormCheckbox
        id="terms-of-use"
        v-model="$v.form.termsOfUse.$model"
        :state="validateInput('termsOfUse')"
        size="lg"
        :value="true"
        :unchecked-value="false"
        name="terms-of-use"
      >
        {{ $t('contributionCreatePage.termsOfUse') }}
      </BFormCheckbox>
    </BFormGroup>

    <BButton
      variant="primary"
      type="submit"
      size="lg"
      block
    >
      {{ $t('contributionCreatePage.signUpAndContribute') }}
    </BButton>
  </BForm>
</template>

<script>
import {
  BForm, BFormGroup, BFormInput, BFormInvalidFeedback, BFormFile, BFormCheckbox, BButton,
} from 'bootstrap-vue';
import {
  required, maxLength, minLength, email, sameAs,
} from 'vuelidate/lib/validators';

import BaseLocationInput from './BaseLocationInput.vue';

export default {
  components: {
    BForm,
    BFormGroup,
    BFormInput,
    BFormInvalidFeedback,
    BaseLocationInput,
    BFormFile,
    BFormCheckbox,
    BButton,
  },
  validations: {
    form: {
      address: {
        required,
      },
      name: {
        required,
        minLength: minLength(2),
        maxLength: maxLength(32),
      },
      email: {
        required,
        email,
      },
      password: {
        required,
        minLength: minLength(6),
      },
      passwordConfirmation: {
        required,
        minLength: minLength(6),
        sameAsPassword: sameAs('password'),
      },
      termsOfUse: {
        checked: (value) => value === true,
      },
    },
  },
  data() {
    return {
      form: {
        address: null,
        photo: null,
        name: null,
        email: null,
        password: null,
        passwordConfirmation: null,
        termsOfUse: false,
      },
      isPhotoValid: null,
    };
  },
  watch: {
    'form.photo': function (newVal) {
      if (newVal) {
        this.validateFile(newVal);
      }
    },
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

      const userData = {
        email: this.form.email,
        name: this.form.name,
        password: this.form.password,
        passwordConfirmation: this.form.passwordConfirmation,
        termsOfUse: this.form.termsOfUse,
      };
      const eventData = { photo: this.form.photo, address: this.form.address };
      this.$emit('submit', { eventData, userData });
    },
    handleFormReset() {
      this.form = {
        address: null,
        photo: null,
        name: null,
        email: null,
        password: null,
        passwordConfirmation: null,
      };
      this.isPhotoValid = null;

      this.clearFile();
      this.$nextTick(() => {
        this.$v.$reset();
      });
    },
    clearFile() {
      this.$refs.fileInput.reset();
    },
    validateFile(file) {
      const maxFileSize = 8378122; // 8MB
      const minFileSize = 102400; // 100KB
      const fileSize = file?.size;
      if (!fileSize) return;

      if (fileSize > maxFileSize || fileSize < minFileSize) {
        this.isPhotoValid = false;
        this.clearFile();
      } else {
        this.isPhotoValid = true;
      }
    },
  },
};
</script>
