import { mapMutations } from 'vuex';

import eventService from '../api/models/event';

export default {
  data() {
    return {
      pendingForGeolocation: false,
    };
  },
  methods: {
    ...mapMutations('map', ['setUserPosition']),
    async findNearestContribution() {
      this.pendingForGeolocation = true;
      const position = await this.getUserPosition();
      if (position?.coords) {
        const { latitude, longitude } = position.coords;
        this.findUserNearestArtwork({ latitude, longitude });
        this.setUserPosition({ latitude, longitude });
      }
      this.pendingForGeolocation = false;
    },
    async getUserPosition() {
      return new Promise((resolve, reject) => {
        if (!('geolocation' in navigator)) {
          reject(new Error('Geolocation is not available.'));
        }

        navigator.geolocation.getCurrentPosition((position) => {
          resolve(position);
        }, (err) => {
          reject(err);
        });
      });
    },
    findUserNearestArtwork({ latitude, longitude }) {
      const params = { latitude, longitude, radius: 75 };
      eventService.findNearestActive(params).then((result) => {
        if (result.data.length) {
          const { passengerId } = result.data[0];
          this.$router.push(`/passenger/${passengerId}`);
        }
      }).catch((err) => {
        console.log(err);
      });
    },
  },
};
