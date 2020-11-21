/* eslint-disable import/no-extraneous-dependencies */
process.env.NODE_ENV = process.env.NODE_ENV || 'development';
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');
const StylelintPlugin = require('stylelint-webpack-plugin');
// const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');
const path = require('path');
const environment = require('./environment');

// environment.plugins.append('BundleAnalyzer', new BundleAnalyzerPlugin());

environment.plugins.append(
  'StylelintPlugin',
  new StylelintPlugin({
    files: ['app/javascript/src/**/*.vue'],
  }),
);

environment.plugins.append(
  'ForkTsCheckerWebpackPlugin',
  new ForkTsCheckerWebpackPlugin({
    typescript: {
      configFile: path.resolve(__dirname, '../../tsconfig.json'),
    },
    async: false,
  }),
);
module.exports = environment.toWebpackConfig();
