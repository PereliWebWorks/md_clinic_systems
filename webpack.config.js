const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const {VueLoaderPlugin} = require('vue-loader')

module.exports = {
	mode: 'development',
	devtool: 'inline-source-map',
	entry: {
		app: './src/app.js'
	},
	module: {
	  rules: [
	    {
	      test: /\.vue$/,
	      use: 'vue-loader'
	    },
	    {
	      test: /\.css$/,
	      use: [
	        'vue-style-loader',
	        'css-loader'
	      ]
	    }
	  ]
	},
	plugins: [
		new VueLoaderPlugin(),
		new HtmlWebpackPlugin({template: './src/index.html'})
	],
	output: {
		filename: '[name].bundle.js',
		path: path.resolve(__dirname, 'dist')
	}
}