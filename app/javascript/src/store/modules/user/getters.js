export const IS_AUTHENTIFIED = 'IS_AUTHENTIFIED';

export const getters = {
  [IS_AUTHENTIFIED]: (state) => !!state.token,
};
