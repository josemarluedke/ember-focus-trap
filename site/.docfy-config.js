const path = require('path');
const autolinkHeadings = require('remark-autolink-headings');
const withProse = require('@docfy/plugin-with-prose');
const codeTitle = require('remark-code-titles');
const highlight = require('rehype-highlight');

/**
 * @type {import('@docfy/core/lib/types').DocfyConfig}
 */
module.exports = {
  repository: {
    url: 'https://github.com/josemarluedke/ember-focus-trap',
    editBranch: 'main'
  },
  tocMaxDepth: 3,
  plugins: [withProse({ className: 'prose dark:prose-light' })],
  remarkPlugins: [codeTitle, autolinkHeadings],
  rehypePlugins: [highlight],
  sources: [
    {
      root: path.resolve(__dirname, '../docs'),
      pattern: '**/*.md',
      urlPrefix: 'docs'
    }
  ],
  labels: {
    docs: 'Docs',
    fetching: 'Fetching'
  }
};
