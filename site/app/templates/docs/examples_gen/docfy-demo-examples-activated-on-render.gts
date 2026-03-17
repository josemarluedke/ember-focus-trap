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
    if (this.isActive) {
      this.isActive = false;
    }
  };

  <template>
    <div class="mb-4">
      <button type="button" {{on "click" this.activate}} class="button">
        Activate trap
      </button>
    </div>

    <div
      class="trap {{if this.isActive 'is-active'}}"
      {{focusTrap
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

        <br />
        Initially focused input
        <input
          type="text"
          id="initial-focusee"
          class="bg-transparent border border-gray-400 dark:border-gray-600"
        />
      </p>
      <button type="button" {{on "click" this.deactivate}} class="button">
        Deactivate trap
      </button>
    </div>
  </template>
}