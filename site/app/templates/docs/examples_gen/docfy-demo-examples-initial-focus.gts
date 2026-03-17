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
    <div class="mb-4">
      <button type="button" {{on "click" this.activate}} class="button">
        Activate trap
      </button>
    </div>

    {{#if this.isActive}}
      <div
        class="trap is-active"
        {{focusTrap
          focusTrapOptions=(hash onDeactivate=this.deactivate)
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
  </template>
}