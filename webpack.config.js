var HtmlWebpackPlugin = require('html-webpack-plugin');
const webpack = require('webpack');
const path = require('path');


var DEVELOPMENT = process.env.NODE_ENV === 'development';
var PRODUCTION = process.env.NODE_ENV === 'production';
var TEST = process.env.NODE_ENV === 'test'

module.exports = {
    entry: "./src/lib.jsx",
    output:  {
      path: path.resolve(__dirname, "dist"),
      filename: "[name].bundle.js",
      publicPath: "/"
    },
    module: {
      rules: [
        {
          test: /\.(js|jsx)$/,
          use: [{
            loader: "babel-loader",
            options: {presets:["react","es2015","stage-0"]}
          }],
          exclude: /(node_modules)/
        }
      ]
    },
    resolve:{
      modules:[
        "node_modules",
        path.resolve(__dirname, "src")
      ],
      extensions: [
        ".js", ".jsx"
      ],
    },
    performance: {
      hints: "warning",
      maxAssetSize: 200000,
      maxEntrypointSize: 400000
    },
    devtool: "source-map",
    context: __dirname,
    target: "web",
    stats: {
      assets: true,
      colors: true,
      errors: true,
      hash: true
    },
    devServer:{
      contentBase: path.join(__dirname, 'dist'),
      compress: true,
      historyApiFallback: true,
      hot: true,
      noInfo: true
    },
    plugins: [
      new webpack.DefinePlugin({
        'process.env': {
          NODE_ENV: JSON.stringify(process.env.NODE_ENV),
        }
      }),
      new webpack.HotModuleReplacementPlugin(),
      new HtmlWebpackPlugin({
        title: 'Component Library',
        template: 'index-template.html'
      }),
      new webpack.optimize.CommonsChunkPlugin({
       name: 'common' // Specify the common bundle's name.
     })
    ]
}
