<template>
  <div>
    <v-select
      :options="availableLocales"
      :value="currentLocale"
      :clearable="false"
      transition="none"
      @input="changeLocale"
    />
  </div>
</template>

<script>
import vSelect from 'vue-select';

export default {
  components: {
    vSelect,
  },
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
        { label: 'Francais', code: 'fr' },
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
