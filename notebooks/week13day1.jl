### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 27a55fd4-5c0d-4b5f-9dd8-3dd04a36dc68
using PlutoUI, PlutoTeachingTools

# ╔═╡ 65a5d160-6041-11ed-0ff9-2379cc6d582a
md"""
# Reproducible Research
**Astro 497, Week 13, Monday**
"""

# ╔═╡ f63b98e1-097d-4a77-a5e8-a66107b9d745
TableOfContents()

# ╔═╡ f6a868cc-90d5-4b8b-b61d-07ec539daa1f
md"""
## What should we expect of science?
- Reproducible
- Replicable
- Valid

Historically, different fields of science have used these terms in different ways.  
As their importance became more widely recognized, the National Academies produced a [report](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science) that attempts to standardize language.  
"""

# ╔═╡ bb1b2266-01e7-4991-ad6e-924309f8d1b5
md"""
## Reproduciblity
> "obtaining consistent results using the same input data, computational steps, methods, and code, and conditions of analysis."
> 
> --- [Reproducibility & Replicability in Science (2019)](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science) 
- Focuses on the reliability of the **computations** and their **implementation**
- If a study isn't reproducible, then there are likely errors that should be corrected.  
- (Some subtleties in the context of stochastic algorithms)
- Minimal requirement for a study to be trusted.
"""

# ╔═╡ 85202f76-d0df-43e8-88e4-0018f1b4ef35
md"""
## Replicablility
> "obtaining consistent results across studies aimed at answering the same scientific question, each of which has obtained its own data” 
>
> --- [Reproducibility & Replicability in Science (2019)](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science) 
- Robustness of a scientific conclusion...   given the researcher's choices (e.g., definition of sample, analysis method), but allowing for natural variations in data.
- Even if a study isn't replicable, it still might be high-quality science.
"""

# ╔═╡ 5abc1e1f-3d26-4d7c-881b-d1a17cef69a2
md"""
## Validity
> "obtaining consistent results across studies aimed at answering the same scientific question, each of which has obtained its own data” 
>
> --- [Reproducibility & Replicability in Science (2019)](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science) 
- Robustness of a scientific conclusion

"""

# ╔═╡ 9a8b10b8-5d87-4a5d-96e4-53278dc9b337
md"""
### Making research replicabile & valid is very hard!
> "when a researcher transparently reports a study and makes available the underlying digital artifacts, such as data and code, the results should be computationally reproducible. 
> In contrast, even when a study was rigorously conducted according to best practices, correctly analyzed, and transparently reported, it may fail to be replicated."
>
> --- [Reproducibility & Replicabilitiy in Science (2019)](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science)

"""

# ╔═╡ 708e1d38-1f96-4330-b698-829e2680b4aa
md"""
## Common Barriers to Reproducibility
- Inadequate recordkeeping (e.g., failing to archive data & metadata)
- Availability of data & metadata (e.g., not sharing data)
- Obsolescence of data (e.g., glass plates, digital media, file formats,...)
- Obsolescence of code (e.g., programs, libraries, compilers, OS,...)
- Flaws in attempt to replicate (e.g., lack of expertise, failure to follow protocols)
- Barriers in the culture of research:  resources & incentives
"""

# ╔═╡ 21967ce3-ab1c-4a3e-9740-bac624befbca
md"""
### How is astronomy doing?
#### Good
- Federally funded observatories (and many larger private ones) have archives for their data. 
- Institutional & discipline-specific services for archiving data products: 
  - ScholarSphere & Data Comomons (Penn State)
  - Zenodo (CERN)
  - Dataverse (Harvard)
  - SciServer (JHU)
- FITS format has been standardized since 1981.
- Programming languages used for Data Science (e.g., Julia, Python, R) incorporate package managers
- Funding agencies & AAS journals increasingly encourage archiving data, providing and "data behind the figures".

#### Not-so-good
- Smaller, private observatories less likely to have funding to archive data
- Much less likely to archive higher-level data products, metadata and documentation necessary to make use of them
- Large datasets often need performant file formats that have yet to prove their longevity (e.g., HDF5) 
- Most computational R and Python rely on C/C++ or Fortran code underneath that rely on Makefiles that are customized for different architectures by hand.
- Making research reproducible takes serious time and funding.  When there are finite resources, difficult choices have to be made. 
"""

# ╔═╡ 86c4afa6-1606-4dd7-a82b-86b08e30b41c
md"""
## Common Barriers to Replicability
- Human error (typically unintentional)
- Misuse of statistical methods
- Publication bias
- Inadequate experimental design
- Inadequate reporting of study protocols
- Incentive system that encourages "significant" results
"""

# ╔═╡ bb7a19f8-8449-46a0-b4fd-fdf1c2589150
md"""
### Failure to Replicate can lead to Scientific Progress! 
- Different research groups can make different, reasonable choices
- One (or more) choices affect results
- Subsequent investigation identifies which choice(s) were responsible for the different outcomes
- Only works if both groups precisely document their choices.
"""

# ╔═╡ 4b139332-bb44-4ac3-8dd9-2090600a3449
md"""
## Who is reproducing & replicating research?
- Original investigator(s) reproducing their own results to convince themselves (most common)
- Original investigator(s) reproducing their own results to convince others (e.g., collaborators, other scientists in the field, or industry/government), particularly if a result is highly surprising or has significant ramifications
- Different investigators (potentially from same or different lab) may attempt to replicate a study using a data set they are collecting as a stepping stone in their research process.
- Different investigators may try to build on a previous study, not succeed, and then decide to try to replicate the previous study to identify why they didn't succeed.
- Maybe no one.
"""

# ╔═╡ 2848f7a7-1878-4c7e-a509-af3eece7c0ca
md"""
## Strategies to make your work reproducible
- Make input data publically available (when allowed & ethical)
- Use open-source software for analysis
- Use package manager to completely specify languages, libraries & packages used.
- Version control source code and scripts
- Only use results, tables & figures generated by scripts
- For complex calculations, use workflow management software
- Make code used to generate results public
- Archive code & data
- Provide sufficient documentation for others to reproduce calculations.
- Encourage a team to replicate your results from the documentation you've provided.
"""

# ╔═╡ 8265dc36-55a6-4420-a063-ff5b3c53b088
md"""
### Tools to automate workflows
- Build tools: make, cmake
- Scientific workflows: [Snakemake](https://snakemake.readthedocs.io/en/stable/), Galaxy, Nextflow, BigDataScript, ...
- Example scripts for code/data behind figures in AAS journals: [Showyourwork](https://luger.dev/showyourwork.html)
"""

# ╔═╡ 1048e2eb-37a8-41bb-9f4b-72ad85243e37
md"""
## Dangers of Big Data
-  Multiple testing:  Perform many possible tests (explicitly or "by eye") and then report one that appears to be significant in isolation
-  $p$-hacking:  "the practice of collecting, selecting, or analyzing data until a result of statistical significance is found"  (RRiS 2019)
-  Overfitting:  Over confidence in model performance, especially when applied to out-of-sample data
-  Machine learning models:  Overreliance on optimizing predictive performance using complex models, rather than prioritizing, interpretability and explainability
"""

# ╔═╡ a74af3c1-48e3-4a10-9a99-b473de53e0c2
md"""
## Other relevant terms:
### Rigor
> "the strict application of the scientific method to ensure robust and unbiased experimental design"
>
> NIH 2018 via [Reproducibility & Replicabilitiy in Science (2019)](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science)

### Reliability
> "A predominant focus on the replicability of individual studies is an inefficient way to assure the reliability of scientific knowledge. Rather, reviews of cumulative evidence on a subject, to assess both the overall effect size and generalizability, is often a more useful way to gain confidence in the state of scientific knowledge." 
>
> --- [Reproducibility & Replicabilitiy in Science (2019)](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science)

### Generalizability
> "Generalizability, another term frequently used in science, refers to the extent that results of a study apply in other contexts or populations that differ from the original one."
>
> --- [Reproducibility & Replicabilitiy in Science (2019)](https://www.nationalacademies.org/our-work/reproducibility-and-replicability-in-science)

#### Transparency
"""

# ╔═╡ 6a6f159b-09b1-4a53-bfa9-ffcbe20b94dd
md"""
# Setup/Helper Code
"""

# ╔═╡ a4574030-1a50-4988-a46b-becf718148a5
ChooseDisplayMode()

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoTeachingTools = "~0.2.5"
PlutoUI = "~0.7.48"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "cc4bd91eba9cdbbb4df4746124c22c0832a460d6"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.1.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "0f960b1404abb0b244c1ece579a0ec78d056a5d1"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.15"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "ab9aa169d2160129beb241cb2750ca499b4e90e9"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.17"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "dedbebe234e06e1ddad435f5c6f4b85cd8ce55f7"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.2.2"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "cceb0257b662528ecdf0b4b4302eb00e767b38e7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "0e8bcc235ec8367a8e9648d48325ff00e4b0a545"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.5"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "ea3e4ac2e49e3438815f8946fa7673b658e35bdb"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.5"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "efc140104e6d0ae3e7e30d56c98c4a927154d684"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.48"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "dad726963ecea2d8a81e26286f625aee09a91b7c"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.4.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─65a5d160-6041-11ed-0ff9-2379cc6d582a
# ╟─f63b98e1-097d-4a77-a5e8-a66107b9d745
# ╟─f6a868cc-90d5-4b8b-b61d-07ec539daa1f
# ╟─bb1b2266-01e7-4991-ad6e-924309f8d1b5
# ╟─85202f76-d0df-43e8-88e4-0018f1b4ef35
# ╟─5abc1e1f-3d26-4d7c-881b-d1a17cef69a2
# ╟─9a8b10b8-5d87-4a5d-96e4-53278dc9b337
# ╟─708e1d38-1f96-4330-b698-829e2680b4aa
# ╟─21967ce3-ab1c-4a3e-9740-bac624befbca
# ╟─86c4afa6-1606-4dd7-a82b-86b08e30b41c
# ╟─bb7a19f8-8449-46a0-b4fd-fdf1c2589150
# ╟─4b139332-bb44-4ac3-8dd9-2090600a3449
# ╟─2848f7a7-1878-4c7e-a509-af3eece7c0ca
# ╟─8265dc36-55a6-4420-a063-ff5b3c53b088
# ╟─1048e2eb-37a8-41bb-9f4b-72ad85243e37
# ╟─a74af3c1-48e3-4a10-9a99-b473de53e0c2
# ╟─6a6f159b-09b1-4a53-bfa9-ffcbe20b94dd
# ╟─a4574030-1a50-4988-a46b-becf718148a5
# ╠═27a55fd4-5c0d-4b5f-9dd8-3dd04a36dc68
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
