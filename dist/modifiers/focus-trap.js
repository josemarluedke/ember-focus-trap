import { capabilities, setModifierManager } from '@ember/modifier';
import { createFocusTrap } from 'focus-trap';

let cap;
try {
  cap = capabilities('3.22');
} catch {
  // @ts-expect-error we support older versions of Ember
  cap = capabilities('3.13');
}
const focusTrapModifier = {};
setModifierManager(() => {
  return {
    capabilities: cap,
    createModifier() {
      return {
        focusTrapOptions: {},
        isActive: true,
        isPaused: false,
        shouldSelfFocus: false,
        focusTrap: undefined
      };
    },
    installModifier(state, element, {
      named
    }) {
      const {
        isActive,
        isPaused,
        shouldSelfFocus,
        focusTrapOptions,
        additionalElements,
        _createFocusTrap
      } = named;
      state.focusTrapOptions = {
        ...focusTrapOptions
      };
      state.isActive = isActive ?? true;
      state.isPaused = isPaused ?? false;
      if (!state.focusTrapOptions.initialFocus && shouldSelfFocus) {
        state.focusTrapOptions.initialFocus = element;
      }
      if (state.focusTrapOptions.returnFocusOnDeactivate !== false) {
        state.focusTrapOptions.returnFocusOnDeactivate = true;
      }
      const createFocusTrap$1 = _createFocusTrap ?? createFocusTrap;
      state.focusTrap = createFocusTrap$1(additionalElements ? [element, ...additionalElements] : element, state.focusTrapOptions);
      if (state.isActive) {
        state.focusTrap.activate();
      }
      if (state.isPaused) {
        state.focusTrap.pause();
      }
    },
    updateModifier(state, {
      named: params
    }) {
      const focusTrapOptions = params.focusTrapOptions || {};
      if (state.isActive && !params.isActive) {
        const returnFocus = focusTrapOptions.returnFocusOnDeactivate ?? true;
        state.focusTrap?.deactivate({
          returnFocus
        });
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
    destroyModifier(state) {
      if (state.focusTrap) {
        state.focusTrap.deactivate();
      }
    }
  };
}, focusTrapModifier);

export { focusTrapModifier as default };
//# sourceMappingURL=focus-trap.js.map
