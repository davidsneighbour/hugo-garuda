const path = require('path');
const webpack = require('webpack');
const VueLoaderPlugin = require('vue-loader/lib/plugin');

const fs = require('fs');

class MetaInfoPlugin {
  constructor(options) {
    this.options = { filename: 'meta.json', ...options };
  }

  apply(compiler) {
    compiler.hooks.done.tap(this.constructor.name, (stats) => {
      const metaInfo = {
        // add any other information if necessary
        hash: stats.hash,
      };
      const json = JSON.stringify(metaInfo);
      return new Promise((resolve, reject) => {
        fs.writeFile(this.options.filename, json, 'utf8', (error) => {
          if (error) {
            reject(error);
            return;
          }
          resolve();
        });
      });
    });
  }
}

module.exports = {
  mode: 'production',
  target: 'web',
  entry: {
    main: './javascript/main.js',
  },
  output: {
    path: path.resolve(__dirname, './public/theme/assets/scripts/'),
    publicPath: '/theme/assets/scripts/build.[hash].js',
    filename: 'build.[hash].js',
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          'vue-style-loader',
          'css-loader',
        ],
      }, {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: {},
          // other vue-loader options go here
        },
      },
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env'],
            cacheDirectory: true,
            cacheCompression: false,
          },
        },
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]?[hash]',
        },
      },
      // this will apply to both plain `.scss` files
      // AND `<style lang="scss">` blocks in `.vue` files
      {
        test: /\.scss$/,
        use: [
          'vue-style-loader',
          'css-loader',
          'sass-loader',
        ],
      },
    ],
  },
  resolve: {
    alias: {
      vue$: 'vue/dist/vue.esm.js',
    },
    extensions: ['*', '.js', '.vue', '.json'],
  },
  performance: {
    hints: false,
  },
  plugins: [
    new VueLoaderPlugin(),
    new MetaInfoPlugin({ filename: './public/theme/assets/scripts/meta.json' }),
  ],
};

if (process.env.NODE_ENV === 'production') {
  module.exports.plugins = (module.exports.plugins || []).concat([
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"',
      },
    }),
    new webpack.LoaderOptionsPlugin({
      minimize: true,
    }),
  ]);
}
