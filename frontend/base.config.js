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
    application: ['./app/entry'], // workaround for require allowing (fixed in webpack 2)
  },
  module: {
    resolve: {
      extensions: ['', '.js'],
      modulesDirectories: [ 'node_modules' ],
      alias: {
        libs: path.join(__dirname, 'app', 'libs'),
      }
    },
    loaders: [
      {
        test: /\.js$/,
        // include: [ path.resolve(__dirname + '/../protected/assets') ],
        exclude: /node_modules/,
        loader: 'babel?presets[]=es2015'
      },
    ],
  },
  plugins: [
    new AssetsPlugin({prettyPrint: true}),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    })
  ]
};
