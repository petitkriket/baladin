module.exports = {
  processors: [
    ['@mapbox/stylelint-processor-arbitrary-tags', { fileFilterRegex: [/\.vue$/] }],
  ],
  extends: [
    'stylelint-config-standard',
    'stylelint-config-recess-order',
  ],
  rules: {
    'no-empty-source': null,
  },
  ignoreFiles: [
    'vendor/**/*',
    'app/assets/**/*',
    'public/**/*',
    '**/*.js',
    '**/*.ts',
  ],
};
