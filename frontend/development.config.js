const webpack = require('webpack');

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
        test: /\.(ttf|eot|svg|woff(2)?)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file?name=[path][name].[ext]'
      },
    ]
  },
  plugins: [
  ]
};
