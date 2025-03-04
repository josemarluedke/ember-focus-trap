import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, find, settled } from '@ember/test-helpers';
import sinon from 'sinon';
import { focusTrap } from 'ember-focus-trap';
import { hash, array } from '@ember/helper';
import { tracked } from '@glimmer/tracking';

let noop = () => {
  // empty
};

class State {
  @tracked isActive: boolean | undefined;
  @tracked isPaused: boolean | undefined;

  constructor(isActive?: boolean, isPaused?: boolean) {
    this.isActive = isActive;
    this.isPaused = isPaused;
  }
}

module('Integration | Modifier | focus-trap', function (hooks) {
  setupRenderingTest(hooks);
  let fakeFocusTrap: ReturnType<typeof sinon.fake.returns>;
  let instance: {
    activate: ReturnType<typeof sinon.fake>;
    deactivate: ReturnType<typeof sinon.fake>;
    pause: ReturnType<typeof sinon.fake>;
    unpause: ReturnType<typeof sinon.fake>;
  };

  hooks.beforeEach(function () {
    instance = {
      activate: sinon.fake(),
      deactivate: sinon.fake(),
      pause: sinon.fake(),
      unpause: sinon.fake(),
    };

    fakeFocusTrap = sinon.fake.returns(instance);
  });

  hooks.afterEach(() => {
    sinon.restore();
  });

  module('installModifier', function () {
    test('default activation ', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              focusTrapOptions=(hash onDeactivate=noop)
              _createFocusTrap=fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');

      assert.ok(
        fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          onDeactivate: noop,
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.equal(instance.activate.callCount, 1, 'should have called');
    });

    test('activation with additional elements', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              additionalElements=(array "#foo" "#bar")
              focusTrapOptions=(hash onDeactivate=noop)
              _createFocusTrap=fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');

      assert.ok(
        fakeFocusTrap.calledWithExactly([find('[data-test]'), '#foo', '#bar'], {
          onDeactivate: noop,
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.equal(instance.activate.callCount, 1, 'should have called');
    });

    test('activation with initialFocus as selector', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              focusTrapOptions=(hash
                onDeactivate=noop initialFocus="#initial-focusee"
              )
              _createFocusTrap=fakeFocusTrap
            }}
          >
            <button type="button" id="initial-focusee">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          onDeactivate: noop,
          initialFocus: '#initial-focusee',
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
    });

    test('when passing shouldSelfFocus', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap shouldSelfFocus=true _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');

      assert.ok(
        fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          initialFocus: find('[data-test]'),
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.equal(instance.activate.callCount, 1, 'should have called');
    });

    test('when passing isActive as false', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=false _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.equal(instance.activate.callCount, 0, 'should not have called');
    });

    test('when passign isActive as true', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=true _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        instance.activate.callCount,
        1,
        'should have called activate',
      );
    });

    test('when passign isPaused as true', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap isPaused=true _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(instance.pause.callCount, 1, 'should have called activate');
    });
  });

  module('updateModifier', function () {
    test('it acivates when isActive is updated from false to true', async function (assert) {
      const state = new State(false);
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=state.isActive _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(instance.activate.callCount, 0, 'should not have called');

      state.isActive = true;
      await settled();

      assert.equal(
        instance.activate.callCount,
        1,
        'should have called activate',
      );
    });

    test('it deactivates when isActive is updated from true to false', async function (assert) {
      const state = new State(true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=state.isActive _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        instance.deactivate.callCount,
        0,
        'should not have called diactive',
      );

      state.isActive = false;
      await settled();

      assert.equal(
        instance.deactivate.callCount,
        1,
        'should have called diactive',
      );
    });

    test('it deactivates when isActive is updated from true to false and back again', async function (assert) {
      const state = new State(true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=state.isActive _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        instance.deactivate.callCount,
        0,
        'should not have called deactivate',
      );

      state.isActive = false;
      await settled();

      assert.equal(
        instance.deactivate.callCount,
        1,
        'should have called deactivate',
      );

      state.isActive = true;
      await settled();

      assert.equal(
        instance.activate.callCount,
        2,
        'should have called activate',
      );
    });

    test('it respects returnFocusOnDeactivate default option', async function (assert) {
      const state = new State(true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=state.isActive _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.equal(
        instance.deactivate.callCount,
        0,
        'should not have called diactive',
      );

      state.isActive = false;
      await settled();

      assert.ok(
        instance.deactivate.calledWithExactly({ returnFocus: true }),
        'should have called diactive with options',
      );
    });

    test('it respects returnFocusOnDeactivate when false', async function (assert) {
      const state = new State(true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              focusTrapOptions=(hash returnFocusOnDeactivate=false)
              isActive=state.isActive
              _createFocusTrap=fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: false,
        }),
        'should have called with the element and options',
      );
      assert.equal(
        instance.deactivate.callCount,
        0,
        'should not have called diactive',
      );

      state.isActive = false;
      await settled();

      assert.ok(
        instance.deactivate.calledWithExactly({ returnFocus: false }),
        'should have called diactive with options',
      );
    });

    test('it pauses when isPaused is updated from false to true', async function (assert) {
      const state = new State(undefined, false);
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              isActive=true
              isPaused=state.isPaused
              _createFocusTrap=fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(instance.pause.callCount, 0, 'should not have called');

      state.isPaused = true;
      await settled();

      assert.equal(instance.pause.callCount, 1, 'should have called pause');
    });

    test('it unpauses when isPaused is updated from true to false', async function (assert) {
      const state = new State(undefined, true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap isPaused=state.isPaused _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        instance.unpause.callCount,
        0,
        'should not have called unpause',
      );

      state.isPaused = false;
      await settled();

      assert.equal(instance.unpause.callCount, 1, 'should have called unpause');
    });

    test('it unpauses when isPaused is updated from true to false and back again', async function (assert) {
      const state = new State(undefined, true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap isPaused=state.isPaused _createFocusTrap=fakeFocusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        instance.unpause.callCount,
        0,
        'should not have called unpause',
      );

      state.isPaused = false;
      await settled();

      assert.equal(instance.unpause.callCount, 1, 'should have called unpause');

      state.isPaused = true;
      await settled();

      assert.equal(instance.pause.callCount, 2, 'should not have called pause');
    });
  });

  module('destroyModifier', function () {
    test('it diactives when removing focus-trap element', async function (assert) {
      const state = new State(true);

      await render(
        <template>
          {{#if state.isActive}}
            <div
              data-test
              {{focusTrap isActive=true _createFocusTrap=fakeFocusTrap}}
            >
              <button type="button">Some button</button>
            </div>
          {{/if}}
        </template>,
      );
      assert.equal(fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        instance.deactivate.callCount,
        0,
        'should not have called deactivate',
      );

      state.isActive = false;
      await settled();

      assert.equal(
        instance.deactivate.callCount,
        1,
        'should have called deactivate',
      );
    });
  });
});
