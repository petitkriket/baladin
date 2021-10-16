<template>
  <BNavItemDropdown no-caret>
    <template #button-content>
      {{ $t('navbar.language') }}
      <PhTranslate
        :size="20"
        weight="light"
        class="mr-2"
      />
    </template>

    <BDropdownItem
      v-for="{ code, label } in filteredLocales"
      :key="code"
      @click="onLocaleSelection(code)"
    >
      {{ label }}
    </BDropdownItem>
  </BNavItemDropdown>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import { BNavItemDropdown, BDropdownItem } from 'bootstrap-vue';
import { PhTranslate } from 'phosphor-vue';

import { UPDATE_LOCALE } from '../store/modules/user/actions-types';

export default {
  name: 'TheLocaleSwitcher',
  components: {
    BNavItemDropdown,
    BDropdownItem,
    PhTranslate,
  },
  computed: {
    ...mapState(['user', ['settings']]),
    currentLocale() {
      return this.localeOptions.find((locale) => (locale.code === this.user.settings.locale));
    },
    filteredLocales() {
      return this.localeOptions.filter((locale) => (locale.code !== this.user.settings.locale));
    },
    localeOptions() {
      return this.$i18n.availableLocales.map((locale) => ({
        label: locale.toUpperCase(),
        code: locale,
      }));
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
    onLocaleSelection(localeCode) {
      this[UPDATE_LOCALE](localeCode);
    },
  },
};
</script>
