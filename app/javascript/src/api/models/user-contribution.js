import api from '../index';

const path = '/api/v1';
const resource = 'contributions';

const userContributionService = {
  getAll() {
    return api.get(`${path}/${resource}`);
  },
};

export default userContributionService;
