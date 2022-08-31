### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 2824ff96-5186-4d22-bea1-7c4df5f5e4bc
begin
	using PlutoUI, PlutoTeachingTools
end

# ╔═╡ 95538698-17ec-4034-978e-b737247c74b8
md"""
# Model Assessment
**Astro 497: Week 4, Monday**

## Logistics
- Lab 4 link
"""

# ╔═╡ e251d327-aaff-4b19-86a1-7e5230e22910
md"""
## Overview
1. Validate the computation
1. Validate the result on simulated data
1. Compare Likelihood to expected distribution
1. Sensitivity to individual data points
1. Sensitivity to prior distribution/assumptions
1. Posterior predictive distribution
1. Cross validation
"""

# ╔═╡ 9393819c-1ea6-4149-984c-8a3e752181f3
md"""
# Validate the computation
- Are the results pausible?
  - E.g., Magnitude of best-fit value for each model parameter
- For algorithms that have stochastic element, are results robust to:
  - Different (reasonable) initial guesses?
  - Different draws from psuedo-random number generator?
- For itterative algorithms:
  - Why did algorithm stop?
  - Any warning signs of non-convergence?
- For algorithms that return an uncertainty estimate, is the reported precission:
  - Robust?
  - Scientifically useful?
"""

# ╔═╡ 66bced2e-2fb9-4a88-9a66-4efb3c935707
md"""
# Validate the result on simulated data
- **Key step that is often overlooked!**
"""

# ╔═╡ afdc0b36-e330-4a44-ab56-ab9ce00e6dd6
md"""
# Compare Likelihood to expected distribution
Likelihood: 
```math
\begin{eqnarray}
\mathcal{L} & = & p( \mathrm{data} \; | \; \mathrm{model\; parameters}, \; \mathrm{model} ) \\
& = & p (y|θ,M) = p(y|\theta)
\end{eqnarray}
```

Often, we have a complex *physical model*, but a relatively simple model of the *measurement process*.  In these cases, if we knew the full model was correct and the model parameters ($\theta$), then we can compute the distribution of the likelihood. 

For simple measurement models, this can often be done analytically.  E.g., 
- [χ² distribution](https://en.wikipedia.org/wiki/Chi-squared_distribution) for sum of squared residuals (if measurement error is Gaussian)
- [*F*-distribution](https://en.wikipedia.org/wiki/F-distribution) for ratio of two variables drawn from χ² distribution
- [Poisson distribution](https://en.wikipedia.org/wiki/Poisson_distribution) for sum of counts (if counts are from a Poisson process)

For more complex measurement models, this is often done via simulation.

"""

# ╔═╡ 9f32462f-07b4-44d0-a20f-454cbe1e4762
md"""
# Sensitivity to individual data points
"""

# ╔═╡ 035ddb6c-52be-4d66-bc43-028aa2014033
md"""
# Sensitivity to prior distribution/assumptions
- In a Bayesian analysis, we specify prior assumptions quantitatively by specifying a prior distribution for unknown model parameters.
- There are assumptions in any model (even if they're hard to find, e.g., in a frequentist test). 

- Usually, reasonable scientists could make different reasonable assumptions.  
- The precise quantiative results will differ depending on the assumptions.
- The differences in the results under different assumptions might be:
  - So small they are scientifically unininteresting,
  - So large that more detailed analysis isn't a good use of your time,
  - Somewhere in the middle.  
- We need to know where this analysis falls along that spectrum.
"""

# ╔═╡ 46c12e8c-5a00-49fe-b922-30457993931c
md"""
# Posterior predictive distribution
- Are predictions of model 
"""

# ╔═╡ 881cd551-f535-494d-87d5-f2cb4a59066b
md"""
# Cross validation

## Cross validation of a single model
- Divide data into two subsets (e.g., 75% "training", 25% "validation")
- Fit data ("train model") using only training set
- Use resulting parameters to make predictions for validation set
- How well did the model do?  (evaluate "loss function")

## Cross validation when considering multiple models
- Divide data into **three** subsets (e.g., 60% "training", 20% "validation", 20% "test")
- For each model you want to consider:
  - Fit/Train using only data from training set
  - Validate using only data from validation set
- Pick which model you'll use for decissions/publication:
- Evaluate predictions for test data set.
- Report results on test data.
- **Avoid temptation** to make further "improvements" at the point.

"""

# ╔═╡ be85c7bb-baab-463d-b69f-898eaf4316a4
tip(md"""
**Question?**
- abc
- 
""")

# ╔═╡ d031150e-28ce-489f-8d9a-d397a1473f05
md"# Helper Code"

# ╔═╡ 504e22c9-d7ba-4cc6-bb68-f05f101db340
ChooseDisplayMode()

# ╔═╡ a3bb5429-4336-43bf-9838-c35748617a17
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
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

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
deps = ["HypertextLiteral", "LaTeXStrings", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "7aa8eef291dbb46aba4aab7fc3895d540a4725d8"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.1.5"

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
# ╟─95538698-17ec-4034-978e-b737247c74b8
# ╠═e251d327-aaff-4b19-86a1-7e5230e22910
# ╠═9393819c-1ea6-4149-984c-8a3e752181f3
# ╠═66bced2e-2fb9-4a88-9a66-4efb3c935707
# ╠═afdc0b36-e330-4a44-ab56-ab9ce00e6dd6
# ╠═9f32462f-07b4-44d0-a20f-454cbe1e4762
# ╠═035ddb6c-52be-4d66-bc43-028aa2014033
# ╠═46c12e8c-5a00-49fe-b922-30457993931c
# ╟─881cd551-f535-494d-87d5-f2cb4a59066b
# ╠═be85c7bb-baab-463d-b69f-898eaf4316a4
# ╟─d031150e-28ce-489f-8d9a-d397a1473f05
# ╠═504e22c9-d7ba-4cc6-bb68-f05f101db340
# ╠═a3bb5429-4336-43bf-9838-c35748617a17
# ╟─2824ff96-5186-4d22-bea1-7c4df5f5e4bc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
