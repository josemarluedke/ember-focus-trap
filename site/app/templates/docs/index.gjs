<template>
  <h1 id="what-it-does"><a href="#what-it-does">What it does?</a></h1>
<p>Please read the <a href="https://github.com/focus-trap/focus-trap">focus-trap</a> documentation to understand what a focus trap is, what happens when a focus trap is activated, and what happens when one is deactivated.</p>
<p>This project is a simple Ember modifier that allow you to trap DOM nodes in
your applications.</p>
<ul>
<li>The focus trap automatically activates when element is rendered.</li>
<li>The focus trap automatically deactivates when element is removed.</li>
<li>The focus trap can be activated and deactivated, paused and unpaused via
named arguments.</li>
</ul>
<h2 id="example"><a href="#example">Example</a></h2>
<p>Below is a simple demo if a focus trap working. Click below to active the trap. You will notice that
you can't tab to elements out of the box.</p>
<blockquote>
<p>When a focus trap is active, the box will be highlighted.</p>
</blockquote>
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
    <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span> <span class="hljs-attr">class</span>=<span class="hljs-string">"my-4"</span>></span>
      <span class="hljs-tag">&#x3C;<span class="hljs-name">button</span> <span class="hljs-attr">type</span>=<span class="hljs-string">"button"</span> \{{<span class="hljs-attr">on</span> "<span class="hljs-attr">click</span>" <span class="hljs-attr">this.activate</span>}} <span class="hljs-attr">class</span>=<span class="hljs-string">"button"</span>></span>
        Activate trap
      <span class="hljs-tag">&#x3C;/<span class="hljs-name">button</span>></span>
    <span class="hljs-tag">&#x3C;/<span class="hljs-name">div</span>></span>

    <span class="hljs-tag">&#x3C;<span class="hljs-name">div</span>
      <span class="hljs-attr">class</span>=<span class="hljs-string">"trap \{{if this.isActive 'is-active'}}"</span>
      \{{<span class="hljs-attr">focusTrap</span>
        <span class="hljs-attr">isActive</span>=<span class="hljs-string">this.isActive</span>
        <span class="hljs-attr">focusTrapOptions</span>=<span class="hljs-string">(hash</span> <span class="hljs-attr">escapeDeactivates</span>=<span class="hljs-string">false)</span>
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
</template>