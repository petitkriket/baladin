<template>
  <l-map
    ref="map"
    :options="mapOptions"
    :center="center"
    :zoom="zoom"
    :style="mapStyle"
    @update:center="$emit('center', $event)"
    @update:zoom="$emit('zoom', $event)"
  >
    <LTileLayer
      ref="mapboxGlLayer"
      :options="layerOptions"
      :tile-layer-class="tileLayerClass"
      :attribution="attribution"
      detect-retina
    />
    <base-map-marker-user :position="userPosition" />

    <!-- artwork journey -->
    <base-map-container-group
      :events="historyMarkers"
      clustered
    />

    <!-- current artworks position TO REFACTOR -->
    <base-map-container-group :events="lastPositionMarkers" />

    <l-control-zoom position="bottomleft" />
  </l-map>
</template>

<script>
import L from 'leaflet';
import 'leaflet-swoopy';
import 'leaflet.smoothwheelzoom';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl-leaflet';
import { LMap, LTileLayer, LControlZoom } from 'vue2-leaflet';

import BaseMapContainerGroup from './BaseMapContainerGroup.vue';
import BaseMapMarkerUser from './BaseMapMarkerUser.vue';

const accessToken = process.env.MAPBOX_TOKEN;
window.mapboxgl = mapboxgl;

export default {
  name: 'BaseMapContainer',
  components: {
    LMap,
    LTileLayer,
    LControlZoom,
    BaseMapContainerGroup,
    BaseMapMarkerUser,
  },
  props: {
    center: {
      type: Object,
      default: () => {},
    },
    zoom: {
      type: Number,
      default: 3,
    },
    userPosition: {
      type: Object,
      default: () => {},
    },
    lastPositionMarkers: {
      type: Array,
      default: () => [],
    },
    historyMarkers: {
      type: Array,
      default: () => [],
    },
    locale: {
      type: String,
      default: null,
    },
  },
  data() {
    return {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OSM</a> contributors &copy; <a href="https://www.mapbox.com/">Mapbox</a>',
      tileLayerClass: (url, options) => L.mapboxGL(options),
      layerOptions: {
        accessToken,
        style: 'mapbox://styles/julesvau/ckja5klb3i1q919qmfbiz6qxj',
      },
    };
  },
  computed: {
    mapOptions() {
      return {
        minZoom: 3,
        maxZoom: 16,
        scrollWheelZoom: false,
        smoothWheelZoom: true,
        smoothSensitivity: 2,
        zoomControl: false,
        attributionControl: false,
      };
    },
    mapStyle() {
      return {
        height: 'calc(100vh - 41px)',
        width: '100%',
        backgroundColor: '#ffffff',
      };
    },
  },
  watch: {
    historyMarkers(newValue) {
      this.clearArrowPath();
      if (!newValue?.length) return;

      const bounds = newValue.map((item) => ([item.latitude, item.longitude]));
      this.fitBoundsThenDrawPath(bounds);
    },
    locale(value) {
      this.changeMapboxLabelsLocale(value);
    },
  },
  methods: {
    drawArrowPath(group) {
      const pairs = [];
      group.forEach((val, index) => {
        if (index < (group.length + 1)) {
          pairs.push([val, group[index + 1]]);
        }
      });

      pairs.forEach(([latitude, longitude], index) => {
        if (latitude && longitude) {
          const isLast = (pairs.length - 2) === index;
          if (isLast) {
            this.drawArrowItemWithHead(latitude, longitude);
          } else {
            this.drawArrowItem(latitude, longitude);
          }
        }
      });
    },
    drawArrowItem(latitude, longitude) {
      const options = {
        color: '#ffc815',
        weight: 1.6,
        hideArrowHead: true,
        opacity: 0.4,
        factor: 0.8,
      };
      L.swoopyArrow(latitude, longitude, options)
        .addTo(this.$refs.map.mapObject);
    },
    drawArrowItemWithHead(latitude, longitude) {
      const options = {
        color: '#ffc815',
        weight: 1.6,
        factor: 0.8,
      };
      L.swoopyArrow(latitude, longitude, options)
        .addTo(this.$refs.map.mapObject);
    },
    clearArrowPath() {
      this.$refs.map.mapObject.eachLayer((layer) => {
        // eslint-disable-next-line no-underscore-dangle
        if (layer._currentPathVisible) this.$refs.map.mapObject.removeLayer(layer);
      });
    },
    fitBoundsThenDrawPath(group) {
      const options = { padding: [150, 150] };
      this.$refs.map.mapObject.flyToBounds(group, options);
      this.$refs.map.mapObject.once('moveend', () => {
        this.drawArrowPath(group);
      });
    },
    changeMapboxLabelsLocale(locale) {
      const { _glMap } = this.$refs.mapboxGlLayer.mapObject;

      _glMap.getStyle().layers.forEach(({ type, id }) => {
        if (type === 'symbol') {
          _glMap.setLayoutProperty(id, 'text-field', ['get', `name_${locale}`]);
        }
      });
    },
  },
};
</script>
<style>
@import "mapbox-gl/dist/mapbox-gl.css";
</style>
