<template>
  <l-layer-group>
    <v-marker-cluster :options="clusterOptions">
      <!-- history markers -->
      <template v-if="clustered">
        <BaseMapContainerMarker
          v-for="marker in markers"
          :key="marker.id"
          :marker-item="{...marker, pastMarker: true }"
        />
      </template>

      <!-- current position markers -->
      <template v-else>
        <BaseMapContainerMarker
          v-for="marker in markers"
          :key="marker.id"
          :marker-item="marker"
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
    markers: {
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
