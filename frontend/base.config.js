const path = require('path');
const webpack = require('webpack');
const AssetsPlugin = require('assets-webpack-plugin');

module.exports = {
  context: __dirname,
  output: {
    path: path.join(__dirname, '..', 'public', 'assets'),
    filename: 'bundle-[name].js'
  },
  entry: {
    application: ['./app/base-entry'], // workaround for require allowing (fixed in webpack 2)
    main_page: ['./app/pages/main'],
  },
  resolve: {
    extensions: ['', '.js', '.coffee'],
    modulesDirectories: [ 'node_modules' ],
    alias: {
      libs: path.join(__dirname, 'libs'),
      common: path.join(__dirname, 'app', 'common'),
    }
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        include: [ path.resolve(__dirname + 'frontend/app') ],
        loader: 'babel?presets[]=es2015'
      },
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.vue$/, loader: 'vue' }
    ],
  },
  plugins: [
    new AssetsPlugin({prettyPrint: true}),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      '_': 'underscore'
    }),
    new webpack.DefinePlugin({
      __RAILS_ENV__: JSON.stringify(process.env.RAILS_ENV || 'development')
    })
  ]
};
