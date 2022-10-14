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
# Exoplanet Populations
**Astro 497, Week 8, Day 3**
"""

# ╔═╡ 5802bccb-e7de-40f2-87b7-5f68545dbb98
TableOfContents()

# ╔═╡ b6cbdfef-f881-4a36-8cfa-e3ef98e5c035
md"""
# Mid-semester Feedback

#### Thanks for the encouragement about the labs!

## How to use Wednesdays
- All respondents expressed interest in using at least some of the remaining Wednesdays for working on projects.  
- 2nd most popular was talking through how to approach solving quantitative problems 

Let's make a plan.  
"""

# ╔═╡ 4f1e2adf-d23e-4d84-a331-88b1857579dd
TwoColumn(
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


# ╔═╡ e6b8ed94-1762-4723-b077-f9463f8ad0ff
md"""
## Other suggestions
- Provide a full week to complete labs.  
"""

# ╔═╡ bdfc73de-4cb9-4153-b506-97aa3c89076a
TwoColumn(
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
""")

# ╔═╡ 64865555-6812-446a-b808-9f41449f274a


# ╔═╡ baf36f8f-72fa-4492-a15b-200da8e8fe08
md"""
## Mid-term Exam Feedback
- Most respondents cited time as a significant challenge.
- Some students mentioned not knowing which equations to use or not being confident that they used the right equations.
"""

# ╔═╡ d03d8317-22c4-4ff8-8921-9155ba77a064
md"""
# How to organize knowledge about exoplanets (or any new field)?
- Start with very limited knowledge.
- As discover more exoplanets, iteratively improve knowledge.
- As detection methods improve, we expect that the first detections are likely to be extreme in some way.
- Even after detecting thousands of exoplanets, detection biases sculpt the known population. 

## What we'd like to use
- Physical characteristics (e.g., rocky, oceans, atmosphere)
- How planets formed
"""

# ╔═╡ 35601a4f-1282-4511-b102-3874ed8add41
md"""
!!! hint "What's the problem with this system?"
    We usually don't know their detailed physical characteristics.
    We will never know their formation history for certain. 
"""

# ╔═╡ cfafc195-e8fb-4ae7-9d39-6e2e480c4c31
md"""
## Commonly used categories in practice
### What do we measure first/best?
- Orbital period (for transits or RVs)
   - Relatively easy to transform in insolation
- Size (for transits) or $m \sin i$ (for RVs)
"""

# ╔═╡ aacdada5-2912-4037-8de2-c14f6ead0de7
md"""
### Giant Planets
- Hot-Jupiters (HJs)
- Warm Giant Planets
- Temperate/Cool Giant Planets (RV)
- Wide-orbits Giant Planets (Direct Imaging)
"""

# ╔═╡ 6bf696f1-0d0f-40d1-b03e-e0c591e9ef79
md"""
### Neptune-size/mass Planets
- Hot-Neptunes
- Warm Neptunes
"""

# ╔═╡ 5f902134-f5a0-414d-af93-5334e6024c35
md"""
### Rocky Planets
- Ultra short period planets (USPs) 
- Warm rocky planets
- Habitable-zone rocky planets
"""

# ╔═╡ ababa190-51d0-48bc-b097-72ff6a1cff80
md"""
## What else can we measure?
Categories based on a notable property that is harder to measure, so is measured for only a subset of planets/systems: 
- Chains of planets in mean-motion resonances (transits/TTVs)
- Eccentric giant planets  (RVs, TTVs)
- Misaligned hot-Jupiters  (RM)
- Bulk densities (combining transits and RVs or TTVs)
  - Rocky planets
  - Planets with H/He atmospheres
  - Waterworlds
  - Super-puffy planets
"""

# ╔═╡ 742c93a4-247b-4abd-aee8-1515872e333c
md"""
## Categories for rare planets/systems
- Ultra-short period planets 
- Warm Jupiters
- Brown dwarf desert
- Pairs of planets straddling the radius valley
"""

# ╔═╡ 7c543f14-f0ac-4160-be87-92d502221bdc
md"""
# More nuanced types of information about a population
- Non-detections ("truncation")
- Upper (or lower) limits ("censoring")

## How to deal with censored & truncated data?
- For simple models can derive likelihoods
- Hierarchical models

## Challenges of combining data from multiple surveys/methods
"""

# ╔═╡ 793c67a2-69c6-4577-a435-53601d91485e
md"""
# Reading Questions
## Selection Effects
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
# ╟─b6cbdfef-f881-4a36-8cfa-e3ef98e5c035
# ╟─4f1e2adf-d23e-4d84-a331-88b1857579dd
# ╟─e6b8ed94-1762-4723-b077-f9463f8ad0ff
# ╟─bdfc73de-4cb9-4153-b506-97aa3c89076a
# ╟─64865555-6812-446a-b808-9f41449f274a
# ╟─baf36f8f-72fa-4492-a15b-200da8e8fe08
# ╟─d03d8317-22c4-4ff8-8921-9155ba77a064
# ╟─35601a4f-1282-4511-b102-3874ed8add41
# ╟─cfafc195-e8fb-4ae7-9d39-6e2e480c4c31
# ╟─aacdada5-2912-4037-8de2-c14f6ead0de7
# ╟─6bf696f1-0d0f-40d1-b03e-e0c591e9ef79
# ╟─5f902134-f5a0-414d-af93-5334e6024c35
# ╟─ababa190-51d0-48bc-b097-72ff6a1cff80
# ╟─742c93a4-247b-4abd-aee8-1515872e333c
# ╟─7c543f14-f0ac-4160-be87-92d502221bdc
# ╟─793c67a2-69c6-4577-a435-53601d91485e
# ╟─5c891d4b-8ed6-4153-b027-5ee36e12579c
# ╟─124ca383-cf56-4aef-8137-045f1d39dceb
# ╟─aab300af-0a91-49e2-892a-3501c79b2c07
# ╟─73619a67-d86c-4d03-93c8-f3c56fc79f2c
# ╟─6a003863-69dc-40aa-95f3-bfe7159bdf6e
# ╟─2ef8e8d0-4af9-11ed-2a34-1fe4f1ff7dc8
# ╟─d0d367dd-30cd-4306-baf5-7cd5f24aca0f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
