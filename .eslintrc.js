module.exports = {
  "env": {
    "es6": true,
    "node": true
  },
  "extends": [
      "eslint:recommended",
      "plugin:vue/recommended"
  ],
  "globals": {
      "Atomics": "readonly",
      "SharedArrayBuffer": "readonly"
  },
  "parserOptions": {
      "ecmaVersion": 11
  },
  "plugins": [
      "vue"
  ],
  "rules": {}
};