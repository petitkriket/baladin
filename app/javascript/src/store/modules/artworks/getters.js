import * as GETTERS_TYPES from './getters-types';

// eslint-disable-next-line import/prefer-default-export
export const getters = {
  [GETTERS_TYPES.ARTWORKS_CURRENT_EVENTS]: (state) => state.list.map((artwork) => {
    const { latitude, longitude } = artwork;
    if (latitude && longitude) {
      return { latitude, longitude };
    }
    return null;
  }),
};
