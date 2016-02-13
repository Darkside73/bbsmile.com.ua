const path = require('path')
const webpack = require('webpack');
const CleanPlugin = require('clean-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const CompressionPlugin = require("compression-webpack-plugin");
const RenameFilesPlugin = require("./webpack/plugins/rename-files");

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
    new CompressionPlugin({ test: /\.js$|\.css$/ }),
    new CleanPlugin(
      path.join('public', 'assets'),
      { root: path.join(process.cwd()) }
    ),
    new RenameFilesPlugin(path.join(process.cwd(), 'public', 'assets'), [
      {
        test: /^bundle-tinymce_content_styles-.+\.css$/,
        destination: 'tinymce_content_styles.css'
      }
    ])
  ]
};
