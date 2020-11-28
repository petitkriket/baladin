export const SET_ARTWORKS = 'SET_ARTWORKS';
export const ADD_ARTWORK_EVENTS = 'ADD_ARTWORK_EVENTS';
export const UPDATE_ARTWORK_EVENTS = 'UPDATE_ARTWORK_EVENTS';

export const mutations = {
  [SET_ARTWORKS](state, payload) {
    state.artworks = payload;
  },
  [ADD_ARTWORK_EVENTS](state, payload) {
    state.events = [...state.events, payload];
  },
  [UPDATE_ARTWORK_EVENTS](state, payload) {
    const index = state.events.findIndex((event) => (event.id === payload.id));
    state.events.splice(index, 1, payload);
  },
};
