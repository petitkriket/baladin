export const setErrorServer = (error) => ({
  type: 'error_server',
  status: error.request.status,
  errors: error.response.data,
});

export default { setErrorServer };
