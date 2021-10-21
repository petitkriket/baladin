import { decamelize } from 'humps';

import api from '../index';

const path = '/api/v1';
const resource = 'events';

const eventService = {
  findNearestActive(params) {
    return api.get(`${path}/${resource}/find`, { params });
  },
  update(id, event) {
    const formData = new FormData();
    Object.entries(event).forEach(([key, value]) => formData.append(decamelize(`event[${key}]`), value));

    return api.put(`${path}/${resource}/${id}`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },
  create({ event, passenger }) {
    const formData = new FormData();
    Object.entries(event).forEach(([key, value]) => formData.append(decamelize(`event[${key}]`), value));
    Object.entries(passenger).forEach(([key, value]) => formData.append(decamelize(`passenger[${key}]`), value));

    return api.post(`${path}/${resource}`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },
};

export default eventService;
