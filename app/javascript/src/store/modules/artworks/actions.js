import axios from 'axios';
import { SET_ARTWORKS, ADD_ARTWORK_EVENTS, UPDATE_ARTWORK_EVENTS } from './mutations';
import { setErrorServer } from '../../utils';

export const FETCH_ARTWORKS = 'FETCH_ARTWORKS';
export const FETCH_ARTWORK_EVENTS = 'FETCH_ARTWORK_EVENTS';

export const actions = {
  [FETCH_ARTWORKS]({ commit }) {
    return new Promise((resolve, reject) => {
      const url = '/api/v1/passengers/';
      axios.get(url)
        .then((response) => {
          commit(SET_ARTWORKS, response.data);
          resolve(response.data);
        }).catch((error) => {
          reject(setErrorServer(error));
        });
    });
  },

  [FETCH_ARTWORK_EVENTS]({ commit, state }, artwork) {
    return new Promise((resolve, reject) => {
      const url = `/api/v1/passengers/${artwork.id}/events`;
      const alreadyPresent = state.events.find((event) => (event.id === artwork.id));
      axios.get(url)
        .then((response) => {
          const payload = { id: artwork.id, events: [...response.data] };
          if (alreadyPresent) {
            commit(UPDATE_ARTWORK_EVENTS, payload);
          } else {
            commit(ADD_ARTWORK_EVENTS, payload);
          }
          resolve(payload);
        }).catch((error) => {
          reject(setErrorServer(error));
        });
    });
  },
};
