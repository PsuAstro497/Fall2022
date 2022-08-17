### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 3d94c83d-0238-4ba5-820f-022bd6aac230
using PlutoUI, PlutoTeachingTools

# ╔═╡ 01f5afeb-2a44-48d4-8e7c-b9f932602b08
md"""
**Astro 497: Week 2, Friday**

# Exoplanet Detection:  Transits

## Overview
- Transit Method
- Observables
- Transit Probability
- Transit Surveys
- Multiple Transiting Planet Systems
- Strengths & Weaknesses
- Multiple Transiting Plantes
"""

# ╔═╡ 28d92f9a-ec46-4fa9-b6a8-fb234610b974
md"""
# Transit Method
"""

# ╔═╡ 10606b2e-f494-4368-b85b-fd02132b45b2
md"""
$(Resource("https://exoplanets.nasa.gov/5_ways_content/vid/transit_method_single_planet.mp4"))
Credit:  NASA
"""

# ╔═╡ f873d738-f2f8-4e9c-8d62-2e3f617e9e48
md"""
$(LocalResource("../_assets/week2/circular_diagram.png"))
Credit:  [Joshua Winn (2010)](https://arxiv.org/abs/1001.2010)
"""

# ╔═╡ 12127631-9af6-4f29-a297-d39a9680d7ed
md"""
##### Normalized Flux versus time
```math
\begin{equation}
f(t) = 1 + k^2 \frac{I_p(t)}{I_\star} -
\begin{cases}
k^2 \alpha_{\rm tra}(t) & \text{transits,} \\
0 & \text{outside eclipses,} \\
k^2 \frac{I_p(t)}{I_\star} \alpha_{\rm occ}(t) & \text{occultations.}
\end{cases}
\end{equation}
```
- Disk-averaged intensity of the star: $I_\star$
- Disk-averaged intensity of the planet: $I_p$ 
- Planet-star radius ratio: $k = R_p/R_\star$
"""

# ╔═╡ a72ea48b-c4c7-4b13-8751-e5494da2b9e8
md"""
## Keplerian Orbit
### Motion in the Orbital plane:
$r = \frac{a(1-e^2)}{1+e\cos f}$
- Star-planet sepration: $r$
- Semimajor axis: $a$
- Eccentricity: $e$
- True anomaly: $f$
"""

# ╔═╡ 03b9598f-3de1-4519-ac6a-184305ff4168
md"""
### Orbit projected onto the sky
```math
\begin{eqnarray}
X & = & -r \cos(\omega+f), \\
Y & = & -r \sin(\omega+f)\cos i,\\
Z & = & r \sin(\omega+f)\sin i
\end{eqnarray}
```

- Inclination: $i$
- Arguement of pericenter: $\omega$
- Longitude of ascending node: $\Omega$ (arbitrarily set to $180\degree$)
"""

# ╔═╡ 72ddc5df-5408-47dc-8b99-7063306b305d
md"""
#### When do transits occur?
$X^2+Y^2 \le R_\star + R_p$

$f_{{\rm tra}} = +\frac{\pi}{2} - \omega$
$f_{{\rm occ}} = -\frac{\pi}{2} - \omega$
"""

# ╔═╡ 4dc63f3a-e4c5-4a2a-98ad-6cb00e4e71a0
md"""
# Transit Observables
$(LocalResource("../_assets/week2/transit_diagram.png"))
Credit:  [Joshua Winn (2010)](https://arxiv.org/abs/1001.2010)
"""

# ╔═╡ b9089f24-6836-49b4-a9b5-48bbf138afd5
md"""
## One transit
- Transit Depth: $\delta$ (dimensionless)
- Impact Parameter: $b$ (units of stellar radii)
- Ingress Duration: $\tau$
- Transit Durations:
   - Total duration: $t_{IV}-t_{I}$
   - Full-transit duration: $t_{III}-t_{II}$
   - Mathematically-convenient duration: $T$
   - Best-measured duration: $(t_1+t_2-t_3-t_4)/2$
"""

# ╔═╡ 886279f9-e77f-4ffc-aadf-35d6fd5e64c2
md"""
#### Impact parameter
$b = \frac{a \cos i}{R_\star} \left(\frac{1-e^2}{1 + e\sin\omega}\right)$

"""

# ╔═╡ 0a1c2f71-de04-4e42-b140-cafaf663ac31
md"""
#### Transit depth 
$\delta \approx \left(\frac{R_p}{R_\star}\right)^2~\left[1 - \frac{I_p(t_{\rm tra})}{I_\star}\right]$
"""

# ╔═╡ 54caf8ec-22e7-46eb-960d-e318e846bcb9
md"""
## Multiple Transits
- Orbital period: $P$
- Epoch of $n$th transit: $t_n$
- Deviations from mean values
  - Transit Timing Variations (TTVs): $\delta t_i$
  - Transit Duration Variations (TDVs): $\delta T_i$
  - Transit Depth Variations (TdVs): $\delta d_i$
"""

# ╔═╡ 1a1d349c-ba18-4d17-9123-28652469824d
md"""
# Transit Probability
$(LocalResource("../_assets/week2/probcalc.png"))
Credit:  [Joshua Winn (2010)](https://arxiv.org/abs/1001.2010)
"""

# ╔═╡ 3ab2e03b-724b-452f-b4b7-3cb855dae849
md"""

$p_{\rm tra} = \left(\frac{R_\star \pm R_p}{a}\right)
                   \left(\frac{1 + e\sin\omega}{1 - e^2} \right)$

For a small planet on acircular orbit:

$p_{\rm tra} = \frac{R_\star}{a}~\approx 0.005~\left( \frac{R_\star}{R_{\odot}} \right)
                        \left( \frac{a}{{\rm AU}} \right)^{-1}$

"""

# ╔═╡ 1903ed4c-a09a-4dac-ad6f-6204cbc60237
md"""
# Transit Surveys
## Ground-based Transit Surveys

"""

# ╔═╡ 970cdb06-6953-428c-9fdc-cdbd346dd8c6
md"""
### Early Surveys
$(LocalResource("../_assets/week2/horne_table.png", :width=>"100%"))
Credit: [Horne 2002](http://star-www.st-and.ac.uk/~kdh1/transits/table.html)
"""

# ╔═╡ 5ec759dd-551c-4da6-8aa7-b442958720e8
md"""
### Notable ground-based transit surveys
Dozens of large planets:
- [SuperWASP](https://wasp-planets.net/wasp-planets/)
- [HATNet](https://hatnet.org/planets/)
Small planets around nearby stars:
- [MEarth](https://lweb.cfa.harvard.edu/MEarth/Welcome.html)
- [TRAPPIST](https://www.eso.org/public/usa/teles-instr/lasilla/trappist/)
"""

# ╔═╡ f8f1b2e2-e72d-4c6e-9d51-b7ebf812897c
md"""
## Space-based Transit Surveys
- CoRoT
- Kepler/K2
- TESS
- Plato
"""

# ╔═╡ c8432773-77dd-4a78-ba90-50042f70ccad
md"""
### Kepler/K2
![Kepler/K2 spacecraft](https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/images/314379main_keplerstacking-lrg_full.jpg)
Credit: [NASA](https://www.nasa.gov/mission_pages/kepler/multimedia/images/09-02-16.html)
"""

# ╔═╡ fd9c5332-f1e8-43e1-a77a-4e77bb58f105
md"""
### TESS
![TESS Spacecraft](https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/tess_with_techs_4000.jpg)
Credit: [NASA](https://www.nasa.gov/image-feature/this-is-tess-our-newest-planet-hunter)
"""

# ╔═╡ 0d7d2c3e-f3fe-4a9e-986c-463d24a30fa6
md"""
# Stregnths & Weaknesses
## Strengths
-
-

## Weaknesses
-
-

"""

# ╔═╡ 9e5421f0-25f8-476b-a2fe-7e6acddfb3d9
Resource("https://exoplanets.nasa.gov/5_ways_content/vid/transit_method_double_planet.mp4") #, :width=>"100%")

# ╔═╡ 14afc732-48cb-43a3-956b-a2f42b49dceb
md"""
# Multiple Transiting Planets
## Kepler-11
![Kepler-11 Cartoon](https://upload.wikimedia.org/wikipedia/commons/9/9a/Kepler-11_System.jpg)
Credit: [NASA/Tim Pyle](https://www.nasa.gov/mission_pages/kepler/multimedia/images/kepler11_solar_system.html)
"""

# ╔═╡ 4809e920-04e0-4ebe-8daa-c14a21db653c
md"""
## TRAPPIST-1
![TRAPPIST-1 Light Curve Animation](https://exoplanets.nasa.gov/internal_resources/822)
Credit: [NASA](https://exoplanets.nasa.gov/faq/31/whats-a-transit/)
"""

# ╔═╡ a5c32806-1e5b-11ed-0f01-7f4009ba4972


# ╔═╡ c651ae5b-cea8-4c61-a50c-819697d24a06
md"# Helper Code"

# ╔═╡ 087cd2b5-2821-466d-b869-504ad97931a0
TableOfContents()

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoTeachingTools = "~0.1.4"
PlutoUI = "~0.7.39"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
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

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

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

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoTeachingTools]]
deps = ["LaTeXStrings", "Markdown", "PlutoUI", "Random"]
git-tree-sha1 = "e2b63ee022e0b20f43fcd15cda3a9047f449e3b4"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.1.4"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8d1f54886b9037091edf146b517989fc4a09efec"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.39"

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
# ╟─01f5afeb-2a44-48d4-8e7c-b9f932602b08
# ╟─28d92f9a-ec46-4fa9-b6a8-fb234610b974
# ╟─10606b2e-f494-4368-b85b-fd02132b45b2
# ╟─f873d738-f2f8-4e9c-8d62-2e3f617e9e48
# ╟─12127631-9af6-4f29-a297-d39a9680d7ed
# ╟─a72ea48b-c4c7-4b13-8751-e5494da2b9e8
# ╟─03b9598f-3de1-4519-ac6a-184305ff4168
# ╟─72ddc5df-5408-47dc-8b99-7063306b305d
# ╟─4dc63f3a-e4c5-4a2a-98ad-6cb00e4e71a0
# ╟─b9089f24-6836-49b4-a9b5-48bbf138afd5
# ╟─886279f9-e77f-4ffc-aadf-35d6fd5e64c2
# ╟─0a1c2f71-de04-4e42-b140-cafaf663ac31
# ╟─54caf8ec-22e7-46eb-960d-e318e846bcb9
# ╟─1a1d349c-ba18-4d17-9123-28652469824d
# ╟─3ab2e03b-724b-452f-b4b7-3cb855dae849
# ╟─1903ed4c-a09a-4dac-ad6f-6204cbc60237
# ╟─970cdb06-6953-428c-9fdc-cdbd346dd8c6
# ╟─5ec759dd-551c-4da6-8aa7-b442958720e8
# ╟─f8f1b2e2-e72d-4c6e-9d51-b7ebf812897c
# ╟─c8432773-77dd-4a78-ba90-50042f70ccad
# ╟─fd9c5332-f1e8-43e1-a77a-4e77bb58f105
# ╟─0d7d2c3e-f3fe-4a9e-986c-463d24a30fa6
# ╟─9e5421f0-25f8-476b-a2fe-7e6acddfb3d9
# ╟─14afc732-48cb-43a3-956b-a2f42b49dceb
# ╟─4809e920-04e0-4ebe-8daa-c14a21db653c
# ╠═a5c32806-1e5b-11ed-0f01-7f4009ba4972
# ╟─c651ae5b-cea8-4c61-a50c-819697d24a06
# ╠═3d94c83d-0238-4ba5-820f-022bd6aac230
# ╠═087cd2b5-2821-466d-b869-504ad97931a0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
