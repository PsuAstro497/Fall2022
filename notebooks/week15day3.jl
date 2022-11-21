### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 0a76c19b-a812-4a27-927c-8462d8b45263
using PlutoUI, PlutoTeachingTools, ShortCodes

# ╔═╡ 21e779f0-69a2-11ed-2375-6186eb8751c8
md"""
# Future of Exoplanet Characterization
**Astro497, Week 15, Day 3**
"""

# ╔═╡ b4416de1-92ff-4f58-817d-7caac2dae00e
md"""
## Logistics
- Class presentations
"""

# ╔═╡ 922dc0fb-ac8b-4e40-9c91-263aaaa831ec
TableOfContents()

# ╔═╡ 55eeb586-f85d-4f35-b0d4-ccd6fe1a2b5f
md"""
## Questions fom Last week
"""

# ╔═╡ 701c1397-f876-413c-a088-7f32821f0b72
question_box(md"""What are some of the "more sophisticated" ways to image mature planets and and why are they necessary?""")

# ╔═╡ 8cae27e3-feaf-49df-8ac7-6dc3dd79d359
question_box(md"Will the planet's spectrum suffer from the contamination of stellar light, stellar wind, or circumstellar materials? If so, how can astronomers  eliminate such contamination?")

# ╔═╡ 313a5800-4395-40d1-acfb-b8d7831fec2f
question_box(md"Are coronagraphs just able to observe objects with very small [angular] separations or do they offer any other large scale benefits?")

# ╔═╡ 92f30fd8-3fc3-40c8-98be-e3b139936a3a
md"""
# Future of Exoplanet Characterization
"""

# ╔═╡ 0a47fda7-4d49-4455-8697-3ef1ef452cb8
md"""
## Radial Velocities
- Follow-up of transiting systems
- Preparatory science for direct imaging missions
"""

# ╔═╡ 755424c3-9ff9-463e-8942-73c619e50f0c
md"""
## Transits 
- [Cheops](https://www.esa.int/Science_Exploration/Space_Science/Cheops): Follow-up of RV targets
- [TESS](https://tess.gsfc.nasa.gov/) extended missions
- [Plato](https://platomission.com/) follow-up of Kepler field
"""

# ╔═╡ bf4f3112-367d-4d4b-8a76-722004db6bcb
md"""
## Transit/Occultation Spectroscopy
### [JWST](https://webb.nasa.gov/)
$(LocalResource("../_assets/week15/jwst_spectrum_wasp39b.png", :width=>"100%"))
Credit: [NASA, ESA, CSA & StScI](https://www.nasa.gov/image-feature/goddard/2022/nasa-s-webb-reveals-steamy-atmosphere-of-distant-planet-in-detail)

$(LocalResource("../_assets/week15/jwst_spectrum_wasp96b.jpg", :width=>"100%"))
Credit: [Image: NASA, ESA, CSA, and L. Hustak (STScI)](https://www.nasa.gov/feature/goddard/2022/nasa-s-webb-detects-carbon-dioxide-in-exoplanet-atmosphere)
"""

# ╔═╡ 9be30e1c-e8f5-42a2-a77b-166a61d82201
md"""
## [Ariel](https://arielmission.space/) (Atmospheric Infrared Remote sensing Exoplnae Large Survey)
- Luanch scheduled 2029
- 4 year primary mission
- 1.1 x 0.7 meter primary
- Orbit about L2
- Photoometry & Spectroscopy spanning 0.5--7.8 μm

$(Resource("https://arielmission.space/wp-content/uploads/2019/04/ariel4.png", :width=>"60%"))
"""

# ╔═╡ 25cef735-d449-4c5e-b09a-ee6860ce9bb0
md"""
## Direct Imaging Misson Concepts:
#### Decadal Survey Inputs:
- HabEx (4m)
  - Camera (general purpose)
  - Coronagraph
  - Spectragraph
    - Vis, Blue: 0.45–-0.67 μm, R~140
    - Vis, Red: 0.67-–1.0 μm, R~140
    - NIR: 0.975-–1.8 μm, R~40
  - Starshade (52m!)
- LUVOIR (Large Ultraviolet Optical Infrared Surveyor)
  - LUVOIR-A: (8m)
  - LUVOIR-B: (15m)
  - Instruments:
    - Coronagraphic imager/spectrograph:
      - Near-UV (0.200-0.525 μm; R~140) 
      - Optical (0.515-1.030 μm; R~70) 
      - Near-IR (1-2 μm; R~200)
    - Optional star-shade
    - General purpose astrophysics instruments:
      - High-definition imager (UV/optical (200-950nm) and NIR (800--2500nm) arms)
      - Multiobject Spectragraph
      - Poliarization instrument (from ESA)
#### Decadal Survey Recommendation:
- “large infrared/optical/ultraviolet telescope... in 2040s” (6m) --- [A&A Decadal Survey 2020](https://www.nationalacademies.org/our-work/decadal-survey-on-astronomy-and-astrophysics-2020-astro2020)
"""

# ╔═╡ f6bd00b8-63b6-4f1b-87fe-f679df3f1652
md"""
#### LUVOIR 
$(LocalResource("../_assets/week15/1024px-Rendering_of_LUVOIR-A_observatory,_2019.png", :width=>"100%"))
Credit:  [NASA](https://asd.gsfc.nasa.gov/luvoir/design/)"""

# ╔═╡ e098ba7f-3262-4441-aeb0-b35db391ae7b
md"""
#### HabEX
$(LocalResource("../_assets/week15/Starshade_Artist's_Concept_2_PIA20911.jpg", :width=>"100%"))
Credit: [NASA/JPL-Caltech](https://photojournal.jpl.nasa.gov/catalog/PIA20911) """

# ╔═╡ cafe66ec-cb81-4033-9bc3-9a35cd66441f
md"""
## Simulated Spectra from HabEX
$(LocalResource("../_assets/week15/HabExFinalReport-FigES3.png",:width=>"100%"))
Image Credit:  [HabEx Final Report](https://www.jpl.nasa.gov/habex/)
"""

# ╔═╡ c6380774-4c57-484d-82ab-2364ba020f86
md"""
## Simulated Earth Spectrum from LUVOIR
$(LocalResource("../_assets/week15/LUVOIR_earth_spectrum.png",:width=>"100%"))
Image Credit: J. Lustig-Yaeger via [LUVOIR Final Report](https://www.luvoirtelescope.org/copy-of-design)
"""

# ╔═╡ 76e28b88-8d8b-4004-98af-b4462cc06f5e
md"""
## Earth through time
$(LocalResource("../_assets/week15/LUVOIR_earth_through_time.png",:width=>"100%"))
Image Credit:  Arney, Domagal-Goldman & Griswold via [LUVOIR Final Report](https://www.luvoirtelescope.org/copy-of-design)
"""

# ╔═╡ 90e42040-f3ae-41cb-9811-ea7ab8c9b3d5
md"""
## Prepatory Extremely Precise Radial Velocity Survey
$(LocalResource("../_assets/week13/EPRV_HabEx_yield.png"))
--- Credit: Morgan et al. 2021 submitted/Crass et al. 2021

"""

# ╔═╡ 401d052c-106c-4296-bff3-e997a26e8c9c
md"""
### Projected Yield of Proposed EPRV Survey

$(LocalResource("../_assets/week13/Luhn_snr_architectures.jpg", :width=>"70%"))
--- Credit: [Luhn et al. 2022](https://ui.adsabs.harvard.edu/abs/2022arXiv220412512L/abstract)

$(LocalResource("../_assets/week13/Luhn_snr_stellar_types.jpg", :width=>"70%"))
--- Credit: [Luhn et al. 2022](https://ui.adsabs.harvard.edu/abs/2022arXiv220412512L/abstract)
"""

# ╔═╡ c251e18c-1415-45c0-b2d7-ee32eaa348bc
question_box(md"What types of star are better for direct imaging of their planets?")

# ╔═╡ 3e3f9001-4cc9-47ab-a7f5-27b34354aaaa
md"""
$(LocalResource("../_assets/week13/HabEx_targets_1.png"))
$(LocalResource("../_assets/week13/HabEx_targets_2.png"))
--- Credit: [HabEx Final Report](https://www.jpl.nasa.gov/habex/documents/)
"""

# ╔═╡ 30eebd11-6202-4058-bcf4-7e439b6bc720
md"""
## Light curve of Earth (diurnal)
$(LocalResource("../_assets/week15/Earth_rotational_variability_fst2002.png",:width=>"100%"))
Image Credit:  [Ford, Seager & Turner 2002](https://arxiv.org/abs/astro-ph/0210277)
"""

# ╔═╡ 712bd604-6d28-438b-8f3d-91ae187fa539
md"""
## Light curve of Earth (diurnal)
$(LocalResource("../_assets/week15/Earth_seasonal_variations_fst2022.png",:width=>"80%"))
Image Credit:  [Ford, Seager & Turner 2002](https://arxiv.org/abs/astro-ph/0210277)
"""

# ╔═╡ 61a64ee3-0b60-487a-82d6-9359c9ed5934
md"""
## Light curve of alternative Earths
$(LocalResource("../_assets/week15/alt_earths_fst2002.png",:width=>"80%"))
Image Credit:  [Ford, Seager & Turner 2002](https://arxiv.org/abs/astro-ph/0210277)
"""


# ╔═╡ 3e1cf4b5-9746-4116-a364-b2075fc3f142
md"""
## Autocorrelation function of Earth's lightcurve (equatorial view)
$(LocalResource("../_assets/week15/earth_rotation_acf.png",:width=>"80%"))
Black:  Cloudless.  Blue:  Cloud-free. $br
Image Credit:  [Palle et al. 2008](https://arxiv.org/abs/0802.1836)
"""


# ╔═╡ 8ca54e3d-9234-447f-8dc2-9f62de0de29c
md"""
## Evolution of Earth's light curve 
$(LocalResource("../_assets/week15/earth_albedo_variability_9.3d.png",:width=>"100%"))
Caption:  
Each curve is the average daily lightcurve over 9.3 days.
$br
Left:  Cloud-free.  Right:  Clouds 
$br
Image Credit:  [Palle et al. 2008](https://arxiv.org/abs/0802.1836)
"""


# ╔═╡ 5f985f48-1b6c-4706-a32a-d6f8338e8bdf


# ╔═╡ e7cd1f30-12da-408e-8f73-c14b7e6c9626
md"""
# Setup/Helper Code
"""

# ╔═╡ 78b5ed93-0496-405d-839f-472dec2188c0
ChooseDisplayMode()

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
ShortCodes = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"

[compat]
PlutoTeachingTools = "~0.2.5"
PlutoUI = "~0.7.48"
ShortCodes = "~0.3.3"
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

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

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

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

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

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "SnoopPrecompile", "StructTypes", "UUIDs"]
git-tree-sha1 = "84b10656a41ef564c39d2d477d7236966d2b5683"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.12.0"

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

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

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
git-tree-sha1 = "b64719e8b4504983c7fca6cc9db3ebc8acc2a4d6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.1"

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
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

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

[[deps.ShortCodes]]
deps = ["Base64", "CodecZlib", "HTTP", "JSON3", "Memoize", "UUIDs"]
git-tree-sha1 = "0fcc38215160e0a964e9b0f0c25dcca3b2112ad1"
uuid = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
version = "0.3.3"

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

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "ca4bccb03acf9faaf4137a9abc1881ed1841aa70"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.10.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "8a75929dcd3c38611db2f8d08546decb514fcadf"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.9"

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
# ╟─21e779f0-69a2-11ed-2375-6186eb8751c8
# ╟─b4416de1-92ff-4f58-817d-7caac2dae00e
# ╟─922dc0fb-ac8b-4e40-9c91-263aaaa831ec
# ╟─55eeb586-f85d-4f35-b0d4-ccd6fe1a2b5f
# ╟─701c1397-f876-413c-a088-7f32821f0b72
# ╟─8cae27e3-feaf-49df-8ac7-6dc3dd79d359
# ╟─313a5800-4395-40d1-acfb-b8d7831fec2f
# ╟─92f30fd8-3fc3-40c8-98be-e3b139936a3a
# ╟─0a47fda7-4d49-4455-8697-3ef1ef452cb8
# ╟─755424c3-9ff9-463e-8942-73c619e50f0c
# ╠═bf4f3112-367d-4d4b-8a76-722004db6bcb
# ╟─9be30e1c-e8f5-42a2-a77b-166a61d82201
# ╟─25cef735-d449-4c5e-b09a-ee6860ce9bb0
# ╟─f6bd00b8-63b6-4f1b-87fe-f679df3f1652
# ╟─e098ba7f-3262-4441-aeb0-b35db391ae7b
# ╟─cafe66ec-cb81-4033-9bc3-9a35cd66441f
# ╟─c6380774-4c57-484d-82ab-2364ba020f86
# ╟─76e28b88-8d8b-4004-98af-b4462cc06f5e
# ╟─90e42040-f3ae-41cb-9811-ea7ab8c9b3d5
# ╟─401d052c-106c-4296-bff3-e997a26e8c9c
# ╟─c251e18c-1415-45c0-b2d7-ee32eaa348bc
# ╟─3e3f9001-4cc9-47ab-a7f5-27b34354aaaa
# ╟─30eebd11-6202-4058-bcf4-7e439b6bc720
# ╟─712bd604-6d28-438b-8f3d-91ae187fa539
# ╟─61a64ee3-0b60-487a-82d6-9359c9ed5934
# ╟─3e1cf4b5-9746-4116-a364-b2075fc3f142
# ╟─8ca54e3d-9234-447f-8dc2-9f62de0de29c
# ╠═5f985f48-1b6c-4706-a32a-d6f8338e8bdf
# ╟─e7cd1f30-12da-408e-8f73-c14b7e6c9626
# ╟─78b5ed93-0496-405d-839f-472dec2188c0
# ╟─0a76c19b-a812-4a27-927c-8462d8b45263
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
