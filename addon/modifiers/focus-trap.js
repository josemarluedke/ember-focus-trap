import { setModifierManager } from '@ember/modifier';
import FocusTrap from 'focus-trap';

export default setModifierManager(
  () => ({
    createModifier() {
      return {
        focusTrapOptions: undefined,
        isActive: undefined,
        isClosed: undefined,
        focusTrap: undefined,
        previouslyFocusedElement: undefined
      };
    },

    installModifier(
      state,
      element,
      {
        named: { isActive, isPaused, focusTrapOptions, _createFocusTrap }
      }
    ) {
      state.focusTrapOptions = focusTrapOptions || {};
      state.isActive = isActive;
      state.isPaused = isPaused;

      let createFocusTrap = FocusTrap;
      // Private to allow mocking FocusTrap in tests
      if (_createFocusTrap) {
        createFocusTrap = _createFocusTrap;
      }

      if (state.focusTrapOptions.returnFocusOnDeactivate !== false) {
        state.focusTrapOptions.returnFocusOnDeactivate = true;
      }

      if (typeof document !== 'undefined') {
        state.previouslyFocusedElement = document.activeElement;
      }

      state.focusTrap = createFocusTrap(element, state.focusTrapOptions);

      if (isActive) {
        state.focusTrap.activate();
      }

      if (isPaused) {
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
      state.isActive = params.isActive;
      state.isPaused = params.isPaused;
    },

    destroyModifier({ focusTrap, focusTrapOptions, previouslyFocusedElement }) {
      // FastBoot guard https://github.com/emberjs/ember.js/issues/17949
      if (typeof FastBoot !== 'undefined') {
        return;
      }
      focusTrap.deactivate();
      if (
        focusTrapOptions.returnFocusOnDeactivate !== false &&
        previouslyFocusedElement &&
        previouslyFocusedElement.focus
      ) {
        previouslyFocusedElement.focus();
      }
    }
  }),
  class FocusTrapModifier {}
);
