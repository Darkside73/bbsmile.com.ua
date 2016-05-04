const webpack = require('webpack');
const WebpackDevServer = require('webpack-dev-server');
const config = require('./webpack.config');
const hotRailsPort = process.env.HOT_RAILS_PORT || 3550;

config.output.publicPath = `http://localhost:${hotRailsPort}/assets/webpack/`;
['application', 'main_page',
  'inner_page', 'product_page', 'admin_panel'].forEach(entryName => {
  config.entry[entryName].push(
    'webpack-dev-server/client?http://localhost:' + hotRailsPort,
    'webpack/hot/only-dev-server'
  );
});

config.plugins.push(
  new webpack.optimize.OccurenceOrderPlugin(),
  new webpack.HotModuleReplacementPlugin(),
  new webpack.NoErrorsPlugin()
);

new WebpackDevServer(webpack(config), {
  publicPath: config.output.publicPath,
  hot: true,
  inline: true,
  historyApiFallback: true,
  quiet: false,
  noInfo: false,
  lazy: false,
  stats: {
    colors: true,
    hash: false,
    version: false,
    chunks: false,
    children: false,
  }
}).listen(hotRailsPort, 'localhost', function (err, result) {
  if (err) console.log(err)
  console.log(
    '=> 🔥  Webpack development server is running on port ' + hotRailsPort
  );
})
