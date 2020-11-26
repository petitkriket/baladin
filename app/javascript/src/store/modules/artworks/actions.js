import axios from 'axios';
import * as MUTATIONS_TYPES from './mutations-types';
import * as ACTIONS_TYPES from './actions-types';
import { setErrorServer } from '../../utils';

// eslint-disable-next-line import/prefer-default-export
export const actions = {
  [ACTIONS_TYPES.FETCH_ARTWORKS]({ commit }) {
    return new Promise((resolve, reject) => {
      const url = '/api/v1/passengers/';
      axios.get(url)
        .then((response) => {
          commit(MUTATIONS_TYPES.SET_ARTWORKS, response.data);
          resolve(response.data);
        }).catch((error) => {
          reject(setErrorServer(error));
        });
    });
  },

};
