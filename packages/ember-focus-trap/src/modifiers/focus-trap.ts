import { setModifierManager, capabilities } from '@ember/modifier';
import { createFocusTrap as CreateFocusTrap } from 'focus-trap';
import type { Options as FocusTrapOptions } from 'focus-trap';

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

interface FocusTrapModifierArgs {
  isActive?: boolean;
  isPaused?: boolean;
  shouldSelfFocus?: boolean;
  focusTrapOptions?: FocusTrapOptions;
  additionalElements?: HTMLElement[];
  /**
   * Optional custom function to create a focus trap.
   */
  _createFocusTrap?: typeof CreateFocusTrap;
}

export default setModifierManager(
  () => {
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

        // Create a shallow copy of the options.
        state.focusTrapOptions = { ...focusTrapOptions };
        if (typeof isActive !== 'undefined') {
          state.isActive = isActive;
        }
        if (typeof isPaused !== 'undefined') {
          state.isPaused = isPaused;
        }
        if (
          state.focusTrapOptions &&
          typeof state.focusTrapOptions.initialFocus === 'undefined' &&
          shouldSelfFocus
        ) {
          state.focusTrapOptions.initialFocus = element;
        }

        // Allow a custom focus trap creation function (e.g., for testing).
        let createFocusTrap = CreateFocusTrap;
        if (_createFocusTrap) {
          createFocusTrap = _createFocusTrap;
        }

        // Ensure returnFocusOnDeactivate is true unless explicitly set to false.
        if (state.focusTrapOptions.returnFocusOnDeactivate !== false) {
          state.focusTrapOptions.returnFocusOnDeactivate = true;
        }

        state.focusTrap = createFocusTrap(
          typeof additionalElements !== 'undefined'
            ? [element, ...additionalElements]
            : element,
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
        const focusTrapOptions: FocusTrapOptions =
          params.focusTrapOptions || {};

        if (state.isActive && !params.isActive) {
          const { returnFocusOnDeactivate } = focusTrapOptions;
          const returnFocus =
            typeof returnFocusOnDeactivate === 'undefined' ? true : false;
          state.focusTrap?.deactivate({ returnFocus });
        } else if (!state.isActive && params.isActive) {
          state.focusTrap?.activate();
        }

        if (state.isPaused && !params.isPaused) {
          state.focusTrap?.unpause();
        } else if (!state.isPaused && params.isPaused) {
          state.focusTrap?.pause();
        }

        // Update state with new options.
        state.focusTrapOptions = focusTrapOptions;
        if (typeof params.isActive !== 'undefined') {
          state.isActive = params.isActive;
        }
        if (typeof params.isPaused !== 'undefined') {
          state.isPaused = params.isPaused;
        }
      },

      destroyModifier(state: FocusTrapState): void {
        if (state.focusTrap) {
          state.focusTrap.deactivate();
        }
      },
    };
  },
  class FocusTrapModifier {},
);
