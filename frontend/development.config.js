const webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  debug: true,
  displayErrorDetails: true,
  outputPathinfo: true,
  devtool: 'eval-source-map',
  output: {
    devtoolModuleFilenameTemplate: info => {
      if (info.resource.match(/\.vue$/)) {
        $filename = info.allLoaders.match(/type=script/)
                  ? info.resourcePath : 'generated';
      } else {
        $filename = info.resourcePath;
      }
      return $filename;
    },
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: 'style!css?sourceMap' },
      {
        test: /\.scss$/,
        loader: 'style!css?sourceMap!resolve-url!sass?sourceMap'
      },
      {
        test: /\.(png|jpg|gif)$/,
        loader: 'url?name=[path][name].[ext]&limit=8192'
      },
      {
        test: /\.(ttf|eot|svg|woff(2)?)(\?.+)?$/,
        loader: 'file?name=[path][name].[ext]'
      },
      {
        test: /tinymce_content_styles\.scss/,
        loader: ExtractTextPlugin.extract("style-loader", "css!resolve-url!sass")
      }
    ]
  },
  plugins: [
    new ExtractTextPlugin("[name].css", {allChunks: true }),
  ]
};
