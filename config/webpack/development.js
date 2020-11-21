/* eslint-disable import/no-extraneous-dependencies */
process.env.NODE_ENV = process.env.NODE_ENV || 'development';
const StylelintPlugin = require('stylelint-webpack-plugin');
const environment = require('./environment');

environment.plugins.append(
  'StylelintPlugin',
  new StylelintPlugin({
    files: ['app/javascript/src/**/*.vue'],
  }),
);

module.exports = environment.toWebpackConfig();
