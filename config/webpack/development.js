process.env.NODE_ENV = process.env.NODE_ENV || 'development';
// eslint-disable-next-line import/no-extraneous-dependencies
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');
// eslint-disable-next-line import/no-extraneous-dependencies
// const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');
const path = require('path');
const environment = require('./environment');

// environment.plugins.append('BundleAnalyzer', new BundleAnalyzerPlugin());

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
