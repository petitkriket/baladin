import dayjs from 'dayjs';

import authentificationService from '../../../api/models/authentification';
import userAccountService from '../../../api/models/user-account';
import userContributionService from '../../../api/models/user-contribution';
import eventService from '../../../api/models/event';
import i18n from '../../../plugins/i18n';

import * as MUTATIONS_TYPES from './mutations-types';
import * as ACTIONS_TYPES from './actions-types';

const actions = {
  [ACTIONS_TYPES.UPDATE_LOCALE]({ commit }, localeCode) {
    i18n.locale = localeCode;
    dayjs.locale(localeCode);

    commit(MUTATIONS_TYPES.SET_LOCALE, localeCode);
  },
  [ACTIONS_TYPES.SIGN_IN]({ commit }, user) {
    return new Promise((resolve, reject) => {
      authentificationService.signIn(user)
        .then((response) => {
          commit(MUTATIONS_TYPES.SET_USER, response.data.user);
          commit(MUTATIONS_TYPES.SET_TOKEN, response.headers.authorization);
          resolve(response.data);
        }).catch((error) => {
          reject(error);
        });
    });
  },
  [ACTIONS_TYPES.SIGN_OUT]({ commit }) {
    return new Promise((resolve, reject) => {
      authentificationService.signOut()
        .then((response) => {
          commit(MUTATIONS_TYPES.SET_USER, {});
          commit(MUTATIONS_TYPES.SET_TOKEN, null);
          resolve(response.data);
        }).catch((error) => {
          reject(error);
        });
    });
  },
  [ACTIONS_TYPES.UPDATE_USER_ACCOUNT]({ commit, dispatch }, user) {
    return new Promise((resolve, reject) => {
      userAccountService.update(user)
        .then((response) => {
          commit(MUTATIONS_TYPES.SET_USER, response.data.user);
          const { locale } = response.data.user;
          if (locale) {
            dispatch(ACTIONS_TYPES.UPDATE_LOCALE, locale)
          }
          resolve(response.data);
        }).catch((error) => {
          reject(error);
        });
    });
  },
  [ACTIONS_TYPES.DELETE_USER_ACCOUNT]({ commit }) {
    return new Promise((resolve, reject) => {
      userAccountService.delete()
        .then((response) => {
          commit(MUTATIONS_TYPES.SET_USER, {});
          commit(MUTATIONS_TYPES.SET_TOKEN, null);
          resolve(response.data);
        }).catch((error) => {
          reject(error);
        });
    });
  },
  [ACTIONS_TYPES.FETCH_USER_CONTRIBUTIONS]({ commit }) {
    return new Promise((resolve, reject) => {
      userContributionService.getAll()
        .then((response) => {
          commit(MUTATIONS_TYPES.SET_CONTRIBUTIONS, response.data);
          resolve(response.data);
        }).catch((error) => {
          reject(error);
        });
    });
  },
  [ACTIONS_TYPES.UPDATE_USER_CONTRIBUTION]({ commit }, event) {
    return new Promise((resolve, reject) => {
      eventService.update(event.id, event)
        .then((response) => {
          commit(MUTATIONS_TYPES.SET_CONTRIBUTION, response.data.event);
          resolve(response.data);
        }).catch((error) => {
          reject(error);
        });
    });
  },
};

export default actions;
