import axios from 'axios';

import { transformResponse, transformRequest } from './utils/parsers';

const api = axios.create({
  withCredentials: true,
  transformResponse,
  transformRequest,
});

api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('user-token');
    if (token) {
      // eslint-disable-next-line no-param-reassign
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
);

export default api;
