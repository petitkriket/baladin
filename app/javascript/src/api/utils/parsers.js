import axios from 'axios';
import humps from 'humps';

// Parses JSON responses keys to camelCase
const transformResponse = [
  ...axios.defaults.transformResponse,
  (data, headers) => (data && /json/.test(headers['content-type'])
    ? humps.camelizeKeys(data, (key, convert) => convert(key))
    : data),
];

// Parses JSON requests keys to snake_case except for form-data
const transformRequest = [
  (data, headers) => (data && headers['Content-Type'] === 'multipart/form-data'
    ? data
    : humps.decamelizeKeys(data, (key, convert, options) => (/^[A-Z0-9_]+$/.test(key) ? key : convert(key, options)))),
  ...axios.defaults.transformRequest,
];

export { transformResponse, transformRequest };
