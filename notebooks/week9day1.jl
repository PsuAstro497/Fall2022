### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 2ef8e8d0-4af9-11ed-2a34-1fe4f1ff7dc8
begin
using PlutoUI, PlutoTeachingTools, HypertextLiteral
using DataFrames
end

# ╔═╡ 3d1bb85d-27c4-41ce-85b2-1e65566d4515
md"""
# Data Science Lifecycle
**Astro 497, Week 9, Day 1**
"""

# ╔═╡ 5802bccb-e7de-40f2-87b7-5f68545dbb98
TableOfContents()

# ╔═╡ d3d8d201-e3aa-4cd6-9df2-6d291c06172b
md"""
## Reading questions
"""

# ╔═╡ 124ca383-cf56-4aef-8137-045f1d39dceb
md"""
By number of known planets:
- Most planets discovered by RVs around G & K type stars (sweat spot for RVs)
- Most planets discovered by transits around G & F type stars (brighter)

By occurrence rate of planets:
- Cool stars
- Metal-rich stars

What biases could contribute to these apparent trends?
"""

# ╔═╡ aab300af-0a91-49e2-892a-3501c79b2c07
hint(md"""
- Cooler main sequence stars have smaller masses and radii →
  - RV amplitude is larger for given planet mass
  - Transit depth is larger for given planet size
- Metal-rich stars have larger opacity in photosphere →
  - Brighter for given mass and age

- Early indication of a preference for giant planets around metal-rich stars led some RV surveys to intentionally select metal-rich stars.
  
""")

# ╔═╡ 41885326-82e5-45eb-940e-de73eef9542f
md"""
- Transit Timing Variations
  - Systems near mean-motion resonances
  - Very closely spaced planets
  - TTV period short enough to see TTVs during Kepler mission 
  - Orbital periods long enough that TTV amplitude could be detected
- Imaging
  - Large orbital separations
  - Prefer nearly face-on orbits
  - Planets bright in IR → 
    - Nearby
    - Hot → Massive & Young

- Microlensing
  - Sweet spot in projected angular distance
  - More massive planets have longer microlensing signatures

"""

# ╔═╡ c235a0f3-ff38-436e-8b18-15efc19f200a
md"""
- Microlensing
"""

# ╔═╡ 45caad00-3102-49f1-9388-67a1703388fb
md"""
When using different telescopes from different locations, better coverage in time-domain is achieved.  However, correlated noise due to *atmospheric effects* or *stellar variability* will still affect transit survey sensitivity.
"""

# ╔═╡ 39cfffe5-90b0-4b6c-aefb-0beee32dc70f
md"""
## Periodograms
"""

# ╔═╡ 09032194-ba8f-4d5c-83f9-d8396cf80c3a
md"""
See [periodograms](http://localhost:1234/edit?id=47d17f80-4e22-11ed-3bed-83c8eef24851&isolated_cell_id=5a73b1fc-99bc-4530-ae4a-49ce25df99dc&isolated_cell_id=27119a64-236d-4b8f-b48a-0f4690f2a2f1)
"""

# ╔═╡ 8bf4eb0d-2ab4-4cfc-ba14-357db52f77ae
md"""
## Labs
"""

# ╔═╡ 55bc1d57-c9e4-4415-a2b4-3d72b9fd0bda
df1 = DataFrame(:x=>1:3, :a=>["a","b","c"] )

# ╔═╡ b9c55b94-c2ae-4168-9ac1-f82e0a6c0f93
df2 = DataFrame(:y=>10:10:30, :b=>rand(3) )

# ╔═╡ 736fae87-4cb6-4f4a-8fa7-2eeae32b5db9
crossjoin(df1,df2)

# ╔═╡ 57c17cde-8763-4db2-9504-e9e74fbb0ee3
md"""
## File Formats

### What type of data does it store?
- Text
- Documents
- Numerical values
- Time-series
- Images
- Data cubes

### Very common file formats
- Text (ASCII or Unicode)
  - Delimited (e.g., CSV, TSV)
  - Fixed-width (e.g, AAS machine-readable tables)
  - Markup languages (e.g., html, xml, toml, yaml,...)
- Binary
  - FITS: Standard for astronomical observations
  - HDF5: Standard for numerical simulations

### Key questions to ask when choosing a file format
- How big is the dataset?
- Will users want to read all data at once or small pieces of data?
- Is dataset highly structured (e.g., large tables or images)?
- Is it important to include machine-readable metadata?
- Does it make sense to compress data?

### What not to use
- Your own custom binary file format
- File formats that depend on versions of your softare (e.g., pickle)
- Markup languages for highly structured data 
- Text formats for large datasets

"""

# ╔═╡ e51391a6-4d60-4b85-b606-04f567476d54
md"""
# Data Science Lifecycle
"""

# ╔═╡ c625122d-6d63-445d-9281-40971851507c
md"""
## Example of a Data Science Lifecycle
(This is just one of many.)

1. Ask an interesting question
   - What is the scientific goal?
   - What would you do if you had all the data?
   - What do you want to predict or estimate?
2. Get the data
   - How were the data sampled?
   - Which data are relevant?
   - Are there privacy issues?
3. Explore the data
   - Plot the data.
   - Are there anomalies?
   - Are there patterns?
4. Model the data
   - Build a model.
   - Fit the model.
   - Validate the model.
5. Communicate and visualize the results
   - What did we learn?
   - Do the results make sense?
   - Can we tell a story?
--- Blitzstein & Pfister for [Harvard CS109](https://cs109.github.io/2015/)
"""

# ╔═╡ 5f77f4db-cb91-4696-b517-28b17f51ed48
md"""
#### What's missing?
"""

# ╔═╡ cf3d848d-b566-4475-80fd-a3743201eb0c
hint(md"""
- Making iterative process/loops explicit
- Interpreting results for oneself
- Deploying model to work for future data
""")

# ╔═╡ b096359d-158d-42c5-80a1-9543eb30ef9e
md"""
### Some workflows common in industry
#### OSEMN
  - Obtain
  - Scrub
  - Explore
  - Model
  - iNterpret

#### CRISP-DM
   - Business Understanding
   - Data Understanding
   - Data Preparation
   - Modeling
   - Evaluation
   - Deployment

Emphasizes loops and deployment

#### Team Data Science Process (TDSP) 
Combines a workflow with project templates and recommendations for infrastructure and tools.  Favors MS products.
"""

# ╔═╡ 43dc6de8-fbab-42d3-9daa-3ac29b100764
md"""
#### Domino’s data science life cycle is founded on three guiding principles:
1. Ideation
2. Data Acquisition and Exploration
3. Research & Development
4. Validation
5. Delivery
6. Monitoring

Emphasizes frequest iteration, collaboration and reproducibility.
"""

# ╔═╡ e66bd4b0-0e43-4903-a10b-6fa85cad0b26
md"""
## Adapting Data Science Workflows from Industry to Scientific Setting
- Reinterpret terms like "business case" and "customer"
- Often don't know to quantify success when we start a project
- Generally, place more value on interpretability 
- Can accommodate projects requiring longer timescales
- Increasingly, plan to make data & codes with public
- Often communication is primarily with other scientists
"""

# ╔═╡ ca78d256-8d41-4904-b48b-eae0c77cbf40
md"""
# ICDS Fall 2022 Symposium
#### Data Science, AI, and a Sustainable, Resilient, and Equitable Future

## Keynote speaker: danah boyd
#### Partner Researcher at Microsoft Research, the founder of Data & Society and a Distinguished Visiting Professor at Georgetown University

Quotes that stood out to me.
- "I found that the people who ascribe the most power to statistics and data are not people who do statistics and data science.  They are executives who give the vision talks about the power of data..." - Jeff Hammerbacher (2016), former lead of Data Science at Facebook

- "Performing math is different than doing math."  (in context of redistrictors making it look like yore being objective)

- "You're not making true claims.  You're making invitations for inquiry." (in context of redistricting)

- "It's easier for me to agree with the model" (in context of career risk)


"""

# ╔═╡ 73619a67-d86c-4d03-93c8-f3c56fc79f2c
md"""
# Setup
"""

# ╔═╡ 6a003863-69dc-40aa-95f3-bfe7159bdf6e
ChooseDisplayMode()

# ╔═╡ d0d367dd-30cd-4306-baf5-7cd5f24aca0f
question(str; invite="Question") = Markdown.MD(Markdown.Admonition("tip", invite, [str]))

# ╔═╡ 5c891d4b-8ed6-4153-b027-5ee36e12579c
question(md"""
Is there one type of star that is more frequently found having exoplanets orbiting it, and if so, could that be due to selection effects as well?
""")

# ╔═╡ ec32bba8-e334-4c41-a4f8-36b262cf2b32
question(md"What are the selection effects for other methods of exoplanet detection?")

# ╔═╡ ea42b3f7-bda0-4919-b76f-9808c0b994fe
question(md"Do rogue planets impact exoplanet selection effects or number distributions at all? ")

# ╔═╡ 3567639a-da74-4d1b-b93c-da2e099295c6
question(md"""
Will multi-observatory transit surveys detection ability limited by "red noise"? """)

# ╔═╡ 94607e8e-e6e5-4483-899b-8214f6acefe5
question(md"""
Can you explain the LS periodogram?
""")

# ╔═╡ 69284468-3d75-430e-8bb0-c75e97f2e448
question(md"""
Is it possible to measure multiple periodogram power peaks that are all similar in magnitude and above the detection threshold, and what should be done in these cases?
""")

# ╔═╡ 60cf2065-206c-4354-9ca5-f0b1b0ac9219
question(md"""
Crossjoin:  What does the cartesian product of rows exactly mean?
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DataFrames = "~1.4.1"
HypertextLiteral = "~0.9.4"
PlutoTeachingTools = "~0.2.3"
PlutoUI = "~0.7.43"
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
git-tree-sha1 = "1833bda4a027f4b2a1c984baddcf755d77266818"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.1.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "3ca828fe1b75fa84b021a7860bd039eaea84d2f2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.3.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "46d2680e618f8abd007bce0c3026cb0c4a8f2032"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.12.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "558078b0b78278683a7445c626ee78c86b9bb000"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.4.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

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

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

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

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

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
deps = ["Dates"]
git-tree-sha1 = "6c01a9b494f6d2a9fc180a08b182fcb06f0958a0"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.2"

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
git-tree-sha1 = "d8be3432505c2febcea02f44e5f4396fae017503"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.3"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "6e33d318cf8843dade925e35162992145b4eb12f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.44"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "460d9e154365e058c4d886f6f7d6df5ffa1ea80e"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.1.2"

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

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "c79322d36826aa2f4fd8ecfa96ddb47b174ac78d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.0"

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
# ╟─3d1bb85d-27c4-41ce-85b2-1e65566d4515
# ╟─5802bccb-e7de-40f2-87b7-5f68545dbb98
# ╟─d3d8d201-e3aa-4cd6-9df2-6d291c06172b
# ╟─5c891d4b-8ed6-4153-b027-5ee36e12579c
# ╟─124ca383-cf56-4aef-8137-045f1d39dceb
# ╟─aab300af-0a91-49e2-892a-3501c79b2c07
# ╟─ec32bba8-e334-4c41-a4f8-36b262cf2b32
# ╟─41885326-82e5-45eb-940e-de73eef9542f
# ╟─ea42b3f7-bda0-4919-b76f-9808c0b994fe
# ╟─c235a0f3-ff38-436e-8b18-15efc19f200a
# ╟─3567639a-da74-4d1b-b93c-da2e099295c6
# ╟─45caad00-3102-49f1-9388-67a1703388fb
# ╟─39cfffe5-90b0-4b6c-aefb-0beee32dc70f
# ╟─94607e8e-e6e5-4483-899b-8214f6acefe5
# ╟─09032194-ba8f-4d5c-83f9-d8396cf80c3a
# ╟─69284468-3d75-430e-8bb0-c75e97f2e448
# ╟─8bf4eb0d-2ab4-4cfc-ba14-357db52f77ae
# ╟─60cf2065-206c-4354-9ca5-f0b1b0ac9219
# ╠═55bc1d57-c9e4-4415-a2b4-3d72b9fd0bda
# ╠═b9c55b94-c2ae-4168-9ac1-f82e0a6c0f93
# ╠═736fae87-4cb6-4f4a-8fa7-2eeae32b5db9
# ╟─57c17cde-8763-4db2-9504-e9e74fbb0ee3
# ╟─e51391a6-4d60-4b85-b606-04f567476d54
# ╟─c625122d-6d63-445d-9281-40971851507c
# ╟─5f77f4db-cb91-4696-b517-28b17f51ed48
# ╟─cf3d848d-b566-4475-80fd-a3743201eb0c
# ╟─b096359d-158d-42c5-80a1-9543eb30ef9e
# ╟─43dc6de8-fbab-42d3-9daa-3ac29b100764
# ╟─e66bd4b0-0e43-4903-a10b-6fa85cad0b26
# ╟─ca78d256-8d41-4904-b48b-eae0c77cbf40
# ╟─73619a67-d86c-4d03-93c8-f3c56fc79f2c
# ╟─6a003863-69dc-40aa-95f3-bfe7159bdf6e
# ╟─2ef8e8d0-4af9-11ed-2a34-1fe4f1ff7dc8
# ╟─d0d367dd-30cd-4306-baf5-7cd5f24aca0f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
