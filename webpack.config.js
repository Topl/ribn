const path = require("path");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");

module.exports = {
	mode: "development",
	devtool: "inline-source-map",
	entry: {
		background: path.join(__dirname, "web", "src", "scripts", "background.ts"),
		content: path.join(__dirname, "web", "src", "scripts", "content.ts"),
		injected: path.join(__dirname, "web", "src", "scripts", "injected.ts"),
	},
	module: {
		rules: [{ test: /\.ts?$/, use: "ts-loader", exclude: /node_modules/ }],
	},
	resolve: {
		extensions: [".ts", ".js"],
	},
	plugins: [
		new CleanWebpackPlugin({ cleanStaleWebpackAssets: false }),
	],
	output: {
		filename: "[name].bundle.js",
		path: path.resolve(__dirname, "web", "dist"),
	},
};
