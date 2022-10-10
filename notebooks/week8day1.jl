### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ bd1bf442-3fba-441d-b22e-8768d67d8652
begin
	using CSV, DataFrames, Query
	using HTTP
	using PlutoUI, PlutoTeachingTools
end

# ╔═╡ 3a2210fa-478f-11ed-059b-6f5c943fb80d
md"""
## Queries & Data Wrangling
**Astro 497, Week 8, Monday**
"""

# ╔═╡ a629d501-0dbc-4be8-b1fb-984af4fe2fd8
TableOfContents()

# ╔═╡ c801d8b3-d439-4d55-be1b-111207dd1bf5
md"""
# Databases
"""

# ╔═╡ 16243631-00ec-4ffd-8eb5-1281a4d00f02
md"""
### Simplest form
- Store data 
- Retrieve data
- Commonly implemented as a set of **tables**
  - **Columns** contain different fields (e.g., ID, magnitude, RA, Dec)
  - **Rows** contain entries (e.g., 51 Pegasi, Kepler-10, HAT-P-13,... )

### Value-added features
- Return subset of data *efficiently*
- Many strategies for how to filter data (e.g., order of operations)
- Database server can use heuristics to pick good strategy
- Allow for transactions to update database
"""

# ╔═╡ 1be82094-5d9a-47a5-96ac-50c5a3179e3a
md"""
### Fundamental properties of databases
- Atomicity:  All part of a transaction succeed, or the database is rolled back to its previous state
- Consistency:  Data in database always satisfies its validation rules
- Isolation: Even if multiple transactions are made concurrently, there is no interference between transactions
- Durability:  Once a transaction is committed, it will remain committed
"""

# ╔═╡ 1b60fbf6-1baf-46ac-92c4-2d9485f92220
md"""
### SQL-based Database Servers
Open-source:
- MySQL
- PostgreSQL & Greenplum
Commercial:
- Microsoft SQL Server: 
- IBM DB2
- Oracle Database
- ...
"""

# ╔═╡ 280f7444-4b3c-46e4-b1f6-a8eced3a24a2
md"""
#### Continuing innovation in database systems
- SciDB (array & disk based database)
- MonetDB (column store)
- JuliaDB (pure Julia, for persistent data)

When selecting a database for a project, consider:
- How much data is to be stored?
- How frequent/large will transactions be?
- Are there specific hardware or OS requirements?
- Does the team have someone dedicated to supporting database?
"""

# ╔═╡ f783601e-f0a0-4c6a-b478-060b288a279e
md"""
### Database Clients
- One database server many clients simultaneously
- Different clients can use different interfaces
  - Command line
  - Webpage
  - URL-based
  - Custom Graphical user interface (GUI)
"""

# ╔═╡ ad409d2a-1d8f-4f9f-b649-6b5c76321f7e
md"""
# Queries
"""

# ╔═╡ 9ac78e9d-c97e-451c-af50-2a7251f0714b
md"""
**Query**:  An expression that requests database to return a specific subset of data.  

#### Query languages:
- Structured Query Language (SQL):  Dated, but by far the most common
- Astronomical Data Query Language (ADQL):  Astronomy-specific
- Language Integrated Query (LINQ):  Microsoft-supported
- Many more
"""

# ╔═╡ 804babe2-6398-401d-b443-eeff52721208
md"""
## SQL essentials
- Selecting (columns)
- Filtering (for rows)
- Joining (multiple tables)
- Aggregating (rows within a table)

### SQL programming
- Variables
- Functions
- Procedures
- Data management
- Transactions
"""

# ╔═╡ a30a9fb2-0ac8-488a-ac63-0f9085b32fa2
md"""
## Example SQL Queries

#### Do not send
```sql
select * from SomeTable
```

Why?
"""

# ╔═╡ 650e5cbe-7bc2-4c13-881a-e4469cf0152a
md"""
#### Take a quick peak two columns data for first few entries
```sql
select top 10 X, Y from SomeTable 
```

"""

# ╔═╡ b61ec045-9c2f-4496-bde4-f2bade567867
md"""
#### Find extreme values of X
```sql
select top 10 X, Y 
from SomeTable 
order by X
```

"""

# ╔═╡ 5e7371b9-7923-4ec3-b9c0-505391f5aebd
md"""
#### Filter which rows are returned using expression 
```sql
select top 10 x,y
from SomeTable 
where x*x+y*y between 0 and 1
order by x 
```
"""

# ╔═╡ 1f5a730e-6831-4973-9e6d-b5adc3db9778
md"""
#### Check how many rows are in a table
```sql
select COUNT(designation) as N from gaiadr2.gaia_source
```

#### Check how many rows satisfy a filter
```sql
select COUNT(designation) as n, AVG(astrometric_n_good_obs_al) as astrometric_n_good_obs_al_ave
from gaiadr2.gaia_source
where phot_g_mean_mag < 14
```
"""

# ╔═╡ 8d04311d-42dc-499b-af80-7a2e6bdc332e
md"""
#### Grouping data
```sql
select COUNT(designation) as N from gaiadr2.gaia_source,
       AVG(astrometric_n_good_obs_al) as astrometric_n_good_obs_al_ave,
       AVE(phot_g_mean_mag) as phot_g_mean_mag_ave
where phot_g_mean_mag < 14
group by round(phot_g_mean_mag,1)
order by mean(phot_g_mean_mag)
```
"""

# ╔═╡ 29a7a0ca-fbe8-42e9-aabf-4e30a0a4eae7
md"""
#### [Gaia Archive](https://gea.esac.esa.int/archive/)
"""

# ╔═╡ e1669276-2b84-4bd4-94bc-d58feda22caf
md"""
## Virtual Observatory (VO)
Defines standards that help astronomers to collaborate effectively, emphasizing working with multiple data sources.  

- Astronomical Data Query Language (ADQL) 
- Table Access Protocol (TAP)
"""

# ╔═╡ d09c5da7-7b12-478b-ae23-bf130a645f93
md"""
## Astronomy-specific functions in ADQL
- AREA
- BOX
- CENTROID
- CIRCLE
- CONTAINS
- COORD1
- COORD2
- COORDSYS
- DISTANCE
- INTERSECTS
- POINT
- POLYGON
- REGION
"""

# ╔═╡ f561d36e-ec3c-42b8-b7f8-0202f4a4363b
md"""
### Table Access Protocol (TAP)
"""

# ╔═╡ 5396181f-b169-4011-b590-7bcc546bbbdc
md"""
Start with ADQL 
```sql
SELECT <column list> FROM <table> WHERE <constraints>
```
but transform it into a url, by
1.  Prepend a base service url
2.  convert spaces to `+`'s
3.  Deal with other special characters (e.g., +, quotes)
4.  Optionally, specify format for results
e.g., 
```url
https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+pl_name,pl_masse,ra,dec+from+ps
```
"""

# ╔═╡ cb1b5efb-3ce2-4eb7-99a2-eec4cbd02eea
md"""
# Joins
"""

# ╔═╡ 5afb074f-8416-4441-be7e-96f73d448940
md"""
Joining tables is a fundamental concept that can be applied either to DataFrames stored locally or as part of SQL/ADQL queries.
"""

# ╔═╡ 04f2fa13-057e-4b26-a2db-2a02055dc61d
md"""
- `innerjoin` & `semijoin`:  Return rows for values of the key that exist **in both tables**
- `outerjoin`: Return rows for values of the key that exist **in either table**
- `leftjoin`: Return rows for values of the key that exist **in first table**
- `rightjoin`: Return rows for values of the key that exist **in second table**


- `antijoin`: Return rows Return rows for values of the key that exist **in first table but not the second table**


- `crossjoin`: Return table with every row from first table as rows and every row from second table as columns
"""

# ╔═╡ 49bf3268-bb0f-484c-972a-14f94d7c4151
md"""
### Examples
"""

# ╔═╡ 70fe782a-bcd8-4239-b922-f6949435d865
tip(md"Originally, both tables contained columns named `ra` and `dec`.  The joined table contains columns `ra` and `ra_1` (and `dec` and `dec_1`) because we set `makeunique`.")

# ╔═╡ 6d00e16e-0556-440f-bb7b-29a347e65272
md"""
#### What if we didn't know the Gaia designation?
"""

# ╔═╡ ccfcbbe1-a358-41e8-a562-f5db25e2a9fc
md"""
#### Wait, which row is the best match?
"""

# ╔═╡ 540c6982-2759-4b63-b5a4-e360bddfa4e1
md"""
## Questions?
"""

# ╔═╡ 499a15c9-41bb-46ea-beff-4ae9584ed780
md"""
# Setup & Helper Code
"""

# ╔═╡ a62e5bb9-9027-4da8-8ce4-65a5419f79e3
ChooseDisplayMode()

# ╔═╡ 0d1dafe5-d584-4952-981e-f418d5043cef
begin
	nexsci_query_base_url = "https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query="
	gaia_query_base_url = 
	"https://gea.esac.esa.int/tap-server/tap/sync?REQUEST=doQuery&LANG=ADQL&FORMAT=csv&QUERY="
end

# ╔═╡ 45813921-68c4-4a61-84f2-d7f06a1e9e1b
begin
	make_tap_query_url_url = "#" * (PlutoRunner.currently_running_cell_id |> string)
"""
`make_tap_query_url(base_url, table_name; ...)`

Returns url for a Table Access Protocol (TAP) query.
Inputs:
- base url 
- table name
Optional arguments (and default):
- `max_rows` (all)
- `select_cols` (all)
- `where` (no requirements)
- `order_by_cols` (not sorted)
- `format` (tsv)
See [NExScI](https://exoplanetarchive.ipac.caltech.edu/docs/TAP/usingTAP.html#sync) or [Virtual Observatory](https://www.ivoa.net/documents/TAP/) for more info.
"""
function make_tap_query_url(query_base_url::String, query_table::String; max_rows::Integer = 0, select_cols::String = "", where::String = "", order_by_cols::String = "", format::String="tsv" )
	
	query_select = "select"
	if max_rows > 0 
		query_select *= "+top+" * string(max_rows)
	end
	if length(select_cols) >0
		query_select *= "+" * select_cols 
	else
		query_select *= "+*"
	end
	query_from = "+from+" * query_table
	query_where = length(where)>0 ? "+where+" * where : ""
	query_order_by = length(order_by_cols) > 0 ? "+order+by+" * order_by_cols : ""
	query_format = "&format=" * format
	url = query_base_url * query_select * query_from * query_where * query_order_by * query_format
end
end

# ╔═╡ 241a7b00-a53e-4c93-8b1e-a9b76e3223e3
url_ex1 = make_tap_query_url(nexsci_query_base_url, "ps", select_cols="pl_name,gaia_id,sy_kepmag,ra,dec", where="default_flag=1")

# ╔═╡ 41f86e08-7292-468f-9d6f-266b169c7d8b
"""
`query_to_df(url)` downloads data from a URL and attempts to place it into a DataFrame
"""
query_to_df(url) = CSV.read(HTTP.get(url).body,DataFrame)

# ╔═╡ 59c3abea-3aee-452d-902a-9a22b6393bd6
df_ex1 = query_to_df(url_ex1)

# ╔═╡ 91aab994-2b5f-4de2-b78e-828868c3ead5
targetpos = (; ra = df_ex1.ra[1], dec = df_ex1.dec[1] )

# ╔═╡ 29ab2b94-1aba-4831-ba1f-044c7f2843d1
url_ex4 = make_tap_query_url(gaia_query_base_url, "gaiadr3.gaia_source", where="1=contains(POINT($(targetpos.ra),$(targetpos.dec)),CIRCLE(ra,dec,30./3600.))", select_cols="*,DISTANCE(POINT($(targetpos.ra),$(targetpos.dec)),POINT(ra,dec))+AS+ang_sep",order_by_cols="ang_sep",max_rows=1000)

# ╔═╡ 41dfc658-2e54-4408-8e52-4879e209b022
df_ex1.sy_kepmag[8]

# ╔═╡ 6cde0247-5471-45e5-b291-73b8b96179ab
df_ex4 = query_to_df(url_ex4)

# ╔═╡ e667dfb6-40b6-4739-ae63-a8be386e1f21
sort(df_ex4[!,[:designation,:ang_sep,:phot_g_mean_mag] ], :ang_sep)

# ╔═╡ 5c48bd08-18e4-4e08-97e1-b69413ae7e3a
"""`replace_spaces_for_tap(str)`

Replace spaces with +'s as expected for TAP queries.
"""
replace_spaces_for_tap(s::AbstractString) = replace(s," "=>"+")

# ╔═╡ cc583927-f657-4617-a057-97a15f8ccb3a
desig = replace_spaces_for_tap(df_ex1.gaia_id[8])

# ╔═╡ 8708d13b-25ac-4829-b9cb-bdbc02a29005
url_ex2 = make_tap_query_url(gaia_query_base_url, "gaiadr2.gaia_source", where="designation='$(desig)'",select_cols="*",max_rows=5)

# ╔═╡ 3c057644-11a0-404d-acc8-6f897f52fb1a
df_ex2 = query_to_df(url_ex2)

# ╔═╡ 8fb6efb1-6493-449a-b5cb-49763b7d361c
df_ex3 = innerjoin(df_ex1,df_ex2, on=:gaia_id=>:designation, matchmissing=:notequal, makeunique=true )

# ╔═╡ 1775c8de-0dc3-44c9-b36d-40b5eb2922e1
names(df_ex3)

# ╔═╡ c784f6bd-0843-4682-bcaa-f26a8fd5f7b5
begin
	""" 
	`select_cols_for_tap(cols)`

	Returns a string of comma-separated columns names from a vector of columns names (as either strings or symbols), for using in a TAP query.
	"""
	function select_cols_for_tap end
	select_cols_for_tap(cols_to_keep::AbstractVector{Symbol}) = select_cols_for_tap(string.(cols_to_keep)) #string(map(s->string(s) * "+", cols_to_keep)...)[1:end-1]
	select_cols_for_tap(cols_to_keep::AbstractVector{AS}) where {AS<:AbstractString} = string(map(s->s * ",", cols_to_keep)...)[1:end-1]
	select_cols_for_tap(col_to_keep::Symbol) = string(col_to_keep)
	select_cols_for_tap(col_to_keep::AbstractString) = col_to_keep
end


# ╔═╡ a9b23444-160e-48ca-8099-b136b6bc43a8


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Query = "1a8c2f83-1ff3-5112-b086-8aa67b057ba1"

[compat]
CSV = "~0.10.4"
DataFrames = "~1.4.1"
HTTP = "~1.4.0"
PlutoTeachingTools = "~0.2.3"
PlutoUI = "~0.7.43"
Query = "~1.0.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "925e60680a34a704783566f3069dfad9ce1a43cc"

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

[[deps.BitFlags]]
git-tree-sha1 = "84259bb6172806304b9101094a7cc4bc6f56dbc6"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.5"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "873fb188a4b9d76549b81465b1f75c82aaf59238"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.4"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "1833bda4a027f4b2a1c984baddcf755d77266818"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.1.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "3ca828fe1b75fa84b021a7860bd039eaea84d2f2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.3.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "46d2680e618f8abd007bce0c3026cb0c4a8f2032"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.12.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "558078b0b78278683a7445c626ee78c86b9bb000"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.4.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.DataValues]]
deps = ["DataValueInterfaces", "Dates"]
git-tree-sha1 = "d88a19299eba280a6d062e135a43f00323ae70bf"
uuid = "e7dc6d0d-1eca-5fa6-8ad6-5aecde8b7ea5"
version = "0.4.13"

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

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "e27c4ebe80e8699540f2d6c805cc12203b614f12"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.20"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "4abede886fcba15cd5fd041fef776b230d004cee"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.4.0"

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

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "d0ca109edbae6b4cc00e751a29dcb15a124053d6"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.2.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IterableTables]]
deps = ["DataValues", "IteratorInterfaceExtensions", "Requires", "TableTraits", "TableTraitsUtils"]
git-tree-sha1 = "70300b876b2cebde43ebc0df42bc8c94a144e1b4"
uuid = "1c8ee90f-4401-5389-894e-7a04a3dc0f4d"
version = "1.0.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "5d4d2d9904227b8bd66386c1138cf4d5ffa826bf"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "0.4.9"

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

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "6872f9594ff273da6d13c7c1a1545d5a8c7d0c1c"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.6"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

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

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "ebe81469e9d7b471d7ddb611d9e147ea16de0add"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.2.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e60321e3f2616584ff98f0a4f18d98ae6f89bbb3"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.17+0"

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

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "460d9e154365e058c4d886f6f7d6df5ffa1ea80e"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.1.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Query]]
deps = ["DataValues", "IterableTables", "MacroTools", "QueryOperators", "Statistics"]
git-tree-sha1 = "a66aa7ca6f5c29f0e303ccef5c8bd55067df9bbe"
uuid = "1a8c2f83-1ff3-5112-b086-8aa67b057ba1"
version = "1.0.0"

[[deps.QueryOperators]]
deps = ["DataStructures", "DataValues", "IteratorInterfaceExtensions", "TableShowUtils"]
git-tree-sha1 = "911c64c204e7ecabfd1872eb93c49b4e7c701f02"
uuid = "2aef5ad7-51ca-5a8f-8e88-e75cf067b44b"
version = "0.9.3"

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

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "c0f56940fc967f3d5efed58ba829747af5f8b586"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.15"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableShowUtils]]
deps = ["DataValues", "Dates", "JSON", "Markdown", "Test"]
git-tree-sha1 = "14c54e1e96431fb87f0d2f5983f090f1b9d06457"
uuid = "5e66a065-1f0a-5976-b372-e0b8c017ca10"
version = "0.2.5"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.TableTraitsUtils]]
deps = ["DataValues", "IteratorInterfaceExtensions", "Missings", "TableTraits"]
git-tree-sha1 = "78fecfe140d7abb480b53a44f3f85b6aa373c293"
uuid = "382cd787-c1b6-5bf2-a167-d5b971a19bda"
version = "1.0.2"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "2d7164f7b8a066bcfa6224e67736ce0eb54aef5b"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.9.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "8a75929dcd3c38611db2f8d08546decb514fcadf"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.9"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

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
# ╟─3a2210fa-478f-11ed-059b-6f5c943fb80d
# ╟─a629d501-0dbc-4be8-b1fb-984af4fe2fd8
# ╟─c801d8b3-d439-4d55-be1b-111207dd1bf5
# ╟─16243631-00ec-4ffd-8eb5-1281a4d00f02
# ╟─1be82094-5d9a-47a5-96ac-50c5a3179e3a
# ╟─1b60fbf6-1baf-46ac-92c4-2d9485f92220
# ╟─280f7444-4b3c-46e4-b1f6-a8eced3a24a2
# ╟─f783601e-f0a0-4c6a-b478-060b288a279e
# ╟─ad409d2a-1d8f-4f9f-b649-6b5c76321f7e
# ╟─9ac78e9d-c97e-451c-af50-2a7251f0714b
# ╟─804babe2-6398-401d-b443-eeff52721208
# ╟─a30a9fb2-0ac8-488a-ac63-0f9085b32fa2
# ╠═650e5cbe-7bc2-4c13-881a-e4469cf0152a
# ╟─b61ec045-9c2f-4496-bde4-f2bade567867
# ╟─5e7371b9-7923-4ec3-b9c0-505391f5aebd
# ╟─1f5a730e-6831-4973-9e6d-b5adc3db9778
# ╟─8d04311d-42dc-499b-af80-7a2e6bdc332e
# ╟─29a7a0ca-fbe8-42e9-aabf-4e30a0a4eae7
# ╟─e1669276-2b84-4bd4-94bc-d58feda22caf
# ╟─d09c5da7-7b12-478b-ae23-bf130a645f93
# ╠═f561d36e-ec3c-42b8-b7f8-0202f4a4363b
# ╟─5396181f-b169-4011-b590-7bcc546bbbdc
# ╠═241a7b00-a53e-4c93-8b1e-a9b76e3223e3
# ╠═59c3abea-3aee-452d-902a-9a22b6393bd6
# ╠═cc583927-f657-4617-a057-97a15f8ccb3a
# ╠═8708d13b-25ac-4829-b9cb-bdbc02a29005
# ╠═3c057644-11a0-404d-acc8-6f897f52fb1a
# ╟─cb1b5efb-3ce2-4eb7-99a2-eec4cbd02eea
# ╟─5afb074f-8416-4441-be7e-96f73d448940
# ╟─04f2fa13-057e-4b26-a2db-2a02055dc61d
# ╟─49bf3268-bb0f-484c-972a-14f94d7c4151
# ╠═8fb6efb1-6493-449a-b5cb-49763b7d361c
# ╠═1775c8de-0dc3-44c9-b36d-40b5eb2922e1
# ╟─70fe782a-bcd8-4239-b922-f6949435d865
# ╟─6d00e16e-0556-440f-bb7b-29a347e65272
# ╠═91aab994-2b5f-4de2-b78e-828868c3ead5
# ╠═29ab2b94-1aba-4831-ba1f-044c7f2843d1
# ╠═6cde0247-5471-45e5-b291-73b8b96179ab
# ╟─ccfcbbe1-a358-41e8-a562-f5db25e2a9fc
# ╠═e667dfb6-40b6-4739-ae63-a8be386e1f21
# ╠═41dfc658-2e54-4408-8e52-4879e209b022
# ╟─540c6982-2759-4b63-b5a4-e360bddfa4e1
# ╟─499a15c9-41bb-46ea-beff-4ae9584ed780
# ╠═a62e5bb9-9027-4da8-8ce4-65a5419f79e3
# ╠═bd1bf442-3fba-441d-b22e-8768d67d8652
# ╠═0d1dafe5-d584-4952-981e-f418d5043cef
# ╟─45813921-68c4-4a61-84f2-d7f06a1e9e1b
# ╟─41f86e08-7292-468f-9d6f-266b169c7d8b
# ╟─5c48bd08-18e4-4e08-97e1-b69413ae7e3a
# ╟─c784f6bd-0843-4682-bcaa-f26a8fd5f7b5
# ╠═a9b23444-160e-48ca-8099-b136b6bc43a8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
