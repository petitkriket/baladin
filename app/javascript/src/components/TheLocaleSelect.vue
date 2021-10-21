<template>
  <div>
    <p class="mb-2">
      {{ $t('navbar.language') }}
      <PhTranslate
        :size="20"
        weight="light"
        class="mr-2"
      />
    </p>
    <BFormSelect
      v-model="user.settings.locale"
      v-bind="$attrs"
      :options="localeOptions"
      @change="onLocaleSelection"
    />
  </div>
</template>

<script>
import { BFormSelect } from 'bootstrap-vue';
import { PhTranslate } from 'phosphor-vue';

import { mapActions, mapState } from 'vuex';

import { UPDATE_LOCALE } from '../store/modules/user/actions-types';

export default {
  components: {
    BFormSelect,
    PhTranslate,
  },
  computed: {
    ...mapState(['user', ['settings']]),
    localeOptions() {
      return this.$i18n.availableLocales
        .map((locale) => ({
          text: locale.toUpperCase(),
          value: locale,
        }));
    },
  },
  methods: {
    ...mapActions('user', [UPDATE_LOCALE]),
    onLocaleSelection(localeCode) {
      this[UPDATE_LOCALE](localeCode);
    },
  },
};
</script>
