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
      tabindex="-1"
      {{focusTrap
        isActive=this.isActive
        shouldSelfFocus=true
        focusTrapOptions=(hash
          onDeactivate=this.deactivate
          clickOutsideDeactivates=true
        )
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