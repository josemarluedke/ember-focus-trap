import Component from '@glimmer/component';
import { service } from '@ember/service';
import { on } from '@ember/modifier';
import { tracked } from '@glimmer/tracking';
import { DocfyLink, DocfyOutput, DocfyPreviousAndNextPage, type DocfyService } from '@docfy/ember';
import PageHeadings from './page-headings';
import intersectHeadings from '../modifiers/intersect-headings';

interface DocsLayoutSignature {
  Args: Record<string, never>;
  Element: HTMLDivElement;
  Blocks: {
    default: [];
  };
}

export default class DocsLayout extends Component<DocsLayoutSignature> {
  @service declare docfy: DocfyService;

  @tracked isMenuOpen = false;
  @tracked currentHeadingId?: string;

  toggleMenu = () => {
    this.isMenuOpen = !this.isMenuOpen;
  }

  closeMenu = () => {
    this.isMenuOpen = false;
  }

  setCurrentHeadingId = (id: string): void => {
    this.currentHeadingId = id;
  };

  <template>
    <div class="max-w-screen-xl mx-auto px-4">
      <div class="relative lg:flex">
        {{! Mobile menu toggle }}
        <div class="pt-4 lg:hidden">
          <button
            type="button"
            class="flex items-center px-4 py-2 border border-gray-300 dark:border-gray-600 rounded text-sm text-gray-700 dark:text-gray-300"
            {{on "click" this.toggleMenu}}
          >
            <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
              <path
                d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                clip-rule="evenodd"
                fill-rule="evenodd"
              ></path>
            </svg>
            Contents
          </button>
        </div>

        {{! Left Sidebar }}
        <div
          class="flex-none pt-4 pr-4 lg:w-56 lg:pt-8 lg:block
            {{if this.isMenuOpen 'block' 'hidden'}}"
        >
          <nav
            class="font-light space-y-1 lg:sticky lg:top-20 lg:overflow-y-auto lg:max-h-[calc(100vh-6rem)]"
          >
            {{#let this.docfy.nested as |node|}}
              <ul class="space-y-1">
                {{#each node.pages as |page|}}
                  <li>
                    <DocfyLink
                      @to={{page.url}}
                      class="block px-3 py-1.5 rounded text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 hover:text-primary-600 dark:hover:text-primary-400"
                      @activeClass="bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-400 font-medium"
                      {{on "click" this.closeMenu}}
                    >
                      {{page.title}}
                    </DocfyLink>
                  </li>
                {{/each}}

                {{#each node.children as |child|}}
                  <li class="pt-2">
                    <div
                      class="px-3 pb-1 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400"
                    >
                      {{child.label}}
                    </div>
                    <ul class="space-y-1">
                      {{#each child.pages as |page|}}
                        <li>
                          <DocfyLink
                            @to={{page.url}}
                            class="block px-3 py-1.5 rounded text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 hover:text-primary-600 dark:hover:text-primary-400"
                            @activeClass="bg-primary-50 dark:bg-primary-900/20 text-primary-700 dark:text-primary-400 font-medium"
                            {{on "click" this.closeMenu}}
                          >
                            {{page.title}}
                          </DocfyLink>
                        </li>
                      {{/each}}
                    </ul>
                  </li>
                {{/each}}
              </ul>
            {{/let}}
          </nav>
        </div>

        {{! Main content }}
        <div class="flex-1 min-w-0 py-8 lg:px-6">
          <DocfyOutput @fromCurrentURL={{true}} as |page|>
            <div
              class="prose dark:prose-invert max-w-none"
              {{intersectHeadings
                onIntersect=this.setCurrentHeadingId
                headings=page.headings
              }}
            >
              {{yield}}
            </div>
          </DocfyOutput>

          {{! Previous / Next navigation }}
          <div class="flex flex-wrap justify-between mt-8 pt-6 border-t border-gray-200 dark:border-gray-700">
            <DocfyPreviousAndNextPage as |previous next|>
              <div class="flex items-center pr-2">
                {{#if previous}}
                  <svg class="h-4 mr-2 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
                    <path
                      d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z"
                      clip-rule="evenodd"
                      fill-rule="evenodd"
                    ></path>
                  </svg>
                  <DocfyLink
                    @to={{previous.url}}
                    class="text-primary-600 dark:text-primary-400 hover:text-primary-700 dark:hover:text-primary-300"
                  >
                    {{previous.title}}
                  </DocfyLink>
                {{/if}}
              </div>
              <div class="flex items-center pl-2">
                {{#if next}}
                  <DocfyLink
                    @to={{next.url}}
                    class="text-primary-600 dark:text-primary-400 hover:text-primary-700 dark:hover:text-primary-300"
                  >
                    {{next.title}}
                  </DocfyLink>
                  <svg class="h-4 ml-2 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
                    <path
                      d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z"
                      clip-rule="evenodd"
                      fill-rule="evenodd"
                    ></path>
                  </svg>
                {{/if}}
              </div>
            </DocfyPreviousAndNextPage>
          </div>
        </div>

        {{! Right sidebar - Page headings (TOC) }}
        <div class="flex-none hidden w-52 pl-4 xl:block">
          <PageHeadings @currentHeadingId={{this.currentHeadingId}} />
        </div>
      </div>
    </div>
  </template>
}
