# Running Pluto notebooks on your local computer

Some students may wish to install Julia and Pluto on their local computer.
While this is not supported, it's likely that the following steps will work for most students: 
1.  Download and install current version of Julia from [julialang.org](https://julialang.org/downloads/).
2.  Run julia
3.  From the Julia REPL (command line), type
```julia
julia> using Pkg
julia> Pkg.add("Pluto")
```
Steps 1 & 3 only need to be done once per computer.
4.  Start Pluto
```julia
julia> using Pluto
julia> Pluto.run()
```
5.  Open a Pluto notebook by typing the path or URL into the box labeled "Open from File".

6.  For cloning, commiting and pushing change to GitHub, students can use the command line version of git (or an alternative git client).  

Warning:  Installing julia using conda (rather than downloading the binaries directly as described above) has been known to cause problems for other students.

