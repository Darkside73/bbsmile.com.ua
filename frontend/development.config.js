const webpack = require('webpack');

module.exports = {
  debug: true,
  displayErrorDetails: true,
  outputPathinfo: true,
  devtool: 'eval-source-map',
  output: {
    devtoolModuleFilenameTemplate: '[resourcePath]',
    devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: 'style!css?sourceMap' },
      { test: /\.less$/, loader: 'style!css?sourceMap!less?sourceMap' },
      {
        test: /\.(png|jpg|gif)$/,
        loader: 'url?name=[path][name].[ext]&limit=8192'
      },
      {
        test: /\.(ttf|eot|svg|woff(2)?)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file?name=[path][name].[ext]'
      }
    ]
  },
  plugins: [
  ]
};
