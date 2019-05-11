# Examples

<aside>
  Check the demos from the underlying library <a href="https://davidtheclark.github.io/focus-trap/demo/" target="_blank">here</a>.
</aside>

## Activated when rendered

In this example, the focus trap is activated when the element is rendered.
We also pass a function to `onDeactivate` to allow `Escape` key to deactivate
the focus trap.

{{component "demo/example2"}}

## initialFocus

When this focus trap activates, focus jumps to a specific, manually specified element.


{{component "demo/example3"}}
