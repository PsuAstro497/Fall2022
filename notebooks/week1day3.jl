### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ d52a0e02-1a73-11ed-1864-45f999e72173
begin
	using PlutoUI, PlutoTeachingTools
end

# ╔═╡ 2632d9c3-1db4-4d43-9c81-7495f2665c3d
md"""
# Astro 497: Week 1, Friday
# Overview of Exoplanets
- NASA's [Exoplanet Science Institute (NExScI)](https://nexsci.caltech.edu/) maintains the [Exoplanet Archive](https://exoplanetarchive.ipac.caltech.edu/index.html)
- They provide several [up-to-date plots](https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/), such as those below.
"""

# ╔═╡ 220e2f65-6c0e-4f89-a01e-a7e53c6eb2a5
md"""
## Discoveries vs Time
$(Resource("https://exoplanetarchive.ipac.caltech.edu/videos/exo_discovery_histogram.mp4", :width=>"75%"))
"""
# $(Resource("https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/exo_dischist_cb.png", :width=>"75%"))

# ╔═╡ b8c097e8-3072-44e4-9cbf-5b683ece4446
md"""
- We'll spend the first ~half of the course focusing on Radial Velocity & Transit methods.
  - These are the natural choices for class projects (because there's lots of data.)
- During the second ~half of the course, we'll touch on most of the other methods briefly.
  - But we won't get as much hands-on experience using them, since you'll be working on your projects then.
"""

# ╔═╡ f4e8da0a-7367-4357-836f-df6af36bcf7a
md"""
## Mass vs Period vs Time
$(Resource("https://exoplanetarchive.ipac.caltech.edu/videos/mass_period_movie_nexsci.mp4",:width=>"75%"))
"""

# ╔═╡ b7152a93-83bc-47e5-829a-a35378c9f20a
if false
	md"""
## Mass-Period Distribution
$(Resource("https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/exo_massperiod_cb.png", :width=>"75%")) 
	"""
end

# ╔═╡ 53840d48-d7c6-4c5f-9044-e368ea97eca0
md"""
# From individual objects to populations
- Which features on above plot reflect intrinsic distribtion of exoplanets?
- Which features reflect strengths/weaknesses of detection methods?

### Correlation vs causation

## Interpretting Data Responsibly
- Which features are *expected* based on well-established astrophysics?
- Which features are scientifically *interesting*?
- What *scientifically interesting* questions could be addressed by...
   - existing data?
   - new observations/analysis in next $N$ years?
"""

# ╔═╡ 891d967c-7cc9-419b-bc1b-124ca26a47b2
md"""
# Period vs Eccentricity 
$(Resource("https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/exo_eccperiod_cb.png",:width=>"75%"))

## What features do you notice?
- How do you interpret those?
"""

# ╔═╡ f368dff0-fce6-4bdd-932f-0174d87b82ec
md"""# What about "Small" Planets?"""

# ╔═╡ 0d91f18b-1c03-474f-8803-ffcf69ec3e51
md"""
## Radius vs Period vs Time
### (Zoom in on Planets from Kepler mission)
$(Resource("https://exoplanetarchive.ipac.caltech.edu/videos/koi-radiusvperiod-nexsci.mp4",:width=>"75%"))
"""

# ╔═╡ aba60bb6-3c89-4377-92c7-b235ccabf05b
md"""## Mass-Radius Distribution
$(Resource("https://exoplanetarchive.ipac.caltech.edu/exoplanetplots/exo_massradius_cb.png", :width=>"75%"))
"""

# ╔═╡ ee66c685-c55b-45e3-a28a-85de1dedc412
md"""
# What's missing from these plots?
"""

# ╔═╡ f5926cdd-806f-4096-ba08-1d01ce8e647f


# ╔═╡ e53d7ed0-fd38-4575-be51-eaf5e8ad8e9b
md"# Helper Code"

# ╔═╡ 362a7280-c035-4db0-8cfc-fe5c1f6b1094
ChooseDisplayMode()

# ╔═╡ a61f206b-d858-4151-aa46-6bd2416bf812
TableOfContents(aside=true)

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
# ╟─2632d9c3-1db4-4d43-9c81-7495f2665c3d
# ╟─220e2f65-6c0e-4f89-a01e-a7e53c6eb2a5
# ╟─b8c097e8-3072-44e4-9cbf-5b683ece4446
# ╟─f4e8da0a-7367-4357-836f-df6af36bcf7a
# ╟─b7152a93-83bc-47e5-829a-a35378c9f20a
# ╟─53840d48-d7c6-4c5f-9044-e368ea97eca0
# ╟─891d967c-7cc9-419b-bc1b-124ca26a47b2
# ╟─f368dff0-fce6-4bdd-932f-0174d87b82ec
# ╟─0d91f18b-1c03-474f-8803-ffcf69ec3e51
# ╟─aba60bb6-3c89-4377-92c7-b235ccabf05b
# ╠═ee66c685-c55b-45e3-a28a-85de1dedc412
# ╠═f5926cdd-806f-4096-ba08-1d01ce8e647f
# ╟─e53d7ed0-fd38-4575-be51-eaf5e8ad8e9b
# ╠═362a7280-c035-4db0-8cfc-fe5c1f6b1094
# ╠═a61f206b-d858-4151-aa46-6bd2416bf812
# ╠═d52a0e02-1a73-11ed-1864-45f999e72173
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
