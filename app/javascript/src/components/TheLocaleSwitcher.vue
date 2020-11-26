<template>
  <v-select
    id="select_locale"
    :options="availableLocales"
    :value="currentLocale"
    :clearable="false"
    transition=""
    @input="changeLocale"
  />
</template>

<script>
export default {
  computed: {
    currentLocale() {
      return this.locales.find((locale) => (locale.code === this.$i18n.locale));
    },
    availableLocales() {
      return this.locales.filter((locale) => (locale.code !== this.$i18n.locale));
    },
    locales() {
      return [
        { label: 'English', code: 'en' },
        { label: 'Français', code: 'fr' },
      ];
    },
  },
  methods: {
    changeLocale(locale) {
      this.$i18n.locale = locale.code;
    },
  },
};
</script>

<style>
.v-select * {
  cursor: pointer;
}
</style>
