---
order: 1
---
# Activated when rendered

In this example, the focus trap is activated when the element is rendered.
We also pass a function to `onDeactivate` to allow `Escape` key to deactivate
the focus trap.


```hbs template
<div class="mb-4">
  <button type="button" {{on "click" this.activate}} class="button">
    Activate trap
  </button>
</div>

{{#if this.isActive}}
  <div
    class="trap is-active"
    {{focus-trap
      focusTrapOptions=(hash
        onDeactivate=this.deactivate
      )
    }}
  >
    <p class="mb-4">
      Here is a focus trap
      <a href="javascript:void(0)">with</a>
      <a href="javascript:void(0)">some</a>
      <a href="javascript:void(0)">focusable</a>
      parts.
    </p>
    <button type="button" {{on "click" this.deactivate}} class="button">
      Deactivate trap
    </button>
  </div>
{{/if}}
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
    this.isActive = false;
  };
}
```
