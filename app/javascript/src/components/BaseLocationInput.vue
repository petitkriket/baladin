<template>
  <div>
    <BFormInput
      v-model="model"
      v-bind="$attrs"
      type="search"
      list="input-location-list"
      @blur="autoSelect"
    />
    <datalist
      v-if="suggestions.length"
      id="input-location-list"
    >
      <option
        v-for="(result, index) in suggestions"
        :key="index"
      >
        {{ result }}
      </option>
    </datalist>
  </div>
</template>

<script>
import { BFormInput } from 'bootstrap-vue';

export default {
  name: 'BaseLocationInput',
  components: { BFormInput },
  props: {
    value: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      suggestions: [],
      geolocateAPI: null,
    };
  },
  computed: {
    model: {
      get() {
        return this.value;
      },
      set(value) {
        this.$emit('input', value);
      },
    },
  },
  watch: {
    value(newValue, oldValue) {
      const validInput = newValue && newValue !== oldValue && this.geolocateAPI;
      if (validInput) {
        this.getSuggestions(newValue);
      }
    },
  },
  created() {
    this.initializeAPI();
  },
  methods: {
    initializeAPI() {
      if (this.geolocateAPI) return;
      this.geolocateAPI = new window.google.maps.places.AutocompleteService();
    },
    getSuggestions(input) {
      if (!this.geolocateAPI) return;
      this.geolocateAPI
        .getPlacePredictions({
          input,
          types: ['geocode'],
        }, this.formatResults);
    },
    formatResults(results, status) {
      if (status !== window.google.maps.places.PlacesServiceStatus.OK) {
        this.suggestions = [];
        return;
      }

      this.suggestions = results
        .filter((result) => result.description !== this.value)
        .map((result) => result.description);
    },
    autoSelect() {
      const firstSuggestion = this.suggestions[0];
      if (firstSuggestion) {
        this.$emit('input', firstSuggestion);
      }
    },
  },
};
</script>
