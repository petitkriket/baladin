import api from '../index';

const path = '/api/v1';
const resource = 'passengers';

const passengerService = {
  getAll() {
    return api.get(`${path}/${resource}`);
  },
  getOneEvents(id) {
    return api.get(`${path}/${resource}/${id}/events`);
  },
};

export default passengerService;
