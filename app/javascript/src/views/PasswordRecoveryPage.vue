<template>
  <BContainer>
    <BRow>
      <BCol>
        <h1 class="py-4">
          {{ $t('passwordRecoveryPage.recoverPassword') }}
        </h1>

        <BCard
          bg-variant="white"
          class="mb-4"
        >
          <BCol v-if="!requestWasSent">
            <p>
              {{ $t('passwordRecoveryPage.itHappens') }}
            </p>
            <BForm @submit="onSubmit">
              <BInputGroup class="my-4">
                <BFormInput
                  id="email"
                  v-model="$v.form.email.$model"
                  :state="validateInput('email')"
                  type="email"
                  size="lg"
                  autocomplete="on"
                  :placeholder="$t('passwordRecoveryPage.yourEmail')"
                />
              </BInputGroup>

              <BButton
                variant="primary"
                size="lg"
                @click="onSubmit"
              >
                {{ $t('passwordRecoveryPage.emailMe') }}
              </BButton>
            </BForm>
          </BCol>
          <BCol v-else>
            <div class="d-flex align-items-center">
              <PhEnvelopeSimple
                :size="32"
                class="mr-2"
              />
              <span class="lead">
                {{ $t('passwordRecoveryPage.confirmation') }}
              </span>
            </div>
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import {
  BCard, BForm, BInputGroup, BFormInput, BButton,
} from 'bootstrap-vue';
import { required, email } from 'vuelidate/lib/validators';
import { PhEnvelopeSimple } from 'phosphor-vue';

import userAccountService from '../api/models/user-account';

export default {
  name: 'PasswordRecoveryPage',
  components: {
    BCard,
    BForm,
    BInputGroup,
    BFormInput,
    BButton,
    PhEnvelopeSimple,
  },
  validations: {
    form: {
      email: {
        required,
        email,
      },
    },
  },
  metaInfo() {
    return {
      title: this.$t('passwordRecoveryPage.recoverPassword'),
    };
  },
  data() {
    return {
      form: {
        email: null,
      },
      requestWasSent: false,
    };
  },
  beforeDestroy() {
    this.handleFormReset();
  },
  methods: {
    validateInput(name) {
      const { $dirty, $error } = this.$v.form[name];
      return $dirty ? !$error : null;
    },
    handleFormReset() {
      this.form = {
        email: null,
      };
      this.requestWasSent = false;

      this.$nextTick(() => {
        this.$v.$reset();
      });
    },
    onSubmit(event) {
      event.preventDefault();
      this.$v.form.$touch();
      if (this.$v.form.$anyError) {
        return;
      }

      const user = { email: this.form.email };
      userAccountService.reset({ user }).then(() => {
        this.requestWasSent = true;
      }).catch((err) => {
        console.log(err);
      });
    },
  },
};
</script>
