import api from '../index';

const path = '/api/v1';

const authenticationService = {
  signIn(user) {
    return api.post(`${path}/signin/`, user);
  },
  signOut() {
    return api.delete(`${path}/signout/`);
  },
};

export default authenticationService;
