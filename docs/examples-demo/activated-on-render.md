---
order: 3
---
# Self focus on the container

Initial focus is on the containing element, which has `tabindex="-1"`; so when you tab through the trap focus does not return to the container.

In this example, clicking outside of the container will deactivate the focus
trap. Note the option `clickOutsideDeactivates`.

This example uses the modifier argument `shouldSelfFocus`. The same could be
achieved by adding an `id` to the container and passing the selector to `initialFocus`
in `focusTrapOptions`. However, `shouldSelfFocus` is a short hand for passing
the element directly to `focusTrapOptions`.

<aside>The option `shouldSelfFocus` is ignored if something is passed in `initialFocus`.</aside>


```hbs template
<div class="mb-4">
  <button type="button" {{on "click" this.activate}} class="button">
    Activate trap
  </button>
</div>

<div
  class="trap {{if this.isActive "is-active"}}"
  {{focus-trap
    isActive=this.isActive
    focusTrapOptions=(hash
      onDeactivate=this.deactivate
      initialFocus="#initial-focusee"
    )
  }}
>
  <p class="pb-4">
    Here is a focus trap
    <a href="javascript:void(0)">with</a>
    <a href="javascript:void(0)">some</a>
    <a href="javascript:void(0)">focusable</a>
    parts.

    <br>
    Initially focused input
    <input type="text" id="initial-focusee" class="bg-transparent border border-gray-400 dark:border-gray-600">
  </p>
  <button type="button" {{on "click" this.deactivate}} class="button">
    Deactivate trap
  </button>
</div>
```

```js component
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class Demo extends Component {
  @tracked isActive = false;

  activate = () => {
    this.isActive = true;
  };

  deactivate = () => {
    if (this.isActive) {
      this.isActive = false;
    }
  };
}
```
