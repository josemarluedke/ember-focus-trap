const { join } = require('path');

module.exports = {
  root: true,
  parserOptions: {
    project: join(__dirname, './tsconfig.eslint.json')
  },
  extends: ['@underline/eslint-config-ember-typescript'],
  rules: {
    '@typescript-eslint/no-empty-interface': 'off',
    'ember/no-empty-glimmer-component-classes': 'off',
    '@typescript-eslint/ban-types': ['off', { types: { object: null } }]
  },
  overrides: [
    {
      files: ['{packages,examples}/**/tests/**/*.ts'],
      rules: {
        '@typescript-eslint/explicit-function-return-type': 'off',
        '@typescript-eslint/no-non-null-assertion': 'off'
      }
    },

    // node files
    {
      files: [
        'addon-main.js',
        '.babelrc.js',
        'babel.config.js',
        '.docfy-config.js',
        '.ember-cli.js',
        '.eslintrc.js',
        '.prettierrc.js',
        '.template-lintrc.js',
        'config/**/*.js',
        'ember-addon-main.js',
        'ember-cli-build.js',
        'postcss.config.js',
        'tailwind.config.js',
        'testem.js',
        'webpack.config.js',
        'scripts/**/*.js',
        'packages/*/config/**/*.js',
        'packages/*/tests/dummy/config/**/*.js',
        'packages/*/config/**/*.js',
        'site/config/**/*.js',
        'site/tests/dummy/config/**/*.js'
      ],
      extends: ['@underline/eslint-config-node'],
      rules: {}
    }
  ]
};
