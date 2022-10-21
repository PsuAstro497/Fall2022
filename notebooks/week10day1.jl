### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ c771a5b6-50df-11ed-31c6-dbf7aa47c90a
using PlutoUI, PlutoTeachingTools

# ╔═╡ fd64866f-1c3b-43ef-93ff-eace062dae2d
md"""
# Data Storage & Memory Access
**Astro 497: Week 10, Monday**
"""

# ╔═╡ 3dfec25d-4600-4425-90a6-c652dd2b5ebc
TableOfContents()

# ╔═╡ 8aef55bf-3bd3-49a6-8c0c-3e9384eebd4b
md"""
## Memory latency heirarchy
- Registers
- Cache L1
- Cache L2
- Cache L3
- RAM
- Local disk storage
- Disk storage on local network
- Disk storage on internew
- Tape storage
"""

# ╔═╡ 5dc6dc68-9e3e-45f1-abba-48381adf6a3a
md"
[Interactive Memory Latency vs Year](https://colin-scott.github.io/personal_website/research/interactive_latency.html)"


# ╔═╡ dc964423-dd50-48c4-9899-36c596b83658
md"""
### Where do your variables go?
- Stack (scalars, small structures or collections with known size)
- Heap (large collections, structures/collections with unknown size)
"""

# ╔═╡ ff821bb7-e4c1-42fc-b8a1-3170b1a3204f
md"""
#### Stack 
![Program call stack](https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/ProgramCallStack2_en.png/862px-ProgramCallStack2_en.png) (from [Wikimedia](https://commons.wikimedia.org/wiki/File:ProgramCallStack2_en.png))

- Stack memory is released on a last-in-first-out basis.
- Therefore, stack (de)allocation is faster than allocation/deallocation from heap.
- Stack has limited size (often can change defaults, but then code becomes OS specific)
- Stack is good for variables:
   - Whose size is known at compile time, 
   - Aren't too large 
   - Won't be needed after function finishes
- Use heap for 
   - Large collections (e.g., arrays, matrices) that are stored contiguously in memory.
   - Collections whose size is unknown at compile time
   - Collections that allow for variable size (even if their size is known at compile time)
"""

# ╔═╡ 63e7b99c-c203-4acf-a775-5d0bc8b69ffd
md"""
### Stages of Compilation
- Preprocessing/parsing of human-written code
- *Lowered*/Intermediate form (for weakly or dynamically typed languages)
- *Typed code* (for strongly or dynamically typed typed languages)
- LLVM Compiler's Intermediate Representation (*LLVM IR*) (similar to "byte code")
   - Text form (for a small fraction of humans to read)
   - Binary forms (for compiler, library)
- Native code (for CPU)
- CPU rewrites code on the fly!
"""


# ╔═╡ ac7bb983-4ac5-4196-ab7c-bc180f35f0d4
md"""
**Q:**  Why have memory speed increases been unable to keep up with CPU speed increases?

**A:**  Registers do keep up with CPU speed.  
- People want more and more memory.  Not all can be fast.
- CPUs have stopped getting faster.  They are increasing their throughput.
[Memory latency comparison](https://colin-scott.github.io/personal_website/research/interactive_latency.html)

**Q:**  What is physically limiting memory speeds from being equal to modern CPU speeds?

**A:**  Real estate on a chip is valuable.  
- Physical proximity affects latency.  
- Low latency memory requires more power than memory with lower latency.
CPU/memory speed is limited by ability to dissipate heat.

![Variations on Moore's Law:
](https://www.karlrupp.net/wp-content/uploads/2018/02/42-years-processor-trend.png) - source: [K. Rupp blog](https://www.karlrupp.net/2018/02/42-years-of-microprocessor-trend-data/#more-760) 
"""

# ╔═╡ 5315a4ec-d56e-4339-8b48-2e4e651dca5f
md"""
## Compiled vs Interpretted Languages
**Q:** When optimizing Python [or R, IDL,...] code I've been told to eliminate for loops wherever possible. 
For Julia (or C/C++, Fortran, Java,...) for loops are not detrimental. Why is this?

- Interpretted languages: 
   + Loops are very slow
   + Usually worth creating extra arrays to avoid explicit loops
- Compiled languages:  
   + Loops are fast.
   + Usually choose whether to write loop explicilty based on what's more convenient for programmer.
   + Using "vectorized" notation can add unnecessary memory allocations...
       - if you don't use broadcasting and fusing   
"""

# ╔═╡ c1509525-20e4-40dd-96fb-629fe993beda
md"""
## Vectorization
The word *vectorization* is used in two fundamentally different ways:
- Computing hardware
- Programming pattern
"""

# ╔═╡ dafec889-067a-40a5-82b4-e862806b6d40
md"""
## Hardware Vectorization

CPUs
- SIMD
- SSE, SSE2, AVX, AVX512

GPUs
- Streamming Multiprocessor (SM)
"""

# ╔═╡ 01a883d0-aa94-46cd-a3cc-7a7ea5a968ec
md"## Data structures"

# ╔═╡ a936e673-0017-459c-81c0-973f4fb450b2
md"""

**Q:**  What is a linked list? Is it similar to an array?
![Linked List](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Singly-linked-list.svg/640px-Singly-linked-list.svg.png)

Use **array** when:
- Know size at time of creation (or won't need to change size often)
- Value fast access to elements (not just the beginning/end)
- Value not allocating more memory than memory
- Very common for scientific performance sensitive code

Use **linked list** when:
- Likely to insert elements and/or change size often
- Don't mind taking longer to access elements (other than beginning/end)
- Value not allocating (much) more memory than necessary
- Useful for frequent sorting 

Other common data structures to consider...
"""


# ╔═╡ 7e328504-0035-4472-a12a-890fac80d718
md"""
### **Hash table** (aka dictionary/`Dict`) when:
- Elements unlikely to be accessed in any particular order
- Value pretty fast access to individual elements
- Don't mind allocating significantly more memory than necessary
- Useful for scripting, non-performance sensitive code

![Hash table](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Hash_table_3_1_1_0_1_0_0_SP.svg/1024px-Hash_table_3_1_1_0_1_0_0_SP.svg.png) - source [Wikimedia](https://commons.wikimedia.org/wiki/File:Hash_table_3_1_1_0_1_0_0_SP.svg), Jorge Stolfi, [CC-BY-SA-3.0](https://creativecommons.org/licenses/by-sa/3.0/deed.en)
"""


# ╔═╡ 6747fbad-7448-45c5-a21a-fd89a58a1300
md"""
## Some form of **tree** when:
- Elements have a meaningful order
- Value fast adding/removing and searching of elements
- Value not allocating (much) more memory than necessary
- Don't mind taking longer to access individual elements
- Willing to spend some time maintaing well-ordered tree
- Common in database type applications

#### Generic tree (not particularly useful) 
![Unbalanced tree](https://upload.wikimedia.org/wikipedia/commons/a/a9/Unbalanced_binary_tree.svg) - source [Wikimedia](https://en.wikipedia.org/wiki/File:Unbalanced_binary_tree.svg)

#### Balanced binary tree
![Balanced tree](https://upload.wikimedia.org/wikipedia/commons/0/06/AVLtreef.svg) - source [Wikimedia](https://en.wikipedia.org/wiki/File:AVLtreef.svg)

"""


# ╔═╡ 806a8cff-af86-4708-8a5a-71bbb4f7f04d
md"""
# Parallel Programming:
## Why go parallel?
### Moore's Law
![Moore's Law: Transistors](https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Moore%27s_Law_Transistor_Count_1970-2020.png/1280px-Moore%27s_Law_Transistor_Count_1970-2020.png)
[Wikimedia](https://commons.wikimedia.org/w/index.php?curid=98219918)
By Max Roser, Hannah Ritchie -
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0)

-----

![Variations on Moore's Law:
](https://www.karlrupp.net/wp-content/uploads/2018/02/42-years-processor-trend.png) - source: [K. Rupp blog](https://www.karlrupp.net/2018/02/42-years-of-microprocessor-trend-data/#more-760) 
"""

# ╔═╡ 42b4b674-6df3-443f-9bc0-68e4a101e727
md"""
## Advantages of Shared-Memory Systems
- Ease of programming
- Good for tightly coupled problems
___
## Disadvantages of Shared-Memory Systems
- Sharing memory creates costs
- Locking
"""

# ╔═╡ 29c92f4d-a0e7-4b27-9de1-535e5ecab5d2
md"""
### Memory architectures:
- Shared memory
- Distributed memory
- Accelerator-specific memory

### Examples of Shared-Memory Systems
- Laptop (~2-6 cores)
- Workstation/Compute Node (~4-24 cores)
- Server (~8-128 cores)
- Old school supercomputers (e.g., Cray Y-MP)
___
### Examples of Distributed-Memory Systems
- Computer Cluster (e.g., Roar)
- Cloud computing
"""

# ╔═╡ 44a59fba-7530-44d3-911a-c73683a45ade
md"""
### Garbage Collection
Julia's garbage collector is "a non-compacting, generational, mark-and-sweep, tracing collector, which at a high level means the following…

**Mark-Sweep / Tracing**:
- When the garbage collector runs, it starts from a set of “roots” and walks through the object graph, “marking” objects as reachable.
- Any object that isn’t marked as reachable and will then be “swept away” — i.e. its memory is reclaimed—since you know it’s not reachable from the roots and is therefore garbage.

**Generational**:
- It’s common that more recently allocated objects become garbage more quickly—this is known as the “generational hypothesis”.
- Generational collectors have different levels of collection: young collections which run more frequently and full collections which run less frequently.
- If the generational hypothesis is true, this saves time since it’s a waste of time to keep checking if older objects are garbage when they’re probably not." 

**Non-compacting / Non-moving**:
- Other garbage collection techniques can copy or move objects during the collection process.  
- Julia does not use any of these—collection does not move or copy anything, it just reclaims unreachable objects.

If you’re having issues with garbage collection, your primary recourse is to generate less garbage:

- Write non-allocating code wherever possible: simple scalar code can generally avoid allocations.

- Use immutable objects (i.e., `struct` rather than `mutable struct`), which can be stack allocated more easily and stored inline in other structures (as compared to mutable objects which generally need to be heap-allocated and stored indirectly by pointer, all of which causes more memory pressure).

- Use pre-allocated data structures and modify them instead of allocating and returning new objects, especially in loops.

- Can call `GC.gc()` to manually call garbage collector.  But this is mainly useful for benchmarking.

(nearly quote from [Julia Discourse post by Stefan Karpinski](https://discourse.julialang.org/t/details-about-julias-garbage-collector-reference-counting/18021))
"""



# ╔═╡ f4b3eceb-b365-4abb-925d-4e14a88c7b28
md"""
# Setup & Helper Code
"""

# ╔═╡ 2e6842b2-f8ac-44a2-a355-1904553cb754
ChooseDisplayMode()

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
project_hash = "69f995e0dc6a1c35a46792be048dc8abd510ce38"

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
# ╟─fd64866f-1c3b-43ef-93ff-eace062dae2d
# ╟─3dfec25d-4600-4425-90a6-c652dd2b5ebc
# ╟─8aef55bf-3bd3-49a6-8c0c-3e9384eebd4b
# ╟─5dc6dc68-9e3e-45f1-abba-48381adf6a3a
# ╟─ac7bb983-4ac5-4196-ab7c-bc180f35f0d4
# ╟─806a8cff-af86-4708-8a5a-71bbb4f7f04d
# ╟─dc964423-dd50-48c4-9899-36c596b83658
# ╟─ff821bb7-e4c1-42fc-b8a1-3170b1a3204f
# ╟─63e7b99c-c203-4acf-a775-5d0bc8b69ffd
# ╟─5315a4ec-d56e-4339-8b48-2e4e651dca5f
# ╟─c1509525-20e4-40dd-96fb-629fe993beda
# ╟─dafec889-067a-40a5-82b4-e862806b6d40
# ╟─01a883d0-aa94-46cd-a3cc-7a7ea5a968ec
# ╟─a936e673-0017-459c-81c0-973f4fb450b2
# ╟─7e328504-0035-4472-a12a-890fac80d718
# ╟─6747fbad-7448-45c5-a21a-fd89a58a1300
# ╟─42b4b674-6df3-443f-9bc0-68e4a101e727
# ╟─29c92f4d-a0e7-4b27-9de1-535e5ecab5d2
# ╟─44a59fba-7530-44d3-911a-c73683a45ade
# ╟─f4b3eceb-b365-4abb-925d-4e14a88c7b28
# ╟─2e6842b2-f8ac-44a2-a355-1904553cb754
# ╠═c771a5b6-50df-11ed-31c6-dbf7aa47c90a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
