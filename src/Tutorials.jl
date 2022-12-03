module Tutorials

using PlutoStaticHTML

const PKGDIR = pkgdir(Tutorials)

export build_tutorials

const TUTORIALS_DIR = joinpath(PKGDIR, "notebooks")

"Get files from a previous run. Assumes that the files are inside a `gh-pages` branch."
function prev_dir()::Union{Nothing,AbstractString}
    if "DISABLE_CACHE" in keys(ENV) && ENV["DISABLE_CACHE"] == "true"
        @info "Cache disabled"
        return nothing
    end
    if !("REPO" in keys(ENV))
        @info "ENV[REPO] not avaliable"
        return nothing
    end
    repo = ENV["REPO"]
    url = "https://github.com/$repo"
    dir = mktempdir()
    @info "Cloning $(url)#gh-pages for caching purposes"
    try
        # This can fail if there is no gh-pages branch yet.
        run(`git clone --depth=1 --branch=gh-pages $url $dir`)
        #prev_dir = joinpath(dir, "tutorials")
        prev_dir = joinpath(dir, "notebooks")
        return prev_dir
    catch
        @info "Error cloning gh-pages branch"
        return nothing
    end
end

"Build all the notebooks in parallel."
function build()
    dir = TUTORIALS_DIR
    output_format = franklin_output
    previous_dir = prev_dir()
    bopts = BuildOptions(dir; output_format, previous_dir)
    hopts = OutputOptions(; append_build_context=true)
    #build_notebooks(bopts, hopts)
    build_notebooks_wo_prebuilt(bopts, hopts)
    return nothing
end

"Add a link to the notebook at the bottom of each tutorial."
function append_notebook_links()
    dir = TUTORIALS_DIR
    md_paths = filter(endswith(".md"), readdir(dir; join=true))
    for md_path in md_paths
        md_file = basename(md_path)
        without_extension, _ = splitext(md_file)
        jl_file = "$(without_extension).jl"
        #url = "/tutorials/$jl_file"
        url = "/notebooks/$jl_file"
        open(md_path, "a") do io
            text = """\n
                _To run this tutorial locally, download [this file]($url) and open it with
                [Pluto.jl](https://plutojl.org)._
                """
            write(io, text)
        end
    end
    return nothing
end

"Copy the source Markdown files, so that they can be inspected for debugging and used with caching."
function copy_markdown_files()
    from_dir = TUTORIALS_DIR
    md_files = filter(endswith(".md"), readdir(from_dir))
    #to_dir = joinpath(PKGDIR, "__site", "tutorials")
    to_dir = joinpath(PKGDIR, "__site", "notebooks")
    mkpath(to_dir)
    for md_file in md_files
        from = joinpath(from_dir, md_file)
        to = joinpath(to_dir, md_file)
        cp(from, to; force=true)
    end
    return nothing
end

"Copy the html files"
function copy_html_files()
    from_dir = TUTORIALS_DIR
    md_files = filter(endswith(".html"), readdir(from_dir))
    #to_dir = joinpath(PKGDIR, "__site", "tutorials")
    to_dir = joinpath(PKGDIR, "__site", "notebooks")
    mkpath(to_dir)
    for md_file in md_files
        from = joinpath(from_dir, md_file)
        to = joinpath(to_dir, md_file)
        cp(from, to; force=true)
    end
    return nothing
end

"Build the tutorials."
function build_tutorials()
    build()
    # Copy the Markdown first or the appended notebook links will add up.
    copy_markdown_files()
    append_notebook_links()
    #copy_html_files()
end
precompile(build_tutorials, ())



function build_notebooks_wo_prebuilt(
        bopts::BuildOptions,
        oopts::PlutoStaticHTML.OutputOptions=PlutoStaticHTML.OutputOptions()
    )::Dict{String,Vector{String}}
    dir = bopts.dir
    files = filter(readdir(dir)) do file
        path = joinpath(dir, file)
        endswith(file, ".jl") &&
        PlutoStaticHTML._is_pluto_file(path) && !startswith(file, PlutoStaticHTML.TMP_COPY_PREFIX) &&
        !( (filesize(path * ".html")>0) ||
           (filesize(path[1:end-3] * ".html")>0) ||
           (filesize(path * ".md")>0) || 
           (filesize(path[1:end-3] * ".md")>0) )
    end
    return build_notebooks(bopts, files, oopts)
end
end # module
