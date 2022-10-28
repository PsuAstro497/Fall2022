### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ ae9e8a91-f154-4888-b029-b0bdfd4f11de
using PlutoUI, PlutoTeachingTools

# ╔═╡ e56ca8be-4f08-11ed-0ea5-e554a448992b
md"""
# Emission Spectroscopy
**Astro 497, Week 10, Friday**
"""

# ╔═╡ da5a69e7-235a-4f4e-b404-c8934f1a3743
TableOfContents()

# ╔═╡ fb7dbb03-ce25-4072-a346-73765abb05e5
md"""
## Logistics
- Schedule for presentations posted
"""

# ╔═╡ 0e1bc001-996a-4e8b-acd4-8d1434689527
md"""
$(LocalResource("../_assets/week2/circular_diagram.png", :width=>"80%"))
--- Credit: Fig 1 from [Winn chapter](https://arxiv.org/abs/1001.2010) of Exoplanets textbook
"""

# ╔═╡ adb15016-e599-40eb-8a57-ebe7854ebe97
md"""
$(LocalResource("../_assets/week9/fig1_transit_geom.png", :width=>"80%"))
--- [Kreidberg, chapter from Handbook of Exoplanets](https://arxiv.org/abs/1709.05941)
"""

# ╔═╡ ef5156b1-f1a6-41d2-84db-80fab9b68172
md"""

## Example Emission Spectrum 
### Start with timeseries
$(LocalResource("../_assets/week10/HAT7whitenew.png",:width=>"80%"))
--- [Mansfield et al.](https://arxiv.org/abs/1805.00424) [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
"""

# ╔═╡ 2a15caef-a987-4087-bf9f-3e6ff276c0bd
md"""
### Reduce to single emission spectrum
$(LocalResource("../_assets/week10/spectra_limit_f_02.png",:width=>"80%"))
--- [Mansfield et al.](https://arxiv.org/abs/1805.00424) [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
"""

# ╔═╡ 2c723044-9c7c-45f3-9600-29275938f9af
md"""
# What sets the scale for emission spectroscopy signal?
"""

# ╔═╡ be67a4e2-9a5f-48f3-afb6-a4ee6a5f9b62
md"""
### Increase in observed flux outside of transit

$f_{\mathrm{out-of-occultation}} \simeq \pi R_\star^2 B_\lambda(T_\star) + \pi R_p^2 B_\lambda(T_{pl})$

$f_{\mathrm{during-occultation}} \simeq \pi R_\star^2 B_\lambda(T_\star)$


- Measurement wavelength: $\lambda$
- Surface temperature of star ($T_\star$) and planet ($T_pl$)
- Radius of Planet: $R_p$ (where optically think at all wavelengths observed)
- Radius of Star: $R_\star$ 
"""

# ╔═╡ d06a2137-fa31-4334-909e-07975ca2987f
md"""
### Planck function for Blackbody radiation
$B_\lambda(T) = \frac{2hc^2}{\lambda^3} \frac{1}{e^{hc/(\lambda k_B T)}-1}$

If both star and planet have uniform surface brightness, then 

$\delta_{occ}(\lambda) =  \frac{\pi R_p^2}{\pi R_\star^2} \frac{B_\lambda(T_p)}{B_\lambda(T_\star)}$

Then integrate $\delta_{occ}(\lambda)$ over spectral bandpass observed.
"""

# ╔═╡ 1202615c-3f96-4e1c-9ca4-8a33a4ed2dae
md"""
#### Rayleigh-Jeans limit
If $\lambda \gg \frac{hc}{k_B T}$, then 

$B_\lambda(T) \rightarrow \frac{2 k_B T}{\lambda^2}$ 
and

$\delta_{occ}(\lambda) \rightarrow  \left(\frac{R_p}{R_\star}\right)^2 \frac{T_p}{T_\star}$

"""

# ╔═╡ 432c2cc2-d105-4936-a955-15ca4ed1bcc6
md"""
### Representative values
| Planet | $\delta$ | $T$ | $\Delta\delta_{occ}$ |
|:-------|---------:|----:|:--------------------:|
| |  | (K) |   |
| Hot-Jupiter | $\simeq 10^{-2}$ | $\simeq 1300$ |  $\simeq 2\times 10^{-3}$ |
| Earth | $\simeq 10^{-4}$ | 273 | $\simeq 5 \times 10^{-6}$ |
"""

# ╔═╡ 498fe414-2dc0-4b85-8c91-4dd066354bca
md"""
### What could we detect?
$(LocalResource("../_assets/week10/OpacitiesNew.png",:width=>"80%"))
--- [Mansfield et al.](https://arxiv.org/abs/1805.00424) [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
"""

# ╔═╡ b23dca9e-afc7-4b8d-9d87-793089c68b51
md"""
### Comparison to models
$(LocalResource("../_assets/week10/VivienNewestSpectrum.png",:width=>"80%"))
--- [Mansfield et al.](https://arxiv.org/abs/1805.00424) [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
"""

# ╔═╡ ae0e2eb9-434c-4e9d-a5a2-83d2c867c5fd
md"""
#  How to prioritize planets for detailed atmospheric characterization?
## Emission spectroscopy metric
```math
\begin{eqnarray}
\mathrm{ESM} & = & 4.29 \times 10^6 \times \left(\frac{R_p}{R_\oplus}\right)^2 \left(\frac{B_{7.5}(T_{day})}{B_{7.5}(T_\star)}\right) \times 10^{-m_K/5} \\
\end{eqnarray}
```

- Planck's function for temperature $T$ evaluated at 7.5μm ($B_{7.5}(T))$
- Planet's dayside temperature ($T_{day}$)
- Apparent magnitude of host star in K band ($m_K$), since that's what's commonly available

- Proportional to SNR for emissions spectroscopy measurement at mid-IR wavelengths
- MIRI LRS bandpass is ~5--10 μm
- Assumes blackbody emission model for star and planet
- Planet emission can differ by over an order of magnitude due to molecular absoprtion bands (and opacity low windows between them)
- Sometimes approximate $T_{day} \simeq 1.1 T_{eq}$ based on models that must assume heat redistristribution factor (0.53), albedo (0.3), etc.

--- [Kempton et al. (2018)](https://ui.adsabs.harvard.edu/abs/2018PASP..130k4401K/abstract)
"""

# ╔═╡ 9d06b2fb-d53b-4190-b229-a22fbb1741e4
md"""
### Example/Reference case
#### GJ 1132b
$R_p/R_\star = 0.0455$
$a/R_\star = 16.54$
$T_\star = 3270\;\mathrm{K}$
$ESM = 7.5$
"""

# ╔═╡ 75c096fb-cb60-4aca-a9a2-6924cad61880
md"""
$(LocalResource("../_assets/week10/mass_vs_metallicity.png",:width=>"80%"))
--- [Mansfield et al.](https://arxiv.org/abs/1805.00424) [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
"""

# ╔═╡ 390589c9-1769-4a86-95c9-c6ce78438759
md"""
# Reading Questions
"""

# ╔═╡ e2f9cf86-88cd-4500-a1ea-03015de70296
md"""
# Setup & Helper Code
"""

# ╔═╡ 5a2ac6e2-6bac-40a7-8d0f-b8300e45f4ae
ChooseDisplayMode()

# ╔═╡ f64a71be-a0f6-4726-974e-5e569040bba7
question(str; invite="Question") = Markdown.MD(Markdown.Admonition("tip", invite, [str]))

# ╔═╡ 16864b92-cd9a-462b-b093-880a618116b1
question(md"How significant is the error when approximating blackbody temperature with brightness temperature?")

# ╔═╡ 128bb657-447e-43cd-8555-0858786e6dfb
question(md"In a lot of the emission spectra, the wavelength range is 1-10 microns. 
Are there any important elements that can be detected that do not lie in this range?")

# ╔═╡ 0d3a2df4-946a-4c31-b7d4-53b94a980157
#md"""#### Things to look for"""
question(md"Is occultation spectroscopy a good way to find out the type of planet we are looking at?")

# ╔═╡ d4f5366c-7c85-4835-b4f9-ec76a1349285
question(md"""
Are there specific types of stars for which occultation spectroscopy is better suited/more successful? 
""")

# ╔═╡ 0baf8ecb-a1c6-4a46-a644-5e2ce39cdc96
question(md"""Are there any drawbacks to emission spectroscopy?""")

# ╔═╡ 7b660cf9-6359-4419-bb31-770204a574dd
question(md""" "Occultation spectroscopy and transit spectroscopy thereby provide different and complementary information about the planetary atmosphere."

What exact different information can these two spectroscopy  provide?""")

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
# ╟─e56ca8be-4f08-11ed-0ea5-e554a448992b
# ╟─da5a69e7-235a-4f4e-b404-c8934f1a3743
# ╟─fb7dbb03-ce25-4072-a346-73765abb05e5
# ╟─0e1bc001-996a-4e8b-acd4-8d1434689527
# ╟─adb15016-e599-40eb-8a57-ebe7854ebe97
# ╟─ef5156b1-f1a6-41d2-84db-80fab9b68172
# ╟─2a15caef-a987-4087-bf9f-3e6ff276c0bd
# ╟─2c723044-9c7c-45f3-9600-29275938f9af
# ╟─be67a4e2-9a5f-48f3-afb6-a4ee6a5f9b62
# ╟─d06a2137-fa31-4334-909e-07975ca2987f
# ╟─1202615c-3f96-4e1c-9ca4-8a33a4ed2dae
# ╟─432c2cc2-d105-4936-a955-15ca4ed1bcc6
# ╟─498fe414-2dc0-4b85-8c91-4dd066354bca
# ╟─16864b92-cd9a-462b-b093-880a618116b1
# ╟─128bb657-447e-43cd-8555-0858786e6dfb
# ╟─b23dca9e-afc7-4b8d-9d87-793089c68b51
# ╟─0d3a2df4-946a-4c31-b7d4-53b94a980157
# ╟─ae0e2eb9-434c-4e9d-a5a2-83d2c867c5fd
# ╟─d4f5366c-7c85-4835-b4f9-ec76a1349285
# ╟─9d06b2fb-d53b-4190-b229-a22fbb1741e4
# ╟─75c096fb-cb60-4aca-a9a2-6924cad61880
# ╟─0baf8ecb-a1c6-4a46-a644-5e2ce39cdc96
# ╟─7b660cf9-6359-4419-bb31-770204a574dd
# ╟─390589c9-1769-4a86-95c9-c6ce78438759
# ╟─e2f9cf86-88cd-4500-a1ea-03015de70296
# ╟─5a2ac6e2-6bac-40a7-8d0f-b8300e45f4ae
# ╟─ae9e8a91-f154-4888-b029-b0bdfd4f11de
# ╟─f64a71be-a0f6-4726-974e-5e569040bba7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
