<template>
  <l-marker
    :lat-lng="[markerItem.latitude, markerItem.longitude]"
    :icon="selectedMarker"
    @click="openPath(markerItem)"
  >
    <l-popup v-if="!markerItem.currentPosition">
      <div>
        {{ markerItem.id }}, {{ markerItem.city }}
      </div>
    </l-popup>
  </l-marker>
</template>

<script>
import { LMarker, LPopup } from 'vue2-leaflet';
import { icon } from 'leaflet';

import iconHistory from '../assets/images/circle-o.svg';
import iconPresent from '../assets/images/circle.svg';

export default {
  components: {
    LMarker,
    LPopup,
  },
  props: {
    markerItem: {
      type: Object,
      default: () => {},
      required: true,
    },
  },
  computed: {
    selectedMarker() {
      return this.markerItem.currentPosition ? this.currentMarker : this.pastMarker;
    },
    currentMarker() {
      return icon({
        iconUrl: iconPresent,
        iconSize: [20, 20],
      });
    },
    pastMarker() {
      return icon({
        iconUrl: iconHistory,
        iconSize: [14, 14],
      });
    },
  },
  methods: {
    openPath({ passengerId, currentPosition }) {
      if (passengerId && currentPosition) {
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
</style>
