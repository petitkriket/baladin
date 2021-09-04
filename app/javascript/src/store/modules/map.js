import { latLng } from 'leaflet';

export default {
  namespaced: true,

  state: {
    center: latLng(0, 0),
    zoom: 3,
    userPosition: null,
  },

  mutations: {
    setCenter(state, payload) {
      state.center = payload;
    },
    setZoom(state, payload) {
      state.zoom = payload;
    },
    setUserPosition(state, payload) {
      state.userPosition = payload;
    },
  },
};
