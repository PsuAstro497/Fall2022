### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 66eaf0bf-79e3-43b4-80a8-cb75971feceb
begin
	using PlutoUI, PlutoTeachingTools
end

# ╔═╡ 39aca95d-6e93-4e18-8789-0928e881d3d9
md"""
**Welcome to**
# Data Science Applications to Exoplanets
"""

# ╔═╡ 502d38bd-8b97-484d-9618-bed479bf648a
md"""
# Safety

- Please err on the side of caution.
- If not feeling well, **please** stay home.
- If have reason to believe may have been exposed, **please** stay home.
- **Please** wear a high-quality & well-fitting mask while in the classroom.  

"""

# ╔═╡ 4f15b6fc-5876-46c5-b682-bfa71e77ee16
md"""

### Masks
- Offer students masks
- Studies indicate that:
   - N95/KN95/KF94 masks are significantly more effective than surgical masks
   - Surgical masks are more effective than cotton masks
   - Good fit and being worn properly is key to either's effectiveness

"""

# ╔═╡ e25a3d93-b981-48e2-9189-1398e137960e
md""" 
### Distancing
- While some students may be comfortable working closely with a partner, others may prefer to maintain physical distance.
- Students are expected to respect others' requests for physical distancing.
- If you work together with a classmate in-person, please get in the habit of communicating with them.
- It's ok to change one's mind mid-semester, as we learn more about the situation.
"""

# ╔═╡ d6e5cea3-1d40-4266-bf1a-478139d3b211
md"""
### Why?
- Being sick, isolating and/or quarantining make it harder to stay on top of classes.
- Being extra cautious during class will help peers and instructor to focus on learning, rather than worrying about their safety.
- If engage in less safe activities outside of class, please take precautions.  
"""

# ╔═╡ 19575253-08f8-48f8-b1ec-89b4074b8108
md"""
# Course Logistics
## Website 
#### [https://psuastro497.github.io/Fall2022/](https://psuastro497.github.io/Fall2022/) contains:
- Syllabus
- Info for each week's lessons (e.g., reading & bonus links)
- Info for to labs/homework exercises.
- Key due dates for project (more info to come)
- Practical Tips 

## Canvas
- Announcements
- Uploading some assignments 
- Links for Zoom & TopHat
- Other info via embedded version of website

## Zoom 
- For Wednesday lab classes
"""

# ╔═╡ db79a1cc-0cec-4cae-a24b-d2f4e256eb2c
md"""
# Creating Accounts:
## Roar: 
- Penn State's supercomputer
- Will use for running labs/homework exercises & class project
- I'll walk people through setup steps this Wednesday.
- Please [request account](http://localhost:8000/tips/roar/create_account/) by end of today.
"""

# ╔═╡ 6c9684cd-3952-4e01-b3bc-d111d47b48ff
md"""
## TopHat:
- For submitting reading questions
- Submit question by 9am on day of relevant class.
- Aim for at least 1 question a week.  (I'll drop some from grade automatically.)
- Create account in time to submit reading question on Friday
   - No need to give phone number or credit card info.
"""

# ╔═╡ dba2b51e-0dc7-48f2-a975-ead2280dca54
md"""
# Textbook & Readings
- [Exoplanets](https://www.amazon.com/Exoplanets-Space-Science-Sara-Seager/dp/0816529450) (Seager, ed; ISBN: 978-0816529452)
Several readings from online sources, e.g.: 
- [Think Julia](https://www.amazon.com/Think-Julia-Like-Computer-Scientist/dp/1492045039) (Lauwens; ISBN: 1492045039) or [online](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html)
- [Julia Data Science](https://www.amazon.com/dp/B09KMRKQ96/) (Storopoli & Huljzer; ISBN-13: 979-8489859165) or [online](https://juliadatascience.io/)
- [Bayesian Statistics using Julia and Turing](https://storopoli.github.io/Bayesian-Julia/)
"""

# ╔═╡ 88003290-02ca-487b-b94d-4ce553caeb6e
Resource("https://images-na.ssl-images-amazon.com/images/I/31txP-5Z+8L._SX385_BO1,204,203,200_.jpg")

# ╔═╡ 4ead033d-0001-4479-86ac-f420ecbf15d3
Resource("https://images-na.ssl-images-amazon.com/images/I/51IsffDG4jL._SX379_BO1,204,203,200_.jpg")

# ╔═╡ b8bc9184-059c-45b3-8a7a-9bb3d4b8c6b4
Resource("https://images-na.ssl-images-amazon.com/images/I/41IR7AhnnpL._SX348_BO1,204,203,200_.jpg")

# ╔═╡ d2f1789a-3d21-40e9-8d98-bdd52e54554e
md"""
# What is Data Science?

### What do you think?

## One oversimplified take...
"""

# ╔═╡ b2376e4d-4d13-42d6-a484-217f1dbcabb7
Resource("https://images.squarespace-cdn.com/content/v1/5150aec6e4b0e340ec52710a/1364352051365-HZAS3CLBF7ABLE3F5OBY/Data_Science_VD.png?format=750w")

# ╔═╡ a12f0d4d-12d9-4c13-81c1-69889e7aabf4
md"The Data Science Venn Diagram is from Drew Conway and is licensed as [Creative Commons Attribution-NonCommercial](http://creativecommons.org/licenses/by-nc/3.0/legalcode)"

# ╔═╡ 07851600-44d6-4b44-9839-8bf19c647884
md"""
## This class is *not* meant to teach:
- Programming (e.g., CMPSC 121, 122)
- Numerical Methods (see ASTRO 410)
- Linear Algebra (see MATH 220)
- Statistics (e.g., ASTRO 415)
- Machine Learning (e.g., DS 310)
- Astronomical Techniques (see ASTOR 451)
- How to conduct Astronomy Research (e.g., a summer project or thesis)
"""

# ╔═╡ 75eecba2-fb5f-4dfc-b2af-b3041c9357b0
md"""
## So what does this class do?
### Exoplanets:
- Overview of field of the field
- Interpret exoplanet observations

### Data Science:
- Develop *Data Acumen*[^1]
  - Model building
  - Data visualization
  - Reproducible research
- Practice "soft skills"
  - Technical collaboration
  - Scientific communications
- Provide taste of Data Science
"""

# ╔═╡ 44755795-c2f7-44dc-86a2-ba6e848f3a67
md"""
### Data Acumen
[^1]: "We define data acumen as the ability to make good judgements about the use of data to support problem solutions." ([Keller et al. 2020](https://doi.org/10.1162/99608f92.2d83f7f5))
"""

# ╔═╡ d8015168-9c59-45b5-81c3-7b37fbf26319
md"""
# Course Overview
Students will learn about techniques for detecting and characterizing extrasolar planetary systems, including the capabilities and challenges for the future of each method. Students will analyze astronomical data to detect and characterize exoplanets and their host stars. Along the way, students will build practical data science skills (e.g., querying astronomical databases, data storage and manipulation, data visualization, exploratory and explanatory data analysis, Bayesian modeling workflows, and reproducible research practices).

## Goals
- Understand how astronomers detect and characterize extrasolar planetary systems,
- Learn about the current state and future of exoplanet science,
- Increase their data acumen, and
- Appreciate how building data science skills can benefit astronomy & astrophysics research.

## Objectives
- Ingest and manipulate data from astronomical surveys.
- Quantitatively describe the effects of exoplanets on astronomical observations.
- Build, apply, assess and update astrophysically motivated models for astronomical observations.
- Create visualizations for exploratory and explanatory data analyses of observations from exoplanet surveys.
- Synthesize the above into a dashboard to support the efficient analysis of exoplanet observations while following principles of reproducible research.
"""

# ╔═╡ 5370fe50-add3-4886-9ef5-a6e1aecd1cc4
md"""
## Remebmer to request Roar account so can log in on Wednesday!
"""

# ╔═╡ 02a0991e-8ebe-4307-b277-59d39d612c78
md"# Helper Code"

# ╔═╡ 9a4a6761-8c60-4a7d-92d3-cdfbc85c76d9
ChooseDisplayMode(present=false)

# ╔═╡ e8794ba6-7344-4c16-b2b7-570008848a4a
md"ToC on side $(@bind toc_aside CheckBox(;default=true))"

# ╔═╡ ffd38b51-b872-432b-a9bf-7568681d3aa1
TableOfContents(aside=toc_aside)

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
# ╟─39aca95d-6e93-4e18-8789-0928e881d3d9
# ╟─502d38bd-8b97-484d-9618-bed479bf648a
# ╟─4f15b6fc-5876-46c5-b682-bfa71e77ee16
# ╟─e25a3d93-b981-48e2-9189-1398e137960e
# ╟─d6e5cea3-1d40-4266-bf1a-478139d3b211
# ╟─19575253-08f8-48f8-b1ec-89b4074b8108
# ╟─db79a1cc-0cec-4cae-a24b-d2f4e256eb2c
# ╟─6c9684cd-3952-4e01-b3bc-d111d47b48ff
# ╟─dba2b51e-0dc7-48f2-a975-ead2280dca54
# ╟─88003290-02ca-487b-b94d-4ce553caeb6e
# ╟─4ead033d-0001-4479-86ac-f420ecbf15d3
# ╟─b8bc9184-059c-45b3-8a7a-9bb3d4b8c6b4
# ╟─d2f1789a-3d21-40e9-8d98-bdd52e54554e
# ╟─b2376e4d-4d13-42d6-a484-217f1dbcabb7
# ╟─a12f0d4d-12d9-4c13-81c1-69889e7aabf4
# ╟─07851600-44d6-4b44-9839-8bf19c647884
# ╟─75eecba2-fb5f-4dfc-b2af-b3041c9357b0
# ╟─44755795-c2f7-44dc-86a2-ba6e848f3a67
# ╟─d8015168-9c59-45b5-81c3-7b37fbf26319
# ╟─5370fe50-add3-4886-9ef5-a6e1aecd1cc4
# ╟─02a0991e-8ebe-4307-b277-59d39d612c78
# ╟─9a4a6761-8c60-4a7d-92d3-cdfbc85c76d9
# ╟─e8794ba6-7344-4c16-b2b7-570008848a4a
# ╟─ffd38b51-b872-432b-a9bf-7568681d3aa1
# ╠═66eaf0bf-79e3-43b4-80a8-cb75971feceb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
