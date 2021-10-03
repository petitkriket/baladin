<template>
  <BContainer>
    <BRow>
      <BCol>
        <h1 class="py-4">
          {{ $t('passwordResetPage.resetPassword') }}
        </h1>

        <BCard
          bg-variant="white"
          class="mb-4"
        >
          <BCol v-if="!requestWasSent">
            <p>
              {{ $t('passwordResetPage.requirements') }}
            </p>

            <BForm @submit="onSubmit">
              <BInputGroup class="my-4">
                <BFormInput
                  id="new-password"
                  v-model="$v.form.password.$model"
                  :state="validateInput('password')"
                  :type="isPasswordVisible ? 'text' :'password'"
                  size="lg"
                  autocomplete="new-password"
                  aria-describedby="request-error-feedback"
                  :placeholder="$t('passwordResetPage.newPassword')"
                />
                <BInputGroupAppend>
                  <BButton
                    variant="outline-primary"
                    @click="togglePasswordVisibility"
                  >
                    <component
                      :is="passwordToggleIcon"
                      :size="32"
                    />
                  </BButton>
                </BInputGroupAppend>
              </BInputGroup>

              <BButton
                variant="primary"
                size="lg"
                @click="onSubmit"
              >
                {{ $t('passwordResetPage.resetPassword') }}
              </BButton>
            </BForm>

            <p
              v-if="requestHasFailed"
              class="text-danger mt-4 mb-0"
            >
              {{ $t('passwordResetPage.requestExpired') }}
              <br>
              <BLink to="/password-recovery">
                <u>{{ $t('passwordResetPage.makeRequest') }} ></u>
              </BLink>
            </p>
          </BCol>
          <BCol v-else>
            <div>
              <PhCheckCircle
                :size="48"
                class="mr-2"
              />
              <p class="lead">
                {{ $t('passwordResetPage.confirmation') }}
              </p>
            </div>
            <BLink to="/authentification">
              <u>
                {{ $t('passwordResetPage.loginNow') }} >
              </u>
            </BLink>
          </BCol>
        </BCard>
      </Bcol>
    </BRow>
  </BContainer>
</template>

<script>
import {
  BCard, BForm, BInputGroup, BFormInput, BInputGroupAppend, BButton, BLink,
} from 'bootstrap-vue';
import { required, minLength } from 'vuelidate/lib/validators';
import { PhEye, PhEyeClosed, PhCheckCircle } from 'phosphor-vue';

import userAccountService from '../api/models/user-account';

export default {
  name: 'PasswordResetPage',
  components: {
    BCard,
    BForm,
    BInputGroup,
    BFormInput,
    BInputGroupAppend,
    BButton,
    PhEye,
    PhEyeClosed,
    PhCheckCircle,
    BLink,
  },
  validations: {
    form: {
      password: {
        required,
        minLength: minLength(6),
      },
    },
  },
  metaInfo() {
    return {
      title: this.$t('passwordResetPage.resetPassword'),
    };
  },
  data() {
    return {
      form: {
        password: null,
      },
      isPasswordVisible: false,
      requestWasSent: false,
      requestHasFailed: false,
    };
  },
  computed: {
    passwordToggleIcon() {
      return this.isPasswordVisible ? PhEyeClosed : PhEye;
    },
  },
  beforeDestroy() {
    this.handleFormReset();
  },
  methods: {
    validateInput(name) {
      const { $dirty, $error } = this.$v.form[name];
      return $dirty ? !$error : null;
    },
    togglePasswordVisibility() {
      this.isPasswordVisible = !this.isPasswordVisible;
    },
    handleFormReset() {
      this.form = {
        password: null,
      };
      this.requestWasSent = false;
      this.requestHasFailed = false;
      this.isPasswordVisible = false;

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

      const { password } = this.form;
      const resetPasswordToken = this.$route.query.reset_password_token;
      const user = { password, passwordConfirmation: password, resetPasswordToken };
      userAccountService.resetPassword({ user }).then(() => {
        this.requestWasSent = true;
      }).catch(() => {
        this.requestHasFailed = true;
      });
    },
  },
};
</script>
