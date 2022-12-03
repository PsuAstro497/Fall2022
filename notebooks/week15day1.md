~~~
<!-- PlutoStaticHTML.Begin -->
<!--
    # This information is used for caching.
    [PlutoStaticHTML.State]
    input_sha = "bb468bc4cae26cc3f7a9fa2ec7fce804139bcb4a60a8caada56375c8fc9eebfc"
    julia_version = "1.8.3"
-->

<div class="markdown"><h1>Putting the Pieces Together</h1><p><strong>Astro497, Week 15, Monday</strong></p></div>





<div class="markdown"><h2>Logistics</h2><ul><li><p><a href="https://github.com/PsuAstro497/PresentationScheduleFall2022">Presentations</a></p></li><li><p>SRTEs</p></li><li><p>My course-specific survey (in Google)</p></li><li><p>Undergrad Town Hall:  Wednesday, November 30th at 5 PM in Davey 541</p></li></ul></div>


<div class="markdown"><h2>Questions fom Last week</h2></div>


<div class="markdown"><div class="admonition is-tip"><header class="admonition-header">Question:</header><div class="admonition-body"><p>What are some of the "more sophisticated" ways to image mature planets and and why are they necessary?</p></div></div></div>


<div class="markdown"><div class="admonition is-tip"><header class="admonition-header">Question:</header><div class="admonition-body"><p>Will the planet's spectrum suffer from the contamination of stellar light, stellar wind, or circumstellar materials? If so, how can astronomers  eliminate such contamination?</p></div></div></div>


<div class="markdown"><div class="admonition is-tip"><header class="admonition-header">Question:</header><div class="admonition-body"><p>Are coronagraphs just able to observe objects with very small [angular] separations or do they offer any other large scale benefits?</p></div></div></div>


<div class="markdown"><h1>Looking back</h1></div>


<div class="markdown"><h2>Course Goals</h2><ul><li><p>Understand how astronomers detect and characterize extrasolar planetary systems,</p></li><li><p>Learn about the current state and future of exoplanet science,</p></li><li><p>Increase their data acumen<a class="footnote" href="#footnote-data_acumen">[data_acumen]</a>, and</p></li><li><p>Appreciate how building data science skills can benefit astronomy &amp; astrophysics research.</p></li></ul><div class="footnote" id="footnote-data_acumen"><p class="footnote-title">data_acumen</p><p>"We define data acumen as the ability to make good judgements about the use of data to support problem solutions." (Keller et al. 2020)</p></div></div>


<div class="markdown"><h2>Course Objectives</h2><ul><li><p>Ingest and manipulate data from astronomical surveys.</p></li><li><p>Quantitatively describe the effects of exoplanets on astronomical observations.</p></li><li><p>Build, apply, assess and update astrophysically motivated models for astronomical observations.</p></li><li><p>Create visualizations for exploratory and explanatory data analyses of observations from exoplanet surveys.</p></li><li><p>Synthesize the above into a dashboard to support the efficient analysis of exoplanet observations while following principles of reproducible research.</p></li></ul></div>


<div class="markdown"><h2>What Data Science skills have we developed?</h2></div>


<div class="markdown"><p>Data Science:</p><ul><li><p>Data Acumen</p></li><li><p>Databases, queries &amp; storage </p></li><li><p>Ingesting data &amp; Data wrangling</p></li><li><p>Exploratory data analysis</p></li><li><p>Model building &amp; assessment</p></li><li><p>Explanatory data analysis</p></li><li><p>Data visualization</p></li><li><p>Reproducible research</p></li><li><p>Scientific workflows</p></li><li><p>Technical collaboration (if teamed up for project)</p></li><li><p>Scientific communications</p></li></ul></div>


<div class="markdown"><h2>What Data Science skills have we skipped <br/> (or only skimmed the surface of)?</h2><ul><li><p>Probability &amp; Statistics</p></li><li><p>Machine Learning/Artificial Intelligence (AI)</p><ul><li><p>Non-parametric regression</p></li><li><p>Classification</p></li><li><p>Clustering</p></li><li><p>Density estimation</p></li><li><p>Anomaly detection</p></li><li><p>Image analysis</p></li></ul></li><li><p>Computing</p><ul><li><p>Data structures</p></li><li><p>Algorithms</p></li><li><p>Databases</p></li><li><p>Parallel computing</p></li></ul></li><li><p>Applications</p><ul><li><p>Hardware</p></li><li><p>Big Data frameworks</p></li><li><p>ML/AI tools</p></li><li><p>Software engineering</p></li><li><p>Deployment &amp; operations</p></li></ul></li></ul></div>


<div class="markdown"><h1>Looking forward</h1></div>


<div class="markdown"><h2>Foundational Classes to learn more about Data Sciences</h2><h4>Mathematics</h4><ul><li><p><strong>Probability</strong></p><ul><li><p>Elementary Probability (STAT 318)</p></li><li><p>Probability Theory (STAT/MATH 414)</p></li><li><p>Introduction to Probability and Stochastic Processes for Engineering (STAT/MATH 418)</p></li><li><p>Astrostatistics (ASTRO 415)</p></li></ul></li><li><p><strong>Linear Algebra</strong> (MATH 220)</p></li></ul><h4>Programming</h4><ul><li><p><strong>Intro to Programming</strong> (e.g., CMPSC 121, 122)</p></li><li><p>Data management/databases (DS 220, but one DS or CMPSC preqreq beyond CMPSC 122)</p></li><li><p>Programming Models for Big Data (DS/CMPSC 410, but several CMPSC prereqs)</p></li><li><p>Information Retrieval and Organization (e.g., IST 441, but several IST prereqs)</p></li></ul><h4>Machine Learning/AI</h4><ul><li><p><strong>Machine Learning</strong> (DS 310; prereqs: (CMPSC 121 or CMPSC 131) and (STAT/MATH 318 or STAT/MATH 414 or STAT/MATH 418))</p></li><li><p>AI (e.g., DS/CMPSC 442, but several CMPSC prereqs)</p></li></ul></div>


<div class="markdown"><h2>Applied classes that connect to Data Sciences</h2><ul><li><p>Astrostatistics (ASTRO 415, Spring 2023)</p></li><li><p>Computational Astrophysics (ASTRO/PHYS 410, Spring 2023)</p></li><li><p>Astronomical Techniques? (ASTRO 451, Fall 2022)</p></li><li><p>Data Science Through Statistical Reasoning and Computation (STAT 380; but prereq STAT 184)</p></li><li><p>Visual Analytics for Data Sciences (DS 330; but prereq DS 220)</p></li><li><p>Research projects (e.g., ASTRO 496, summer project or thesis)</p></li></ul></div>


<div class="markdown"><h2>Project-based learning</h2><p>Pros:  </p><ul><li><p>Help to motivate why need to learn things</p></li><li><p>Emphasize practical problems</p></li></ul><p>Cons: </p><ul><li><p>Forces you to work through implementation details</p></li><li><p>Risk learning specific tools, rather than underlying mathematics/algorithms</p></li><li><p>Specific tools used are very likely certainly become obsolete soon</p></li></ul></div>


<div class="markdown"><h1>Looking back at Exoplanets</h1><ul><li><p>Detection methods:</p></li><li><p>Characterization of individual planets/systems</p></li><li><p>Characterization of populations</p></li><li><p>Future prospects</p></li></ul></div>


<div class="markdown"><h3>Classes to learn more about exoplanets</h3><ul><li><p>Planets and Planetary System Formation (ASTRO 420W)</p></li><li><p>Stellar Structure and Evolution (ASTRO 414)</p></li><li><p>Research projects (e.g., ASTRO 496, summer project or thesis)</p></li></ul></div>


<div class="markdown"><h1>Plan for rest of week</h1></div>


<div class="markdown"><h1>Setup/Helper Code</h1></div>





<input id="width-over-livedocs" name="width-over-livedocs" onclick="window.plutoOptIns.toggle_width(this)" type="checkbox"/>
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

     

<input id="present-mode" name="present-mode" onclick="present()" type="checkbox"/>
<label for="present_mode">
        Present Mode
</label>





<pre class="code-output documenter-example-output" id="var-hash955213">(HTML{String}("<style> \npluto-notebook {\n  counter-reset:  footnote-title;\n} \n\n.footnote-title {\n\tfont-size: 0 !important;\n}\n.footnote-title::before {\n\tcounter-increment: footnote-title !important;\n\tcontent: \"[\" counter(footnote-title) \"]\" !important;\n\tfont-size: 0.75rem !important;\n}\n</style>\n"), HTML{String}("<script id="\&quot;footnotes\&quot;">\n\nconst addNumbersToInlineFootnotes = () => {\n\n\nconst inlinefootnotesNodes=document.querySelectorAll(\"a.footnote\")\nconst bottomfootnoteNodes=document.getElementsByClassName(\"footnote-title\")\n\n\nconst botttomFootnoteTextList=Array.from(bottomfootnoteNodes).map(x=>x.innerText);\n\n\n//get the inline footers inner text so that we can match up with the \nconst inlineFootnoteTextList=Array.from(inlinefootnotesNodes)\n.map(x=>x.innerText)\n\n\n//add square brackets to match the inline footnotes\nconst botttomFootnoteTextListWithBrackets=botttomFootnoteTextList.map(x=>\"[\"+x+\"]\");\n\n\n//find the number which we want to display inline\nvar inlineFootnoteTextListWithNumbers = inlineFootnoteTextList\n.map((x,index)=>{\n\nconst indexOfBottomFootnote = botttomFootnoteTextListWithBrackets.indexOf(x)\nconst indexOfBottomFootnotePlus1 = indexOfBottomFootnote+1\nconst element = inlinefootnotesNodes[index]\n\n//modify the element before part depending on if we find a match\nif (indexOfBottomFootnote<0) \n{//if we don't find a match display an error\n\telement.setAttribute(\"data-before\",\"[\"+\"ERROR! no matching reference\"+\"]\")\n}\nelse \n{//if we do add the number and make the label disapear by sizing it to 0px\n\telement.setAttribute(\"data-before\",\"[\"+indexOfBottomFootnotePlus1+\"]\")\n}\n\nreturn indexOfBottomFootnotePlus1\n\n})\n\n}//end of function addNumbersToInlineFootnotes\n\n\n\n\n\n\n\n\n//run everytime \"something\" is done so that it updates dynamically/reactively\n//2022/10/28\n//all of the below was taken from Table of Contents in PlutoUI \nconst invalidated = { current: false }\nconst updateCallback = () => {\n\tif (!invalidated.current) {\n\t\taddNumbersToInlineFootnotes()\n\t}\n}\nupdateCallback()\nsetTimeout(updateCallback, 100)\nsetTimeout(updateCallback, 1000)\nsetTimeout(updateCallback, 5000)\nconst notebook = document.querySelector(\"pluto-notebook\")\n// We have a mutationobserver for each cell:\nconst mut_observers = {\n\tcurrent: [],\n}\nconst createCellObservers = () => {\n\tmut_observers.current.forEach((o) => o.disconnect())\n\tmut_observers.current = Array.from(notebook.querySelectorAll(\"pluto-cell\")).map(el => {\n\t\tconst o = new MutationObserver(updateCallback)\n\t\to.observe(el, {attributeFilter: [\"class\"]})\n\t\treturn o\n\t})\n}\ncreateCellObservers()\n\n// And one for the notebook's child list, which updates our cell observers:\nconst notebookObserver = new MutationObserver(() => {\n\tupdateCallback()\n\tcreateCellObservers()\n})\nnotebookObserver.observe(notebook, {childList: true})\n\n// And finally, an observer for the document.body classList, to make sure that the fotnotz also works when it is loaded during notebook initialization\nconst bodyClassObserver = new MutationObserver(updateCallback)\nbodyClassObserver.observe(document.body, {attributeFilter: [\"class\"]})\n\n\n\n\n</script>\n<style> \na.footnote {\n\tfont-size: 0 !important;\n}\na.footnote::before {\n\tcontent: attr(data-before) ;\n\tfont-size: 10px;\n}\n</style>\n"))</pre>
<div class='manifest-versions'>
<p>Built with Julia 1.8.3 and</p>
PlutoTeachingTools 0.2.5<br>
PlutoUI 0.7.48
</div>

<!-- PlutoStaticHTML.End -->
~~~