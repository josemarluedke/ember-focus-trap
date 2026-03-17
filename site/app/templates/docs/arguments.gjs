<template>
  <h1 id="arguments"><a href="#arguments">Arguments</a></h1>
<h2 id="focustrapoptions"><a href="#focustrapoptions">focusTrapOptions</a></h2>
<p>Type: Object, optional</p>
<p>Pass any of the options available in focus-trap's createOptions. <a href="https://github.com/davidtheclark/focus-trap#focustrap--createfocustrapelement-createoptions">See
documentation</a>.</p>
<h2 id="isactive"><a href="#isactive">isActive</a></h2>
<p>Type: Boolean, optional</p>
<p>By default, the FocusTrap activates when the element renders.
So you activate and deactivate it by the live cycle of element.
If, however, you want to control when FocusTrap is activated or deactivated,
you can use this option.</p>
<h2 id="ispaused"><a href="#ispaused">isPaused</a></h2>
<p>Type: Boolean, optional</p>
<p>If you would like to pause or unpause the focus trap (see <a href="https://github.com/davidtheclark/focus-trap#focustrappause">focus-trap's documentation</a>), toggle this argument.</p>
<h2 id="shouldselffocus"><a href="#shouldselffocus">shouldSelfFocus</a></h2>
<p>Type: Boolean, optional</p>
<p>If you would like to initially focus in the element in which the modifier is
being applied.</p>
<p><strong>Important:</strong></p>
<ul>
<li>For the focus in the container to work, you must make it focusable. You can
accomplish that by adding <code>tabindex="-1"</code>.</li>
<li>This options has no effect if something is passed in <code>initialFocus</code> under <code>focusTrapOptions</code>.</li>
</ul>
<h2 id="additionalelements"><a href="#additionalelements">additionalElements</a></h2>
<p>Type: Array, optional</p>
<p>If needed, additional elements or containers can be added where focus-trap needs to be applied to. For example, absolutely/fixed-positioned dropdowns or popovers placed within a wormhole/placeholder that need to be included in said focus-trap.</p>
<p>As mentioned within <a href="https://github.com/focus-trap/focus-trap#createfocustrapelement-createoptions">focus-trap's documentation</a>, the order determines where the focus will go after the last tabbable element of a DOM node/selector is reached.</p>
</template>