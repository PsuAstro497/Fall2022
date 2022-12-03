~~~
<!-- PlutoStaticHTML.Begin -->
<!--
    # This information is used for caching.
    [PlutoStaticHTML.State]
    input_sha = "aa3adc36573a42ff1b0ae6b523cdd60106dce7b261f76147f4fa4e66db0db745"
    julia_version = "1.8.3"
-->

<div class="markdown"><h1>Reproducible Research</h1><p><strong>Astro 497, Week 13, Monday</strong></p></div>





<div class="markdown"><h2>What should we expect of science?</h2><ul><li><p>Reproducible</p></li><li><p>Replicable</p></li><li><p>Valid</p></li></ul><p>Historically, different fields of science have used these terms in different ways.   As their importance became more widely recognized, the National Academies produced a <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">report</a> that attempts to standardize language.  </p></div>


<div class="markdown"><h2>Reproduciblity</h2><blockquote><p>"obtaining consistent results using the same input data, computational steps, methods, and code, and conditions of analysis."</p><p>–- <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">Reproducibility &amp; Replicability in Science (2019)</a></p></blockquote><ul><li><p>Focuses on the reliability of the <strong>computations</strong> and their <strong>implementation</strong></p></li><li><p>If a study isn't reproducible, then there are likely errors that should be corrected.  </p></li><li><p>(Some subtleties in the context of stochastic algorithms)</p></li><li><p>Minimal requirement for a study to be trusted.</p></li></ul></div>


<div class="markdown"><h2>Replicablility</h2><blockquote><p>"obtaining consistent results across studies aimed at answering the same scientific question, each of which has obtained its own data” </p><p>–- <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">Reproducibility &amp; Replicability in Science (2019)</a></p></blockquote><ul><li><p>Robustness of a scientific conclusion...   given the researcher's choices (e.g., definition of sample, analysis method), but allowing for natural variations in data.</p></li><li><p>Even if a study isn't replicable, it still might be high-quality science.</p></li></ul></div>


<div class="markdown"><h2>Validity</h2><blockquote><p>"obtaining consistent results across studies aimed at answering the same scientific question, each of which has obtained its own data” </p><p>–- <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">Reproducibility &amp; Replicability in Science (2019)</a></p></blockquote><ul><li><p>Robustness of a scientific conclusion</p></li></ul></div>


<div class="markdown"><h3>Making research replicabile &amp; valid is very hard!</h3><blockquote><p>"when a researcher transparently reports a study and makes available the underlying digital artifacts, such as data and code, the results should be computationally reproducible.  In contrast, even when a study was rigorously conducted according to best practices, correctly analyzed, and transparently reported, it may fail to be replicated."</p><p>–- <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">Reproducibility &amp; Replicabilitiy in Science (2019)</a></p></blockquote></div>


<div class="markdown"><h2>Common Barriers to Reproducibility</h2><ul><li><p>Inadequate recordkeeping (e.g., failing to archive data &amp; metadata)</p></li><li><p>Availability of data &amp; metadata (e.g., not sharing data)</p></li><li><p>Obsolescence of data (e.g., glass plates, digital media, file formats,...)</p></li><li><p>Obsolescence of code (e.g., programs, libraries, compilers, OS,...)</p></li><li><p>Flaws in attempt to replicate (e.g., lack of expertise, failure to follow protocols)</p></li><li><p>Barriers in the culture of research:  resources &amp; incentives</p></li></ul></div>


<div class="markdown"><h3>How is astronomy doing?</h3><h4>Good</h4><ul><li><p>Federally funded observatories (and many larger private ones) have archives for their data. </p></li><li><p>Institutional &amp; discipline-specific services for archiving data products: </p><ul><li><p>ScholarSphere &amp; Data Comomons (Penn State)</p></li><li><p>Zenodo (CERN)</p></li><li><p>Dataverse (Harvard)</p></li><li><p>SciServer (JHU)</p></li></ul></li><li><p>FITS format has been standardized since 1981.</p></li><li><p>Programming languages used for Data Science (e.g., Julia, Python, R) incorporate package managers</p></li><li><p>Funding agencies &amp; AAS journals increasingly encourage archiving data, providing and "data behind the figures".</p></li></ul><h4>Not-so-good</h4><ul><li><p>Smaller, private observatories less likely to have funding to archive data</p></li><li><p>Much less likely to archive higher-level data products, metadata and documentation necessary to make use of them</p></li><li><p>Large datasets often need performant file formats that have yet to prove their longevity (e.g., HDF5) </p></li><li><p>Most computational R and Python rely on C/C++ or Fortran code underneath that rely on Makefiles that are customized for different architectures by hand.</p></li><li><p>Making research reproducible takes serious time and funding.  When there are finite resources, difficult choices have to be made. </p></li></ul></div>


<div class="markdown"><h2>Common Barriers to Replicability</h2><ul><li><p>Human error (typically unintentional)</p></li><li><p>Misuse of statistical methods</p></li><li><p>Publication bias</p></li><li><p>Inadequate experimental design</p></li><li><p>Inadequate reporting of study protocols</p></li><li><p>Incentive system that encourages "significant" results</p></li></ul></div>


<div class="markdown"><h3>Failure to Replicate can lead to Scientific Progress!</h3><ul><li><p>Different research groups can make different, reasonable choices</p></li><li><p>One (or more) choices affect results</p></li><li><p>Subsequent investigation identifies which choice(s) were responsible for the different outcomes</p></li><li><p>Only works if both groups precisely document their choices.</p></li></ul></div>


<div class="markdown"><h2>Who is reproducing &amp; replicating research?</h2><ul><li><p>Original investigator(s) reproducing their own results to convince themselves (most common)</p></li><li><p>Original investigator(s) reproducing their own results to convince others (e.g., collaborators, other scientists in the field, or industry/government), particularly if a result is highly surprising or has significant ramifications</p></li><li><p>Different investigators (potentially from same or different lab) may attempt to replicate a study using a data set they are collecting as a stepping stone in their research process.</p></li><li><p>Different investigators may try to build on a previous study, not succeed, and then decide to try to replicate the previous study to identify why they didn't succeed.</p></li><li><p>Maybe no one.</p></li></ul></div>


<div class="markdown"><h2>Strategies to make your work reproducible</h2><ul><li><p>Make input data publically available (when allowed &amp; ethical)</p></li><li><p>Use open-source software for analysis</p></li><li><p>Use package manager to completely specify languages, libraries &amp; packages used.</p></li><li><p>Version control source code and scripts</p></li><li><p>Only use results, tables &amp; figures generated by scripts</p></li><li><p>For complex calculations, use workflow management software</p></li><li><p>Make code used to generate results public</p></li><li><p>Archive code &amp; data</p></li><li><p>Provide sufficient documentation for others to reproduce calculations.</p></li><li><p>Encourage a team to replicate your results from the documentation you've provided.</p></li></ul></div>


<div class="markdown"><h3>Tools to automate workflows</h3><ul><li><p>Build tools: make, cmake</p></li><li><p>Scientific workflows: <a href="https://snakemake.readthedocs.io/en/stable/">Snakemake</a>, Galaxy, Nextflow, BigDataScript, ...</p></li><li><p>Example scripts for code/data behind figures in AAS journals: <a href="https://luger.dev/showyourwork.html">Showyourwork</a></p></li></ul></div>


<div class="markdown"><h2>Dangers of Big Data</h2><ul><li><p>Multiple testing:  Perform many possible tests (explicitly or "by eye") and then report one that appears to be significant in isolation</p></li><li><p><span class="tex">$p$</span>-hacking:  "the practice of collecting, selecting, or analyzing data until a result of statistical significance is found"  (RRiS 2019)</p></li><li><p>Overfitting:  Over confidence in model performance, especially when applied to out-of-sample data</p></li><li><p>Machine learning models:  Overreliance on optimizing predictive performance using complex models, rather than prioritizing, interpretability and explainability</p></li></ul></div>


<div class="markdown"><h2>Other relevant terms:</h2><h3>Rigor</h3><blockquote><p>"the strict application of the scientific method to ensure robust and unbiased experimental design"</p><p>NIH 2018 via <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">Reproducibility &amp; Replicabilitiy in Science (2019)</a></p></blockquote><h3>Reliability</h3><blockquote><p>"A predominant focus on the replicability of individual studies is an inefficient way to assure the reliability of scientific knowledge. Rather, reviews of cumulative evidence on a subject, to assess both the overall effect size and generalizability, is often a more useful way to gain confidence in the state of scientific knowledge." </p><p>–- <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">Reproducibility &amp; Replicabilitiy in Science (2019)</a></p></blockquote><h3>Generalizability</h3><blockquote><p>"Generalizability, another term frequently used in science, refers to the extent that results of a study apply in other contexts or populations that differ from the original one."</p><p>–- <a href="https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science">Reproducibility &amp; Replicabilitiy in Science (2019)</a></p></blockquote><h4>Transparency</h4></div>


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

<pre class='language-julia'><code class='language-julia'>using PlutoUI, PlutoTeachingTools</code></pre>

<div class='manifest-versions'>
<p>Built with Julia 1.8.3 and</p>
PlutoTeachingTools 0.2.5<br>
PlutoUI 0.7.48
</div>

<!-- PlutoStaticHTML.End -->
~~~