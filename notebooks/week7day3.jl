### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ cf0ea83a-4579-11ed-1543-6b6c2082230a
using PlutoUI, PlutoTeachingTools

# ╔═╡ 3c7421bd-b96f-48db-bc2d-592b33b6d226
md"""
# Class Projects
**Astro 497, Week 7, Day 3**
"""

# ╔═╡ ec2c8424-68ed-4b03-9cf3-32f98a63ab92
TableOfContents()

# ╔═╡ 0732d791-dbca-4b93-a279-ddf47d6f2a7c
md"""
## Logistics
- Exam Results
- Lessons Learned
- Mid-Semester Survey
"""

# ╔═╡ 49cfc43a-04af-49bd-9fd3-158269382af0
md"""
### Project Overview
Students will synthesize lessons learned in the class by building an exoplanet *dashboard* that ingests data related to detecting and/or characterizing exoplanets, performs basic data manipulations, fits a model to the data, assesses the quality of the model for the given observations, and effectively visualizes the results.
"""

# ╔═╡ 51082c9f-b9b5-48d0-9ce7-e022cab973ef
md"""
# What is a Dashboard?
"""

# ╔═╡ a495011e-ffa8-4a8a-9f63-e8ae27dfb098
md"""
## Purpose
- Efficiently communicate what can be learned from data

## How
- Automating common tasks
  - Incorporating (new) data into decision making process
  - Data wrangling (e.g., cleaning, transforming, analyzing)
  - Applying simple models
  - Evaluating models
  - Providing common visualizations
- Facilitate communications & learning
  - Visualizing data
  - Visualizing model predictions
  - Providing common model assessment metrics
  - Automate easy decisions
  - Ease finding information to make hard decisions
"""

# ╔═╡ 80dc0be6-fe15-48a5-ae18-3816ec300a82
md"""
## Dashboard [Elements](https://psuastro497.github.io/Fall2022/project/#elements)
- Ingest data
- Data Wrangling
- Model Fitting
- Model Assessment
- Visualization
- Warning Messages
"""

# ╔═╡ d9d15e47-0324-4f74-9959-02defe1f6e00
md"""
# Project [Timeline](https://psuastro497.github.io/Fall2022/project/#timeline)
- [Project Plan](https://psuastro497.github.io/Fall2022/project/plan) (due Oct 19)
- [Project Checkpoint/Progress Report 1](https://psuastro497.github.io/Fall2022/project/checkpoint) (due Oct 31)
- [Project Checkpoint/Progress Report 2](https://psuastro497.github.io/Fall2022/project/checkpoint) (due Nov 14)
- [Project Dashboard](https://psuastro497.github.io/Fall2022/project/dashboard/) (due Nov 28)
- [Project Presentations](https://psuastro497.github.io/Fall2022/project/presentation/) (due Dec 2 - 9)
- [Individual Report & Reflection](https://psuastro497.github.io/Fall2022/project/report/) (due Dec 9)
"""

# ╔═╡ b71be193-556e-4415-a036-e343034c80bf
md"""
# Project Plan
### Purpose
What will be the purpose of the dashboard? 

### Obtaining Data 
What data set(s) will your dashboard use for its analysis?
   - What observatories and instruments could provide the data to be analyzed?
   - How many different objects (or time periods) are publicly available?
   - Where will you/your dashboard download the data from?
   - Is the data small enough that we will download the entire dataset once? Or is the dataset large enough that the dashboard will query a database to retrieve the data for each object (or time period) separate?
   - What format will the data be in?

### Data Wrangling
   - What data wrangling tasks (e.g., cleaning, transforming) do you anticipate needing to perform?
   - Will the data for each object (or time period) arrive in a single table? Or will you need to perform joins across multiple tables?

### Modeling
   - What models will your dashboard fit to the data?
   - What will serve as the robust baseline model?
   - What will serve as the more sophisticated model?
   - What will the models predict?
   - How will you assess your models?

### Visualize/Communicate Results
Describe the plots that will be displayed on your dashboard. For each plot:
   - What data will be shown?
   - Will it be plotted with a curve, points, contours, histogram, etc.?  
   - What will be the axes?
   - Is there additional information that could be conveyed through other attributes like size or color of points?
   - Would it be helpful to include multiple panels (e.g., to show data on different x or y scales, or to show predictions of different models)?
   - Will the figures that you have already described be sufficient for the dashboard to achieve its purpose? Or do you anticipate needing additional experimentation to convey the results of the analysis effectively? If you have some early ideas, then provide enough information that you can get constructive feedback on them.

### Project schedule
   - What tasks do you (or each member of your team) plan to accomplish each week? Make sure to account for scheduling constraints such as exams or big assignments in other classes, holidays, and travel. Be sure to allow some contingency in the schedule for tasks that take longer than expected or other unexpected delays.
   - If you're working as part of a team, then make a plan for how your team will work. Will you work together on each task simultaneously? Will each person be responsible for writing code to do specific tasks separately? It's particularly important to make a plan that doesn't create problematic dependencies (e.g., one person needs to wait for working code from someone else and the team can only meet the deadline if everything goes perfectly).
   - If you or your team have any hard scheduling constraints that would prevent them from presenting during class on Dec 2, 5, 7 or 9. You may also indicate any additional scheduling preferences.
"""

# ╔═╡ c5c712c1-e8b6-4220-a011-e22675fa9caa
md"""
## Teamwork
"""

# ╔═╡ d469d52c-7330-4004-a8a4-2e09f7eb0c01
md"""
# Questions
"""

# ╔═╡ cf806174-ee8d-4f17-87de-c83c6051c902
md"""
### By far the easiest way to meet class requirements: 
- Pluto notebook & Julia
- For nice UI can use [PlutoUI.jl](https://github.com/fonsp/Pluto.jl)

### A little extra hassle, but very possibly worth it
- Pluto notebook with Julia, plus calls to Python or R
   - [PyCall.jl](https://github.com/JuliaPy/PyCall.jl):  Justin & I have tested on Roar for you.
   - [PythonCall.jl](https://github.com/cjdoris/PythonCall.jl):  Probably nicer in long term, but I'm not sure it's ready yet.
   - [RCall.jl](https://juliainterop.github.io/RCall.jl/stable/):  For R users
- Examples of when this would make sense:  
  - Reading data in obscure file formats using [astropy.io](https://docs.astropy.org/en/stable/io/unified.html)
  - Downloading data using [astroquery](https://astroquery.readthedocs.io/en/latest/) or archive specific package (e.g., lightkurve or pyneid)

### In theory, there are environments that could work
#### But it will probably take significantly more time.

- [Dash](https://dash.gallery/Portal/) (Python-specific)
- [Reactor](https://github.com/herbps10/Reactor/) (R-specific)
- [Shiny](https://shiny.rstudio.com/) (R-specific)
- Potentially more, but I'm worried that they may be less mature, reliable, polished, well documented, etc.:
   - [Dataflow notebooks](https://dataflownb.github.io/)? (Python-specific, on top of Jupyter)
   - [Observable](https://observablehq.com/)? (Javascript+Something else) 
"""

# ╔═╡ 25a44765-87ea-4147-98ab-8bcfcfadec49
warning_box(md"""
If you try something other than Pluto, be prepared to spend significant ammount of time: figuring it out yourself, rewriting code to do tasks that I've already provided examples for, making the dashboard work reliably, and automating the setup process.
""")

# ╔═╡ 83a9749e-da15-42d0-8750-3ee021ca94b8
warning_box(md"""
If using another language make absolutely sure:
- Your dashboard must work reliably for other users and on other systems.  
   - Exactly reproduces all package versions
   - Any dependencies need to be automatically installed (likely in user space)
   - Automatically deals with data transfer, file paths, system libraries, etc.
- These things are annoying, but Justin, Pluto developers and I have already solved them for you (if you use Julia/Pluto).
- It is to be a dashboard, not a notebook or a project report
    - It should work on "new" data that you won't have been able to test it on
    - Can not require users to rerun cells in a specific order after selecting dataset (e.g., target or date range) or changing a parameter.
    - It should be *extremely easy* for users to use.
""")

# ╔═╡ d890335f-435f-494c-8884-580313ffd85e
md"""
## Dashboard Checklist
1. Dashboard successfully reads in data for user selected objects and/or time periods. (1 point)
1. Dashboard performs whatever data wrangling is necessary to provide high-quality results in subsequent analysis. (1 point)
1. Dashboard provides effective visualizations of input data (with relatively little preprocessing and, if applicable, after any potentially significant preprocessing). (1 point)
1. Dashboard successfully fits baseline model to user-selected data. (1 point)
1. Dashboard effectively visualizes the predictions of the baseline model and the deviations of the predictions from observations. (1 point)
1. Dashboard provides accurate and useful assessment of quality of results from baseline model. (1 point)
1. Dashboard successfully fits at least one more sophisticated model to user-selected data. (2 point)
1. Dashboard effectively visualizes the predictions of at least one more sophisticated model and the deviations of the predictions from observations. (1 point)
1. Dashboard provides accurate and useful assessment of quality of results from at least one more sophisticated model. (2 point)
1. Dashboard provides additional visualizations and prominent warning messages that communicate the results of the analysis effectively and clearly. (3 point)
1. Dashboard successfully runs to completion (and any error messages are in plain English) on Roar without manual setup steps. (2 points)
1. Does the dashboard provide a simple and effective user interface for selecting data to be analyzed, setting any user-specified parameters and/or interacting with visualizations. (2 points)
1. Does the dashboard effectively achieve its stated goals? (2 point)
"""

# ╔═╡ fa226e05-2eea-4635-8bc8-24551f73e706
md"""
# Setup
"""

# ╔═╡ 5f2201e5-0a1e-45c7-a7d6-516d86d5f780
ChooseDisplayMode()

# ╔═╡ e1da6dba-7fb7-4eba-a6b0-a1b87b683b04
question(str; invite="Question") = Markdown.MD(Markdown.Admonition("tip", invite, [str]))

# ╔═╡ 96a79b3c-d529-4dfd-a730-90d1a74128f3
question(md"""
Is it necessary to do the final project in Julia? 
Can we do it in a language like R or Python instead?
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoTeachingTools = "~0.2.3"
PlutoUI = "~0.7.43"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "71f8ac5999635d848b5821f188b468ce01104556"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "1833bda4a027f4b2a1c984baddcf755d77266818"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.1.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

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
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

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
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

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
git-tree-sha1 = "d8be3432505c2febcea02f44e5f4396fae017503"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.3"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "2777a5c2c91b3145f5aa75b61bb4c2eb38797136"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.43"

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
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

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
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─3c7421bd-b96f-48db-bc2d-592b33b6d226
# ╟─ec2c8424-68ed-4b03-9cf3-32f98a63ab92
# ╟─0732d791-dbca-4b93-a279-ddf47d6f2a7c
# ╟─49cfc43a-04af-49bd-9fd3-158269382af0
# ╟─51082c9f-b9b5-48d0-9ce7-e022cab973ef
# ╟─a495011e-ffa8-4a8a-9f63-e8ae27dfb098
# ╟─80dc0be6-fe15-48a5-ae18-3816ec300a82
# ╟─d9d15e47-0324-4f74-9959-02defe1f6e00
# ╟─b71be193-556e-4415-a036-e343034c80bf
# ╟─c5c712c1-e8b6-4220-a011-e22675fa9caa
# ╟─d469d52c-7330-4004-a8a4-2e09f7eb0c01
# ╟─96a79b3c-d529-4dfd-a730-90d1a74128f3
# ╟─cf806174-ee8d-4f17-87de-c83c6051c902
# ╟─25a44765-87ea-4147-98ab-8bcfcfadec49
# ╟─83a9749e-da15-42d0-8750-3ee021ca94b8
# ╟─d890335f-435f-494c-8884-580313ffd85e
# ╟─fa226e05-2eea-4635-8bc8-24551f73e706
# ╟─5f2201e5-0a1e-45c7-a7d6-516d86d5f780
# ╠═cf0ea83a-4579-11ed-1543-6b6c2082230a
# ╠═e1da6dba-7fb7-4eba-a6b0-a1b87b683b04
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
