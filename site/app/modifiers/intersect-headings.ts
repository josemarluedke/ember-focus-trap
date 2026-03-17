import Modifier, {
  type ArgsFor,
  type PositionalArgs,
  type NamedArgs,
} from 'ember-modifier';
import { action } from '@ember/object';
import { registerDestructor } from '@ember/destroyable';

interface Heading {
  id: string;
  headings: Heading[];
}

function getHeadingIds(headings: Heading[], output: string[] = []): string[] {
  if (typeof headings === 'undefined') {
    return [];
  }
  headings.forEach((heading) => {
    output.push(heading.id);
    getHeadingIds(heading.headings, output);
  });
  return output;
}

interface Signature {
  Args: {
    Named: {
      headings: Heading[];
      onIntersect: (headingId: string) => void;
    };
    Positional: unknown[];
  };
  Element: Element;
}

export default class IntersectHeadingsModifier extends Modifier<Signature> {
  handler: ((headingId: string) => void) | null = null;
  headings: string[] = [];
  observer: IntersectionObserver | null = null;
  activeIndex: number = -1;

  @action
  handleObserver(elements: IntersectionObserverEntry[]): void {
    let localActiveIndex: number = this.activeIndex || -1;

    const aboveIndeces: number[] = [];
    const belowIndeces: number[] = [];

    elements.forEach((element) => {
      const boundingClientRectY =
        typeof element.boundingClientRect.y !== 'undefined'
          ? element.boundingClientRect.y
          : element.boundingClientRect.top;
      const rootBoundsY =
        typeof element.rootBounds?.y !== 'undefined'
          ? element.rootBounds.y
          : element.rootBounds?.top;
      const isAbove = boundingClientRectY < (rootBoundsY || 0);

      const id = element.target.getAttribute('id');
      const intersectingElemIdx = this.headings.findIndex(
        (item) => item == id,
      );

      if (isAbove) aboveIndeces.push(intersectingElemIdx);
      else belowIndeces.push(intersectingElemIdx);
    });

    const minIndex = Math.min(...belowIndeces);
    const maxIndex = Math.max(...aboveIndeces);

    if (aboveIndeces.length > 0) {
      localActiveIndex = maxIndex;
    } else if (belowIndeces.length > 0 && minIndex <= this.activeIndex) {
      localActiveIndex = minIndex - 1 >= 0 ? minIndex - 1 : 0;
    }

    if (localActiveIndex != this.activeIndex) {
      this.activeIndex = localActiveIndex;
      if (typeof this.handler === 'function') {
        this.handler(this.headings[this.activeIndex] as string);
      }
    }
  }

  observe(): void {
    if ('IntersectionObserver' in window) {
      this.observer = new IntersectionObserver(this.handleObserver, {
        rootMargin: '-96px',
        threshold: 1.0,
      });

      this.headings.forEach((id) => {
        const el = document.getElementById(id);
        if (el) {
          this.observer?.observe(el);
        }
      });
    }
  }

  unobserve(): void {
    if (this && this.observer) {
      this.observer.disconnect();
    }
  }

  constructor(owner: unknown, args: ArgsFor<Signature>) {
    super(owner as never, args);
    this.handler = args.named.onIntersect;
    this.headings = getHeadingIds(args.named.headings);

    this.observe();

    registerDestructor(this, this.unobserve);
  }

  modify(
    _element: HTMLElement,
    _: PositionalArgs<Signature>,
    args: NamedArgs<Signature>,
  ): void {
    if (this.observer) {
      this.unobserve();
    }
    this.handler = args.onIntersect;
    this.headings = getHeadingIds(args.headings);

    this.observe();

    registerDestructor(this, this.unobserve);
  }
}
