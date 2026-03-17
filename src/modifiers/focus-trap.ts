import { setModifierManager, capabilities } from '@ember/modifier';
import { createFocusTrap as CreateFocusTrap } from 'focus-trap';

import type { Options as FocusTrapOptions } from 'focus-trap';
import type { ModifierLike } from '@glint/template';

let cap: ReturnType<typeof capabilities>;
try {
  cap = capabilities('3.22');
} catch {
  // @ts-expect-error we support older versions of Ember
  cap = capabilities('3.13');
}

interface FocusTrapState {
  focusTrapOptions: FocusTrapOptions;
  isActive: boolean;
  isPaused: boolean;
  shouldSelfFocus: boolean;
  focusTrap?: ReturnType<typeof CreateFocusTrap>;
}

export interface FocusTrapModifierSignature {
  Element: HTMLElement;
  Args: {
    Named: {
      /**
       * Whether the focus trap is active. When set to `false`, the trap will be
       * deactivated (returning focus if `returnFocusOnDeactivate` is not `false`).
       *
       * @default true
       */
      isActive?: boolean;
      /**
       * Whether the focus trap is paused. A paused trap releases focus
       * but remains ready to re-engage when unpaused.
       *
       * @default false
       */
      isPaused?: boolean;
      /**
       * When `true`, sets `initialFocus` to the trap's own element,
       * causing the container itself to receive focus on activation.
       * Ignored if `focusTrapOptions.initialFocus` is already set.
       *
       * @default false
       */
      shouldSelfFocus?: boolean;
      /**
       * Configuration options passed directly to the underlying
       * {@link https://github.com/focus-trap/focus-trap#createoptions | focus-trap} library.
       */
      focusTrapOptions?: FocusTrapOptions;
      /**
       * Additional elements to include in the focus trap alongside the
       * modifier's element, creating a multi-container trap.
       * Accepts DOM elements or CSS selector strings.
       */
      additionalElements?: (string | HTMLElement | SVGElement)[];
      /**
       * Custom factory function for creating the focus trap instance.
       * Primarily useful for testing (e.g. injecting a stub).
       *
       * @internal
       */
      _createFocusTrap?: typeof CreateFocusTrap;
    };
  };
}

type FocusTrapModifierArgs = FocusTrapModifierSignature['Args']['Named'];

const focusTrapModifier = {};

setModifierManager(() => {
  return {
    capabilities: cap,

    createModifier(): FocusTrapState {
      return {
        focusTrapOptions: {},
        isActive: true,
        isPaused: false,
        shouldSelfFocus: false,
        focusTrap: undefined,
      };
    },

    installModifier(
      state: FocusTrapState,
      element: HTMLElement,
      { named }: { named: FocusTrapModifierArgs },
    ): void {
      const {
        isActive,
        isPaused,
        shouldSelfFocus,
        focusTrapOptions,
        additionalElements,
        _createFocusTrap,
      } = named;

      state.focusTrapOptions = { ...focusTrapOptions };
      state.isActive = isActive ?? true;
      state.isPaused = isPaused ?? false;

      if (!state.focusTrapOptions.initialFocus && shouldSelfFocus) {
        state.focusTrapOptions.initialFocus = element;
      }

      if (state.focusTrapOptions.returnFocusOnDeactivate !== false) {
        state.focusTrapOptions.returnFocusOnDeactivate = true;
      }

      const createFocusTrap = _createFocusTrap ?? CreateFocusTrap;

      state.focusTrap = createFocusTrap(
        additionalElements ? [element, ...additionalElements] : element,
        state.focusTrapOptions,
      );

      if (state.isActive) {
        state.focusTrap.activate();
      }
      if (state.isPaused) {
        state.focusTrap.pause();
      }
    },

    updateModifier(
      state: FocusTrapState,
      { named: params }: { named: FocusTrapModifierArgs },
    ): void {
      const focusTrapOptions: FocusTrapOptions = params.focusTrapOptions || {};

      if (state.isActive && !params.isActive) {
        const returnFocus = focusTrapOptions.returnFocusOnDeactivate ?? true;
        state.focusTrap?.deactivate({ returnFocus });
      } else if (!state.isActive && params.isActive) {
        state.focusTrap?.activate();
      }

      if (state.isPaused && !params.isPaused) {
        state.focusTrap?.unpause();
      } else if (!state.isPaused && params.isPaused) {
        state.focusTrap?.pause();
      }

      state.focusTrapOptions = focusTrapOptions;
      state.isActive = params.isActive ?? state.isActive;
      state.isPaused = params.isPaused ?? state.isPaused;
    },

    destroyModifier(state: FocusTrapState): void {
      if (state.focusTrap) {
        state.focusTrap.deactivate();
      }
    },
  };
}, focusTrapModifier);

export default focusTrapModifier as unknown as ModifierLike<FocusTrapModifierSignature>;
