// Should summon toast notifications here
// Critical errors (40x, 50x) should be sent to Sentry SDK
export const exceptionHandler = (error) => error;
export const successHandler = (response) => response;
