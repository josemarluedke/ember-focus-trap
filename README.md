ember-focus-trap
==============================================================================
A Ember modifier to trap your focus.


>Trap focus within a DOM node.
There may come a time when you find it important to trap focus within a DOM node — so that when a user hits `Tab` or `Shift+Tab` or clicks around, she can't escape a certain cycle of focusable elements.
You will definitely face this challenge when you are trying to build **accessible modals**.
[Read more at the original library](https://github.com/davidtheclark/focus-trap).


Compatibility
------------------------------------------------------------------------------

* Ember.js v2.18 or above
* Ember CLI v2.13 or above


Installation
------------------------------------------------------------------------------

```
ember install ember-focus-trap
```


Usage
------------------------------------------------------------------------------


```hbs
<div {{focus-trap}}>
  <p>
    Here is a focus trap
    <a href="#">with</a>
    <a href="#">some</a>
    <a href="#">focusable</a>
    parts.
  </p>
  <p>
    <button>Some button</button>
  </p>
</div>
```

### With Focus Trap Options

```hbs
<div
  {{focus-trap
    focusTrapOptions=(hash
      onDeactivate=(action this.myFunction)
      initialFocus="#initial-focusee"
    )
  }}
>
  <p>
    Here is a focus trap
    <a href="#">with</a>
    <a href="#">some</a>
    <a href="#">focusable</a>
    parts.
  </p>
  <p>
    <button id="initial-focusee">Some button</button>
  </p>
</div>
```


Contributing
------------------------------------------------------------------------------

See the [Contributing](CONTRIBUTING.md) guide for details.


License
------------------------------------------------------------------------------

This project is licensed under the [MIT License](LICENSE.md).
