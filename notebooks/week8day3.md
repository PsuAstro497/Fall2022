~~~
<!-- PlutoStaticHTML.Begin -->
<!--
    # This information is used for caching.
    [PlutoStaticHTML.State]
    input_sha = "a3b9ec3e2fe9cf64cf5aeaef26c0cef3ce55c80b0c7fab15b6bb8f5b4fda36cc"
    julia_version = "1.8.2"
-->

<div class="markdown"><h1>Exoplanet Populations</h1>
<p><strong>Astro 497, Week 8, Day 3</strong></p>
</div>

<pre class='language-julia'><code class='language-julia'>TableOfContents()</code></pre>
<script>
	
const indent = true
const aside = true
const title_text = "Table of Contents"
const include_definitions = false


const tocNode = html`<nav class="plutoui-toc">
	<header>
	 <span class="toc-toggle open-toc"></span>
	 <span class="toc-toggle closed-toc"></span>
	 ${title_text}
	</header>
	<section></section>
</nav>`

tocNode.classList.toggle("aside", aside)
tocNode.classList.toggle("indent", indent)


const getParentCell = el => el.closest("pluto-cell")

const getHeaders = () => {
	const depth = Math.max(1, Math.min(6, 3)) // should be in range 1:6
	const range = Array.from({length: depth}, (x, i) => i+1) // [1, ..., depth]
	
	const selector = [
		...(include_definitions ? [
			`pluto-notebook pluto-cell .pluto-docs-binding`, 
			`pluto-notebook pluto-cell assignee:not(:empty)`, 
		] : []),
		...range.map(i => `pluto-notebook pluto-cell h${i}`)
	].join(",")
	return Array.from(document.querySelectorAll(selector)).filter(el => 
		// exclude headers inside of a pluto-docs-binding block
		!(el.nodeName.startsWith("H") && el.closest(".pluto-docs-binding"))
	)
}


const document_click_handler = (event) => {
	const path = (event.path || event.composedPath())
	const toc = path.find(elem => elem?.classList?.contains?.("toc-toggle"))
	if (toc) {
		event.stopImmediatePropagation()
		toc.closest(".plutoui-toc").classList.toggle("hide")
	}
}

document.addEventListener("click", document_click_handler)


const header_to_index_entry_map = new Map()
const currently_highlighted_set = new Set()

const last_toc_element_click_time = { current: 0 }

const intersection_callback = (ixs) => {
	let on_top = ixs.filter(ix => ix.intersectionRatio > 0 && ix.intersectionRect.y < ix.rootBounds.height / 2)
	if(on_top.length > 0){
		currently_highlighted_set.forEach(a => a.classList.remove("in-view"))
		currently_highlighted_set.clear()
		on_top.slice(0,1).forEach(i => {
			let div = header_to_index_entry_map.get(i.target)
			div.classList.add("in-view")
			currently_highlighted_set.add(div)
			
			/// scroll into view
			/*
			const toc_height = tocNode.offsetHeight
			const div_pos = div.offsetTop
			const div_height = div.offsetHeight
			const current_scroll = tocNode.scrollTop
			const header_height = tocNode.querySelector("header").offsetHeight
			
			const scroll_to_top = div_pos - header_height
			const scroll_to_bottom = div_pos + div_height - toc_height
			
			// if we set a scrollTop, then the browser will stop any currently ongoing smoothscroll animation. So let's only do this if you are not currently in a smoothscroll.
			if(Date.now() - last_toc_element_click_time.current >= 2000)
				if(current_scroll < scroll_to_bottom){
					tocNode.scrollTop = scroll_to_bottom
				} else if(current_scroll > scroll_to_top){
					tocNode.scrollTop = scroll_to_top
				}
			*/
		})
	}
}
let intersection_observer_1 = new IntersectionObserver(intersection_callback, {
	root: null, // i.e. the viewport
  	threshold: 1,
	rootMargin: "-15px", // slightly smaller than the viewport
	// delay: 100,
})
let intersection_observer_2 = new IntersectionObserver(intersection_callback, {
	root: null, // i.e. the viewport
  	threshold: 1,
	rootMargin: "15px", // slightly larger than the viewport
	// delay: 100,
})

const render = (elements) => {
	header_to_index_entry_map.clear()
	currently_highlighted_set.clear()
	intersection_observer_1.disconnect()
	intersection_observer_2.disconnect()

		let last_level = `H1`
	return html`${elements.map(h => {
	const parent_cell = getParentCell(h)

		let [className, title_el] = h.matches(`.pluto-docs-binding`) ? ["pluto-docs-binding-el", h.firstElementChild] : [h.nodeName, h]

	const a = html`<a 
		class="${className}" 
		title="${title_el.innerText}"
		href="#${parent_cell.id}"
	>${title_el.innerHTML}</a>`
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
		last_toc_element_click_time.current = Date.now()
		h.scrollIntoView({
			behavior: 'smooth', 
			block: 'start'
		})
	}

	const row =  html`<div class="toc-row ${className} after-${last_level}">${a}</div>`
		intersection_observer_1.observe(title_el)
		intersection_observer_2.observe(title_el)
		header_to_index_entry_map.set(title_el, row)

	if(className.startsWith("H"))
		last_level = className
		
	return row
})}`
}

const invalidated = { current: false }

const updateCallback = () => {
	if (!invalidated.current) {
		tocNode.querySelector("section").replaceWith(
			html`<section>${render(getHeaders())}</section>`
		)
	}
}
updateCallback()
setTimeout(updateCallback, 100)
setTimeout(updateCallback, 1000)
setTimeout(updateCallback, 5000)

const notebook = document.querySelector("pluto-notebook")


// We have a mutationobserver for each cell:
const mut_observers = {
	current: [],
}

const createCellObservers = () => {
	mut_observers.current.forEach((o) => o.disconnect())
	mut_observers.current = Array.from(notebook.querySelectorAll("pluto-cell")).map(el => {
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

// And finally, an observer for the document.body classList, to make sure that the toc also works when it is loaded during notebook initialization
const bodyClassObserver = new MutationObserver(updateCallback)
bodyClassObserver.observe(document.body, {attributeFilter: ["class"]})

// Hide/show the ToC when the screen gets small
let m = matchMedia("(max-width: 1000px)")
let match_listener = () => 
	tocNode.classList.toggle("hide", m.matches)
match_listener()
m.addListener(match_listener)

invalidation.then(() => {
	invalidated.current = true
	intersection_observer_1.disconnect()
	intersection_observer_2.disconnect()
	notebookObserver.disconnect()
	bodyClassObserver.disconnect()
	mut_observers.current.forEach((o) => o.disconnect())
	document.removeEventListener("click", document_click_handler)
	m.removeListener(match_listener)
})

return tocNode
</script>
<style>
@media not print {

.plutoui-toc {
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Cantarell, Helvetica, Arial, "Apple Color Emoji",
		"Segoe UI Emoji", "Segoe UI Symbol", system-ui, sans-serif;
	--main-bg-color: #fafafa;
	--pluto-output-color: hsl(0, 0%, 36%);
	--pluto-output-h-color: hsl(0, 0%, 21%);
	--sidebar-li-active-bg: rgb(235, 235, 235);
	--icon-filter: unset;
}

@media (prefers-color-scheme: dark) {
	.plutoui-toc {
		--main-bg-color: #303030;
		--pluto-output-color: hsl(0, 0%, 90%);
		--pluto-output-h-color: hsl(0, 0%, 97%);
		--sidebar-li-active-bg: rgb(82, 82, 82);
		--icon-filter: invert(1);
	}
}

.plutoui-toc.aside {
	color: var(--pluto-output-color);
	position: fixed;
	right: 1rem;
	top: 5rem;
	width: min(80vw, 300px);
	padding: 0.5rem;
	padding-top: 0em;
	/* border: 3px solid rgba(0, 0, 0, 0.15); */
	border-radius: 10px;
	/* box-shadow: 0 0 11px 0px #00000010; */
	max-height: calc(100vh - 5rem - 90px);
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
    line-height: 1em;
    display: flex;
}

.toc-toggle::before {
    content: "";
    display: inline-block;
    height: 1em;
    width: 1em;
    background-image: url("https://cdn.jsdelivr.net/gh/ionic-team/ionicons@5.5.1/src/svg/list-outline.svg");
	/* generated using https://dopiaza.org/tools/datauri/index.php */
    background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHRpdGxlPmlvbmljb25zLXY1LW88L3RpdGxlPjxsaW5lIHgxPSIxNjAiIHkxPSIxNDQiIHgyPSI0NDgiIHkyPSIxNDQiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDozMnB4Ii8+PGxpbmUgeDE9IjE2MCIgeTE9IjI1NiIgeDI9IjQ0OCIgeTI9IjI1NiIgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDtzdHJva2UtbGluZWNhcDpyb3VuZDtzdHJva2UtbGluZWpvaW46cm91bmQ7c3Ryb2tlLXdpZHRoOjMycHgiLz48bGluZSB4MT0iMTYwIiB5MT0iMzY4IiB4Mj0iNDQ4IiB5Mj0iMzY4IiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6MzJweCIvPjxjaXJjbGUgY3g9IjgwIiBjeT0iMTQ0IiByPSIxNiIgc3R5bGU9ImZpbGw6bm9uZTtzdHJva2U6IzAwMDtzdHJva2UtbGluZWNhcDpyb3VuZDtzdHJva2UtbGluZWpvaW46cm91bmQ7c3Ryb2tlLXdpZHRoOjMycHgiLz48Y2lyY2xlIGN4PSI4MCIgY3k9IjI1NiIgcj0iMTYiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDozMnB4Ii8+PGNpcmNsZSBjeD0iODAiIGN5PSIzNjgiIHI9IjE2IiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6MzJweCIvPjwvc3ZnPg==");
    background-size: 1em;
	filter: var(--icon-filter);
}

.aside .toc-toggle.open-toc:hover::before {
    background-image: url("https://cdn.jsdelivr.net/gh/ionic-team/ionicons@5.5.1/src/svg/arrow-forward-outline.svg");
	/* generated using https://dopiaza.org/tools/datauri/index.php */
    background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHRpdGxlPmlvbmljb25zLXY1LWE8L3RpdGxlPjxwb2x5bGluZSBwb2ludHM9IjI2OCAxMTIgNDEyIDI1NiAyNjggNDAwIiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6NDhweCIvPjxsaW5lIHgxPSIzOTIiIHkxPSIyNTYiIHgyPSIxMDAiIHkyPSIyNTYiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDo0OHB4Ii8+PC9zdmc+");
}
.aside .toc-toggle.closed-toc:hover::before {
    background-image: url("https://cdn.jsdelivr.net/gh/ionic-team/ionicons@5.5.1/src/svg/arrow-back-outline.svg");
	/* generated using https://dopiaza.org/tools/datauri/index.php */
    background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiB2aWV3Qm94PSIwIDAgNTEyIDUxMiI+PHRpdGxlPmlvbmljb25zLXY1LWE8L3RpdGxlPjxwb2x5bGluZSBwb2ludHM9IjI0NCA0MDAgMTAwIDI1NiAyNDQgMTEyIiBzdHlsZT0iZmlsbDpub25lO3N0cm9rZTojMDAwO3N0cm9rZS1saW5lY2FwOnJvdW5kO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2Utd2lkdGg6NDhweCIvPjxsaW5lIHgxPSIxMjAiIHkxPSIyNTYiIHgyPSI0MTIiIHkyPSIyNTYiIHN0eWxlPSJmaWxsOm5vbmU7c3Ryb2tlOiMwMDA7c3Ryb2tlLWxpbmVjYXA6cm91bmQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS13aWR0aDo0OHB4Ii8+PC9zdmc+");
}



.plutoui-toc header {
	display: flex;
	align-items: center;
	gap: .3em;
	font-size: 1.5em;
	/* margin-top: -0.1em; */
	margin-bottom: 0.4em;
	padding: 0.5rem;
	margin-left: 0;
	margin-right: 0;
	font-weight: bold;
	/* border-bottom: 2px solid rgba(0, 0, 0, 0.15); */
	position: sticky;
	top: 0px;
	background: var(--main-bg-color);
	z-index: 41;
}
.plutoui-toc.aside header {
	padding-left: 0;
	padding-right: 0;
}

.plutoui-toc section .toc-row {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	padding: .1em;
	border-radius: .2em;
}

.plutoui-toc section .toc-row.H1 {
	margin-top: 1em;
}


.plutoui-toc.aside section .toc-row.in-view {
	background: var(--sidebar-li-active-bg);
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

.plutoui-toc.indent section .after-H2 a { padding-left: 10px; }
.plutoui-toc.indent section .after-H3 a { padding-left: 20px; }
.plutoui-toc.indent section .after-H4 a { padding-left: 30px; }
.plutoui-toc.indent section .after-H5 a { padding-left: 40px; }
.plutoui-toc.indent section .after-H6 a { padding-left: 50px; }

.plutoui-toc.indent section a.H1 { padding-left: 0px; }
.plutoui-toc.indent section a.H2 { padding-left: 10px; }
.plutoui-toc.indent section a.H3 { padding-left: 20px; }
.plutoui-toc.indent section a.H4 { padding-left: 30px; }
.plutoui-toc.indent section a.H5 { padding-left: 40px; }
.plutoui-toc.indent section a.H6 { padding-left: 50px; }


.plutoui-toc.indent section a.pluto-docs-binding-el,
.plutoui-toc.indent section a.ASSIGNEE
	{
	font-family: JuliaMono, monospace;
	font-size: .8em;
	/* background: black; */
	font-weight: 700;
    font-style: italic;
	color: var(--cm-var-color); /* this is stealing a variable from Pluto, but it's fine if that doesnt work */
}
.plutoui-toc.indent section a.pluto-docs-binding-el::before,
.plutoui-toc.indent section a.ASSIGNEE::before
	{
	content: "> ";
	opacity: .3;
}
</style>



<div class="markdown"><h1>Mid-semester Feedback</h1>
<h4>Thanks for the encouragement about the labs&#33;</h4>
<h2>How to use Wednesdays</h2>
<ul>
<li><p>All respondents expressed interest in using at least some of the remaining Wednesdays for working on projects.  </p>
</li>
<li><p>2nd most popular was talking through how to approach solving quantitative problems </p>
</li>
</ul>
<p>Let&#39;s make a plan.  </p>
</div>

<pre class='language-julia'><code class='language-julia'>TwoColumn(
md"""
#### Potential project workdays:
  - Oct 26 (before Checkpoint 1)
  - Nov 9 (between Checkpoints 1 & 2)
  - Nov 16 (between Checkpoint 2 & Dashboard due)
  - Nov 30 (too late for dashboard itself, but could be used to work on presentations)
""",
    
md"""
#### Project deadlines
- Project Plan (due Oct 19)
- Project Step 1 (due Oct 31)
- Project Step 2 (due Nov 14)
- Project Dashboard (due Nov 28)
- Project Presentations (due Dec 2 - 9)
- Individual Report & Reflection (due Dec 9)
""") 
</code></pre>
<div style="display: flex;"><div style="flex: 50%;"><div class="markdown"><h4>Potential project workdays:</h4>
<ul>
<li><p>Oct 26 &#40;before Checkpoint 1&#41;</p>
</li>
<li><p>Nov 9 &#40;between Checkpoints 1 &amp; 2&#41;</p>
</li>
<li><p>Nov 16 &#40;between Checkpoint 2 &amp; Dashboard due&#41;</p>
</li>
<li><p>Nov 30 &#40;too late for dashboard itself, but could be used to work on presentations&#41;</p>
</li>
</ul>
</div></div><div style="flex: 50%;"><div class="markdown"><h4>Project deadlines</h4>
<ul>
<li><p>Project Plan &#40;due Oct 19&#41;</p>
</li>
<li><p>Project Step 1 &#40;due Oct 31&#41;</p>
</li>
<li><p>Project Step 2 &#40;due Nov 14&#41;</p>
</li>
<li><p>Project Dashboard &#40;due Nov 28&#41;</p>
</li>
<li><p>Project Presentations &#40;due Dec 2 - 9&#41;</p>
</li>
<li><p>Individual Report &amp; Reflection &#40;due Dec 9&#41;</p>
</li>
</ul>
</div></div></div>


<div class="markdown"><h2>Other suggestions</h2>
<ul>
<li><p>Provide a full week to complete labs.  </p>
</li>
</ul>
</div>

<pre class='language-julia'><code class='language-julia'>TwoColumn(
md"""
#### Currently:
- Lab 7: Start Oct 12 –- Due Oct 17
- Lab 8: Start Oct 19 –- Due Oct 24
- Lab 9: Start Nov 2  –- Due Nov 7
""",
md"""
#### Proposed Change:
- Lab 7: Start Oct 12 –- Due Oct 19 
- Lab 8: Start Oct 19  –- Due Oct 26  
- Lab 9: Start Nov 2 –- Due Nov 9
""")</code></pre>
<div style="display: flex;"><div style="flex: 50%;"><div class="markdown"><h4>Currently:</h4>
<ul>
<li><p>Lab 7: Start Oct 12 –- Due Oct 17</p>
</li>
<li><p>Lab 8: Start Oct 19 –- Due Oct 24</p>
</li>
<li><p>Lab 9: Start Nov 2  –- Due Nov 7</p>
</li>
</ul>
</div></div><div style="flex: 50%;"><div class="markdown"><h4>Proposed Change:</h4>
<ul>
<li><p>Lab 7: Start Oct 12 –- Due Oct 19 </p>
</li>
<li><p>Lab 8: Start Oct 19  –- Due Oct 26  </p>
</li>
<li><p>Lab 9: Start Nov 2 –- Due Nov 9</p>
</li>
</ul>
</div></div></div>





<div class="markdown"><h2>Mid-term Exam Feedback</h2>
<ul>
<li><p>Most respondents cited time as a significant challenge.</p>
</li>
<li><p>Some students mentioned not knowing which equations to use or not being confident that they used the right equations.</p>
</li>
</ul>
</div>


<div class="markdown"><h1>How to organize knowledge about exoplanets &#40;or any new field&#41;?</h1>
<ul>
<li><p>Start with very limited knowledge.</p>
</li>
<li><p>As discover more exoplanets, iteratively improve knowledge.</p>
</li>
<li><p>As detection methods improve, we expect that the first detections are likely to be extreme in some way.</p>
</li>
<li><p>Even after detecting thousands of exoplanets, detection biases sculpt the known population. </p>
</li>
</ul>
<h2>What we&#39;d like to use</h2>
<ul>
<li><p>Physical characteristics &#40;e.g., rocky, oceans, atmosphere&#41;</p>
</li>
<li><p>How planets formed</p>
</li>
</ul>
</div>


<div class="markdown"><div class="admonition is-hint">
  <header class="admonition-header">
    What's the problem with this system?
  </header>
  <div class="admonition-body">
    <p>We usually don&#39;t know their detailed physical characteristics. We will never know their formation history for certain. </p>
  </div>
</div>
</div>


<div class="markdown"><h2>Commonly used categories in practice</h2>
<h3>What do we measure first/best?</h3>
<ul>
<li><p>Orbital period &#40;for transits or RVs&#41;</p>
<ul>
<li><p>Relatively easy to transform in insolation</p>
</li>
</ul>
</li>
<li><p>Size &#40;for transits&#41; or <span class="tex">$m \sin i$</span> &#40;for RVs&#41;</p>
</li>
</ul>
</div>


<div class="markdown"><h3>Giant Planets</h3>
<ul>
<li><p>Hot-Jupiters &#40;HJs&#41;</p>
</li>
<li><p>Warm Giant Planets</p>
</li>
<li><p>Temperate/Cool Giant Planets &#40;RV&#41;</p>
</li>
<li><p>Wide-orbits Giant Planets &#40;Direct Imaging&#41;</p>
</li>
</ul>
</div>


<div class="markdown"><h3>Neptune-size/mass Planets</h3>
<ul>
<li><p>Hot-Neptunes</p>
</li>
<li><p>Warm Neptunes</p>
</li>
</ul>
</div>


<div class="markdown"><h3>Rocky Planets</h3>
<ul>
<li><p>Ultra short period planets &#40;USPs&#41; </p>
</li>
<li><p>Warm rocky planets</p>
</li>
<li><p>Habitable-zone rocky planets</p>
</li>
</ul>
</div>


<div class="markdown"><h2>What else can we measure?</h2>
<p>Categories based on a notable property that is harder to measure, so is measured for only a subset of planets/systems: </p>
<ul>
<li><p>Chains of planets in mean-motion resonances &#40;transits/TTVs&#41;</p>
</li>
<li><p>Eccentric giant planets  &#40;RVs, TTVs&#41;</p>
</li>
<li><p>Misaligned hot-Jupiters  &#40;RM&#41;</p>
</li>
<li><p>Bulk densities &#40;combining transits and RVs or TTVs&#41;</p>
<ul>
<li><p>Rocky planets</p>
</li>
<li><p>Planets with H/He atmospheres</p>
</li>
<li><p>Waterworlds</p>
</li>
<li><p>Super-puffy planets</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h2>Categories for rare planets/systems</h2>
<ul>
<li><p>Ultra-short period planets </p>
</li>
<li><p>Warm Jupiters</p>
</li>
<li><p>Brown dwarf desert</p>
</li>
<li><p>Pairs of planets straddling the radius valley</p>
</li>
</ul>
</div>


<div class="markdown"><h1>More nuanced types of information about a population</h1>
<ul>
<li><p>Non-detections &#40;&quot;truncation&quot;&#41;</p>
</li>
<li><p>Upper &#40;or lower&#41; limits &#40;&quot;censoring&quot;&#41;</p>
</li>
</ul>
<h2>How to deal with censored &amp; truncated data?</h2>
<ul>
<li><p>For simple models can derive likelihoods</p>
</li>
<li><p>Hierarchical models</p>
</li>
</ul>
<h2>Challenges of combining data from multiple surveys/methods</h2>
</div>


<div class="markdown"><h1>Reading Questions</h1>
<h2>Selection Effects</h2>
</div>

<pre class='language-julia'><code class='language-julia'>question(md"""
Is there one type of star that is more frequently found having exoplanets orbiting it, and if so, could that be due to selection effects as well?
""")</code></pre>
<div class="markdown"><div class="admonition is-tip">
  <header class="admonition-header">
    Question
  </header>
  <div class="admonition-body">
    <p>Is there one type of star that is more frequently found having exoplanets orbiting it, and if so, could that be due to selection effects as well?</p>
  </div>

</div>
</div>


<div class="markdown"><p>By number of known planets:</p>
<ul>
<li><p>Most planets discovered by RVs around G &amp; K type stars &#40;sweat spot for RVs&#41;</p>
</li>
<li><p>Most planets discovered by transits around G &amp; F type stars &#40;brighter&#41;</p>
</li>
</ul>
<p>By occurrence rate of planets:</p>
<ul>
<li><p>Cool stars</p>
</li>
<li><p>Metal-rich stars</p>
</li>
</ul>
<p>What biases could contribute to these apparent trends?</p>
</div>

<pre class='language-julia'><code class='language-julia'>hint(md"""
- Cooler main sequence stars have smaller masses and radii →
  - RV amplitude is larger for given planet mass
  - Transit depth is larger for given planet size
- Metal-rich stars have larger opacity in photosphere →
  - Brighter for given mass and age

- Early indication of a preference for giant planets around metal-rich stars led some RV surveys to intentionally select metal-rich stars.
  
""")</code></pre>
<div class="markdown"><div class="admonition is-hint">
  <header class="admonition-header">
    Hint
  </header>
<ul>
<li>  <div class="admonition-body">
    <p>Cooler main sequence stars have smaller masses and radii →</p>
  </div>
<ul>
<li><p>RV amplitude is larger for given planet mass</p>
</li>
<li><p>Transit depth is larger for given planet size</p>
</li>
</ul>
</li>
<li><p>Metal-rich stars have larger opacity in photosphere →</p>
<ul>
<li><p>Brighter for given mass and age</p>
</li>
</ul>
</li>
<li><p>Early indication of a preference for giant planets around metal-rich stars led some RV surveys to intentionally select metal-rich stars.</p>
</li>
</ul>

</div>
</div>


<div class="markdown"><h1>Setup</h1>
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



<pre class='language-julia'><code class='language-julia'>begin
using PlutoUI, PlutoTeachingTools, HypertextLiteral
using DataFrames
end</code></pre>


<pre class='language-julia'><code class='language-julia'>question(str; invite="Question") = Markdown.MD(Markdown.Admonition("tip", invite, [str]))</code></pre>
<pre id='var-question' class='code-output documenter-example-output'>question (generic function with 1 method)</pre>
<div class='manifest-versions'>
<p>Built with Julia 1.8.2 and</p>
DataFrames 1.4.1<br>
HypertextLiteral 0.9.4<br>
PlutoTeachingTools 0.2.3<br>
PlutoUI 0.7.44
</div>

<!-- PlutoStaticHTML.End -->
~~~

_To run this tutorial locally, download [this file](/notebooks/week8day3.jl) and open it with
[Pluto.jl](https://plutojl.org)._


_To run this tutorial locally, download [this file](/notebooks/week8day3.jl) and open it with
[Pluto.jl](https://plutojl.org)._


_To run this tutorial locally, download [this file](/notebooks/week8day3.jl) and open it with
[Pluto.jl](https://plutojl.org)._
