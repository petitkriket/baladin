<template>
  <BForm @submit="handleNativeSubmit">
    <BFormGroup
      id="input-group-1"
      :label="$t('contributionEditPage.location')"
      label-for="input-1"
      :description="$t('contributionEditPage.locationHelp')"
      size="lg"
    >
      <BaseLocationInput
        id="input-location"
        v-model.trim="$v.form.address.$model"
        :state="validateInput('address')"
        size="lg"
      />
    </BFormGroup>

    <BFormGroup
      id="input-group-2"
      :label="$t('contributionEditPage.photo')"
      label-for="input-2"
      :description="$t('contributionEditPage.photoHelp')"
      size="lg"
    >
      <BFormFile
        id="input-2"
        v-model="form.photo"
        accept="image/jpeg, image/png, image/gif"
        size="lg"
        capture
      />
    </BFormGroup>
  </BForm>
</template>

<script>
import { BForm, BFormGroup, BFormFile } from 'bootstrap-vue';
import { required, minLength } from 'vuelidate/lib/validators';

import BaseLocationInput from './BaseLocationInput.vue';

export default {
  components: {
    BForm,
    BFormGroup,
    BFormFile,
    BaseLocationInput,
  },
  props: {
    contribution: {
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
      address: {
        required,
        minLength: minLength(3),
      },
    },
  },
  data() {
    return {
      form: {
        address: null,
        photo: null,
      },
    };
  },
  watch: {
    contribution: {
      immediate: true,
      deep: true,
      handler(contributionObject) {
        const isContributionFetched = contributionObject
        && Object.keys(contributionObject).length !== 0
        && contributionObject.constructor === Object;

        if (isContributionFetched) this.loadExistingContribution();
      },
    },
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
        address: null,
        photo: null,
      };

      this.$nextTick(() => {
        this.$v.$reset();
      });
    },
    loadExistingContribution() {
      const { address } = this.contribution;
      this.form.address = address;
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
      Object
        .keys(this.form)
        .forEach((key) => (form[key] === null ? delete form[key] : {}));
      this.$emit('submission', form);
    },
  },
};
</script>
