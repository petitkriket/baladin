<template>
  <BForm @submit="handleNativeSubmit">
    <BFormGroup class="my-4">
      <BFormInput
        id="name"
        v-model.trim="$v.form.name.$model"
        :state="validateInput('name')"
        size="lg"
        :placeholder="$t('claimModal.name')"
      />
    </BFormGroup>

    <BFormGroup
      class="my-4"
      label-for="email"
      :description="$t('claimModal.emailHelp')"
    >
      <BFormInput
        id="email"
        v-model.trim="$v.form.email.$model"
        :state="validateInput('email')"
        type="email"
        size="lg"
        :placeholder="$t('claimModal.email')"
      />
    </BFormGroup>

    <BFormGroup class="my-4">
      <BFormTextarea
        id="message"
        v-model.trim="$v.form.message.$model"
        :state="validateInput('message')"
        size="lg"
        rows="6"
        max-rows="6"
        :placeholder="$t('claimModal.message')"
      />
    </BFormGroup>

    <p class="small">
      {{ $t('claimModal.firstParagraph') }}
    </p>

    <BFormGroup class="my-4">
      <BFormCheckbox
        id="terms-of-use"
        v-model="$v.form.termsOfUse.$model"
        :state="validateInput('termsOfUse')"
        :value="true"
        :unchecked-value="false"
        name="terms-of-use"
      >
        {{ $t('claimModal.secondParagraph') }}
      </BFormCheckbox>
    </BFormGroup>
  </BForm>
</template>

<script>
import {
  BForm, BFormGroup, BFormInput, BFormTextarea, BFormCheckbox,
} from 'bootstrap-vue';
import {
  required, minLength, maxLength, email,
} from 'vuelidate/lib/validators';

export default {
  components: {
    BForm,
    BFormGroup,
    BFormInput,
    BFormTextarea,
    BFormCheckbox,
  },
  props: {
    pending: {
      type: Boolean,
      default: false,
    },
  },
  validations: {
    form: {
      name: {
        required,
        minLength: minLength(2),
        maxLength: maxLength(32),
      },
      email: {
        required,
        email,
      },
      message: {
        required,
        minLength: minLength(10),
        maxLength: maxLength(5000),
      },
      termsOfUse: {
        required,
      },
    },
  },
  data() {
    return {
      form: {
        name: null,
        email: null,
        message: null,
        termsOfUse: null,
      },
    };
  },
  beforeDestroy() {
    this.cleanForm();
  },
  methods: {
    validateInput(name) {
      const { $dirty, $error } = this.$v.form[name];
      return $dirty ? !$error : null;
    },
    cleanForm() {
      this.form = {
        name: null,
        email: null,
        message: null,
        termsOfUse: null,
      };

      this.$nextTick(() => {
        this.$v.$reset();
      });
    },
    handleNativeSubmit(event) {
      event.preventDefault();
      this.emitSubmission();
    },
    emitSubmission() {
      this.$v.form.$touch();
      if (this.$v.form.$anyError) {
        return;
      }

      const { form } = this;
      delete form.termsOfUse;

      Object
        .keys(this.form)
        .forEach((key) => (form[key] === null ? delete form[key] : {}));
      this.$emit('submission', form);
    },
  },
};
</script>
