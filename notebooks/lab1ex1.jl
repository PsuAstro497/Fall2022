### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ ab976d70-f59d-4dcd-ac89-771606a74108
begin
	using PlutoUI
	using PlutoTest 
	using PlutoTeachingTools
	using HypertextLiteral
end

# ╔═╡ 5b826e17-ad51-43d0-9756-89a9fd0ea834
md"""
**Astro 497 Week 1, Exercise 1**

# Getting Started with Julia & Pluto
"""

# ╔═╡ acb10cb1-d03d-47c5-90dc-7216e5110ed2
md"""
## Access the lab
Before we delve into the meat of the course, we'll practice accessing the assignment via your private git repository ("repo"), cloning the repo, starting Julia, and launching the Pluto notebook server, and opening one of the Pluto lab notebooks.  Step-by-step instructions are avaliable in the [tips section](https://psuastro497.github.io/Fall2022/tips/) of the course website.

Once you open the Pluto notebook, it will begin executing the entire notebook.  Depending on your system and how complex the notebook is, sometimes this can take significant time.  You'll read through this notebook, make some small changes, see how that affects the results, save your changes to disk, commit your changes to your local git repository, and then push those to your repository on github.
For many of you, this is likely your first time using all of these tools, and it probably sounds like a lot.  The good news is that you can refer back to the tip and before long all of this will become second nature and you'll wonder how you got along without such tools. 
"""

# ╔═╡ c15ce452-494f-407c-9c08-02d547929e6a
md"""
## Assigning Variables
In Julia, you assign variables values using the `=` sign.
Assigning integer or floating point numbers uses a natural notation.
Once a cell is executed, Pluto shows the output of each cell above the cell with the relevant code.
For example,"""

# ╔═╡ 25d5497c-3a67-4495-9f37-0bc8f2a64e68
current_year = 2022

# ╔═╡ 774b2e4a-6cd7-4c9a-920d-b4f38354d42d
md"""Simple `String`'s are created by enclosing text between double quotes.  
For example,"""

# ╔═╡ 5917df75-0dab-4778-917e-91bbfddbe03a
begin
	course_number = "Astro 497"
	semester = "Fall 2022"
	instructor = "Eric Ford"
end

# ╔═╡ 0d15ba33-f2c4-46d6-9b08-9181d40596cd
md"""Notice that, when working in a Pluto notebook, cells that assign multiple variables need to be wraped in a `begin...end` block. Note that only the output from the last line is displayed.  The other variables were still assigned and can be accessed in other cells."""

# ╔═╡ dc0bf251-b3a6-42f7-84f6-796ac3761b2d
course_number

# ╔═╡ dbfceab2-994d-45a1-97ff-d978827bd129
Foldable("More about strings",tip(md"""Single quotes are used to indicate a single character (as opposed to a string of length 1).  
[Triple quoted string literals](https://docs.julialang.org/en/v1/manual/strings/#Triple-Quoted-String-Literals) are useful for quotes spanning multiple lines (and when you want to include `"` symbols). 
"""))

# ╔═╡ 03e89b06-d69c-4b74-a9a0-4b3afc462411
Foldable("Details about `begin...end` blocks",tip(md"Enclosing code in `begin...end` block is not necessary in general (e.g., julia scripts, Jupyter notebooks, or module code.)  It's necessary inside Pluto, because Pluto is a *reactive* notebook, meaning that it automatically updates later cells that depend on a variable.  No need to worry about this for now."))

# ╔═╡ e2bb48e5-a2b2-42d7-a8e5-5c7532d62e93
md"Assigning integer or floating point numbers uses a natural notation."

# ╔═╡ cda49166-b9fb-4e68-8b3e-b97845c7bf3b
instructor_year = current_year - 1999

# ╔═╡ 0c5d5b14-6c9a-4ac9-8126-0d6e1edba593
favorite_number = 3.1415926535897

# ╔═╡ a3450384-ccfc-4bda-af52-24ed8f429cf8
md"""Now, it's your turn to create variables named `student_name`, `student dept` and `student_year` with values based on yourself.  You can modify the code in the cells below."""

# ╔═╡ 33350a21-7971-406e-b316-6539eca72bf4
begin  # INSERT YOUR RESPONSES BELOW, REPLACING MISSINGs
	student_name = missing
	student_dept = missing
	student_year = missing
end;

# ╔═╡ f15643a4-39d5-4492-98d3-9db4f4cb0d3b
md"""
Run the cell with your code and make sure there are no error messages.  
Sometimes, I may provide a few quick checks in the Pluto notebook itself.  For example,
"""

# ╔═╡ 1bc2edaf-a0a7-4c4e-96c2-25872dd30e2e
if !@isdefined(student_year)
	not_defined(:student_year)
else
	let
		if ismissing(student_name)
			still_missing()
		elseif isnothing(student_name)
			keep_working("Could there be a typeo?")
		elseif !(student_name isa String) 
			keep_working(md"The value should be a String.")
		else
			correct(md"You set `student_name` to $student_name.")
		end
	end
end

# ╔═╡ c05d62b5-6063-41ca-9823-2499b2d4fbc4
if !@isdefined(student_dept)
	not_defined(:student_dept)
else
	let
		if ismissing(student_dept)
			still_missing()
		elseif isnothing(student_dept)
			keep_working("Could there be a typeo?")
		elseif !(student_dept isa String) 
			keep_working(md"The value of `student_year` should be a String.")
		elseif occursin("Astro", student_dept)
			correct(md"Welcome back.")
		else
			correct(md"We're glad to have you join us.")
		end
	end
end

# ╔═╡ 8b666639-e3d0-4535-803d-40ddc4360a9c
if !@isdefined(student_year)
	not_defined(:student_year)
else
	let
		if ismissing(student_year)
			still_missing()
		elseif isnothing(student_year)
			keep_working("Could there be a typeo?")
		elseif !(student_year isa Integer) 
			keep_working(md"The value should be an integer.")
		elseif ! (1<= student_year)
			keep_working(md"I'm expecting `student_year` to be one or larger.")
		elseif ! (student_year <= 8)
			keep_working(md"Are you sure?  Most students finish in less than 8 years.")
		else
			correct(md"I think that $student_year seems like a reasonable value for `student_year`.")
		end
	end
end

# ╔═╡ 99aea265-e252-400c-af3f-a462e5cbd665
md"""
## Pass a Test
Once we start doing real calculations, it will be important to test our work.  Therefore, you and I will both write tests that your code should pass. 
"""

# ╔═╡ 087b40c4-7d59-4f9a-b584-65c2aa9f9578
md"
The first few tests below should pass.  Later, I've written a couple of tests with bugs in them for you to fix.  Look at the results of the cells below, find the tests that doesn't pass, and modify the code so that it passes.  
"

# ╔═╡ eefa92a1-1d4c-4536-abd3-1c1af98e146f
md"One of the first things to check is that variables have been defined.  If not, then later tests will fail and we might spend time trying to dive deeper into the problem than we need to."

# ╔═╡ 78f81544-fead-4649-b306-48fb1463d397
if !( @isdefined(student_name) && @isdefined(student_dept) &&  @isdefined(student_year) )
	keep_working(md"One of the expected variable names is not defined.")
end

# ╔═╡ ac9e6787-5c42-44d6-907e-e7033e7ab4bc
Foldable("Protip: Packages", tip(md"Before using a test, we need to tell Julia to import a module that will provide the `@test` macro.  To simplify the notebook, I've put that code at the bottom of the notebook, so it doesn't distract from our main task."))

# ╔═╡ b49789b2-49c0-49e3-b81f-db04e60f9d23
md"Next, we'll test that the types of the variables are what we expect.  If not, then it's unlikely that the values stored will be what we expect."

# ╔═╡ 34f767c9-f95f-4968-9423-ad87bb456775
@test typeof(student_name) == String

# ╔═╡ d6417bdc-9e36-4d2b-8b3e-f5ddafd82437
@test typeof(student_dept) == String

# ╔═╡ 89ac58ea-b782-4dcc-802f-d6d063e7b855
@test typeof(student_year) <: Number

# ╔═╡ 2479fb6a-2e51-4e6f-8155-d47e9e3ae27d
@test typeof(student_year) <: Integer

# ╔═╡ 6d8e0985-3613-49bc-8050-91e2ee73de52
md"We often see the `==` operator when testing for equality of two numbers.  Here the `==` operator is testing for the equivalence of two types.
Alternatively, we can use the `<:` operator to ask if one type is a 'sub-type' of another 'abstract type'."

# ╔═╡ 7f031249-4413-4cd6-8ba5-b3369a1216a0
md"Now, we're ready to test that the values of the variables are consistent with what we expect."  

# ╔═╡ 8ff88c72-7982-4025-9057-384a48186dc9
@test !ismissing(student_name) && length(student_name) > 3

# ╔═╡ c408ddb6-af5d-4b6a-ae81-9d338fd15f06
@test !ismissing(student_name) && occursin(' ',student_name)

# ╔═╡ d732ab18-65b3-417a-8f8d-5f4502baa777
@test !ismissing(student_dept) && length(student_dept) >= 3

# ╔═╡ bc491991-1c10-43bb-8afe-3ed08c91d3d7
@test !ismissing(student_year) && 1 >= student_year >= 10

# ╔═╡ a328c8c6-6268-4b1f-ae1c-84ee295285c8
@test student_name == instructor

# ╔═╡ 852d7d9d-fc12-42f2-863f-af0b647979df
md"**TODO:** There are (at least) two bugs in the above tests.  Find them and fix them."

# ╔═╡ 2604bbf4-56ee-4d25-81ca-d45e2425cd77
md"""
## Writing code in functions
One of the basic tenets of good software design is organizing your code into small units.  The most common form of this is *functional programming* where you organizer your code into functions.  Below I'll demonstrate a few differnt syntaxes for  writing functions.  
"""

# ╔═╡ de4fc0d5-5d27-4dc4-a2f8-9ec330530952
double(x) = 2x

# ╔═╡ f99a044e-d7f8-4db7-8405-9afe362d381d
function triple(x)
	y = 3*x
	return y
end

# ╔═╡ d3c4dea4-0989-4185-9693-cc53fe062e47
"Takes one finite real argument and returns four times that value."
function quadruple(x::Real)
	@assert !isinf(x) && !isnan(x)   # check that input is finite
	y = 4 * x
	return y
end

# ╔═╡ 105bdaa7-d5d9-4d70-8409-cbd830d9ce1a
md"""
The first example (double) shows a very compact syntax, useful for very simple functions.
The second example (triple) is more useful for writing more complex functions that involve several steps.

The third example (quadruple) demonstrates several additions that make for better code:
- A *docstring* at the beginning explains to users understand what the function does.  The docstring for a function can be accessed from the "Live docs" box at the bottom right of Pluto by placing your cursor on the function name in question.
- '::Real' specifies that the function will only accept input variables that have a type that is a real number (technically that means any type is a sub-type of Real)
- `@assert` is used to make sure that the input arguemnets meet the expectations for your function to work properly.
"""

# ╔═╡ 180e05ce-9085-47c1-b3cd-a86f4c7a77e9
md"""
Now it's your turn.  Write a function `square` that takes one real arguement and returns its value squared.
"""

# ╔═╡ 022804a1-988a-4d1a-b292-d388afe3cfe9
# TODO:  Insert your code for the square function in this cell

# ╔═╡ 7dc7cc54-8b55-42cb-a614-d9f70da9c988
md"## Test your funcion"

# ╔═╡ b62bcdc5-8f23-4376-93ef-1dcf011332d9
md"""
Now, let's look at some tests for the `square` function.  First, we test that `square` is defined, that it is a function and that `square` returns correct values using a few test cases.  These won't catch every possible mistake, but are likely to catch the most common bugs.
"""

# ╔═╡ 30ae128a-0fc2-4060-ab76-bdb516b477b3
@test @isdefined(square)

# ╔═╡ d18526d5-2a97-4e54-8cf1-72a5bfd69510
@test typeof(square) <: Function

# ╔═╡ 31857e95-0e92-484a-aa1e-c52adb53a5c7
@test square(1) == 1

# ╔═╡ e58c26c7-3d7a-4d71-9066-c66cc256e926
@test square(-2) == 4

# ╔═╡ 25f1c477-f471-419f-a320-655d877469a9
@test square(π) ≈ π^2

# ╔═╡ 82c060af-06d1-49df-8b52-7fbdb263be1b
@test isinf(square(-Inf))

# ╔═╡ 223eeb3f-b370-4d2e-abb0-0d88ccea11c1
@test_throws MethodError square("hello")

# ╔═╡ 6584e095-465d-4b3d-a383-9ac569e307cc
md"Check that your function passes the tests above.  If not, then try to fix it."

# ╔═╡ 68341392-aa5a-41b7-a76a-76db1c6357f5
md"""Once you're happy with the results, it's time to save your notebook.  Look for the button in the upper right or `Ctrl`+'S'.  If it's not there, then your notebook has been autosaved.  

Then read the [instructions for submitting assignments](http://localhost:8000/tips/labs/submitting/) for how to commit your changes to your local git repository and push them to github. 
    
When you're done you can look into the `goals.md` file in your repository to begin the final exercise for Lab 1."""

# ╔═╡ 51a1bf7c-6a1d-4d31-a735-de3414a97ab6
md"""## Helper code"""

# ╔═╡ 4d860e75-0631-4ef6-853c-818bafe080f4
md"""Students can ignore the code below that was quietly used above.  However, once you start your project, it may be useful to refer back to some of the helper code from the labs."""

# ╔═╡ b9f89dc4-a8e8-4afe-9da6-9880cfcf2a37
md"""
The above cell both loads the code from packages and brings the functions (and macros) that it "exports" "into scope", meaing that we can "just call them" without having to include the package name as a prefix. 
"""

# ╔═╡ 45efd82d-63e1-4016-838e-d0fbb21db99f
md"The PlutoUI package provides several cool features, but for now we just use it to add the Table of Contents in the upper right corent."

# ╔═╡ 60348e2d-9943-486c-9061-3c5c3bf88883
md"The PlutoTest package provides an alternative `@test` macro for use in Pluto notebooks."

# ╔═╡ ceff74da-4cd2-4091-af1a-8ecde8e13700
md"The PlutoTeachingTools package has several small functions that we use for things like tips."

# ╔═╡ 98ecc733-15f3-4263-821a-483dadfc8ab8
Foldable("Pro Tip:  Test vs PlutoTest",tip(md"Normally, we'd use the `Test` module for the `@test` macro.  Julia has a large set of modules and packages, that range from very basic functionality to complex science codes.  The quality also varries widely.  Several modules (like `Test`) are included in Julia standard library, so they're already installed for us.  
	
However, inside Pluto, it can be helpful to instead import `PlutoTest`, since it displays the results particularly nicely.  (It's an external package and it's still experimental, so if things break in the future, then we can revert to just using `Test`."))

# ╔═╡ 73a3ce7e-9967-4d11-8ab7-0e0409190975
TableOfContents()

# ╔═╡ 148adb47-cf5c-41ff-81e6-4a4f054a33b5
"""
Displays text on right hand side of Pluto notebook.
Optional v_offset allows shifting up or down.
"""
function aside(x; v_offset=0)
    @htl("""
     <style>
     @media (min-width: calc(700px + 30px + 300px)) {
     	aside.plutoui-aside-wrapper {
     		position: absolute;
     		right: -11px;
     		width: 0px;
     	}
     	aside.plutoui-aside-wrapper > div {
     		width: 300px;
     	}
     }
     </style>
     <aside class="plutoui-aside-wrapper" style="top: $(v_offset)px">
     	<div>
     	$(x)
     	</div>
     </aside>
     """)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoTest = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.4"
PlutoTeachingTools = "~0.1.0"
PlutoTest = "~0.1.0"
PlutoUI = "~0.7.9"
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

[[deps.PlutoTest]]
deps = ["HypertextLiteral", "InteractiveUtils", "Markdown", "Test"]
git-tree-sha1 = "b7da10d62c1ffebd37d4af8d93ee0003e9248452"
uuid = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
version = "0.1.2"

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
# ╟─5b826e17-ad51-43d0-9756-89a9fd0ea834
# ╟─acb10cb1-d03d-47c5-90dc-7216e5110ed2
# ╟─c15ce452-494f-407c-9c08-02d547929e6a
# ╠═25d5497c-3a67-4495-9f37-0bc8f2a64e68
# ╟─774b2e4a-6cd7-4c9a-920d-b4f38354d42d
# ╠═5917df75-0dab-4778-917e-91bbfddbe03a
# ╟─0d15ba33-f2c4-46d6-9b08-9181d40596cd
# ╠═dc0bf251-b3a6-42f7-84f6-796ac3761b2d
# ╟─dbfceab2-994d-45a1-97ff-d978827bd129
# ╟─03e89b06-d69c-4b74-a9a0-4b3afc462411
# ╟─e2bb48e5-a2b2-42d7-a8e5-5c7532d62e93
# ╠═cda49166-b9fb-4e68-8b3e-b97845c7bf3b
# ╠═0c5d5b14-6c9a-4ac9-8126-0d6e1edba593
# ╟─a3450384-ccfc-4bda-af52-24ed8f429cf8
# ╠═33350a21-7971-406e-b316-6539eca72bf4
# ╟─f15643a4-39d5-4492-98d3-9db4f4cb0d3b
# ╟─1bc2edaf-a0a7-4c4e-96c2-25872dd30e2e
# ╟─c05d62b5-6063-41ca-9823-2499b2d4fbc4
# ╟─8b666639-e3d0-4535-803d-40ddc4360a9c
# ╟─99aea265-e252-400c-af3f-a462e5cbd665
# ╟─087b40c4-7d59-4f9a-b584-65c2aa9f9578
# ╟─eefa92a1-1d4c-4536-abd3-1c1af98e146f
# ╠═78f81544-fead-4649-b306-48fb1463d397
# ╟─ac9e6787-5c42-44d6-907e-e7033e7ab4bc
# ╟─b49789b2-49c0-49e3-b81f-db04e60f9d23
# ╠═34f767c9-f95f-4968-9423-ad87bb456775
# ╠═d6417bdc-9e36-4d2b-8b3e-f5ddafd82437
# ╠═89ac58ea-b782-4dcc-802f-d6d063e7b855
# ╠═2479fb6a-2e51-4e6f-8155-d47e9e3ae27d
# ╟─6d8e0985-3613-49bc-8050-91e2ee73de52
# ╟─7f031249-4413-4cd6-8ba5-b3369a1216a0
# ╠═8ff88c72-7982-4025-9057-384a48186dc9
# ╠═c408ddb6-af5d-4b6a-ae81-9d338fd15f06
# ╠═d732ab18-65b3-417a-8f8d-5f4502baa777
# ╠═bc491991-1c10-43bb-8afe-3ed08c91d3d7
# ╠═a328c8c6-6268-4b1f-ae1c-84ee295285c8
# ╟─852d7d9d-fc12-42f2-863f-af0b647979df
# ╟─2604bbf4-56ee-4d25-81ca-d45e2425cd77
# ╠═de4fc0d5-5d27-4dc4-a2f8-9ec330530952
# ╠═f99a044e-d7f8-4db7-8405-9afe362d381d
# ╠═d3c4dea4-0989-4185-9693-cc53fe062e47
# ╟─105bdaa7-d5d9-4d70-8409-cbd830d9ce1a
# ╟─180e05ce-9085-47c1-b3cd-a86f4c7a77e9
# ╠═022804a1-988a-4d1a-b292-d388afe3cfe9
# ╟─7dc7cc54-8b55-42cb-a614-d9f70da9c988
# ╠═b62bcdc5-8f23-4376-93ef-1dcf011332d9
# ╠═30ae128a-0fc2-4060-ab76-bdb516b477b3
# ╠═d18526d5-2a97-4e54-8cf1-72a5bfd69510
# ╠═31857e95-0e92-484a-aa1e-c52adb53a5c7
# ╠═e58c26c7-3d7a-4d71-9066-c66cc256e926
# ╠═25f1c477-f471-419f-a320-655d877469a9
# ╠═82c060af-06d1-49df-8b52-7fbdb263be1b
# ╠═223eeb3f-b370-4d2e-abb0-0d88ccea11c1
# ╟─6584e095-465d-4b3d-a383-9ac569e307cc
# ╟─68341392-aa5a-41b7-a76a-76db1c6357f5
# ╟─51a1bf7c-6a1d-4d31-a735-de3414a97ab6
# ╟─4d860e75-0631-4ef6-853c-818bafe080f4
# ╠═ab976d70-f59d-4dcd-ac89-771606a74108
# ╟─b9f89dc4-a8e8-4afe-9da6-9880cfcf2a37
# ╟─45efd82d-63e1-4016-838e-d0fbb21db99f
# ╟─60348e2d-9943-486c-9061-3c5c3bf88883
# ╟─ceff74da-4cd2-4091-af1a-8ecde8e13700
# ╟─98ecc733-15f3-4263-821a-483dadfc8ab8
# ╠═73a3ce7e-9967-4d11-8ab7-0e0409190975
# ╟─148adb47-cf5c-41ff-81e6-4a4f054a33b5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
