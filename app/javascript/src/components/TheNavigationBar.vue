<template>
  <b-navbar v-bind="navbarStyles">
    <BNavbarBrand
      to="/"
      :class="[`text-${navbarStyles.accent}`, 'font-weight-bold']"
    >
      {{ $t('projectTitle') }}
    </BNavbarBrand>

    <BNavbarToggle
      target="nav-collapse"
      class="border-0"
    >
      <template #default="{ expanded }">
        <BNavText>
          {{ expanded ? 'x' : $t('navbar.menu') }}
        </BNavText>
      </template>
    </BNavbarToggle>

    <BCollapse
      id="nav-collapse"
      is-nav
    >
      <BNavbarNav class="ml-auto">
        <!-- private zone navigation  -->
        <template v-if="isDashboardZone">
          <BNavItem
            to="/dashboard/contributions"
            exact
            exact-active-class="active"
          >
            {{ $t('navbar.contributions') }}
          </BNavItem>

          <BNavItem
            to="/dashboard/account-settings"
            exact
            exact-active-class="active"
          >
            {{ $t('navbar.accountSettings') }}
          </BNavItem>

          <BNavItem
            href="#"
            @click="handleSignOut"
          >
            {{ $t('navbar.signOut') }}
          </BNavItem>
        </template>

        <!-- public zone navigation -->
        <template v-else>
          <BNavItem
            to="/about"
            exact
            exact-active-class="active"
          >
            {{ $t('navbar.about') }}
          </BNavItem>

          <BNavItem
            to="/artworks"
            exact
            exact-active-class="active"
          >
            {{ $t('navbar.objects') }}
          </BNavItem>

          <BNavbarNav v-if="IS_AUTHENTIFIED">
            <BNavItem
              to="/dashboard/contributions"
              exact
              exact-active-class="active"
            >
              <BAvatar size="1.4rem" />
            </BNavItem>
          </BNavbarNav>
          <BNavbarNav v-else>
            <TheLocaleSwitcher />

            <BNavItem
              to="/authentification"
              exact
              exact-active-class="active"
            >
              {{ $t('navbar.signIn') }}
            </BNavItem>

            <BNavForm class="ml-lg-4">
              <BButton
                size="sm"
                variant="primary"
                pill
                @click="findNearestContribution"
              >
                {{ $t('navbar.participate') }}
              </BButton>
            </BNavForm>
          </BNavbarNav>
        </template>
      </BNavbarNav>
    </BCollapse>
  </b-navbar>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import {
  BNavbar, BNavbarNav, BNavbarBrand, BNavbarToggle, BNavItem, BNavText, BCollapse, BAvatar, BNavForm, BButton
} from 'bootstrap-vue';

import TheLocaleSwitcher from './TheLocaleSwitcher.vue';
import { IS_AUTHENTIFIED } from '../store/modules/user/getters';
import { SIGN_OUT } from '../store/modules/user/actions-types';

import findNearestContributionMixin from '../mixins/find-nearest-contribution';

export default {
  components: {
    BNavbar,
    BNavbarNav,
    BNavbarBrand,
    BNavbarToggle,
    BNavItem,
    BNavText,
    BCollapse,
    BAvatar,
    BNavForm,
    BButton,
    TheLocaleSwitcher,
  },
  mixins: [findNearestContributionMixin],
  computed: {
    ...mapGetters('user', [
      IS_AUTHENTIFIED,
    ]),
    isDashboardZone() {
      const { requiresAuthentification } = this.$route.meta;
      return requiresAuthentification && IS_AUTHENTIFIED;
    },
    navbarStyles() {
      const { isDashboardZone } = this;
      const accent = isDashboardZone ? 'white' : 'primary';
      return {
        variant: isDashboardZone ? 'primary' : 'white',
        accent,
        type: isDashboardZone ? 'dark' : 'light',
        style: { borderBottom: '2px solid', transition: 'background 150ms ease' },
        fixed: 'top',
        toggleable: 'lg',
        class: `border-${accent}`,
      };
    },
  },
  methods: {
    ...mapActions('user', [
      SIGN_OUT,
    ]),
    handleSignOut() {
      this[SIGN_OUT]().then(() => {
        this.$router.push('/');
      });
    },
  },
};
</script>
