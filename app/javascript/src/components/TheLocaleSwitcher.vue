<template>
  <v-select
    id="select_locale"
    :options="filteredLocales"
    :value="currentLocale"
    :clearable="false"
    transition=""
    @input="changeLocale"
  />
</template>

<script>
import { UPDATE_LOCALE } from '@/store/modules/user/actions-types';
import { mapActions, mapState } from 'vuex';

export default {
  computed: {
    ...mapState(['user', ['settings'],
    ]),
    currentLocale() {
      return this.locales.find((locale) => (locale.code === this.user.settings.locale));
    },
    filteredLocales() {
      return this.locales.filter((locale) => (locale.code !== this.user.settings.locale));
    },
    locales() {
      return [
        { label: 'English', code: 'en' },
        { label: 'Français', code: 'fr' },
      ];
    },
  },
  created() {
    const { locale } = this.user.settings;
    if (locale) {
      this[UPDATE_LOCALE](locale);
    }
  },
  methods: {
    ...mapActions('user', [UPDATE_LOCALE]),
    changeLocale(locale) {
      this[UPDATE_LOCALE](locale.code);
    },
  },
};
</script>

<style>
.v-select * {
  cursor: pointer;
}
</style>
