const path = require('path')
const webpack = require('webpack');
const CleanPlugin = require('clean-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

var extractCss = new ExtractTextPlugin("bundle-[name]-[chunkhash].css", {
  allChunks: true
});
var extractTinymceContentStyles = new ExtractTextPlugin("[name].css", {
  allChunks: true
});

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
        loader: extractCss.extract("style-loader", "css?minimize")
      },
      {
        test: /tinymce_content_styles\.scss/,
        loader: extractTinymceContentStyles.extract(
          "style-loader", "css!resolve-url!sass"
        )
      },
      {
        test: /\.scss$/,
        loader: extractCss.extract(
          "style-loader", "css?minimize!resolve-url!sass?sourceMap"
        )
      },
      { test: /\.(png|jpg|gif)$/, loader: 'url?limit=8192' },
      {
        test: /\.(ttf|eot|svg|woff(2)?)(\?.+)?$/,
        loader: 'file'
      },
    ]
  },
  plugins: [
    new webpack.optimize.CommonsChunkPlugin(
      'common', 'bundle-[name]-[hash].js'
    ),
    extractCss,
    extractTinymceContentStyles,
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
