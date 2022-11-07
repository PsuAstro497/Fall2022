~~~
<!-- PlutoStaticHTML.Begin -->
<!--
    # This information is used for caching.
    [PlutoStaticHTML.State]
    input_sha = "06ceff9ef0adf50b0a4a59646b24c2983570ebe489db0308d68e6e7adc8c8b66"
    julia_version = "1.8.2"
-->

<div class="markdown"><h1>Astro 497: Week 1, Friday</h1>
<h2>Administrative details</h2>
<ul>
<li><p>Computing Setup:  Thanks&#33;</p>
</li>
<li><p>Office Hours:</p>
<ul>
<li><p>Thursdays 3-4pm &#40;Zhenjuan Wang; Davey Lab 532C&#41;</p>
</li>
<li><p>Fridays 3-4pm &#40;Eric Ford; Zoom&#41;</p>
</li>
</ul>
</li>
<li><p>Reading Questions</p>
<ul>
<li><p>Sign up for TopHat if you haven&#39;t already</p>
</li>
<li><p>Aim for asking a question each week</p>
</li>
<li><p>No more readings for coming Monday</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h1>Overview of Exoplanets</h1>
<ul>
<li><p>NASA&#39;s <a href="https://nexsci.caltech.edu/">Exoplanet Science Institute &#40;NExScI&#41;</a> maintains the <a href="https://exoplanetarchive.ipac.caltech.edu/index.html">Exoplanet Archive</a></p>
</li>
<li><p>They provide several <a href="https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/">up-to-date plots</a>, such as those below.</p>
</li>
</ul>
</div>


<div class="markdown"><h2>Discoveries vs Time</h2>
<video src="https://exoplanetarchive.ipac.caltech.edu/videos/exo_discovery_histogram.mp4" controls="" type="video/mp4" width="75&#37;"></video>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"Which observational techniques will we focus on in this course?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Which observational techniques will we focus on in this course?</p>
  </div>

</div>
</div>


<div class="markdown"><ul>
<li><p>We&#39;ll spend the first ~half of the course focusing on Radial Velocity &amp; Transit methods.</p>
<ul>
<li><p>These are the natural choices for class projects &#40;because there&#39;s lots of data.&#41;</p>
</li>
</ul>
</li>
<li><p>During the second ~half of the course, we&#39;ll touch on most of the other methods briefly.</p>
<ul>
<li><p>But we won&#39;t get as much hands-on experience using them, since you&#39;ll be working on your projects then.</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h3>Questions about Astronometry &amp; Timing Variations</h3>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"In the context of Astrometric planet searches, what are two components of motion in the plane of the sky?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>In the context of Astrometric planet searches, what are two components of motion in the plane of the sky?</p>
  </div>

</div>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"""In the context of the Timing Variations method, what does "time perturbations of stars with stable oscillation periods" mean?""")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>In the context of the Timing Variations method, what does &quot;time perturbations of stars with stable oscillation periods&quot; mean?</p>
  </div>

</div>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"Why do we still using timing method to detect exoplanets even though we know life could not survive on these pulsar orbiting planets?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Why do we still using timing method to detect exoplanets even though we know life could not survive on these pulsar orbiting planets?</p>
  </div>

</div>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"What kind of special information do we get only from the timing method of detecting exoplanets?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>What kind of special information do we get only from the timing method of detecting exoplanets?</p>
  </div>

</div>
</div>


<div class="markdown"><h2>Mass vs Period vs Time</h2>
<video src="https://exoplanetarchive.ipac.caltech.edu/videos/mass_period_movie_nexsci.mp4" controls="" type="video/mp4" width="75&#37;"></video>
</div>

<pre class='language-julia'><code class='language-julia'>if false
    md"""
## Mass-Period Distribution
$(Resource("https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/exo_massperiod_cb.png", :width=&gt;"75%")) 
    """
end</code></pre>


<pre class='language-julia'><code class='language-julia'>question(md"""I was wondering why the astronomy community settled on using Jupiter as the "base comparision" for studying exoplanets?""")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>I was wondering why the astronomy community settled on using Jupiter as the &quot;base comparision&quot; for studying exoplanets?</p>
  </div>

</div>
</div>


<div class="markdown"><h1>From individual objects to populations</h1>
<ul>
<li><p>Which features on above plot reflect intrinsic distribtion of exoplanets?</p>
</li>
<li><p>Which features reflect strengths/weaknesses of detection methods?</p>
</li>
</ul>
<h3>Correlation vs causation</h3>
<h2>Interpretting Data Responsibly</h2>
<ul>
<li><p>Which features are <em>expected</em> based on well-established astrophysics?</p>
</li>
<li><p>Which features are scientifically <em>interesting</em>?</p>
</li>
<li><p>What <em>scientifically interesting</em> questions could be addressed by...</p>
<ul>
<li><p>existing data?</p>
</li>
<li><p>new observations/analysis in next <span class="tex">$N$</span> years?</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h1>Period vs Eccentricity</h1>
<img src="https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/exo_eccperiod_cb.png" controls="" type="image/png" width="75&#37;"></img>
<h2>What features do you notice?</h2>
<ul>
<li><p>How do you interpret those?</p>
</li>
</ul>
<h2>What hidden variables might affect your interpretation?</h2>
</div>


<div class="markdown"><h1>What about &quot;Small&quot; Planets?</h1>
</div>


<div class="markdown"><h2>Radius vs Period vs Time</h2>
<h3>&#40;Zoom in on Planets from Kepler mission&#41;</h3>
<video src="https://exoplanetarchive.ipac.caltech.edu/videos/koi-radiusvperiod-nexsci.mp4" controls="" type="video/mp4" width="75&#37;"></video>
</div>


<div class="markdown"><h2>Mass-Radius Distribution</h2>
<img src="https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/exo_massradius_cb.png" controls="" type="image/png" width="75&#37;"></img>
</div>


<div class="markdown"><h1>More Reading Questions</h1>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"Are there any new observational techniques for detecting exoplanets now that telescopes and technology have improved?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Are there any new observational techniques for detecting exoplanets now that telescopes and technology have improved?</p>
  </div>

</div>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"Will there ever be a cap to exponential growth of data availability?  
Could there be a maximum on the amount of data that we can physically store and handle?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Will there ever be a cap to exponential growth of data availability?   Could there be a maximum on the amount of data that we can physically store and handle?</p>
  </div>

</div>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"Is there anyway we would be able to detect habitable planerts that are unlike Earth?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Is there anyway we would be able to detect habitable planerts that are unlike Earth?</p>
  </div>

</div>
</div>


<div class="markdown"><h2>What&#39;s missing from plots above?</h2>
</div>


<div class="markdown"><h2>Just for Fun Questions</h2>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"Do you think there is any intelligent life on exoplanets?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Do you think there is any intelligent life on exoplanets?</p>
  </div>

</div>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"Is Pluto not considered a planet because it is a free-floating object and if so is it not in orbit with the Sun?")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Is Pluto not considered a planet because it is a free-floating object and if so is it not in orbit with the Sun?</p>
  </div>

</div>
</div>


<div class="markdown"><h1>Helper Code</h1>
</div>

<pre class='language-julia'><code class='language-julia'>ChooseDisplayMode()</code></pre>
<!-- https://github.com/fonsp/Pluto.jl/issues/400#issuecomment-695040745 -->
<input
        type="checkbox"
        id="width-over-livedocs"
        name="width-over-livedocs"
    onclick="window.plutoOptIns.toggle_width(this)"
        >
<label for="width-over-livedocs">
        Full Width Mode
</label>
<style>
        body.width-over-docs #helpbox-wrapper {
        display: none !important;
        }
        body.width-over-docs main {
               max-width: none !important;
               margin: 0 !important;
                #max-width: 1100px;
                #max-width: calc(100% - 4rem);
                #align-self: flex-star;
                #margin-left: 50px;
                #margin-right: 2rem;
        }
</style>
<script>
        const toggle_width = function(t) {
                t.checked
                ? document.body.classList.add("width-over-docs")
                : document.body.classList.remove("width-over-docs") }
        window.plutoOptIns = window.plutoOptIns || {}
        window.plutoOptIns.toggle_width = toggle_width
        
</script>
&nbsp; &nbsp; &nbsp;
<input
        type="checkbox"
        id="present-mode"
        name="present-mode"
        onclick="present()"
        >
<label for="present_mode">
        Present Mode
</label>



<pre class='language-julia'><code class='language-julia'>TableOfContents(aside=true)</code></pre>
<script>const getParentCell = el => el.closest("pluto-cell")

const getHeaders = () => {
	const depth = Math.max(1, Math.min(6, 3)) // should be in range 1:6
	const range = Array.from({length: depth}, (x, i) => i+1) // [1, ..., depth]
	
	const selector = range.map(i => `pluto-notebook pluto-cell h${i}`).join(",")
	return Array.from(document.querySelectorAll(selector))
}

const indent = true
const aside = true

const clickHandler = (event) => {
	const path = (event.path || event.composedPath())
	const toc = path.find(elem => elem?.classList?.contains?.("toc-toggle"))
	if (toc) {
		event.stopImmediatePropagation()
		toc.closest(".plutoui-toc").classList.toggle("hide")
	}
}

document.addEventListener("click", clickHandler)


const render = (el) => html`${el.map(h => {
	const parent_cell = getParentCell(h)

	const a = html`<a 
		class="${h.nodeName}" 
		href="#${parent_cell.id}"
	>${h.innerText}</a>`
	/* a.onmouseover=()=>{
		parent_cell.firstElementChild.classList.add(
			'highlight-pluto-cell-shoulder'
		)
	}
	a.onmouseout=() => {
		parent_cell.firstElementChild.classList.remove(
			'highlight-pluto-cell-shoulder'
		)
	} */
	a.onclick=(e) => {
		e.preventDefault();
		h.scrollIntoView({
			behavior: 'smooth', 
			block: 'start'
		})
	}

	return html`<div class="toc-row">${a}</div>`
})}`

const tocNode = html`<nav class="plutoui-toc">
	<header>
     <span class="toc-toggle open-toc">📖</span>
     <span class="toc-toggle closed-toc">📕</span>
	Table of Contents</header>
	<section></section>
</nav>`

tocNode.classList.toggle("aside", aside)
tocNode.classList.toggle("indent", indent)

const updateCallback = () => {
	tocNode.querySelector("section").replaceWith(
		html`<section>${render(getHeaders())}</section>`
	)
}
updateCallback()
setTimeout(updateCallback, 100)
setTimeout(updateCallback, 1000)
setTimeout(updateCallback, 5000)

const notebook = document.querySelector("pluto-notebook")


// We have a mutationobserver for each cell:
const observers = {
	current: [],
}

const createCellObservers = () => {
	observers.current.forEach((o) => o.disconnect())
	observers.current = Array.from(notebook.querySelectorAll("pluto-cell")).map(el => {
		const o = new MutationObserver(updateCallback)
		o.observe(el, {attributeFilter: ["class"]})
		return o
	})
}
createCellObservers()

// And one for the notebook's child list, which updates our cell observers:
const notebookObserver = new MutationObserver(() => {
	updateCallback()
	createCellObservers()
})
notebookObserver.observe(notebook, {childList: true})

// And finally, an observer for the document.body classList, to make sure that the toc also works when if is loaded during notebook initialization
const bodyClassObserver = new MutationObserver(updateCallback)
bodyClassObserver.observe(document.body, {attributeFilter: ["class"]})

// Hide/show the ToC when the screen gets small
let m = matchMedia("(max-width: 1000px)")
let match_listener = () => 
	tocNode.classList.toggle("hide", m.matches)
match_listener()
m.addListener(match_listener)

invalidation.then(() => {
	notebookObserver.disconnect()
	bodyClassObserver.disconnect()
	observers.current.forEach((o) => o.disconnect())
	document.removeEventListener("click", clickHandler)
	m.removeListener(match_listener)
})

return tocNode
</script><style>@media not print {

.plutoui-toc {
	--main-bg-color: unset;
	--pluto-output-color: hsl(0, 0%, 36%);
	--pluto-output-h-color: hsl(0, 0%, 21%);
}

@media (prefers-color-scheme: dark) {
	.plutoui-toc {
		--main-bg-color: hsl(0deg 0% 21%);
		--pluto-output-color: hsl(0, 0%, 90%);
		--pluto-output-h-color: hsl(0, 0%, 97%);
	}
}

.plutoui-toc.aside {
	color: var(--pluto-output-color);
	position:fixed;
	right: 1rem;
	top: 5rem;
	width: min(80vw, 300px);
	padding: 10px;
	border: 3px solid rgba(0, 0, 0, 0.15);
	border-radius: 10px;
	box-shadow: 0 0 11px 0px #00000010;
	/* That is, viewport minus top minus Live Docs */
	max-height: calc(100vh - 5rem - 56px);
	overflow: auto;
	z-index: 40;
	background-color: var(--main-bg-color);
	transition: transform 300ms cubic-bezier(0.18, 0.89, 0.45, 1.12);
}

.plutoui-toc.aside.hide {
	transform: translateX(calc(100% - 28px));
}
.plutoui-toc.aside.hide section {
	display: none;
}
.plutoui-toc.aside.hide header {
	margin-bottom: 0em;
	padding-bottom: 0em;
	border-bottom: none;
}
}  /* End of Media print query */
.plutoui-toc.aside.hide .open-toc,
.plutoui-toc.aside:not(.hide) .closed-toc,
.plutoui-toc:not(.aside) .closed-toc {
	display: none;
}

@media (prefers-reduced-motion) {
  .plutoui-toc.aside {
    transition-duration: 0s;
  }
}

.toc-toggle {
	cursor: pointer;
	padding: 1em;
	margin: -1em;
    margin-right: -0.7em;
}

.plutoui-toc header {
	display: block;
	font-size: 1.5em;
	margin-top: -0.1em;
	margin-bottom: 0.4em;
	padding-bottom: 0.4em;
	margin-left: 0;
	margin-right: 0;
	font-weight: bold;
	border-bottom: 2px solid rgba(0, 0, 0, 0.15);
}

.plutoui-toc section .toc-row {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	padding-bottom: 2px;
}

.highlight-pluto-cell-shoulder {
	background: rgba(0, 0, 0, 0.05);
	background-clip: padding-box;
}

.plutoui-toc section a {
	text-decoration: none;
	font-weight: normal;
	color: var(--pluto-output-color);
}
.plutoui-toc section a:hover {
	color: var(--pluto-output-h-color);
}

.plutoui-toc.indent section a.H1 {
	font-weight: 700;
	line-height: 1em;
}

.plutoui-toc.indent section a.H1 {
	padding-left: 0px;
}
.plutoui-toc.indent section a.H2 {
	padding-left: 10px;
}
.plutoui-toc.indent section a.H3 {
	padding-left: 20px;
}
.plutoui-toc.indent section a.H4 {
	padding-left: 30px;
}
.plutoui-toc.indent section a.H5 {
	padding-left: 40px;
}
.plutoui-toc.indent section a.H6 {
	padding-left: 50px;
}
</style>

<pre class='language-julia'><code class='language-julia'>begin
    using PlutoUI, PlutoTeachingTools
end</code></pre>


<pre class='language-julia'><code class='language-julia'> question(text; v_offset::Integer=0) = Markdown.MD(Markdown.Admonition("tip", "Question", [text]));</code></pre>

<div class='manifest-versions'>
<p>Built with Julia 1.8.2 and</p>
PlutoTeachingTools 0.1.5<br>
PlutoUI 0.7.39
</div>

<!-- PlutoStaticHTML.End -->
~~~

_To run this tutorial locally, download [this file](/notebooks/week1day3.jl) and open it with
[Pluto.jl](https://plutojl.org)._


_To run this tutorial locally, download [this file](/notebooks/week1day3.jl) and open it with
[Pluto.jl](https://plutojl.org)._


_To run this tutorial locally, download [this file](/notebooks/week1day3.jl) and open it with
[Pluto.jl](https://plutojl.org)._
