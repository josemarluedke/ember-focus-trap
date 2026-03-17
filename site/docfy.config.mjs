import path from 'path';
import { fileURLToPath } from 'url';
import autolinkHeadings from 'rehype-autolink-headings';
import highlight from 'rehype-highlight';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export default {
  repository: {
    url: 'https://github.com/josemarluedke/ember-focus-trap',
    editBranch: 'main',
  },
  tocMaxDepth: 3,
  rehypePlugins: [
    [autolinkHeadings, { behavior: 'wrap' }],
    [highlight, { aliases: { javascript: 'gjs', typescript: 'gts' } }],
  ],
  sources: [
    {
      root: path.join(__dirname, '../docs'),
      pattern: '**/*.md',
      urlPrefix: 'docs',
    },
  ],
  labels: {
    docs: 'Docs',
  },
};
