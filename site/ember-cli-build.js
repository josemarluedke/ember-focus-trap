'use strict';

// Enable FastBoot Rehydration
process.env.EXPERIMENTAL_RENDER_MODE_SERIALIZE = true;

const EmberApp = require('ember-cli/lib/broccoli/ember-app');
const env = EmberApp.env();

const postcssPlugins = [
  require('postcss-import')({ path: ['../node_modules'] }),
  require('tailwindcss')('./tailwind.config.js'),
  require('postcss-nested'),
  require('autoprefixer')({
    overrideBrowserslist: require('./config/targets').browsers
  })
];

if (env !== 'development') {
  process.env.PURGE_CSS = 'true';
}
if (env === 'production') {
  // Tailwind JIT
  process.env.TAILWIND_MODE = 'build';
}

module.exports = function (defaults) {
  let app = new EmberApp(defaults, {
    prember: {
      urls: ['/']
    },
    fastboot: {
      hostWhitelist: [/^localhost:\d+$/]
    },
    postcssOptions: {
      compile: {
        enabled: true,
        cacheInclude: [/.*\.css$/, /tailwind\.config\.js$/],
        plugins: postcssPlugins
      }
    }
  });
  return app.toTree();
};
