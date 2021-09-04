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
  findByShortcut(shortcut) {
    return api.get(`${path}/${resource}/find/${shortcut}`);
  },
  claim(id, claim) {
    return api.post(`${path}/${resource}/${id}/claims`, claim);
  },
};

export default passengerService;
