import { hbs } from 'ember-cli-htmlbars';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, find } from '@ember/test-helpers';
import sinon from 'sinon';
let noop = () => {
  // empty
};

module('Integration | Modifier | focus-trap', function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(function () {
    const instance = {
      activate: sinon.fake(),
      deactivate: sinon.fake(),
      pause: sinon.fake(),
      unpause: sinon.fake()
    };

    const fakeFocusTrap = sinon.fake.returns(instance);

    this.set('instance', instance);
    this.set('fakeFocusTrap', fakeFocusTrap);
    this.set('noop', noop);
  });

  hooks.afterEach(() => {
    sinon.restore();
  });

  module('installModifier', function () {
    test('default activation ', async function (assert) {
      await render(
        hbs`<div
            data-test
            {{focus-trap
              focusTrapOptions=(hash onDeactivate=this.noop)
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');

      assert.ok(
        this.fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          onDeactivate: noop,
          returnFocusOnDeactivate: true
        }),
        'should have called with the element and options'
      );
      assert.equal(this.instance.activate.callCount, 1, 'should have called');
    });

    test('activation with initialFocus as selector', async function (assert) {
      await render(
        hbs`<div
            data-test
            {{focus-trap
              focusTrapOptions=(hash
                onDeactivate=this.noop
                initialFocus="#initial-focusee"
              )
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button" id="initial-focusee">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        this.fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          onDeactivate: noop,
          initialFocus: '#initial-focusee',
          returnFocusOnDeactivate: true
        }),
        'should have called with the element and options'
      );
    });

    test('when passing shouldSelfFocus', async function (assert) {
      await render(
        hbs`<div
            data-test
            {{focus-trap
              shouldSelfFocus=true
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');

      assert.ok(
        this.fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          initialFocus: find('[data-test]'),
          returnFocusOnDeactivate: true
        }),
        'should have called with the element and options'
      );
      assert.equal(this.instance.activate.callCount, 1, 'should have called');
    });

    test('when passing isActive as false', async function (assert) {
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isActive=false
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        this.fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: true
        }),
        'should have called with the element and options'
      );
      assert.equal(
        this.instance.activate.callCount,
        0,
        'should not have called'
      );
    });

    test('when passign isActive as true', async function (assert) {
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isActive=true
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.activate.callCount,
        1,
        'should have called activate'
      );
    });

    test('when passign isPaused as true', async function (assert) {
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isPaused=true
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.pause.callCount,
        1,
        'should have called activate'
      );
    });
  });

  module('updateModifier', function () {
    test('it acivates when isActive is updated from false to true', async function (assert) {
      this.set('isActive', false);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isActive=this.isActive
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.activate.callCount,
        0,
        'should not have called'
      );

      this.set('isActive', true);

      assert.equal(
        this.instance.activate.callCount,
        1,
        'should have called activate'
      );
    });

    test('it deactivates when isActive is updated from true to false', async function (assert) {
      this.set('isActive', true);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isActive=this.isActive
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.deactivate.callCount,
        0,
        'should not have called diactive'
      );

      this.set('isActive', false);

      assert.equal(
        this.instance.deactivate.callCount,
        1,
        'should have called diactive'
      );
    });

    test('it deactivates when isActive is updated from true to false and back again', async function (assert) {
      this.set('isActive', true);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isActive=this.isActive
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.deactivate.callCount,
        0,
        'should not have called deactivate'
      );

      this.set('isActive', false);

      assert.equal(
        this.instance.deactivate.callCount,
        1,
        'should have called deactivate'
      );

      this.set('isActive', true);

      assert.equal(
        this.instance.activate.callCount,
        2,
        'should have called activate'
      );
    });

    test('it respects returnFocusOnDeactivate default option', async function (assert) {
      this.set('isActive', true);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isActive=this.isActive
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        this.fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: true
        }),
        'should have called with the element and options'
      );
      assert.equal(
        this.instance.deactivate.callCount,
        0,
        'should not have called diactive'
      );

      this.set('isActive', false);

      assert.ok(
        this.instance.deactivate.calledWithExactly({ returnFocus: true }),
        'should have called diactive with options'
      );
    });

    test('it respects returnFocusOnDeactivate when false', async function (assert) {
      this.set('isActive', true);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              focusTrapOptions=(hash returnFocusOnDeactivate=false)
              isActive=this.isActive
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.ok(
        this.fakeFocusTrap.calledWithExactly(find('[data-test]'), {
          returnFocusOnDeactivate: false
        }),
        'should have called with the element and options'
      );
      assert.equal(
        this.instance.deactivate.callCount,
        0,
        'should not have called diactive'
      );

      this.set('isActive', false);

      assert.ok(
        this.instance.deactivate.calledWithExactly({ returnFocus: false }),
        'should have called diactive with options'
      );
    });

    test('it pauses when isPaused is updated from false to true', async function (assert) {
      this.set('isPaused', false);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isActive=true
              isPaused=this.isPaused
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(this.instance.pause.callCount, 0, 'should not have called');

      this.set('isPaused', true);

      assert.equal(
        this.instance.pause.callCount,
        1,
        'should have called pause'
      );
    });

    test('it unpauses when isPaused is updated from true to false', async function (assert) {
      this.set('isPaused', true);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isPaused=this.isPaused
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.unpause.callCount,
        0,
        'should not have called unpause'
      );

      this.set('isPaused', false);

      assert.equal(
        this.instance.unpause.callCount,
        1,
        'should have called unpause'
      );
    });

    test('it unpauses when isPaused is updated from true to false and back again', async function (assert) {
      this.set('isPaused', true);
      await render(
        hbs`<div
            data-test
            {{focus-trap
              isPaused=this.isPaused
              _createFocusTrap=this.fakeFocusTrap
            }}
          >
            <button type="button">Some button</button>
          </div>`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.unpause.callCount,
        0,
        'should not have called unpause'
      );

      this.set('isPaused', false);

      assert.equal(
        this.instance.unpause.callCount,
        1,
        'should have called unpause'
      );

      this.set('isPaused', true);

      assert.equal(
        this.instance.pause.callCount,
        2,
        'should not have called pause'
      );
    });
  });

  module('destroyModifier', function () {
    test('it diactives when removing focus-trap element', async function (assert) {
      this.set('isEnabled', true);

      await render(
        hbs`{{#if this.isEnabled}}
              <div
                data-test
                {{focus-trap
                  isActive=true
                  _createFocusTrap=this.fakeFocusTrap
                }}
              >
                <button type="button">Some button</button>
              </div>
            {{/if}}`
      );
      assert.equal(this.fakeFocusTrap.callCount, 1, 'should have called once');
      assert.equal(
        this.instance.deactivate.callCount,
        0,
        'should not have called deactivate'
      );

      this.set('isEnabled', false);

      assert.equal(
        this.instance.deactivate.callCount,
        1,
        'should have called deactivate'
      );
    });
  });
});
