import api from '../index';

const path = '/api/v1';
const resource = 'account';

const userAccountService = {
  confirm(params) {
    return api.get(`${path}/confirmation`, { params });
  },
  get() {
    return api.get(`${path}/${resource}`);
  },
  update(user) {
    return api.put(`${path}/${resource}`, user);
  },
  delete() {
    return api.delete(`${path}/${resource}`);
  },
  reset(user) {
    return api.post(`${path}/reset`, user);
  },
  resetPassword(user) {
    return api.patch(`${path}/password`, user);
  },
};

export default userAccountService;
