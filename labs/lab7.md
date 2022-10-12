+++
title = "Queries & Data Wrangling"
lab_num = 7
tags = ["labs"]
+++

## Lab {{lab_num}}: {{title}}
([github](https://github.com/PsuAstro497/lab7-start))

Start {{lab7_start}} ---
Due {{lab7_due}}

## Goals
In this lab, students will learn to:
- Write queries using ADQL and TAP
- Access tables with results of queries
- Manipulate DataFrames including select, filter, join, groupby & transform
- Crossmatch objects between two catalogs
- Download datafiles from a major astronomical archives using astroquery (in ex2.jl)
- Access data from FITS files (in ex2.jl)
- Apply Box Least Squares (BLS) periodogram to search for planets (in optional ex3.jl)

Students will strengthen their understanding of:
- Population of Rossiter-McLaughlin observations
- Data products avaliable from space-based photometric missions (in either ex2.jl or ex3.jl)
- Pre-processing of photometric light curves (in ex3.jl)
- Combining multiple programmling languages (in either ex2.jl or ex3.jl)

All students should work through ex1.jl.  
Students may choose to complete either exercise 2 or exercise 3,

### Logistics
Follow [this link](https://classroom.github.com/a/zjN5xMsq) to create your own private copy of this lab's repository on GitHub.com.
depending on what would be most useful for their class project.
Before starting ex2.jl or ex3.jl, see instructions in Canvas announcement for updating your Julia depot, so the calls to astropy, astroquery and lightkurve will work.   


See the help on the course website for instructions on getting setup to use ACI, cloning, committing, pushing and submitting your work.

### Resources
- [Julia Data Science online textbook](https://juliadatascience.io/dataframes)
- [ESA archive web interface](https://gea.esac.esa.int/archive/)
- [ESA archive documentation](https://www.cosmos.esa.int/web/gaia-users/archive/programmatic-access#CommandLine_Tap) and [example queries](https://www.cosmos.esa.int/web/gaia-users/archive/writing-queries)
- [NExScI intro to using TAP](https://exoplanetarchive.ipac.caltech.edu/docs/TAP/usingTAP.html#sync)
- [Virtual Observatory specifications for TAP](https://www.ivoa.net/documents/TAP/) for more info.
- Exopalnet Archive Planetary Systems Table's [column descriptions](https://exoplanetarchive.ipac.caltech.edu/docs/API_PS_columns.html).  
- [Mikulski Archive for Space Telescopes (MAST)](https://archive.stsci.edu/)  
- [FITS primer](https://fits.gsfc.nasa.gov/fits_primer.html)

Other Packages Used:
- [DataFrames.jl](https://dataframes.juliadata.org/stable/man/working_with_dataframes/)
- [Query.jl](https://github.com/queryverse/Query.jl).
- [FITSIO.jl](https://github.com/JuliaAstro/FITSIO.jl)
- [BoxLeastSquares.jl](https://github.com/JuliaAstro/BoxLeastSquares.jl)
- [PyCall.jl](https://github.com/JuliaPy/PyCall.jl)
- [Astropy](https://docs.astropy.org/en/stable/)
- [Astroquery](https://astroquery.readthedocs.io/en/latest/api/astroquery.mast.ObservationsClass.html#astroquery.mast.ObservationsClass.query_criteria)
- [Lightkurve](https://docs.lightkurve.org/)
