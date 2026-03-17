---
order: 1
---

# What it does?

Please read the [focus-trap](https://github.com/focus-trap/focus-trap) documentation to understand what a focus trap is, what happens when a focus trap is activated, and what happens when one is deactivated.

This project is a simple Ember modifier that allow you to trap DOM nodes in
your applications.

- The focus trap automatically activates when element is rendered.
- The focus trap automatically deactivates when element is removed.
- The focus trap can be activated and deactivated, paused and unpaused via
    named arguments.

## Example

Below is a simple demo if a focus trap working. Click below to active the trap. You will notice that
you can't tab to elements out of the box.

> When a focus trap is active, the box will be highlighted.

```gts component
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { hash } from '@ember/helper';
import { focusTrap } from 'ember-focus-trap';

export default class Demo extends Component {
  @tracked isActive = false;

  activate = () => {
    this.isActive = true;
  };

  deactivate = () => {
    this.isActive = false;
  };

  <template>
    <div class="my-4">
      <button type="button" {{on "click" this.activate}} class="button">
        Activate trap
      </button>
    </div>

    <div
      class="trap {{if this.isActive 'is-active'}}"
      {{focusTrap
        isActive=this.isActive
        focusTrapOptions=(hash escapeDeactivates=false)
      }}
    >
      <p class="pb-4">
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
  </template>
}
```
