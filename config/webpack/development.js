/* eslint-disable import/no-extraneous-dependencies */
process.env.NODE_ENV = process.env.NODE_ENV || 'development';
const StylelintPlugin = require('stylelint-webpack-plugin');
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');
const environment = require('./environment');

environment.plugins.append(
  'StylelintPlugin',
  new StylelintPlugin({
    files: ['app/javascript/src/**/*.vue'],
  }),
);

environment.plugins.append(
  'BundleAnalyzer',
  new BundleAnalyzerPlugin({
    openAnalyzer: false,
  }),
);

module.exports = environment.toWebpackConfig();
