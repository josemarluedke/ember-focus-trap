import { createFocusTrap as CreateFocusTrap } from 'focus-trap';
import type { Options as FocusTrapOptions } from 'focus-trap';
import type { ModifierLike } from '@glint/template';
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
declare const _default: ModifierLike<FocusTrapModifierSignature>;
export default _default;
//# sourceMappingURL=focus-trap.d.ts.map