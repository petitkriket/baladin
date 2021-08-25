import eventService from '../api/models/event';

export default {
  data() {
    return {
      pollTimer: null,
      visibilityChangeEventName: null,
    };
  },
  methods: {
    async findNearestContribution() {
      const position = await this.getUserPosition();
      if (position?.coords) {
        this.findUserNearestArtwork(position.coords);
      }
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
