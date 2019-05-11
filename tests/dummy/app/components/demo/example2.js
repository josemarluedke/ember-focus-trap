// BEGIN-SNIPPET demo-example2.js
import Component from '@ember/component';
import { action } from '@ember/object';

export default class Demo extends Component {
  isActive = false;

  @action
  activate() {
    this.set('isActive', true);
  }

  @action
  deactivate() {
    this.set('isActive', false);
  }
}
// END-SNIPPET
