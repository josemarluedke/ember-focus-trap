import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, find, settled } from '@ember/test-helpers';
import { fake, restore } from 'sinon';
import { hash, array } from '@ember/helper';
import { tracked } from '@glimmer/tracking';
import focusTrap from '#src/modifiers/focus-trap.ts';

import type { createFocusTrap as CreateFocusTrap } from 'focus-trap';

const noop = () => {
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

const fakes: {
  focusTrap: ReturnType<typeof fake> & typeof CreateFocusTrap;
  instance: {
    activate: ReturnType<typeof fake>;
    deactivate: ReturnType<typeof fake>;
    pause: ReturnType<typeof fake>;
    unpause: ReturnType<typeof fake>;
  };
} = {
  focusTrap: undefined!,
  instance: undefined!,
};

function setupFakes() {
  fakes.instance = {
    activate: fake(),
    deactivate: fake(),
    pause: fake(),
    unpause: fake(),
  };

  fakes.focusTrap = fake.returns(
    fakes.instance,
  ) as unknown as typeof fakes.focusTrap;
}

module('Integration | Modifier | focus-trap', function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(setupFakes);
  hooks.afterEach(() => restore());

  module('installModifier', function () {
    test('default activation', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              focusTrapOptions=(hash onDeactivate=noop)
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );

      assert.ok(
        fakes.focusTrap.calledWithExactly(find('[data-test]'), {
          onDeactivate: noop,
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.strictEqual(
        fakes.instance.activate.callCount,
        1,
        'should have called',
      );
    });

    test('activation with additional elements', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              additionalElements=(array "#foo" "#bar")
              focusTrapOptions=(hash onDeactivate=noop)
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );

      assert.ok(
        fakes.focusTrap.calledWithExactly(
          [find('[data-test]'), '#foo', '#bar'],
          {
            onDeactivate: noop,
            returnFocusOnDeactivate: true,
          },
        ),
        'should have called with the element and options',
      );
      assert.strictEqual(
        fakes.instance.activate.callCount,
        1,
        'should have called',
      );
    });

    test('activation with initialFocus as selector', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              focusTrapOptions=(hash
                onDeactivate=noop initialFocus="#initial-focus"
              )
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button" id="initial-focus">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.ok(
        fakes.focusTrap.calledWithExactly(find('[data-test]'), {
          onDeactivate: noop,
          initialFocus: '#initial-focus',
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
            {{focusTrap shouldSelfFocus=true _createFocusTrap=fakes.focusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );

      assert.ok(
        fakes.focusTrap.calledWithExactly(find('[data-test]'), {
          initialFocus: find('[data-test]'),
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.strictEqual(
        fakes.instance.activate.callCount,
        1,
        'should have called',
      );
    });

    test('when passing isActive as false', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=false _createFocusTrap=fakes.focusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.ok(
        fakes.focusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.strictEqual(
        fakes.instance.activate.callCount,
        0,
        'should not have called',
      );
    });

    test('when passing isActive as true', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap isActive=true _createFocusTrap=fakes.focusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.activate.callCount,
        1,
        'should have called activate',
      );
    });

    test('when passing isPaused as true', async function (assert) {
      await render(
        <template>
          <div
            data-test
            {{focusTrap isPaused=true _createFocusTrap=fakes.focusTrap}}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.pause.callCount,
        1,
        'should have called pause',
      );
    });
  });

  module('updateModifier', function () {
    test('it activates when isActive is updated from false to true', async function (assert) {
      const state = new State(false);

      await render(
        <template>
          <div
            data-test
            {{focusTrap
              isActive=state.isActive
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.activate.callCount,
        0,
        'should not have called',
      );

      state.isActive = true;
      await settled();

      assert.strictEqual(
        fakes.instance.activate.callCount,
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
            {{focusTrap
              isActive=state.isActive
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        0,
        'should not have called deactivate',
      );

      state.isActive = false;
      await settled();

      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        1,
        'should have called deactivate',
      );
    });

    test('it deactivates when isActive is updated from true to false and back again', async function (assert) {
      const state = new State(true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              isActive=state.isActive
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        0,
        'should not have called deactivate',
      );

      state.isActive = false;
      await settled();

      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        1,
        'should have called deactivate',
      );

      state.isActive = true;
      await settled();

      assert.strictEqual(
        fakes.instance.activate.callCount,
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
            {{focusTrap
              isActive=state.isActive
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.ok(
        fakes.focusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: true,
        }),
        'should have called with the element and options',
      );
      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        0,
        'should not have called deactivate',
      );

      state.isActive = false;
      await settled();

      assert.ok(
        fakes.instance.deactivate.calledWithExactly({ returnFocus: true }),
        'should have called deactivate with options',
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
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.ok(
        fakes.focusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: false,
        }),
        'should have called with the element and options',
      );
      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        0,
        'should not have called deactivate',
      );

      state.isActive = false;
      await settled();

      assert.ok(
        fakes.instance.deactivate.calledWithExactly({ returnFocus: false }),
        'should have called deactivate with options',
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
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.pause.callCount,
        0,
        'should not have called',
      );

      state.isPaused = true;
      await settled();

      assert.strictEqual(
        fakes.instance.pause.callCount,
        1,
        'should have called pause',
      );
    });

    test('it unpauses when isPaused is updated from true to false', async function (assert) {
      const state = new State(undefined, true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              isPaused=state.isPaused
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.unpause.callCount,
        0,
        'should not have called unpause',
      );

      state.isPaused = false;
      await settled();

      assert.strictEqual(
        fakes.instance.unpause.callCount,
        1,
        'should have called unpause',
      );
    });

    test('it unpauses when isPaused is updated from true to false and back again', async function (assert) {
      const state = new State(undefined, true);
      await render(
        <template>
          <div
            data-test
            {{focusTrap
              isPaused=state.isPaused
              _createFocusTrap=fakes.focusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.unpause.callCount,
        0,
        'should not have called unpause',
      );

      state.isPaused = false;
      await settled();

      assert.strictEqual(
        fakes.instance.unpause.callCount,
        1,
        'should have called unpause',
      );

      state.isPaused = true;
      await settled();

      assert.strictEqual(
        fakes.instance.pause.callCount,
        2,
        'should have called pause',
      );
    });
  });

  module('destroyModifier', function () {
    test('it deactivates when removing focus-trap element', async function (assert) {
      const state = new State(true);

      await render(
        <template>
          {{#if state.isActive}}
            <div
              data-test
              {{focusTrap isActive=true _createFocusTrap=fakes.focusTrap}}
            >
              <button type="button">Some button</button>
            </div>
          {{/if}}
        </template>,
      );
      assert.strictEqual(
        fakes.focusTrap.callCount,
        1,
        'should have called once',
      );
      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        0,
        'should not have called deactivate',
      );

      state.isActive = false;
      await settled();

      assert.strictEqual(
        fakes.instance.deactivate.callCount,
        1,
        'should have called deactivate',
      );
    });
  });
});
