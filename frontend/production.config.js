const path = require('path')
const webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const CleanPlugin = require('clean-webpack-plugin');

module.exports = {
  output: {
    filename: './bundle-[name]-[chunkhash].js',
    chunkFilename: 'bundle-[name]-[chunkhash].js',
    publicPath: '/assets/'
  },
  module: {
    loaders: [
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract("style-loader", "css?minimize")
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract(
          "style-loader", "css?minimize!resolve-url!sass"
        )
      },
      { test: /\.(png|jpg|gif)$/, loader: 'url?limit=8192' },
      {
        test: /\.(ttf|eot|svg|woff(2)?)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file'
      }
    ]
  },
  plugins: [
    new webpack.optimize.CommonsChunkPlugin(
      'common', 'bundle-[name]-[hash].js'
    ),
    new ExtractTextPlugin("bundle-[name]-[chunkhash].css", {
      allChunks: true
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      mangle: true,
      compress: {
        warnings: false
      }
    }),
    new CleanPlugin(
      path.join('public', 'assets'),
      { root: path.join(process.cwd()) }
    )
  ]
};
