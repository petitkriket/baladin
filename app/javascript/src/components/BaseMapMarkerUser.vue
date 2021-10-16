<template>
  <LMarker
    v-if="position"
    :icon="icon"
    :lat-lng="[position.latitude, position.longitude]"
  />
</template>

<script>
import { LMarker } from 'vue2-leaflet';
import { divIcon } from 'leaflet';

export default {
  name: 'BaseMapMarkerUser',
  components: {
    LMarker,
  },
  props: {
    position: {
      type: Object,
      default: () => {},
    },
  },
  computed: {
    icon() {
      return divIcon(
        {
          html: '<div class="pin"></div><div class="pin-effect"></div>',
          iconAnchor: [50, 50],
          className: 'marker',
        },
      );
    },
  },
};
</script>

<style>
@keyframes pulsate {
  0% {
    opacity: 0;
    transform: scale(0.1);
  }

  50% {
    opacity: 1;
  }

  100% {
    opacity: 0;
    transform: scale(0.6);
  }
}

.pin {
  position: relative;
  top: 40px;
  left: 40px;
  z-index: 402;
  width: 21px;
  height: 21px;
  background: rgba(5, 124, 255, 1);
  border: 2px solid #fff;
  border-radius: 50%;
}

.pin-effect {
  position: absolute;
  top: 0;
  display: block;
  width: 100px;
  height: 100px;
  background: rgba(5, 124, 255, 0.3);
  border-radius: 50%;
  opacity: 0;
  animation: pulsate 3000ms ease-out infinite;
}
</style>
