<template>
  <l-marker
    v-if="event"
    :lat-lng="[event.latitude, event.longitude]"
    :icon="icon"
    :options="{ opacity: event.isFocused ? 1 : 0.4 }"
    @click="focusOn(event)"
  >
    <l-popup v-if="event && !event.currentPosition">
      <small>{{ popUpText }}</small>
    </l-popup>
  </l-marker>
</template>

<script>
import { icon } from 'leaflet';
import { LMarker, LPopup } from 'vue2-leaflet';

import iconHistory from '../assets/images/circle-o.svg';
import iconPresent from '../assets/images/circle.svg';

export default {
  components: {
    LMarker,
    LPopup,
  },
  props: {
    event: {
      type: Object,
      default: null,
    },
  },
  computed: {
    icon() {
      return icon({
        iconUrl: this.event.currentPosition ? iconPresent : iconHistory,
        opacity: this.event.isFocused ? 1 : 0.4,
        className: this.event.isFocused ? 'text-primary' : 'text-secondary',
        iconSize: [14, 14],
        popupAnchor: [0, 0],
      });
    },
    popUpText() {
      const labelName = this.event.currentPosition ? 'currentPositionDescription' : 'previousPositionDescription';
      return this.$t(`mapPage.${labelName}`, {
        n: this.event.name,
        country: this.event.country,
        city: this.event.city,
        username: this.event.user.name,
      });
    },
  },
  methods: {
    focusOn({ passengerId, currentPosition, isFocused }) {
      if (passengerId && currentPosition && !isFocused) {
        this.$router.push({ path: `/passenger/${passengerId}` });
      }
    },
  },
};
</script>

<style>
@import "leaflet.markercluster/dist/MarkerCluster.css";
@import "leaflet.markercluster/dist/MarkerCluster.Default.css";

.marker-cluster-small div,
.marker-cluster-medium div,
.marker-cluster-large div {
  background-color: transparent;
}

.marker-cluster {
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: monospace;
  font-weight: 700;
  color: white;
  text-align: center;
  background: #4b6187;
  border: 1px solid #4b6187;
  border-radius: 50%;
}

.marker-cluster::before {
  position: absolute;
  top: 1px;
  right: 1px;
  bottom: 1px;
  left: 1px;
  z-index: -1;
  content: ' ';
  border: 1px solid white;
  border-radius: 50%;
}

.leaflet-container {
  font: inherit !important;
  font-size: inherit;
  color: var(--primary);
}

.leaflet-popup {
  border: 1px solid var(--primary);
}

.leaflet-popup-tip {
  width: 8px !important;
  height: 8px !important;
  margin: -5px auto 0 !important;
  color: var(--primary) !important;
  border: 1px solid var(--primary);
  box-shadow: none !important;
}

.leaflet-popup-content-wrapper {
  color: var(--primary) !important;
  border-radius: 0 !important;
  box-shadow: none !important;
}

.leaflet-popup-close-button {
  display: none;
}
</style>
