import { setModifierManager, capabilities } from '@ember/modifier';
import { createFocusTrap as CreateFocusTrap } from 'focus-trap';

let cap;
try {
  cap = capabilities('3.22');
} catch {
  cap = capabilities('3.13');
}

export default setModifierManager(() => {
  return {
    capabilities: cap,

    createModifier() {
      return {
        focusTrapOptions: undefined,
        isActive: true,
        isPaused: false,
        shouldSelfFocus: false,
        focusTrap: undefined
      };
    },

    installModifier(
      state,
      element,
      {
        named: {
          isActive,
          isPaused,
          shouldSelfFocus,
          focusTrapOptions,
          additionalElements,
          _createFocusTrap
        }
      }
    ) {
      // treat the original focusTrapOptions as immutable, so do a shallow copy here
      state.focusTrapOptions = { ...focusTrapOptions } || {};
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

      // Private to allow mocking FocusTrap in tests
      let createFocusTrap = CreateFocusTrap;
      if (_createFocusTrap) {
        createFocusTrap = _createFocusTrap;
      }

      if (state.focusTrapOptions.returnFocusOnDeactivate !== false) {
        state.focusTrapOptions.returnFocusOnDeactivate = true;
      }

      state.focusTrap = createFocusTrap(
        typeof additionalElements !== 'undefined'
          ? [element, ...additionalElements]
          : element,
        state.focusTrapOptions
      );

      if (state.isActive) {
        state.focusTrap.activate();
      }

      if (state.isPaused) {
        state.focusTrap.pause();
      }
    },

    updateModifier(state, { named: params }) {
      const focusTrapOptions = params.focusTrapOptions || {};

      if (state.isActive && !params.isActive) {
        const { returnFocusOnDeactivate } = focusTrapOptions;
        const returnFocus =
          typeof returnFocusOnDeactivate === 'undefined' ? true : false;
        state.focusTrap.deactivate({ returnFocus });
      } else if (!state.isActive && params.isActive) {
        state.focusTrap.activate();
      }

      if (state.isPaused && !params.isPaused) {
        state.focusTrap.unpause();
      } else if (!state.isPaused && params.isPaused) {
        state.focusTrap.pause();
      }

      // Update state
      state.focusTrapOptions = focusTrapOptions;

      if (typeof params.isActive !== 'undefined') {
        state.isActive = params.isActive;
      }

      if (typeof params.isPaused !== 'undefined') {
        state.isPaused = params.isPaused;
      }
    },

    destroyModifier({ focusTrap }) {
      focusTrap.deactivate();
    }
  };
}, class FocusTrapModifier {});
