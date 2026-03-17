import DocfyDemoExamplesInitialFocus from './examples_gen/docfy-demo-examples-initial-focus.gts';
import DocfyDemoExamplesContainerSelfFocus from './examples_gen/docfy-demo-examples-container-self-focus.gts';
import DocfyDemoExamplesActivatedOnRender from './examples_gen/docfy-demo-examples-activated-on-render.gts';
import { DocfyDemo } from '@docfy/ember';

<template>
  <h1 id="examples"><a href="#examples">Examples</a></h1>
<p>Check the demos from the underlying library <a href="https://focus-trap.github.io/focus-trap/" target="_blank">here</a>.</p>
<h2 id="examples"><a href="#examples">Examples</a></h2>
<DocfyDemo @id="docfy-demo-examples-initial-focus" as |demo|>
<demo.Description
          @title="Activated when rendered" @editUrl="https://github.com/josemarluedke/ember-focus-trap/edit/main/docs/examples-demo/initial-focus.md">
<p>In this example, the focus trap is activated when the element is rendered.
We also pass a function to <code>onDeactivate</code> to allow <code>Escape</code> key to deactivate
the focus trap.</p>
</demo.Description>
<demo.Example>
<DocfyDemoExamplesInitialFocus />
</demo.Example>
<demo.Snippet @name="component">
<pre><code class="hljs language-gts"><span class="hljs-keyword">import</span> <span class="hljs-title class_">Component</span> <span class="hljs-keyword">from</span> <span class="hljs-string">'@glimmer/component'</span>;
<span class="hljs-keyword">import</span> { tracked } <span class="hljs-keyword">from</span> <span class="hljs-string">'@glimmer/tracking'</span>;
<span class="hljs-keyword">import</span> { on } <span class="hljs-keyword">from</span> <span class="hljs-string">'@ember/modifier'</span>;
<span class="hljs-keyword">import</span> { hash } <span class="hljs-keyword">from</span> <span class="hljs-string">'@ember/helper'</span>;
<span class="hljs-keyword">import</span> { focusTrap } <span class="hljs-keyword">from</span> <span class="hljs-string">'ember-focus-trap'</span>;

<span class="hljs-keyword">export</span> <span class="hljs-keyword">default</span> <span class="hljs-keyword">class</span> <span class="hljs-title class_">Demo</span> <span class="hljs-keyword">extends</span> <span class="hljs-title class_ inherited__">Component</span> {
  <span class="hljs-meta">@tracked</span> isActive = <span class="hljs-literal">false</span>;

  activate = <span class="hljs-function">() =></span> {
    <span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span> = <span class="hljs-literal">true</span>;
  };

  deactivate = <span class="hljs-function">() =></span> {
    <span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span> = <span class="hljs-literal">false</span>;
  };

  <span class="xml"><span class="hljs-tag">&#x3C;<span class="hljs-name">template</span>></span>
    <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span> <span class="hljs-attr">class</span>=<span class="hljs-string">"mb-4"</span>></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">button</span> <span class="hljs-attr">type</span>=<span class="hljs-string">"button"</span> \{{<span class="hljs-attr">on</span> "<span class="hljs-attr">click</span>" <span class="hljs-attr">this.activate</span>}} <span class="hljs-attr">class</span>=<span class="hljs-string">"button"</span>></span>
        Activate trap
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">button</span>></span>
    <span class="hljs-tag">&#x3C;/<span class="hljs-name">div</span>></span>

    \{{#if this.isActive}}
      <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span>
        <span class="hljs-attr">class</span>=<span class="hljs-string">"trap is-active"</span>
        \{{<span class="hljs-attr">focusTrap</span>
          <span class="hljs-attr">focusTrapOptions</span>=<span class="hljs-string">(hash</span> <span class="hljs-attr">onDeactivate</span>=<span class="hljs-string">this.deactivate)</span>
        }}
      ></span>
        <span class="hljs-tag">&#x3C;<span class="hljs-name">p</span> <span class="hljs-attr">class</span>=<span class="hljs-string">"mb-4"</span>></span>
          Here is a focus trap
          <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>with<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
          <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>some<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
          <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>focusable<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
          parts.
        <span class="hljs-tag">&#x3C;/<span class="hljs-name">p</span>></span>
        <span class="hljs-tag">&#x3C;<span class="hljs-name">button</span> <span class="hljs-attr">type</span>=<span class="hljs-string">"button"</span> \{{<span class="hljs-attr">on</span> "<span class="hljs-attr">click</span>" <span class="hljs-attr">this.deactivate</span>}} <span class="hljs-attr">class</span>=<span class="hljs-string">"button"</span>></span>
          Deactivate trap
        <span class="hljs-tag">&#x3C;/<span class="hljs-name">button</span>></span>
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">div</span>></span>
    \{{/if}}
  <span class="hljs-tag">&#x3C;/<span class="hljs-name">template</span>></span></span>
}
</code></pre>
</demo.Snippet>
</DocfyDemo>
<DocfyDemo @id="docfy-demo-examples-container-self-focus" as |demo|>
<demo.Description
          @title="Initial Focus" @editUrl="https://github.com/josemarluedke/ember-focus-trap/edit/main/docs/examples-demo/container-self-focus.md">
<p>When this focus trap activates, focus jumps to a specific, manually specified element.</p>
</demo.Description>
<demo.Example>
<DocfyDemoExamplesContainerSelfFocus />
</demo.Example>
<demo.Snippet @name="component">
<pre><code class="hljs language-gts"><span class="hljs-keyword">import</span> <span class="hljs-title class_">Component</span> <span class="hljs-keyword">from</span> <span class="hljs-string">'@glimmer/component'</span>;
<span class="hljs-keyword">import</span> { tracked } <span class="hljs-keyword">from</span> <span class="hljs-string">'@glimmer/tracking'</span>;
<span class="hljs-keyword">import</span> { on } <span class="hljs-keyword">from</span> <span class="hljs-string">'@ember/modifier'</span>;
<span class="hljs-keyword">import</span> { hash } <span class="hljs-keyword">from</span> <span class="hljs-string">'@ember/helper'</span>;
<span class="hljs-keyword">import</span> { focusTrap } <span class="hljs-keyword">from</span> <span class="hljs-string">'ember-focus-trap'</span>;

<span class="hljs-keyword">export</span> <span class="hljs-keyword">default</span> <span class="hljs-keyword">class</span> <span class="hljs-title class_">Demo</span> <span class="hljs-keyword">extends</span> <span class="hljs-title class_ inherited__">Component</span> {
  <span class="hljs-meta">@tracked</span> isActive = <span class="hljs-literal">false</span>;

  activate = <span class="hljs-function">() =></span> {
    <span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span> = <span class="hljs-literal">true</span>;
  };

  deactivate = <span class="hljs-function">() =></span> {
    <span class="hljs-keyword">if</span> (<span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span>) {
      <span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span> = <span class="hljs-literal">false</span>;
    }
  };

  <span class="xml"><span class="hljs-tag">&#x3C;<span class="hljs-name">template</span>></span>
    <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span> <span class="hljs-attr">class</span>=<span class="hljs-string">"mb-4"</span>></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">button</span> <span class="hljs-attr">type</span>=<span class="hljs-string">"button"</span> \{{<span class="hljs-attr">on</span> "<span class="hljs-attr">click</span>" <span class="hljs-attr">this.activate</span>}} <span class="hljs-attr">class</span>=<span class="hljs-string">"button"</span>></span>
        Activate trap
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">button</span>></span>
    <span class="hljs-tag">&#x3C;/<span class="hljs-name">div</span>></span>

    <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span>
      <span class="hljs-attr">class</span>=<span class="hljs-string">"trap \{{if this.isActive 'is-active'}}"</span>
      <span class="hljs-attr">tabindex</span>=<span class="hljs-string">"-1"</span>
      \{{<span class="hljs-attr">focusTrap</span>
        <span class="hljs-attr">isActive</span>=<span class="hljs-string">this.isActive</span>
        <span class="hljs-attr">shouldSelfFocus</span>=<span class="hljs-string">true</span>
        <span class="hljs-attr">focusTrapOptions</span>=<span class="hljs-string">(hash</span>
          <span class="hljs-attr">onDeactivate</span>=<span class="hljs-string">this.deactivate</span>
          <span class="hljs-attr">clickOutsideDeactivates</span>=<span class="hljs-string">true</span>
        )
      }}
    ></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">p</span> <span class="hljs-attr">class</span>=<span class="hljs-string">"pb-4"</span>></span>
        Here is a focus trap
        <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>with<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
        <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>some<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
        <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>focusable<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
        parts.
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">p</span>></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">button</span> <span class="hljs-attr">type</span>=<span class="hljs-string">"button"</span> \{{<span class="hljs-attr">on</span> "<span class="hljs-attr">click</span>" <span class="hljs-attr">this.deactivate</span>}} <span class="hljs-attr">class</span>=<span class="hljs-string">"button"</span>></span>
        Deactivate trap
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">button</span>></span>
    <span class="hljs-tag">&#x3C;/<span class="hljs-name">div</span>></span>
  <span class="hljs-tag">&#x3C;/<span class="hljs-name">template</span>></span></span>
}
</code></pre>
</demo.Snippet>
</DocfyDemo>
<DocfyDemo @id="docfy-demo-examples-activated-on-render" as |demo|>
<demo.Description
          @title="Self focus on the container" @editUrl="https://github.com/josemarluedke/ember-focus-trap/edit/main/docs/examples-demo/activated-on-render.md">
<p>Initial focus is on the containing element, which has <code>tabindex="-1"</code>; so when you tab through the trap focus does not return to the container.</p>
<p>In this example, clicking outside of the container will deactivate the focus
trap. Note the option <code>clickOutsideDeactivates</code>.</p>
<p>This example uses the modifier argument <code>shouldSelfFocus</code>. The same could be
achieved by adding an <code>id</code> to the container and passing the selector to <code>initialFocus</code>
in <code>focusTrapOptions</code>. However, <code>shouldSelfFocus</code> is a short hand for passing
the element directly to <code>focusTrapOptions</code>.</p>
<aside>The option `shouldSelfFocus` is ignored if something is passed in `initialFocus`.</aside>
</demo.Description>
<demo.Example>
<DocfyDemoExamplesActivatedOnRender />
</demo.Example>
<demo.Snippet @name="component">
<pre><code class="hljs language-gts"><span class="hljs-keyword">import</span> <span class="hljs-title class_">Component</span> <span class="hljs-keyword">from</span> <span class="hljs-string">'@glimmer/component'</span>;
<span class="hljs-keyword">import</span> { tracked } <span class="hljs-keyword">from</span> <span class="hljs-string">'@glimmer/tracking'</span>;
<span class="hljs-keyword">import</span> { on } <span class="hljs-keyword">from</span> <span class="hljs-string">'@ember/modifier'</span>;
<span class="hljs-keyword">import</span> { hash } <span class="hljs-keyword">from</span> <span class="hljs-string">'@ember/helper'</span>;
<span class="hljs-keyword">import</span> { focusTrap } <span class="hljs-keyword">from</span> <span class="hljs-string">'ember-focus-trap'</span>;

<span class="hljs-keyword">export</span> <span class="hljs-keyword">default</span> <span class="hljs-keyword">class</span> <span class="hljs-title class_">Demo</span> <span class="hljs-keyword">extends</span> <span class="hljs-title class_ inherited__">Component</span> {
  <span class="hljs-meta">@tracked</span> isActive = <span class="hljs-literal">false</span>;

  activate = <span class="hljs-function">() =></span> {
    <span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span> = <span class="hljs-literal">true</span>;
  };

  deactivate = <span class="hljs-function">() =></span> {
    <span class="hljs-keyword">if</span> (<span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span>) {
      <span class="hljs-variable language_">this</span>.<span class="hljs-property">isActive</span> = <span class="hljs-literal">false</span>;
    }
  };

  <span class="xml"><span class="hljs-tag">&#x3C;<span class="hljs-name">template</span>></span>
    <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span> <span class="hljs-attr">class</span>=<span class="hljs-string">"mb-4"</span>></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">button</span> <span class="hljs-attr">type</span>=<span class="hljs-string">"button"</span> \{{<span class="hljs-attr">on</span> "<span class="hljs-attr">click</span>" <span class="hljs-attr">this.activate</span>}} <span class="hljs-attr">class</span>=<span class="hljs-string">"button"</span>></span>
        Activate trap
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">button</span>></span>
    <span class="hljs-tag">&#x3C;/<span class="hljs-name">div</span>></span>

    <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span>
      <span class="hljs-attr">class</span>=<span class="hljs-string">"trap \{{if this.isActive 'is-active'}}"</span>
      \{{<span class="hljs-attr">focusTrap</span>
        <span class="hljs-attr">isActive</span>=<span class="hljs-string">this.isActive</span>
        <span class="hljs-attr">focusTrapOptions</span>=<span class="hljs-string">(hash</span>
          <span class="hljs-attr">onDeactivate</span>=<span class="hljs-string">this.deactivate</span>
          <span class="hljs-attr">initialFocus</span>=<span class="hljs-string">"#initial-focusee"</span>
        )
      }}
    ></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">p</span> <span class="hljs-attr">class</span>=<span class="hljs-string">"pb-4"</span>></span>
        Here is a focus trap
        <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>with<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
        <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>some<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
        <span class="hljs-tag">&#x3C;<span class="hljs-name">a</span> <span class="hljs-attr">href</span>=<span class="hljs-string">"javascript:void(0)"</span>></span>focusable<span class="hljs-tag">&#x3C;/<span class="hljs-name">a</span>></span>
        parts.

        <span class="hljs-tag">&#x3C;<span class="hljs-name">br</span> /></span>
        Initially focused input
        <span class="hljs-tag">&#x3C;<span class="hljs-name">input</span>
          <span class="hljs-attr">type</span>=<span class="hljs-string">"text"</span>
          <span class="hljs-attr">id</span>=<span class="hljs-string">"initial-focusee"</span>
          <span class="hljs-attr">class</span>=<span class="hljs-string">"bg-transparent border border-gray-400 dark:border-gray-600"</span>
        /></span>
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">p</span>></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">button</span> <span class="hljs-attr">type</span>=<span class="hljs-string">"button"</span> \{{<span class="hljs-attr">on</span> "<span class="hljs-attr">click</span>" <span class="hljs-attr">this.deactivate</span>}} <span class="hljs-attr">class</span>=<span class="hljs-string">"button"</span>></span>
        Deactivate trap
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">button</span>></span>
    <span class="hljs-tag">&#x3C;/<span class="hljs-name">div</span>></span>
  <span class="hljs-tag">&#x3C;/<span class="hljs-name">template</span>></span></span>
}
</code></pre>
</demo.Snippet>
</DocfyDemo>
</template>