export const ARTWORKS_CURRENT_EVENTS = 'ARTWORKS_CURRENT_EVENTS';

export const getters = {
  [ARTWORKS_CURRENT_EVENTS]: (state) => state.artworks.map((artwork) => ({
    ...artwork.last_validated_event,
    currentPosition: true,
  })),
};
