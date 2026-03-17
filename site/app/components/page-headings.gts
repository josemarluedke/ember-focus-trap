import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { DocfyOutput } from '@docfy/ember';

const docfyEq = (a: string, b?: string): boolean => a === b;

const stripHtml = (html: string): string => {
  return html.replace(/<[^>]*>/g, '');
};

const easeInOutQuad = (
  t: number,
  b: number,
  c: number,
  d: number,
): number => {
  t /= d / 2;
  if (t < 1) {
    return (c / 2) * t * t + b;
  }
  t--;
  return (-c / 2) * (t * (t - 2) - 1) + b;
};

function scrollTo(
  toPosition: number,
  callback?: () => void,
  duration = 500,
): void {
  const scrollingElement = document.scrollingElement
    ? document.scrollingElement
    : document.body;
  const startPosition = scrollingElement.scrollTop;
  const change = toPosition - startPosition;
  let currentTime = 0;
  const increment = 20;

  const animateScroll = (): void => {
    currentTime += increment;
    scrollingElement.scrollTop = easeInOutQuad(
      currentTime,
      startPosition,
      change,
      duration,
    );

    if (currentTime < duration) {
      requestAnimationFrame(animateScroll);
    } else {
      if (callback && typeof callback === 'function') {
        callback();
      }
    }
  };
  animateScroll();
}

function scrollToElement(element: HTMLElement, duration = 500): void {
  const toPosition = element.offsetTop;
  scrollTo(toPosition, undefined, duration);
}

interface Signature {
  Args: {
    currentHeadingId?: string;
  };
}

export default class PageHeadings extends Component<Signature> {
  onClick = (evt: MouseEvent): void => {
    const href = (evt.target as HTMLElement).getAttribute('href');
    if (href) {
      const toElement = document.querySelector(href) as HTMLElement;
      scrollToElement(toElement);
    }
  }

  <template>
    <div
      class="overflow-y-auto sticky top-20 max-h-[calc(100vh-6rem)] pt-8 pb-4 text-sm text-gray-600 dark:text-gray-400"
    >
      <DocfyOutput @fromCurrentURL={{true}} as |page|>
        {{#if page.headings.length}}
          <div class="mb-2 font-semibold text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
            On this page
          </div>
          <ul>
            {{#each page.headings as |heading|}}
              <li class="border-l border-gray-200 dark:border-gray-700">
                <a
                  href="#{{heading.id}}"
                  class="transition block px-3 py-1 border-l-2 hover:text-primary-600 dark:hover:text-primary-400
                    {{if
                      (docfyEq heading.id @currentHeadingId)
                      'border-primary-500 text-primary-600 dark:text-primary-400 font-medium'
                      'border-transparent'
                    }}"
                  {{on "click" this.onClick}}
                >
                  {{stripHtml heading.title}}
                </a>

                {{#if heading.headings.length}}
                  <ul>
                    {{#each heading.headings as |subHeading|}}
                      <li>
                        <a
                          href="#{{subHeading.id}}"
                          class="transition block pl-6 py-1 border-l-2 hover:text-primary-600 dark:hover:text-primary-400
                            {{if
                              (docfyEq subHeading.id @currentHeadingId)
                              'border-primary-500 text-primary-600 dark:text-primary-400 font-medium'
                              'border-transparent'
                            }}"
                          {{on "click" this.onClick}}
                        >
                          {{stripHtml subHeading.title}}
                        </a>
                      </li>
                    {{/each}}
                  </ul>
                {{/if}}
              </li>
            {{/each}}
          </ul>
        {{/if}}
      </DocfyOutput>
    </div>
  </template>
}
