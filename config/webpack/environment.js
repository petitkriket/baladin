const { environment } = require('@rails/webpacker');
const path = require('path');
// eslint-disable-next-line import/no-extraneous-dependencies
const { DefinePlugin } = require('webpack');
const { VueLoaderPlugin } = require('vue-loader');
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

const customConfig = {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, '..', '..', 'app/javascript/src'),
    },
  },
};

environment.config.merge(customConfig);

environment.plugins.append(
  'BundleAnalyzer',
  new BundleAnalyzerPlugin(),
);

environment.plugins.prepend(
  'VueLoaderPlugin',
  new VueLoaderPlugin(),
);

environment.plugins.prepend(
  'Define',
  new DefinePlugin({
    __VUE_OPTIONS_API__: true,
    __VUE_PROD_DEVTOOLS__: false,
  }),
);

const vue = require('./loaders/vue');

environment.loaders.prepend('vue', vue);

environment.splitChunks();

module.exports = environment;
