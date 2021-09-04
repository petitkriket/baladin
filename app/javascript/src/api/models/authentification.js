import { decamelize } from 'humps';

import api from '../index';

const path = '/api/v1';

const authenticationService = {
  signUp(user) {
    return api.post(`${path}/signup/`, user);
  },
  signUpAndContribute(user, event) {
    const formData = new FormData();

    Object.entries(user).forEach(([key, value]) => formData.append(decamelize(`user[${key}]`), value));
    Object.entries(event).forEach(([key, value]) => formData.append(decamelize(`event[${key}]`), value));

    return api.post(`${path}/signup/`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },
  signIn(user) {
    return api.post(`${path}/signin/`, user);
  },
  signOut() {
    return api.delete(`${path}/signout/`);
  },
};

export default authenticationService;
