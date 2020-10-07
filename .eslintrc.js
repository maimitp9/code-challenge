module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: [
		"eslint:recommended",
		"plugin:vue/recommended",
		"@vue/prettier",
		"@vue/typescript"
	],
	parserOptions: {
		parser: '@typescript-eslint/parser'
	},
	plugins: ["vue"],
	rules: {}
};
