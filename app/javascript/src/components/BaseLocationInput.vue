<template>
  <div>
    <BFormInput
      v-model="location"
      type="search"
      list="input-location-list"
      v-bind="$attrs"
      @change="onSelection"
    />
    <datalist id="input-location-list">
      <option
        v-for="(result, index) in searchResults"
        :key="index"
      >
        {{ result }}
      </option>
    </datalist>
  </div>
</template>

<script>
import { BFormInput } from 'bootstrap-vue';

const { GOOGLE_MAPS_JS_KEY } = process.env;
export default {
  components: { BFormInput },
  props: {
    user: {
      type: Object,
      default: () => {},
    },
  },
  data() {
    return {
      location: '',
      searchResults: [],
      service: null,
    };
  },
  metaInfo() {
    return {
      script: [{
        src: `https://maps.googleapis.com/maps/api/js?key=${GOOGLE_MAPS_JS_KEY}&libraries=places`,
        async: true,
        defer: true,
        callback: () => this.initializeAPI(),
      }],
    };
  },
  watch: {
    location(newValue) {
      if (!newValue) return;
      this.service.getPlacePredictions({
        input: this.location,
        types: ['geocode'],
      }, this.handleSuggestions);
    },
  },
  methods: {
    initializeAPI() {
      this.service = new window.google.maps.places.AutocompleteService();
    },
    handleSuggestions(predictions, status) {
      if (status !== window.google.maps.places.PlacesServiceStatus.OK) {
        this.searchResults = [];
        return;
      }
      this.searchResults = predictions.map((prediction) => prediction.description);
    },
    onSelection() {
      this.$emit('input', this.location);
    },
  },
};
</script>
