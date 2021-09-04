<template>
  <l-layer-group>
    <v-marker-cluster :options="clusterOptions">
      <!-- history events -->
      <template v-if="clustered">
        <BaseMapContainerMarker
          v-for="event in events"
          :key="event.id"
          :event="{...event, pastMarker: true }"
        />
      </template>

      <!-- current position events -->
      <template v-else>
        <BaseMapContainerMarker
          v-for="event in events"
          :key="event.id"
          :event="event"
        />
      </template>
    </v-marker-cluster>
  </l-layer-group>
</template>

<script>
import { LLayerGroup } from 'vue2-leaflet';
import Vue2LeafletMarkerCluster from 'vue2-leaflet-markercluster';
import BaseMapContainerMarker from './BaseMapContainerMarker.vue';

export default {
  components: {
    BaseMapContainerMarker,
    LLayerGroup,
    'v-marker-cluster': Vue2LeafletMarkerCluster,
  },
  props: {
    events: {
      type: Array,
      default: () => [],
    },
    clustered: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    clusterOptions() {
      const disableClusteringAtZoom = this.clustered ? 16 : 3;
      return { disableClusteringAtZoom, chunkedLoading: true };
    },
  },
};
</script>
