<template>
  <div :style="mapStyle">
    <l-map
      ref="map"
      :zoom="zoom"
      :center="center"
      :options="mapOptions"
      :style="mapStyle"
      @update:center="centerUpdate"
      @update:zoom="zoomUpdate"
      @ready="onMapReady()"
    >
      <LTileLayer
        ref="mapboxGlLayer"
        :options="layerOptions"
        :tile-layer-class="tileLayerClass"
        :attribution="attribution"
      />
      <!-- current artworks position TO REFACTOR -->
      <base-map-container-group :markers="lastPositionMarkers" />

      <!--
        loops for an array of artworks path
        filtered using vue router
        -->
      <base-map-container-group
        :markers="historyMarkers"
        clustered
      />
    </l-map>
  </div>
</template>

<script>
import { mapMutations, mapState } from 'vuex';
import { LMap, LTileLayer } from 'vue2-leaflet';
import L from 'leaflet';
import 'leaflet-swoopy';
import 'leaflet.smoothwheelzoom';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl-leaflet';
import 'mapbox-gl/dist/mapbox-gl.css';

import BaseMapContainerGroup from './BaseMapContainerGroup.vue';

const accessToken = process.env.MAPBOX_TOKEN;
window.mapboxgl = mapboxgl;

export default {
  components: {
    LMap,
    LTileLayer,
    BaseMapContainerGroup,
  },
  props: {
    lastPositionMarkers: {
      type: Array,
      default: () => [],
      required: false,
    },
    historyMarkers: {
      type: Array,
      default: () => [],
      required: false,
    },
    locale: {
      type: String,
      default: 'en',
      required: true,
    },
  },
  data() {
    return {
      map: null,
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OSM</a> contributors &copy; <a href="https://www.mapbox.com/">Mapbox</a>',
      tileLayerClass: (url, options) => L.mapboxGL(options),
      layerOptions: {
        accessToken,
        style: 'mapbox://styles/julesvau/cjw0pvu1e0ck71cob17mqucr0',
      },
    };
  },
  computed: {
    ...mapState('map', [
      'center',
      'zoom',
    ]),
    mapOptions() {
      return {
        minZoom: 3,
        maxZoom: 16,
        scrollWheelZoom: false,
        smoothWheelZoom: true,
        smoothSensitivity: 2,
        zoomControl: false,
      };
    },
    mapStyle() {
      return {
        height: 'calc(100vh - 41px)',
        width: '100%',
      };
    },
  },
  watch: {
    locale(value) {
      this.setMapboxGlLayerLocale(value);
    },
  },
  beforeDestroy() {
    this.setZoom(this.$refs.map.mapObject.getZoom());
    this.setCenter(this.$refs.map.mapObject.getCenter());
  },
  methods: {
    ...mapMutations('map', [
      'setCenter',
      'setZoom',
    ]),
    centerUpdate(value) {
      this.setCenter(value);
    },
    zoomUpdate(value) {
      this.setZoom(value);
    },
    setMapboxGlLayerLocale(locale) {
      // eslint-disable-next-line no-underscore-dangle
      const map = this.$refs.mapboxGlLayer.mapObject._glMap;
      map.getStyle().layers.forEach((layer) => {
        if (layer.type === 'symbol') {
          map.setLayoutProperty(layer.id, 'text-field', ['get', `name_${locale}`]);
        }
      });
    },
    onMapReady() {
      // arrows..
      this.map = this.$refs.map.mapObject;
      const coords = this.historyMarkers.map((item) => ([item.latitude, item.longitude]));
      const pairs = [];
      coords.forEach((val, index) => {
        if (index < (coords.length + 1)) {
          pairs.push([val, coords[index + 1]]);
        }
      });

      pairs.forEach((element) => {
        L.swoopyArrow(element[0], element[1], {
          iconAnchor: [20, 10],
          color: '#ffc815',
          weight: 1.6,
          factor: 0.8,
        }).addTo(this.map);
      });
    },
    onFindNearestClick() {
      console.log('hello!');
    },
  },
};
</script>
