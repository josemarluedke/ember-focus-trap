# Examples

<aside>
  Check the demos from the underlying library <a href="https://davidtheclark.github.io/focus-trap/demo/" target="_blank">here</a>.
</aside>

## Activated when rendered

In this example, the focus trap is activated when the element is rendered.
We also pass a function to `onDeactivate` to allow `Escape` key to deactivate
the focus trap.

{{component "demo/example2"}}

## Initial Focus

When this focus trap activates, focus jumps to a specific, manually specified element.

{{component "demo/example3"}}

## Focus on the container

Initial focus is on the containing element, which has tabindex="-1"; so when you tab through the trap focus does not return to the container.

In this example, clicking outside of the container will deactivate the focus
trap. Note the option `clickOutsideDeactivates`.

{{component "demo/example4"}}
