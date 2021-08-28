import api from '../index';

const path = '/api/v1';
const resource = 'account';

const userAccountService = {
  update(user) {
    return api.put(`${path}/${resource}`, user);
  },
  delete() {
    return api.delete(`${path}/${resource}`);
  },
};

export default userAccountService;
