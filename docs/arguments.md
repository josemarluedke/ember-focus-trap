---
order: 3
---

# Arguments

## focusTrapOptions

Type: Object, optional

Pass any of the options available in focus-trap's createOptions. [See
documentation](https://github.com/davidtheclark/focus-trap#focustrap--createfocustrapelement-createoptions).

## isActive

Type: Boolean, optional

By default, the FocusTrap activates when the element renders.
So you activate and deactivate it by the live cycle of element.
If, however, you want to control when FocusTrap is activated or deactivated,
you can use this option.

## isPaused

Type: Boolean, optional

If you would like to pause or unpause the focus trap (see [focus-trap's documentation](https://github.com/davidtheclark/focus-trap#focustrappause)), toggle this argument.

## shouldSelfFocus

Type: Boolean, optional

If you would like to initially focus in the element in which the modifier is
being applied.

**Important:** For the focus in the container to work, you must make it focusable. You can
accomplish that by adding `tabindex="-1"`.

<aside>This options has no effect if something is passed in `initialFocus` under `focusTrapOptions`.</aside>

## additionalElements

Type: Array, optional

If needed, additional elements or containers can be added where focus-trap needs to be applied to. For example, absolutely/fixed-positioned dropdowns or popovers placed within a wormhole/placeholder that need to be included in said focus-trap.

As mentioned within [focus-trap's documentation](https://github.com/focus-trap/focus-trap#createfocustrapelement-createoptions), the order determines where the focus will go after the last tabbable element of a DOM node/selector is reached.
