ember-focus-trap
==============================================================================
A Ember modifier to trap your focus.

We use [focus-trap](https://github.com/davidtheclark/focus-trap) as a lower-level implementation.
It is super lightweight and has minimal dependencies.

Trap focus within a DOM node.

There may come a time when you find it important to trap focus within a DOM node — so that when a user hits `Tab` or `Shift+Tab` or clicks around, she can"t escape a certain cycle of focusable elements.

Please read the [focus-trap](https://github.com/davidtheclark/focus-trap) documentation to understand what a focus trap is, what happens when a focus trap is activated, and what happens when one is deactivated.

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


[See demos and read the documentation here](https://josemarluedke.github.io/ember-focus-trap).


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
