// BEGIN-SNIPPET demo-example3.js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class Demo extends Component {
  @tracked isActive = false;

  @action
  activate() {
    this.isActive = true;
  }

  @action
  deactivate() {
    this.isActive = false;
  }
}
// END-SNIPPET
