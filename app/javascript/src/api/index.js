import axios from 'axios';

import { transformResponse, transformRequest } from './utils/parsers';
import { exceptionHandler, successHandler } from './utils/exception-handling';

const api = axios.create({
  withCredentials: true,
  transformResponse,
  transformRequest,
});

api.interceptors.request.use(
  (response) => {
    successHandler(response);
    return Promise.resolve(response);
  },
  (error) => {
    exceptionHandler(error);
    return Promise.reject(error);
  },
);

export default api;
