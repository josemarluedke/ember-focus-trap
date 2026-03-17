import { LinkTo } from '@ember/routing';
import { pageTitle } from 'ember-page-title';
import ThemeSwitcher from 'site/components/theme-switcher';

<template>
  {{pageTitle "Ember Focus Trap"}}

  <header class="sticky top-0 z-10 bg-gray-900 border-b border-gray-700">
    <div class="flex items-center h-16 px-4 mx-auto max-w-screen-xl">
      <LinkTo
        @route="index"
        class="text-xl font-semibold text-primary-500 hover:text-primary-400"
      >
        Ember Focus Trap
      </LinkTo>

      <nav class="flex items-center ml-auto gap-6">
        <LinkTo
          @route="docs"
          class="text-gray-200 hover:text-white pb-1 border-b-2 border-transparent hover:border-primary-500"
        >
          Docs
        </LinkTo>

        <a
          href="https://github.com/josemarluedke/ember-focus-trap"
          target="_blank"
          rel="noopener noreferrer"
          class="text-gray-200 hover:text-white"
        >
          <svg viewBox="0 0 20 20" class="w-5 h-5 fill-current">
            <title>GitHub</title>
            <path
              d="M10 0a10 10 0 0 0-3.16 19.49c.5.1.68-.22.68-.48l-.01-1.7c-2.78.6-3.37-1.34-3.37-1.34-.46-1.16-1.11-1.47-1.11-1.47-.9-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.08 2.91.83.1-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.94 0-1.1.39-1.99 1.03-2.69a3.6 3.6 0 0 1 .1-2.64s.84-.27 2.75 1.02a9.58 9.58 0 0 1 5 0c1.91-1.3 2.75-1.02 2.75-1.02.55 1.37.2 2.4.1 2.64.64.7 1.03 1.6 1.03 2.69 0 3.84-2.34 4.68-4.57 4.93.36.31.68.92.68 1.85l-.01 2.75c0 .26.18.58.69.48A10 10 0 0 0 10 0"
            ></path>
          </svg>
        </a>

        <ThemeSwitcher />
      </nav>
    </div>
  </header>

  <main
    class="min-h-screen bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
  >
    {{outlet}}
  </main>

  <footer
    class="border-t border-gray-300 dark:border-gray-700 p-4 text-center text-sm text-gray-700 dark:text-gray-300"
  >
    Released under MIT License - Created by
    <a
      href="https://github.com/josemarluedke"
      target="_blank"
      rel="noopener noreferrer"
      class="whitespace-nowrap text-primary-600 hover:underline"
    >
      Josemar Luedke
    </a>
  </footer>
</template>
