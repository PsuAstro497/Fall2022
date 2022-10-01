### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ cda49574-3843-11ed-255d-f301e028a76e
begin 
	using PlutoUI, PlutoTeachingTools
	#using CSV, DataFrames, Query
	using Downloads
	#using Distributions, Statistics
	#using Plots, LaTeXStrings, ColorSchemes, StatsPlots
end

# ╔═╡ 4dade109-dd8b-450c-8a79-b0e5f8b9304d
md"""
# Exoplanet Masses & Orbits
**Astro 497, Week 7, Day 1**
"""

# ╔═╡ c8f40951-6a14-4b0a-90f5-48206b77f123
TableOfContents()

# ╔═╡ 1ea3b5f3-5eed-4452-ae90-df5cdb4b3b99
md"""
# Kepler's Multiple Planet Systems
"""

# ╔═╡ 32e6170f-0ab3-4681-9517-f9ef940e2b30
md"""
## Architectures of systems with $\ge$4 known transiting planets.
$(LocalResource("../_assets/week5/cks_multis_architectures.png"))
Credit: Fig 1 from [Weiss & Petigura (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJ...893L...1W/abstract)
"""

# ╔═╡ 2849d543-08df-4abd-9da6-a5fe02bc9228
md"""
Upcoming figures from [He, Ford & Ragozzine (2019) MNRAS, 490, 4575](https://ui.adsabs.harvard.edu/abs/2019MNRAS.490.4575H/abstract)
and
[He, Ford, Ragozzine & Carrera (2020) AJ, 160, 276](https://ui.adsabs.harvard.edu/abs/2020AJ....160..276H/abstract).
"""

# ╔═╡ 08ee8e02-9648-416f-b0b2-755e3d355714
md"""
## Number of Detections versus multiplicity
$(LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_multiplicities_compare.png"))
"""

# ╔═╡ ab9008f3-de65-4fef-a393-2a5dda409318
md"""
## Number of Detections versus multiplicity
$(LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_multiplicities_compare.png"))
"""

# ╔═╡ 0d1199fc-0888-4943-8dee-7e29ea04d20a
md"""
### Marginal Distribution of Ratios of Transit Observables for Pairs of Planets in Same System

$(TwoColumn(LocalResource("../_assets/week5/Non_Clustered_Model_periodratios_compare.png"),LocalResource("../_assets/week5/Non_Clustered_Model_depthratios_compare.png")))
"""
# LocalResource("../_assets/week5/Non_Clustered_Model_logxi_compare.png")

# ╔═╡ 4480d4e1-324c-4414-b278-6a798bab77f0
md"""
## Forward model for generating simulated planetary systems
### Drawing Periods & Radii
$(LocalResource("../_assets/week5/Models_cartoon.png"))
### Drawing Eccentricities & Inclinations
$(LocalResource("../_assets/week5/AMD_model_cartoon.png"))
"""

# ╔═╡ cf7ef986-66a6-4ba9-b1bd-2291862fb3f0
md"""
## Best-fit Model for Planetary Systems
### Marginal Distribution of Transit Observables
$(ThreeColumn(
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_periods_compare.png"),
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_radii_compare.png"),
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_durations_compare.png")))

### Marginal Distribution of Ratios of Transit Observables for Pairs of Planets in Same System

$(ThreeColumn(
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_periodratios_compare.png"),
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_depthratios_compare.png"), 
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_logxi_all_compare.png")))
"""

# ╔═╡ 745e7b26-8db6-48b1-b20d-9d1093981fa1
LocalResource("../_assets/week5/Compare_models/Models_Compare_underlying_multiplicities.png", :width=>"75%")

# ╔═╡ 6bbd37e2-98dc-4c44-95ef-e236f143b942
LocalResource("../_assets/week5/Best_model/Clustered_P_R_Model_underlying_pratio_min_vs_amd_ecc_incl.png")

# ╔═╡ 9566be82-268b-44e6-b5c7-839d0ff49cbf
LocalResource("../_assets/week5/Best_model/Clustered_P_R_Model_underlying_mult_vs_amd_ecc_incl_dists_long.png")

# ╔═╡ 44db6c55-4235-4ff5-b391-847ac9d369e5
#LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_logxi_per_mult.png")

# ╔═╡ 51f670ae-da32-475d-b59e-272edf5c8596
#=
TwoColumn(
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_logxi_mmr_compare.png"),
	LocalResource("../_assets/week5/Best_model/Observed/Clustered_P_R_Model_logxi_nonmmr_compare.png") )
=#

# ╔═╡ b264c46c-43de-49c2-8788-08e192f25ff3
md"""
# Questions (general)
"""

# ╔═╡ c879333a-5aa4-4528-9110-00f491a9ed4a
md"""
# Helper Code
"""

# ╔═╡ fbf647a7-b2ba-445d-8622-35c6cb2e27d0
ChooseDisplayMode()

# ╔═╡ 1d254576-2985-4f2a-8ca3-3c9c0e3960db
question(str; invite="Question") = Markdown.MD(Markdown.Admonition("tip", invite, [str]))

# ╔═╡ 30bb5f69-d7ca-472e-9868-2ef5f8325c22
question(md"What are some ways we can make sure a planet is transiting if the planet is only passing through one side of the star?")

# ╔═╡ 976efdd7-992c-4559-90a3-82a3b4f7ef3e
question(md"How often do we see multiple exoplanet eclipses at once? Say, two planets passing in front of the host star at the same time? I'd think this to be very rare, but what could such a phenomena reveal about the host star's planetary system?")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Downloads = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoTeachingTools = "~0.2.3"
PlutoUI = "~0.7.40"
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
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

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
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

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
git-tree-sha1 = "a602d7b0babfca89005da04d89223b867b55319f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.40"

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
# ╟─4dade109-dd8b-450c-8a79-b0e5f8b9304d
# ╟─c8f40951-6a14-4b0a-90f5-48206b77f123
# ╟─1ea3b5f3-5eed-4452-ae90-df5cdb4b3b99
# ╟─32e6170f-0ab3-4681-9517-f9ef940e2b30
# ╟─2849d543-08df-4abd-9da6-a5fe02bc9228
# ╟─08ee8e02-9648-416f-b0b2-755e3d355714
# ╟─ab9008f3-de65-4fef-a393-2a5dda409318
# ╟─0d1199fc-0888-4943-8dee-7e29ea04d20a
# ╟─4480d4e1-324c-4414-b278-6a798bab77f0
# ╟─cf7ef986-66a6-4ba9-b1bd-2291862fb3f0
# ╟─745e7b26-8db6-48b1-b20d-9d1093981fa1
# ╟─6bbd37e2-98dc-4c44-95ef-e236f143b942
# ╟─9566be82-268b-44e6-b5c7-839d0ff49cbf
# ╟─44db6c55-4235-4ff5-b391-847ac9d369e5
# ╟─51f670ae-da32-475d-b59e-272edf5c8596
# ╟─b264c46c-43de-49c2-8788-08e192f25ff3
# ╟─30bb5f69-d7ca-472e-9868-2ef5f8325c22
# ╟─976efdd7-992c-4559-90a3-82a3b4f7ef3e
# ╟─c879333a-5aa4-4528-9110-00f491a9ed4a
# ╠═fbf647a7-b2ba-445d-8622-35c6cb2e27d0
# ╠═cda49574-3843-11ed-255d-f301e028a76e
# ╟─1d254576-2985-4f2a-8ca3-3c9c0e3960db
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
