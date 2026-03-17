import { pageTitle } from 'ember-page-title';
import { hash } from '@ember/helper';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { focusTrap } from 'ember-focus-trap';

class DemoState {
  @tracked isActive = false;
  @tracked isPaused = false;

  activate = () => (this.isActive = true);
  deactivate = () => (this.isActive = false);
  togglePause = () => (this.isPaused = !this.isPaused);
}

const basic = new DemoState();
const conditional = new DemoState();
const selfFocus = new DemoState();
const pausable = new DemoState();

<template>
  {{pageTitle "ember-focus-trap Demo"}}

  <h1>ember-focus-trap Demo</h1>

  {{! ── 1. Basic toggle ── }}
  <section>
    <h2>Basic Toggle</h2>
    <p>Click "Activate" to trap focus inside the box. Press Escape or click
      "Deactivate" to release.</p>

    <button
      type="button"
      {{on "click" basic.activate}}
      disabled={{basic.isActive}}
    >
      Activate trap
    </button>

    <div
      class="trap {{if basic.isActive 'is-active'}}"
      {{focusTrap
        isActive=basic.isActive
        focusTrapOptions=(hash
          onDeactivate=basic.deactivate clickOutsideDeactivates=true
        )
      }}
    >
      <p>Focus is trapped here.</p>
      <a href="#">Link one</a>
      <a href="#">Link two</a>
      <button type="button" {{on "click" basic.deactivate}}>Deactivate</button>
    </div>
  </section>

  {{! ── 2. Activated on render ── }}
  <section>
    <h2>Activated on Render</h2>
    <p>The trap activates as soon as it's rendered into the DOM.</p>

    <button
      type="button"
      {{on "click" conditional.activate}}
      disabled={{conditional.isActive}}
    >
      Show &amp; trap
    </button>

    {{#if conditional.isActive}}
      <div
        class="trap is-active"
        {{focusTrap
          focusTrapOptions=(hash onDeactivate=conditional.deactivate)
        }}
      >
        <p>I appeared and immediately trapped focus.</p>
        <a href="#">Focusable link</a>
        <button
          type="button"
          {{on "click" conditional.deactivate}}
        >Close</button>
      </div>
    {{/if}}
  </section>

  {{! ── 3. Container self-focus ── }}
  <section>
    <h2>Container Self Focus</h2>
    <p>Uses
      <code>shouldSelfFocus</code>
      so the container itself receives initial focus.</p>

    <button
      type="button"
      {{on "click" selfFocus.activate}}
      disabled={{selfFocus.isActive}}
    >
      Activate trap
    </button>

    <div
      class="trap {{if selfFocus.isActive 'is-active'}}"
      tabindex="-1"
      {{focusTrap
        isActive=selfFocus.isActive
        shouldSelfFocus=true
        focusTrapOptions=(hash
          onDeactivate=selfFocus.deactivate clickOutsideDeactivates=true
        )
      }}
    >
      <p>The container itself got focus, not a child element.</p>
      <a href="#">Link one</a>
      <a href="#">Link two</a>
      <button
        type="button"
        {{on "click" selfFocus.deactivate}}
      >Deactivate</button>
    </div>
  </section>

  {{! ── 4. Pause / unpause ── }}
  <section>
    <h2>Pause &amp; Unpause</h2>
    <p>A paused trap releases focus but stays ready to re-engage.</p>

    <button
      type="button"
      {{on "click" pausable.activate}}
      disabled={{pausable.isActive}}
    >
      Activate trap
    </button>

    <div
      class="trap
        {{if pausable.isActive 'is-active'}}
        {{if pausable.isPaused 'is-paused'}}"
      {{focusTrap
        isActive=pausable.isActive
        isPaused=pausable.isPaused
        focusTrapOptions=(hash
          onDeactivate=pausable.deactivate clickOutsideDeactivates=true
        )
      }}
    >
      <p>
        {{#if pausable.isPaused}}
          Trap is
          <strong>paused</strong>
          — you can tab outside.
        {{else}}
          Trap is
          <strong>active</strong>
          — focus is locked here.
        {{/if}}
      </p>
      <a href="#">Link one</a>
      <button type="button" {{on "click" pausable.togglePause}}>
        {{if pausable.isPaused "Unpause" "Pause"}}
      </button>
      <button
        type="button"
        {{on "click" pausable.deactivate}}
      >Deactivate</button>
    </div>
  </section>
</template>
