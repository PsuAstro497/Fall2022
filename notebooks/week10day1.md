~~~
<!-- PlutoStaticHTML.Begin -->
<!--
    # This information is used for caching.
    [PlutoStaticHTML.State]
    input_sha = "bc82846f3c49b30c2e99f0e0414a4350d06e0e4f65995827b0f7fea8ffea2f01"
    julia_version = "1.8.2"
-->

<div class="markdown"><h1>Data Storage &amp; Memory Access</h1>
<p><strong>Astro 497: Week 10, Monday</strong></p>
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



<div class="markdown"><h2>Logistics</h2>
<ul>
<li><p>Should have received Project Plan feedback via Canvas</p>
</li>
<li><p>If you/your team didn&#39;t address one or more of the plan components, then please address those as part of your checkpoint 1 &#40;or before if it would be helpful&#41;.  </p>
</li>
</ul>
</div>


<div class="markdown"><h1>Memory latency hierarchy</h1>
<ul>
<li><p>Registers:</p>
</li>
<li><p>Caches:</p>
</li>
<li><p>RAM</p>
</li>
<li><p>Local disk storage</p>
</li>
<li><p>Non-local disks</p>
</li>
<li><p>Tape storage &#40;e.g., Roar Near-line storage&#41;</p>
</li>
</ul>
</div>


<div class="markdown"><h2>Registers:</h2>
<ul>
<li><p>All calculations are based on data in registers</p>
</li>
<li><p>Only a few dozen registers per CPU core</p>
</li>
<li><p>Many of those are special purpose &#40;e.g., performing multiple arithmetic operations at once&#41;</p>
</li>
</ul>
</div>


<div class="markdown"><h2>Caches:</h2>
<ul>
<li><p>L1 Cache:  </p>
<ul>
<li><p>Very low latency</p>
</li>
<li><p>Typically 16 – 64KB data cache per core</p>
</li>
<li><p>Separate instruction cache</p>
</li>
</ul>
</li>
<li><p>L2 Cache:</p>
<ul>
<li><p>Typically a few times slower than L1 cache</p>
</li>
<li><p>Typically 256KB - few MB L2 cache per core &#40;or pair of cores&#41;</p>
</li>
</ul>
</li>
<li><p>L3 Cache:</p>
<ul>
<li><p>Typically ~10 times slower than L2 cache</p>
</li>
<li><p>Typically ~few to tens or even hundreds of MB </p>
</li>
<li><p>Often shared among all CPU cores</p>
</li>
<li><p>N-way associative cache → How many different places a variable could be in the cache</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h2>RAM</h2>
<ul>
<li><p>GB to TB </p>
</li>
<li><p>Symmetric Multiprocessing &#40;SMP&#41;: all cores have equal access to all RAM</p>
</li>
<li><p>Non-Uniform Memory Access &#40;NUMA&#41;: </p>
<ul>
<li><p>RAM divided</p>
</li>
<li><p>Some is assigned to be &quot;local&quot; to each core &#40;or pair of cores&#41;</p>
</li>
<li><p>Rest of RAM is accessible via an interconnect </p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h2>Disk storage</h2>
<ul>
<li><p>Local disk storage</p>
<ul>
<li><p>NVME</p>
</li>
<li><p>SSD </p>
</li>
<li><p>Dard drives</p>
</li>
</ul>
</li>
<li><p>Disk storage within local network</p>
</li>
<li><p>Disk storage over internet</p>
<ul>
<li><p>Internet2</p>
</li>
<li><p>Commodity internet</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h2>Tape storage</h2>
<ul>
<li><p>Very high latency</p>
</li>
<li><p>Can still have high throughput</p>
</li>
<li><p>Efficient in terms cost, energy &amp; reliability</p>
</li>
<li><p>On Roar, known as &quot;near-line archival storage&quot;</p>
</li>
</ul>
</div>


<div class="markdown"><p><a href="https://colin-scott.github.io/personal_website/research/interactive_latency.html">Interactive Memory Latency vs Year</a></p>
</div>


<div class="markdown"><h1>Where do your variables go?</h1>
<ul>
<li><p>Programmer explicitly chooses when to write to disk or access network. </p>
<ul>
<li><p>&#40;Some cloud programming frameworks abstract these away&#41;</p>
</li>
</ul>
</li>
<li><p>The vast majority of scientific software development uses high-level languages.  </p>
</li>
<li><p>High-level languages let compilers and CPUs manage caches</p>
</li>
<li><p>Programmer choices can make it easy/hard/impossible for them to use caches effectively.</p>
</li>
<li><p>Programmer choices also dictate whether variables are stored in:</p>
<ul>
<li><p>Stack &#40;scalars, small structures or collections with known size&#41;</p>
</li>
<li><p>Heap &#40;large collections, structures/collections with unknown size&#41;</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h2>Stack</h2>
<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/ProgramCallStack2_en.png/862px-ProgramCallStack2_en.png" alt="Program call stack" /> &#40;from <a href="https://commons.wikimedia.org/wiki/File:ProgramCallStack2_en.png">Wikimedia</a>&#41;</p>
<ul>
<li><p>Stack memory is released on a last-in-first-out basis.</p>
</li>
<li><p>Stack &#40;de&#41;allocation is much faster than allocation/deallocation from heap.</p>
</li>
<li><p>Stack has fixed size &#40;e.g., 8MB is default on linux, can change with <code>ulimit -s</code>&#41;</p>
</li>
<li><p>Active frame of stack is likely to stay in cache</p>
</li>
<li><p>Stack is good for variables:</p>
<ul>
<li><p>Whose size is known at compile time, </p>
</li>
<li><p>Aren&#39;t too large </p>
</li>
<li><p>Won&#39;t be needed after a function finishes</p>
</li>
</ul>
</li>
<li><p>Use heap for </p>
<ul>
<li><p>Large collections &#40;e.g., arrays, matrices&#41; that are stored contiguously in memory.</p>
</li>
<li><p>Collections whose size is unknown at compile time</p>
</li>
<li><p>Collections vary in size &#40;in hard to predict way&#41;</p>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h1>Key factors for achieving good performance</h1>
<p>From highest to lowest priority:</p>
<ol>
<li><p>Choose an appropriate algorithm for your problem</p>
</li>
<li><p>Use compiled language, rather than an interpreted language</p>
</li>
<li><p>Use variables with fixed and known types</p>
</li>
<li><p>Minimize<a href="#footnote-1" class="footnote">[1]</a> disk/network/tape access</p>
</li>
<li><p>Minimize<a href="#footnote-1" class="footnote">[1]</a> unnecessary memory allocations on heap</p>
</li>
<li><p>Choose data types that promote linear access, e.g.,</p>
<ul>
<li><p>Vectors &amp; Arrays &#40;rather than Dictionaries&#41;</p>
</li>
<li><p>Arrays of values &#40;rather than arrays of pointers&#41;7. Group reads/writes of nearby data </p>
</li>
<li><p>For matrices, inner loop over minor dimension</p>
<ul>
<li><p>Fortran, Matlab, R &amp; Julia<a href="#footnote-2" class="footnote">[2]</a> matrices are column-major</p>
</li>
<li><p>C/C&#43;&#43; &amp; Python<a href="#footnote-2" class="footnote">[2]</a> matrices are row-major</p>
</li>
</ul>
</li>
<li><p>For large matrices, there are clever strategies of working on smaller blocks at a time.  Use cache-optimized libraries, e.g., </p>
<ul>
<li><p>BLAS, LAPACK, IntelMKL</p>
</li>
</ul>
</li>
<li><p>For datasets with many columns, structures of arrays &#40;rather than arrays of structures&#41;</p>
</li>
</ul>
</li>
<li><p>Use programming patterns that make it easy to parallelize the &quot;embarrassingly parallel&quot; portions of your code.</p>
<ul>
<li><p>E.g., <code>map</code>, <code>mapreduce</code>, <code>split-apply-combine</code></p>
</li>
<li><p>Once fully tested in serial, then can turn on parallelism for those sections easily.</p>
</li>
</ul>
</li>
<li><p>Only after ensuring that you&#39;ve done all of the above, should you even consider using &quot;advanced&quot; programming techniques that obfuscate the code, make it hard to maintain, or are likely to soon become out-of-date. </p>
</li>
</ol>
<div class="footnote" id="footnote-1"><p class="footnote-title">1</p><p>Use it when you need it, but don&#39;t add lots of extra small read/writes to disk or memory allocations.  </p>
</div>
<div class="footnote" id="footnote-2"><p class="footnote-title">2</p><p>By default.  With Julia &amp; Numby, one can explicitly specify a variable to be stored in the opposite format.  </p>
</div>
</div>


<div class="markdown"><h2>What is <em>not</em> on the list for achieving high performance?</h2>
<p>&quot;Vectorization&quot; The word <em>vectorization</em> is used in two fundamentally different ways:</p>
<ul>
<li><p>Computing hardware, e.g.</p>
<ul>
<li><p>SSE, SSE2, AVX, AVX512</p>
</li>
<li><p>GPU Streamming Multiprocessors</p>
</li>
</ul>
</li>
<li><p>Programming patterns, e.g., </p>
<ul>
<li><p>z &#61; x &#43; y</p>
</li>
</ul>
</li>
</ul>
<p>In many places, vectorization, as in the programming pattern, can make code easier to read.  However, often it results in unnecessary memory allocations and cache misses<a href="#footnote-3" class="footnote">[3]</a>.  Therefore, be careful about using vectorized notation in performance-sensitive sections of code.</p>
<div class="footnote" id="footnote-3"><p class="footnote-title">3</p><p>In many cases, Julia and JAX can broadcast and fuse vectorized expressions to achieve nearly identical performance as hand-written loops.</p>
</div>
</div>


<div class="markdown"><h2>Compiled vs Interpretted Languages</h2>
<p><strong>Q:</strong> When optimizing Python &#91;or R, IDL,...&#93; code I&#39;ve been told to eliminate for loops wherever possible.  For Julia &#40;or C/C&#43;&#43;, Fortran, Java,...&#41; for loops are not detrimental. Why is this?</p>
<ul>
<li><p>Interpretted languages: </p>
<ul>
<li><p>Loops are very slow</p>
</li>
<li><p>Usually worth creating extra arrays to avoid explicit loops</p>
</li>
</ul>
</li>
<li><p>Compiled languages:  </p>
<ul>
<li><p>Loops are fast.</p>
</li>
<li><p>Usually choose whether to write loop explicilty based on what&#39;s more convenient for programmer.</p>
</li>
<li><p>Using &quot;vectorized&quot; notation can add unnecessary memory allocations and cache misses...</p>
<ul>
<li><p>if you don&#39;t use broadcasting and fusing   </p>
</li>
</ul>
</li>
</ul>
</li>
</ul>
</div>


<div class="markdown"><h1>Trends in Computing Hardware</h1>
<h2>Moore&#39;s Law</h2>
<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Moore&#37;27s_Law_Transistor_Count_1970-2020.png/1280px-Moore&#37;27s_Law_Transistor_Count_1970-2020.png" alt="Moore&#39;s Law: Transistors" /> <a href="https://commons.wikimedia.org/w/index.php?curid&#61;98219918">Wikimedia</a> By Max Roser, Hannah Ritchie - <a href="https://creativecommons.org/licenses/by/4.0">CC BY 4.0</a></p>
</div>


<div class="markdown"><h3>Intel Xeon CPU Die Shot</h3>
<img src="https://en.wikichip.org/w/images/1/1f/intel_xeon_e7_die_shot.jpg" controls="" type="image/jpeg" width="80&#37;"></img>
<p>–- <a href="https://en.wikichip.org/wiki/User:David">David @ WikiChip.org</a></p>
</div>


<div class="markdown"><h3>Why are computers becoming more parallel?</h3>
<p><img src="https://www.karlrupp.net/wp-content/uploads/2018/02/42-years-processor-trend.png" alt="Variations on Moore&#39;s Law: " /> - source: <a href="https://www.karlrupp.net/2018/02/42-years-of-microprocessor-trend-data/#more-760">K. Rupp blog</a> </p>
</div>


<div class="markdown"><h1>Data structures</h1>
</div>


<div class="markdown"><h2>Array</h2>
<p>Good when:</p>
<ul>
<li><p>Value fast access to individual elements, even if not in linear order</p>
<ul>
<li><p>But even faster if elements will often be accessed in linear order</p>
</li>
</ul>
</li>
<li><p>Know how many elements you&#39;ll need &#40;or at least can make a decent guess&#41;</p>
</li>
<li><p>Don&#39;t want to allocate more memory that you actually need</p>
</li>
<li><p>There&#39;s not a reason to use a more complicated data structure</p>
</li>
</ul>
</div>


<div class="markdown"><h2>Hash table &#40;aka dictionary/<code>Dict</code>&#41;</h2>
<p>Good when:</p>
<ul>
<li><p>Elements unlikely to be accessed in any particular order</p>
</li>
<li><p>Value pretty fast access to individual elements</p>
</li>
<li><p>Don&#39;t mind allocating significantly more memory than necessary</p>
</li>
<li><p>Useful for scripting, non-performance sensitive code</p>
</li>
</ul>
<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Hash_table_3_1_1_0_1_0_0_SP.svg/1024px-Hash_table_3_1_1_0_1_0_0_SP.svg.png" alt="Hash table" /> - source <a href="https://commons.wikimedia.org/wiki/File:Hash_table_3_1_1_0_1_0_0_SP.svg">Wikimedia</a>, Jorge Stolfi, <a href="https://creativecommons.org/licenses/by-sa/3.0/deed.en">CC-BY-SA-3.0</a></p>
</div>


<div class="markdown"><h2>Some form of tree when:</h2>
<ul>
<li><p>Elements have a meaningful order</p>
</li>
<li><p>Value fast adding/removing and searching of elements</p>
</li>
<li><p>Value not allocating &#40;much&#41; more memory than necessary</p>
</li>
<li><p>Don&#39;t mind taking longer to access individual elements</p>
</li>
<li><p>Willing to spend some time maintaining well-ordered tree</p>
</li>
<li><p>Common in database applications</p>
</li>
</ul>
<h4>Generic tree &#40;not particularly useful&#41;</h4>
<p><img src="https://upload.wikimedia.org/wikipedia/commons/a/a9/Unbalanced_binary_tree.svg" alt="Unbalanced tree" /> - source <a href="https://en.wikipedia.org/wiki/File:Unbalanced_binary_tree.svg">Wikimedia</a></p>
<h4>Balanced binary tree</h4>
<p><img src="https://upload.wikimedia.org/wikipedia/commons/0/06/AVLtreef.svg" alt="Balanced tree" /> - source <a href="https://en.wikipedia.org/wiki/File:AVLtreef.svg">Wikimedia</a></p>
</div>


<div class="markdown"><h3>Linked List</h3>
<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Singly-linked-list.svg/640px-Singly-linked-list.svg.png" alt="Linked List" /></p>
<p>Use <strong>array</strong> when:</p>
<ul>
<li><p>Know size at time of creation &#40;or won&#39;t need to change size often&#41;</p>
</li>
<li><p>Value fast access to elements &#40;not just the beginning/end&#41;</p>
</li>
<li><p>Value not allocating more memory than memory</p>
</li>
<li><p>Very common for scientific performance sensitive code</p>
</li>
</ul>
<p>Use <strong>linked list</strong> when:</p>
<ul>
<li><p>Likely to insert elements and/or change size often</p>
</li>
<li><p>Don&#39;t mind taking longer to access elements &#40;other than beginning/end&#41;</p>
</li>
<li><p>Value not allocating &#40;much&#41; more memory than necessary</p>
</li>
<li><p>Useful for frequent sorting </p>
</li>
</ul>
<p>Other common data structures to consider...</p>
</div>


<div class="markdown"><h1>Garbage Collection</h1>
<p>Julia&#39;s garbage collector is &quot;a non-compacting, generational, mark-and-sweep, tracing collector, which at a high level means the following…</p>
<p><strong>Mark-Sweep / Tracing</strong>:</p>
<ul>
<li><p>When the garbage collector runs, it starts from a set of “roots” and walks through the object graph, “marking” objects as reachable.</p>
</li>
<li><p>Any object that isn’t marked as reachable and will then be “swept away” — i.e. its memory is reclaimed—since you know it’s not reachable from the roots and is therefore garbage.</p>
</li>
</ul>
<p><strong>Generational</strong>:</p>
<ul>
<li><p>It’s common that more recently allocated objects become garbage more quickly—this is known as the “generational hypothesis”.</p>
</li>
<li><p>Generational collectors have different levels of collection: young collections which run more frequently and full collections which run less frequently.</p>
</li>
<li><p>If the generational hypothesis is true, this saves time since it’s a waste of time to keep checking if older objects are garbage when they’re probably not.&quot; </p>
</li>
</ul>
<p><strong>Non-compacting / Non-moving</strong>:</p>
<ul>
<li><p>Other garbage collection techniques can copy or move objects during the collection process.  </p>
</li>
<li><p>Julia does not use any of these—collection does not move or copy anything, it just reclaims unreachable objects.</p>
</li>
</ul>
<p>If you’re having issues with garbage collection, your primary recourse is to generate less garbage:</p>
<ul>
<li><p>Write non-allocating code wherever possible: simple scalar code can generally avoid allocations.</p>
</li>
<li><p>Use immutable objects &#40;i.e., <code>struct</code> rather than <code>mutable struct</code>&#41;, which can be stack allocated more easily and stored inline in other structures &#40;as compared to mutable objects which generally need to be heap-allocated and stored indirectly by pointer, all of which causes more memory pressure&#41;.</p>
</li>
<li><p>Use pre-allocated data structures and modify them instead of allocating and returning new objects, especially in loops.</p>
</li>
<li><p>Can call <code>GC.gc&#40;&#41;</code> to manually call garbage collector.  But this is mainly useful for benchmarking.</p>
</li>
</ul>
<p>&#40;nearly quote from <a href="https://discourse.julialang.org/t/details-about-julias-garbage-collector-reference-counting/18021">Julia Discourse post by Stefan Karpinski</a>&#41;</p>
</div>


<div class="markdown"><h1>Setup &amp; Helper Code</h1>
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



<pre class='language-julia'><code class='language-julia'>using PlutoUI, PlutoTeachingTools</code></pre>

<div class='manifest-versions'>
<p>Built with Julia 1.8.2 and</p>
PlutoTeachingTools 0.2.3<br>
PlutoUI 0.7.44
</div>

<!-- PlutoStaticHTML.End -->
~~~

_To run this tutorial locally, download [this file](/notebooks/week10day1.jl) and open it with
[Pluto.jl](https://plutojl.org)._


_To run this tutorial locally, download [this file](/notebooks/week10day1.jl) and open it with
[Pluto.jl](https://plutojl.org)._


_To run this tutorial locally, download [this file](/notebooks/week10day1.jl) and open it with
[Pluto.jl](https://plutojl.org)._
