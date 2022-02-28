<p align="center">
  <img width="640" src="https://repository-images.githubusercontent.com/186169303/b236b180-7408-11e9-9c6d-e58e1fd21700">
</p>

<p align="center">
  <a href="https://github.com/josemarluedke/ember-focus-trap/actions"><img src="https://github.com/josemarluedke/frontile/workflows/CI/badge.svg" alt="Build Status"></a>
  <a href="https://emberobserver.com/addons/ember-focus-trap"><img src="https://emberobserver.com/badges/ember-focus-trap.svg" alt="Ember Observer Score"></a>
  <a href="https://badge.fury.io/js/ember-focus-trap"><img src="https://badge.fury.io/js/ember-focus-trap.svg" alt="NPM version"></a>
</p>

**Ember Focus Trap**: A Ember modifier to trap your focus.

[View the docs here](https://ember-focus-trap.netlify.app/).

We use [focus-trap](https://github.com/focus-trap/focus-trap) as a lower-level implementation.
It is super lightweight and has minimal dependencies.

Trap focus within a DOM node.

There may come a time when you find it important to trap focus within a DOM node — so that when a user hits `Tab` or `Shift+Tab` or clicks around, she can"t escape a certain cycle of focusable elements.

Please read the [focus-trap](https://github.com/focus-trap/focus-trap) documentation to understand what a focus trap is, what happens when a focus trap is activated, and what happens when one is deactivated.

## Compatibility

* Ember.js v3.16 or above (Ember v4 compatible)
* Ember CLI v3.20 or above
* Node.js v12 or above

## Installation

```
ember install ember-focus-trap
```

## Usage

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
    <button type="button">Some button</button>
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
    <button type="button" id="initial-focusee">Some button</button>
  </p>
</div>
```

## Contributing

See the [Contributing](CONTRIBUTING.md) guide for details.

## License

This project is licensed under the [MIT License](LICENSE.md).
