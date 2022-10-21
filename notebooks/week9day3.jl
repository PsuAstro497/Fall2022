### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ ae9e8a91-f154-4888-b029-b0bdfd4f11de
using PlutoUI, PlutoTeachingTools

# ╔═╡ e56ca8be-4f08-11ed-0ea5-e554a448992b
md"""
# Transmission Spectroscopy
**Astro 497, Week 9, Friday**
"""

# ╔═╡ da5a69e7-235a-4f4e-b404-c8934f1a3743
TableOfContents()

# ╔═╡ adb15016-e599-40eb-8a57-ebe7854ebe97
md"""
$(LocalResource("../_assets/week9/fig1_transit_geom.png", :width=>"80%"))
--- [Kreidberg, chapter from Handbook of Exoplanets](https://arxiv.org/abs/1709.05941)
"""

# ╔═╡ 0e1bc001-996a-4e8b-acd4-8d1434689527
LocalResource("../_assets/week2/circular_diagram.png", :width=>"80%")

# ╔═╡ 92b3b41d-01fc-4fb5-909f-9a933ca211e6
md"""

## Example Transmission Spectrum of WASP-43b 
$(LocalResource("../_assets/week9/fig3_w43.png",:width=>"80%"))
- Main figure is transmission spectrum from Hubble WFC3
- Inset figure is emission spectrum is Spitzer/IRAC 3.6 & 4.5μm
--- [Kreidberg et al. 2015 & chapter from Handbook of Exoplanets](https://arxiv.org/abs/1709.05941)
"""

# ╔═╡ ef536496-c022-4088-bf3c-1c38b94ff572
md"""
## Ground-based transmision spectroscopy 
#### XO-2b
$(LocalResource("../_assets/week9/XO2FOV.png", :width=>"60%"))
$(LocalResource("../_assets/week9/GTC_XO2_HD_4pi.png", :width=>"60%"))
--- [Sing et al. 2011](https://arxiv.org/abs/1008.4795)
"""

# ╔═╡ 2c723044-9c7c-45f3-9600-29275938f9af
md"""
# What sets the scale for transmission spectroscopy signal?
"""

# ╔═╡ 1c92299c-fd1d-421b-a0c2-c840e8e06062
md"""
## Atmospheric Scale Height
$$H = \frac{k_B T}{\mu_m g}$$

- Temperature: $T$ 
- Mean molecular mass: $\mu_m$ 
- Gravitational acceleration: $g$ 
- Boltzmann constant: $k_B$ 

Assumes an **isothermal** atmosphere in hydrostatic equilbirum.

$$\rho(z) = \rho_0 \exp(-z/H)$$
"""

# ╔═╡ fb614745-bf3d-45f7-b6a3-9d81dfdb5045
md"""
### Standard Transit depth

$$\delta \simeq \frac{\pi R_p^2}{\pi R_\star^2}$$

- Radius of Planet: $R_p$ (where optically think at all wavelengths observed)
- Radius of Star: $R_\star$ 

### Increase in transit depth

$$\Delta\delta(\lambda) = \frac{\pi (R_p + N_H(\lambda)  H)^2}{\pi R_\star^2} - \frac{\pi R_p^2}{\pi R_\star^2} \simeq 2 N_H \delta \left(\frac{H}{R_p}\right)$$

- Number of scale heights of additional absorption: $N_H(\lambda)\simeq 2$ for cloud-free atmospheres at low resolution
- Measurement wavelength: $\lambda$
"""

# ╔═╡ 432c2cc2-d105-4936-a955-15ca4ed1bcc6
md"""
### Representative values
| Planet | $\delta$ | $T$ | $g$  | $\mu_m$ | $\Delta\delta$ |
|:-------|---------:|--------:|----------:|:-------------:|---------:|
| |  | (K) | (m/s) | (amu) |  |
| Hot-Jupiter | $\simeq 10^{-2}$ | $\simeq 1300$ | $\simeq 25$| $\simeq 2$ | $\simeq 10^{-4}$ |
| Earth | $\simeq 10^{-4}$ | 273 | 10 | 28 | $\simeq 10^{-6}$ |
"""

# ╔═╡ 4f07a97e-b844-4f5c-b15f-1432ded4735a
md"""
# Gallery of Transmission Spectroscopy measurements

$(LocalResource("../_assets/week9/atmospheric_scaleheight.jpeg", :width=>"100%"))

--- [Archive fo Exoplanet Transmission Spectra](https://stellarplanet.org/science/exoplanet-transmission-spectra/) & Wakeford (2020)
"""

# ╔═╡ 0d3a2df4-946a-4c31-b7d4-53b94a980157
md"""
#### Things to look for
- Sodium absorption ~0.6μm (HAT-P-1)
- Rayleigh scattering (HD 189733b)
- Lack of rayleigh scattering → clouds (GJ 436b, GJ 1214b)
- Water Absorption ~1.4μm (WASP-127b, WASP-39b, WASP-107b, WASP-52b, HAT-P26b)
- Lack of features (TRAPPIST)
"""

# ╔═╡ ae0e2eb9-434c-4e9d-a5a2-83d2c867c5fd
md"""
#  How to prioritize planets for detailed atmospheric characterization?
## Transmission spectroscopy metric
```math
\begin{eqnarray}
\mathrm{TSM} & = & (\mathrm{Scale\; factor}) \times  \left(\frac{R_p}{R_\oplus}\right)^3 \left(\frac{M_\oplus}{M_p}\right) \left(\frac{R_\odot}{R_\star}\right)^2 \left(\frac{T_{eq}}{K}\right) \times 10^{-m_J/5} \\
& \propto & R_p \frac{H}{R_\star} \left(\mathrm{stellar\; flux}\right)
\end{eqnarray}
```

- Proportional to SNR for transmission spectroscopy measurement 
- Starts with scale height model → assumes isothermal atmosphere with **no clouds or hazes**
- Adds assumption of equilibrium temperature: $T_{eq} \equiv T_{\star,eff} \sqrt{\frac{R_\star}{a}} \left(2^{-1/4}\right)$
   - assumes zero albedo, full day-night heat redsitribution
- Original TSM uses Apparent aagnitude in J band: $m_J$ → roughly corresponding to JWST's Near IR Imager and Slitless Spectrograph (NIRISS)
   - Variations on TSM use apparent magnitude in other bands.

--- [Kempton et al. (2018)](https://ui.adsabs.harvard.edu/abs/2018PASP..130k4401K/abstract)

"""

# ╔═╡ 80a92749-ef71-4a6e-a1e8-ef14218846d8
md"""
$(LocalResource("../_assets/week9/TOI-177_TSM_Rp.png"))
--- [Almenara et al. 2022](https://ui.adsabs.harvard.edu/abs/2022A%26A...665A..91A/abstract)
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

# ╔═╡ 118c2c33-ae39-49ef-a430-b51139b969cb
question(md"""Is transmission spectroscopy limited by the thickness of a planet's atmosphere? 

Since it gets more dense closer to the center of the planet, are we only able to resolve what makes up the outer edges of said planet's atmosphere?""")

# ╔═╡ 8505a3ac-d44a-4e80-a37f-4860f35d9382
question(md"""While analyzing atmosphere composition, how to distinguish between the spectrum footprint produced by the planet and that produced by the observed background star?""")

# ╔═╡ 1ff54f17-505e-4f11-8a98-62d35d23391a
question(md"""Are the different filters used in a large variety of ways? Or or they just used based on certain properties of the planets that are being detected?""")

# ╔═╡ 3d61adf1-b48c-4a25-99eb-97c9593a0bb6
question(md"""Is a planet's transmission spectrum dependent on its temperature and mean molecular mass?  

Is this a confounding factor when determining its atmospheric composition?""")


# ╔═╡ 3ee02e32-b6ed-4f1e-aafd-7e3a6c1f5619
question(md"""What information can we get about planets using transmission spectroscopy?""")

# ╔═╡ 848ab804-cf30-47e7-b164-c7af7afe1501
question(md"If we are able to gather the light that has run into a planet's atmosphere, is there enough data to detect what the atmosphere of exoplanets consist of?")

# ╔═╡ 0baf8ecb-a1c6-4a46-a644-5e2ce39cdc96
question(md"""Are there any drawbacks to transmission spectroscopy?""")

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
# ╟─e56ca8be-4f08-11ed-0ea5-e554a448992b
# ╟─da5a69e7-235a-4f4e-b404-c8934f1a3743
# ╟─118c2c33-ae39-49ef-a430-b51139b969cb
# ╠═adb15016-e599-40eb-8a57-ebe7854ebe97
# ╟─8505a3ac-d44a-4e80-a37f-4860f35d9382
# ╟─0e1bc001-996a-4e8b-acd4-8d1434689527
# ╟─92b3b41d-01fc-4fb5-909f-9a933ca211e6
# ╟─1ff54f17-505e-4f11-8a98-62d35d23391a
# ╟─ef536496-c022-4088-bf3c-1c38b94ff572
# ╟─2c723044-9c7c-45f3-9600-29275938f9af
# ╟─1c92299c-fd1d-421b-a0c2-c840e8e06062
# ╟─fb614745-bf3d-45f7-b6a3-9d81dfdb5045
# ╟─432c2cc2-d105-4936-a955-15ca4ed1bcc6
# ╟─3d61adf1-b48c-4a25-99eb-97c9593a0bb6
# ╟─4f07a97e-b844-4f5c-b15f-1432ded4735a
# ╟─3ee02e32-b6ed-4f1e-aafd-7e3a6c1f5619
# ╟─0d3a2df4-946a-4c31-b7d4-53b94a980157
# ╟─848ab804-cf30-47e7-b164-c7af7afe1501
# ╟─ae0e2eb9-434c-4e9d-a5a2-83d2c867c5fd
# ╟─80a92749-ef71-4a6e-a1e8-ef14218846d8
# ╟─0baf8ecb-a1c6-4a46-a644-5e2ce39cdc96
# ╟─390589c9-1769-4a86-95c9-c6ce78438759
# ╟─e2f9cf86-88cd-4500-a1ea-03015de70296
# ╟─5a2ac6e2-6bac-40a7-8d0f-b8300e45f4ae
# ╠═ae9e8a91-f154-4888-b029-b0bdfd4f11de
# ╠═f64a71be-a0f6-4726-974e-5e569040bba7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
