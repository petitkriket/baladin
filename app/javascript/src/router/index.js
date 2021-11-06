import Vue from 'vue';
import VueRouter from 'vue-router';

import store from '../store';

import LandingPage from '../views/LandingPage.vue';
import HomePage from '../views/HomePage.vue';
import AboutPage from '../views/AboutPage.vue';
import ArtworksPage from '../views/ArtworksPage.vue';
import ConfirmAccountPage from '../views/ConfirmAccountPage.vue';
import AuthentificationPage from '../views/AuthentificationPage.vue';
import PasswordRecoveryPage from '../views/PasswordRecoveryPage.vue';
import PasswordResetPage from '../views/PasswordResetPage.vue';

import DashboardPage from '../views/DashboardPage.vue';
import ContributionsPage from '../views/ContributionsPage.vue';
import AccountSettingsPage from '../views/AccountSettingsPage.vue';
import ContributionEditPage from '../views/ContributionEditPage.vue';
import ContributionPage from '../views/ContributionPage.vue';
import ContributionNewPage from '../views/ContributionNewPage.vue';

import NotFoundPage from '../views/NotFoundPage.vue';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  base: '/',
  routes: [
    {
      path: '/',
      name: 'LandingPage',
      component: LandingPage,
      meta: { isFullwidth: true },
    },
    {
      path: '/passenger',
      name: 'Home',
      component: HomePage,
      meta: { isFullwidth: true },
    },
    {
      path: '/passenger/:id',
      name: 'Passenger',
      component: HomePage,
      meta: { isFullwidth: true },
    },
    {
      path: '/about',
      name: 'About',
      component: AboutPage,
    },
    {
      path: '/artworks',
      name: 'Artworks',
      component: ArtworksPage,
    },
    {
      path: '/authentification',
      name: 'Authentification',
      component: AuthentificationPage,
    },
    {
      path: '/confirmation',
      alias: '/users/confirmation',
      name: 'Confirm account',
      component: ConfirmAccountPage,
    },
    {
      path: '/password-recovery',
      name: 'Password recovery',
      component: PasswordRecoveryPage,
    },
    {
      path: '/reset-password',
      alias: '/users/password/edit',
      name: 'Reset password',
      component: PasswordResetPage,
    },
    {
      path: '/dashboard',
      name: 'Dashboard',
      component: DashboardPage,
      meta: { requiresAuthentification: true },
      children: [
        {
          path: 'contributions',
          name: 'Contribution List',
          component: ContributionsPage,
          meta: { requiresAuthentification: true },
        },
        {
          path: 'contributions/:id/edit',
          name: 'Contribution Edit',
          component: ContributionEditPage,
          meta: { requiresAuthentification: true },
        },
        {
          path: 'contributions/new',
          name: 'Contribution New',
          component: ContributionNewPage,
          meta: { requiresAuthentification: true },
        },
        {
          path: 'account-settings',
          name: 'Account settings',
          component: AccountSettingsPage,
          meta: { requiresAuthentification: true },
        },
      ],
    },
    {
      path: '/:shortcode(\\w{3})',
      name: 'Contribute',
      component: ContributionPage,
    },
    {
      path: '/*',
      name: 'NotFound',
      component: NotFoundPage,
    },
  ],
});

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requiresAuthentification)) {
    const isUserAuthentified = store.getters['user/IS_AUTHENTIFIED'];
    if (isUserAuthentified) {
      next();
      return;
    }
    next({ name: 'Authentification', query: { redirectTo: to.fullPath } });
  }
  next();
});

export default router;
