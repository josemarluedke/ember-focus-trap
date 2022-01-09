---
order: 1
---

# What it does?

Please read the [focus-trap](https://github.com/focus-trap/focus-trap) documentation to understand what a focus trap is, what happens when a focus trap is activated, and what happens when one is deactivated.

This project is a simple Ember modifier that allow you to trap DOM nodes in
your applications.

- The focus trap automatically activates when element is rendered.
- The focus trap automatically deactivates when element is removed.
- The focus trap can be activated and deactivated, paused and unpaused via
    named arguments.

## Example

Below is a simple demo if a focus trap working. Click below to active the trap. You will notice that
you can't tab to elements out of the box.

> When a focus trap is active, the box will be highlighted.

<Demo::Example1 />
