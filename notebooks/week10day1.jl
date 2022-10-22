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

# ╔═╡ afd8e60d-b96b-4c06-8246-d1592dff222d
md"""
# Memory latency hierarchy
- Registers:
- Caches:
- RAM
- Local disk storage
- Non-local disks
- Tape storage (e.g., Roar Near-line storage)
"""

# ╔═╡ 97976480-c802-490e-856f-17dc21dee021
md"""
## Registers:
  - All calculations are based on data in registers
  - Only a few dozen registers per CPU core
  - Many of those are special purpose (e.g., performing multiple arithmetic operations at once)
"""

# ╔═╡ 4a452891-744e-403c-ace5-d9d3c72616f2
md"""
## Caches:
  - L1 Cache:  
    - Very low latency
    - Typically 16 -- 64KB data cache per core
    - Separate instruction cache
  - L2 Cache:
    - Typically a few times slower than L1 cache
    - Typically 256KB - few MB L2 cache per core (or pair of cores)
  - L3 Cache:
    - Typically ~10 times slower than L2 cache
    - Typically ~few to tens or even hundreds of MB 
    - Often shared among all CPU cores
    - N-way associative cache → How many different places a variable could be in the cache
"""

# ╔═╡ 850f5dea-987b-4ae3-97a2-0602abb68917
md"""
## RAM
  - GB to TB 
  - Symmetric Multiprocessing (SMP): all cores have equal access to all RAM
  - Non-Uniform Memory Access (NUMA): 
    - RAM divided
    - Some is assigned to be "local" to each core (or pair of cores)
    - Rest of RAM is accessible via an interconnect 
"""

# ╔═╡ 003b71bd-38d6-4024-a7a7-bac6bf9bc691
md"""
## Disk storage
- Local disk storage
  - NVME
  - SSD 
  - Dard drives
- Disk storage within local network
- Disk storage over internet
  - Internet2
  - Commodity internet
"""

# ╔═╡ 1ef4627d-a5d6-46cb-afde-20bf20c0f929
md"""
## Tape storage
  - Very high latency
  - Can still have high throughput
  - Efficient in terms cost, energy & reliability
  - On Roar, known as "near-line archival storage"
"""

# ╔═╡ 5dc6dc68-9e3e-45f1-abba-48381adf6a3a
md"
[Interactive Memory Latency vs Year](https://colin-scott.github.io/personal_website/research/interactive_latency.html)"


# ╔═╡ dc964423-dd50-48c4-9899-36c596b83658
md"""
# Where do your variables go?
- Programmer explicitly chooses when to write to disk or access network. 
  -  (Some cloud programming frameworks abstract these away)
- The vast majority of scientific software development uses high-level languages.  
- High-level languages let compilers and CPUs manage caches
- Programmer choices can make it easy/hard/impossible for them to use caches effectively.
- Programmer choices also dictate whether variables are stored in:
  - Stack (scalars, small structures or collections with known size)
  - Heap (large collections, structures/collections with unknown size)
"""

# ╔═╡ ff821bb7-e4c1-42fc-b8a1-3170b1a3204f
md"""
## Stack 
![Program call stack](https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/ProgramCallStack2_en.png/862px-ProgramCallStack2_en.png) (from [Wikimedia](https://commons.wikimedia.org/wiki/File:ProgramCallStack2_en.png))

- Stack memory is released on a last-in-first-out basis.
- Stack (de)allocation is much faster than allocation/deallocation from heap.
- Stack has fixed size (e.g., 8MB is default on linux, can change with `ulimit -s`)
- Active frame of stack is likely to stay in cache
- Stack is good for variables:
   - Whose size is known at compile time, 
   - Aren't too large 
   - Won't be needed after a function finishes
- Use heap for 
   - Large collections (e.g., arrays, matrices) that are stored contiguously in memory.
   - Collections whose size is unknown at compile time
   - Collections vary in size (in hard to predict way)
"""

# ╔═╡ 3dfc1aa3-6670-4369-8094-00ac52a06317
md"""
# Key factors for achieving good performance

From highest to lowest priority:
1. Choose an appropriate algorithm for your problem
2. Use compiled language, rather than an interpreted language
3. Use variables with fixed and known types
4. Minimize[^1] disk/network/tape access
5. Minimize[^1] unnecessary memory allocations on heap
6. Choose data types that promote linear access, e.g.,
   - Vectors & Arrays (rather than Dictionaries)
   - Arrays of values (rather than arrays of pointers)7. Group reads/writes of nearby data 
   - For matrices, inner loop over minor dimension
     - Fortran, Matlab, R & Julia[^2] matrices are column-major
     - C/C++ & Python[^2] matrices are row-major
   - For large matrices, there are clever strategies of working on smaller blocks at a time.  Use cache-optimized libraries, e.g., 
     - BLAS, LAPACK, IntelMKL
   - For datasets with many columns, structures of arrays (rather than arrays of structures)
7. Use programming patterns that make it easy to parallelize the "embarrassingly parallel" portions of your code.
   - E.g., `map`, `mapreduce`, `split-apply-combine`
   - Once fully tested in serial, then can turn on parallelism for those sections easily.
8. Only after ensuring that you've done all of the above, should you even consider using "advanced" programming techniques that obfuscate the code, make it hard to maintain, or are likely to soon become out-of-date. 

[^1]: Use it when you need it, but don't add lots of extra small read/writes to disk or memory allocations.  

[^2]: By default.  With Julia & Numby, one can explicitly specify a variable to be stored in the opposite format.  
"""

# ╔═╡ c1509525-20e4-40dd-96fb-629fe993beda
md"""
## What is *not* on the list for achieving high performance?
"Vectorization"
The word *vectorization* is used in two fundamentally different ways:
- Computing hardware, e.g.
  - SSE, SSE2, AVX, AVX512
  - GPU Streamming Multiprocessors
- Programming patterns, e.g., 
  - z = x + y

In many places, vectorization, as in the programming pattern, can make code easier to read.  However, often it results in unnecessary memory allocations and cache misses[^3].  Therefore, be careful about using vectorized notation in performance-sensitive sections of code.

[^3]: In many cases, Julia and JAX can broadcast and fuse vectorized expressions to achieve nearly identical performance as hand-written loops.
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
   + Using "vectorized" notation can add unnecessary memory allocations and cache misses...
       - if you don't use broadcasting and fusing   
"""

# ╔═╡ 806a8cff-af86-4708-8a5a-71bbb4f7f04d
md"""
# Trends in Computing Hardware
## Moore's Law
![Moore's Law: Transistors](https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Moore%27s_Law_Transistor_Count_1970-2020.png/1280px-Moore%27s_Law_Transistor_Count_1970-2020.png)
[Wikimedia](https://commons.wikimedia.org/w/index.php?curid=98219918)
By Max Roser, Hannah Ritchie -
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0)

-----
### Why are computers becoming more parallel?
![Variations on Moore's Law:
](https://www.karlrupp.net/wp-content/uploads/2018/02/42-years-processor-trend.png) - source: [K. Rupp blog](https://www.karlrupp.net/2018/02/42-years-of-microprocessor-trend-data/#more-760) 
"""

# ╔═╡ 01a883d0-aa94-46cd-a3cc-7a7ea5a968ec
md"# Data structures"

# ╔═╡ 155c323b-8ff6-41b3-9d57-252c18f9b73c
md"""
## Array 
Good when:
- Value fast access to individual elements, even if not in linear order
  - But even faster if elements will often be accessed in linear order
- Know how many elements you'll need (or at least can make a decent guess)
- Don't want to allocate more memory that you actually need
- There's not a reason to use a more complicated data structure
"""

# ╔═╡ 7e328504-0035-4472-a12a-890fac80d718
md"""
## Hash table (aka dictionary/`Dict`)
Good when:
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


# ╔═╡ a936e673-0017-459c-81c0-973f4fb450b2
md"""

### Linked List
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


# ╔═╡ 44a59fba-7530-44d3-911a-c73683a45ade
md"""
# Garbage Collection
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
# ╟─fd64866f-1c3b-43ef-93ff-eace062dae2d
# ╟─3dfec25d-4600-4425-90a6-c652dd2b5ebc
# ╟─afd8e60d-b96b-4c06-8246-d1592dff222d
# ╟─97976480-c802-490e-856f-17dc21dee021
# ╟─4a452891-744e-403c-ace5-d9d3c72616f2
# ╟─850f5dea-987b-4ae3-97a2-0602abb68917
# ╟─003b71bd-38d6-4024-a7a7-bac6bf9bc691
# ╟─1ef4627d-a5d6-46cb-afde-20bf20c0f929
# ╟─5dc6dc68-9e3e-45f1-abba-48381adf6a3a
# ╟─dc964423-dd50-48c4-9899-36c596b83658
# ╟─ff821bb7-e4c1-42fc-b8a1-3170b1a3204f
# ╟─3dfc1aa3-6670-4369-8094-00ac52a06317
# ╟─c1509525-20e4-40dd-96fb-629fe993beda
# ╟─5315a4ec-d56e-4339-8b48-2e4e651dca5f
# ╟─806a8cff-af86-4708-8a5a-71bbb4f7f04d
# ╟─01a883d0-aa94-46cd-a3cc-7a7ea5a968ec
# ╟─155c323b-8ff6-41b3-9d57-252c18f9b73c
# ╟─7e328504-0035-4472-a12a-890fac80d718
# ╟─6747fbad-7448-45c5-a21a-fd89a58a1300
# ╟─a936e673-0017-459c-81c0-973f4fb450b2
# ╟─44a59fba-7530-44d3-911a-c73683a45ade
# ╟─f4b3eceb-b365-4abb-925d-4e14a88c7b28
# ╟─2e6842b2-f8ac-44a2-a355-1904553cb754
# ╠═c771a5b6-50df-11ed-31c6-dbf7aa47c90a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
