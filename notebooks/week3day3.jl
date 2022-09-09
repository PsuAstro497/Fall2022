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

# ╔═╡ 3d94c83d-0238-4ba5-820f-022bd6aac230
begin
	using PlutoUI, PlutoTeachingTools, HypertextLiteral
	using Plots, LaTeXStrings
	using Plots.PlotMeasures
end

# ╔═╡ 1aa502dc-7525-4432-aeac-ef98474f6568
md"""
**Astro 497: Week 3, Friday**
# Exoplanet Detection:  $br Transit Timing Variations (TTVs)
"""

# ╔═╡ 087cd2b5-2821-466d-b869-504ad97931a0
TableOfContents()

# ╔═╡ 478ae32d-7b46-43a8-b3ad-12b280a96612
md"""
## Logistics
"""

# ╔═╡ 8e63323f-bf73-4674-84b0-96e6e8b92484
md"""
## Overview of Today
- Transit Timing Variations Method
- TTV Observables
- Examples
- TTV Regimes
- TTV Modeling
- Relevant Datasets
- Exomoons
- Strengths & Weaknesses
- Reading Questions
"""

# ╔═╡ 28d92f9a-ec46-4fa9-b6a8-fb234610b974
md"""
# Transit Timing Variations Method
"""

# ╔═╡ 10606b2e-f494-4368-b85b-fd02132b45b2
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/9/96/201008-2a_PlanetOrbits_16x9-_Transit_timing_of_1-planet_vs_2-planet_systems.ogv"))
Credit:  NASA Ames/Kepler mission
"""

# ╔═╡ 8c293f5f-910a-4c1d-8b7c-7c76348e8505
md"""
**Q:** Is it possible to use *deviations from a Keplerian orbit* to detect hidden exoplanets? If so, is there any exoplanet detected in this way?
"""

# ╔═╡ 89aa00c2-6d6b-4516-8041-af35050d3c8e
#=
$(RobustLocalResource("https://cfn-live-content-bucket-iop-org.s3.amazonaws.com/journals/1538-3881/153/5/224/revision1/ajaa6897f1_hr.jpg","../_assets/week3/ajaa6897f1_hr.jpg",:width=>"80%"))
Credit: 

$(RobustLocalResource("https://cfn-live-content-bucket-iop-org.s3.amazonaws.com/journals/0004-637X/743/2/200/revision1/apj408732f14_hr.jpg","../_assets/week3/apj408732f14_hr.jpg",:width=>"80%"))
Credit: 

$(RobustLocalResource("https://cfn-live-content-bucket-iop-org.s3.amazonaws.com/journals/1538-3881/153/5/224/revision1/ajaa6897t5_lr.gif","../_assets/week3/ajaa6897t5_lr.gif",:width=>"80%"))

=#
md"""
**A:** Yes, e.g., Kepler-19c 
See Fig. 1 of [Malavolta et al. (2017)](https://doi.org/10.3847/1538-3881/aa6897)

See Fig 14. of [Balllard et al. (2011)](https://doi.org/10.3847/1538-3881/aa6897)

See Table 6 of [Malavolta et al. (2017)](https://doi.org/10.3847/1538-3881/aa6897)
"""

# ╔═╡ 1a1d349c-ba18-4d17-9123-28652469824d
md"""
# Probability of Multiple Transiting Planets
### Recall figure for probability of one planet transiting
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week2/probcalc.png","../_assets/week2/probcalc.png"))
Credit:  [Joshua Winn (2010)](https://arxiv.org/abs/1001.2010)
"""

# ╔═╡ 3ab2e03b-724b-452f-b4b7-3cb855dae849
md"""

$p_{\rm tra} = \left(\frac{R_\star \pm R_p}{a}\right)
                   \left(\frac{1 + e\sin\omega}{1 - e^2} \right)$

"""
#="""For a small planet on acircular orbit:

$p_{\rm tra} = \frac{R_\star}{a}~\approx 0.005~\left( \frac{R_\star}{R_{\odot}} \right)
                        \left( \frac{a}{{\rm AU}} \right)^{-1}$

"""
=#

# ╔═╡ 107c2f8d-24fb-49c0-bed3-5fcd7c0e86bd
md"""
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week3/transplanetsphere.svg","../_assets/week3/transplanetsphere.svg"))
Credit: [Ragozzine & Holman (2010)](https://arxiv.org/abs/1006.3727) $br
Paper [(Brakensiek & Ragozzine 2016)](https://iopscience.iop.org/article/10.3847/0004-637X/821/1/47) & [code](https://github.com/eford/CORBITS.jl)  for calculating intersection area efficiently
"""

# ╔═╡ 54caf8ec-22e7-46eb-960d-e318e846bcb9
md"""
# Transit Observables
- Orbital period: $P$
- Epoch of $n$th transit: $t_n$
- Deviations from mean values
  - Transit Timing Variations (TTVs): $\delta t_i$
  - Transit Duration Variations (TDVs): $\delta T_i$
  - Transit Depth Variations (TdVs): $\delta d_i$
"""

# ╔═╡ b769c22b-fa22-471d-9742-0c2d2ee77a48
md"# Example TTV observations of system with multiple transiting planets"

# ╔═╡ 5d2b1262-4287-4d32-80ee-cc65939ea4dd
md"""
## Kepler-9 TTVs
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week3/FigTTV.pn","../_assets/week3/FigTTV.png", :width=>"80%"))
Credit: [Dreizler & Ofir (2014)](https://arxiv.org/abs/1403.1372)
"""

# ╔═╡ b5d79d39-6752-4a70-8bcc-9391350b8161
md"""
#### Kepler-9 TTV Residuals
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week3/FigTTVres.png","../_assets/week3/FigTTVres.png", :width=>"80%"))
Credit: [Dreizler & Ofir (2014)](https://arxiv.org/abs/1403.1372)

"""

# ╔═╡ 0c7dfa89-c640-4223-ae4b-f64b18191462
md"""
#### Posterior distributions for masses of Kepler-9 b & c
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week3/FigMassP2.png","../_assets/week3/FigMassP1.png", :width=>"49%"))
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week3/FigMassP2.png","../_assets/week3/FigMassP2.png", :width=>"49%"))
Credit: [Dreizler & Ofir (2014)](https://arxiv.org/abs/1403.1372)
"""

# ╔═╡ 3014430c-610f-4468-8e2f-5dc7ce9af16b
md"""
## Kepler TTV Gallery
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week3/apjsaa25b0f6_lr.jpg","../_assets/week3/apjsaa25b0f6_lr.jpg", :width=>"80%"))
Credit: Fig 5 from [Holczer et al. (2016)](https://iopscience.iop.org/article/10.3847/0067-0049/225/1/9)
"""

# ╔═╡ 8c8110c5-2565-4c61-95d9-8c2cf2a60784
md"# TTV model for pair of planets near a Mean Motion Resonance (MMR)"

# ╔═╡ 0e9a5324-e7a7-463d-aea7-6223867d6ea4
md"""
| Variable    | Inner      | Outer       |
| ----------- | ---------- | ----------- |
| P (d)   | $(@bind Pin NumberField(1:0.01:100,default=10))  | $(@bind Pout NumberField(1:0.01:100,default=20.1))       |
| m (M_⊕) | $(@bind min NumberField(1:0.1:1000,default=1))   | $(@bind mout NumberField(1:0.1:1000,default=2))  |
| e       | $(@bind ein NumberField(0:0.01:1,default=0.01)) | $(@bind eout NumberField(0:0.01:1,default=0.01)) |
| ω       | $(@bind ωin NumberField(0:0.01:2π,default=0))    | $(@bind ωout NumberField(0:0.01:2π,default=0)) |
| t0  (d) | $(@bind t0in NumberField(0:0.001:100,default=0)) | $(@bind t0out NumberField(0:0.001:100,default=0)) |
"""

# ╔═╡ b32c1bdb-c404-4125-914a-8b6638d1c0bc
md"""
Timespan to plot: $(@bind timespan NumberField(0:10_000,default=365*3.5)) days
"""

# ╔═╡ 781e2bd4-e979-49c5-a38f-4000cae53521


# ╔═╡ f8f1b2e2-e72d-4c6e-9d51-b7ebf812897c
md"""
# TTV Surveys
- Ground-based
- Kepler/K2
- TESS
- Plato
"""

# ╔═╡ c8432773-77dd-4a78-ba90-50042f70ccad
md"""
### Kepler/K2
![Kepler/K2 spacecraft](https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/images/314379main_keplerstacking-lrg_full.jpg)
Credit: [NASA](https://www.nasa.gov/mission_pages/kepler/multimedia/images/09-02-16.html)
"""

# ╔═╡ fd9c5332-f1e8-43e1-a77a-4e77bb58f105
md"""
### TESS
![TESS Spacecraft](https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/tess_with_techs_4000.jpg)
Credit: [NASA](https://www.nasa.gov/image-feature/this-is-tess-our-newest-planet-hunter)
"""

# ╔═╡ b65d5bd5-34e5-48bc-b333-2a8107f8d2ac
md"""
### Plato
![Artist impression of PLATO Spacecraft](https://cdn.sci.esa.int/documents/33240/35301/PLATO_artist_impression_20191105_2_625.jpg)
Copyright: [Copyright: ESA/ATG medialab](https://sci.esa.int/web/services/terms-and-conditions)
"""

# ╔═╡ 631bb7a1-b09e-4594-a0b2-aa14e99a833f
md"""
# Transit Duration Variations (TDVs) & $br Transit Depth Variations (TdVs)

!!! question
    **What are the mechanisms for TTVs, TDVs & TdVs?**

"""

# ╔═╡ 277b635d-a42d-4008-8cc0-577db676f6e0
md"""
$(RobustLocalResource("https://psuastro497.github.io/Fall2022/assets/week2/transit_diagram.png","../_assets/week2/transit_diagram.png"))
Credit:  [Joshua Winn (2010)](https://arxiv.org/abs/1001.2010)
"""

# ╔═╡ b9089f24-6836-49b4-a9b5-48bbf138afd5
if false
md"""
### One transit
- Transit Depth: $\delta$ (dimensionless)
- Impact Parameter: $b$ (units of stellar radii)
- Ingress Duration: $\tau$
- Transit Durations:
   - Total duration: $t_{IV}-t_{I}$
   - Full-transit duration: $t_{III}-t_{II}$
   - Mathematically-convenient duration: $T$
   - Best-measured duration: $(t_1+t_2-t_3-t_4)/2$
"""
end

# ╔═╡ 886279f9-e77f-4ffc-aadf-35d6fd5e64c2
md"""
#### Impact parameter
$b = \frac{a \cos i}{R_\star} \left(\frac{1-e^2}{1 + e\sin\omega}\right)$

"""

# ╔═╡ 0a1c2f71-de04-4e42-b140-cafaf663ac31
md"""
#### Transit depth 
$\delta \approx \left(\frac{R_p}{R_\star}\right)^2~\left[1 - \frac{I_p(t_{\rm tra})}{I_\star}\right]$
"""

# ╔═╡ a72ea48b-c4c7-4b13-8751-e5494da2b9e8
md"""
### Motion in the Orbital plane:
$r = \frac{a(1-e^2)}{1+e\cos f}$
- Star-planet sepration: $r$
- Semimajor axis: $a$
- Eccentricity: $e$
- True anomaly: $f$
"""

# ╔═╡ 03b9598f-3de1-4519-ac6a-184305ff4168
md"""
### Orbit projected onto the sky
```math
\begin{eqnarray}
X & = & -r \cos(\omega+f), \\
Y & = & -r \sin(\omega+f)\cos i,\\
Z & = & r \sin(\omega+f)\sin i
\end{eqnarray}
```

- Inclination: $i$
- Arguement of pericenter: $\omega$
- Longitude of ascending node: $\Omega$ (arbitrarily set to $180\degree$)
"""

# ╔═╡ 46e7c55b-8239-4399-a7c9-240d9f3e5709
md"""
**Q:** Is it  easy to distinguish between the effects of different non-Keplerian factors?  
"""

# ╔═╡ 107288da-6aa8-4ca1-9095-661c93ecb2de
md"## Exomoons?"

# ╔═╡ 40297599-858a-4f43-9eca-05757f3acca9
md"""
**Q:** Is it easy to disnguish between the effects unknown bodies like small moons or planets, or even asteroid belts?
"""

# ╔═╡ a5c32806-1e5b-11ed-0f01-7f4009ba4972
md"""
**Q:** How reliable are TTV's in determining exomoon candidates? I know these are often used to try to identify exomoon's, but how do we even begin to try to predict exomoon transits?
"""

# ╔═╡ 28b274a4-f666-4b44-91dd-bf2188ad073b
md"""
$(Resource("https://www.aanda.org/articles/aa/olm/2018/09/aa33085-18/aa33085-18-1-olm.webm", :width=>"95%"))
Credit: [Rodenbeck et al. (2018)](https://doi.org/10.1051/0004-6361/201833085)
"""

# ╔═╡ 2e888e9e-093d-473a-b45d-1ae3c9275591
# $(Resource("https://www.aanda.org/articles/aa/full_html/2018/09/aa33085-18/aa33085-18-fig1.jpg", :width=>"80%"))
#Credit: 
md"""
See Fig 1. of [Rodenbeck et al. (2018)](https://doi.org/10.1051/0004-6361/201833085)
"""

# ╔═╡ 4369b76d-0eb9-4712-aa5d-9f27d15ca1f6
#$(Resource("https://www.aanda.org/articles/aa/full_html/2018/09/aa33085-18/aa33085-18-fig2.jpg", :width=>"80%"))
#Credit:
md"""
See Fig. 2 of [Rodenbeck et al. (2018)](https://doi.org/10.1051/0004-6361/201833085)
"""

# ╔═╡ 0d7d2c3e-f3fe-4a9e-986c-463d24a30fa6
md"""
# Stregnths & Weaknesses
## Strengths
- Can detect low-mass planets
- TTVs are particulalry sensitive to closely-spaced planets and planets near mean-motion resonances.
- Can characterize masses and eccentricities of multiple-planet systems, even when host star is far away and faint
- Can measure masses and eccentricities with minimal degeneracies for closely-spaced planetary systems if each planet transits and the TTVs are large compared to measurement uncertainties.

## Weaknesses
- TTVs are not applicable for studying systems where no planet transits.
- If only one planet transits, then typically can reliably detect the presence of one or more perturbing bodies, but it is very difficult to characterize the planets in such systems via TTVs alone.
- TTVs of near-resonant systems typically constrain planet-planet mass ratio better than planet masses or planet-star mass ratios.
- There is often a degeneracy between planet masses and eccentricities, particularly for systems where TTVs are primarily due to a near mean-motion resonance. 
- One has to be cautious of other potential causes for small TTV signals (e.g., starspots, detrending algorithms, exomoons, binary stars).
"""

# ╔═╡ 8e9040ab-dfa8-4b9c-962a-4a07d2a064a4
md"""# Reading Questions"""

# ╔═╡ 0aa6e9a3-5232-4139-8ce2-8241ef886870
md"""
### Coordinate Systems for Modeling Planetary Systems
**Q:** Can you go over astrocentric and barycentric coordinate systems?

**Q:**  Does the Jacobian coordinate system fit the Keplerian model best? 

**A:** For strictly Keplerian motion, don't need a Jacobian coorinate system.

$br

**Q:**  Which coordinate system do we use when we measure the non-Keplerian situation?

#### Hierarchical Jacobi coordinates
$(RobustLocalResource("https://iopscience.iop.org/article/10.1086/340752/fulltext/fg1.h.gif?doi=10.1086/340752","../_assets/week3/hierarchical_jacobian_coordinates.gif", :width=>"70%"))
Credit: [Mardling & Lin (2001)](http://dx.doi.org/10.1086/340752) Figure 1

$br

**Q:**  What coordinate system should be used to fit different types of datasets?

**A:** It depends.   for planetary systems around a single star Hierarchical Jacobian coordinates are usually a good choice.  If that's not good enough, may need full n-body model.

Multiple star systems get complicated.  

"""

# ╔═╡ 8834e7b6-fd28-4df4-9c7b-ce8fdc86e42a
md"""**Q:** What are symplectic and nonsymplectic integration algorithms?

**A:** See [lab notebook with comparison of symplectiv & non-symplectic integrations](https://psuastro528.github.io/lab2-start/ex2.html)
"""

# ╔═╡ 83c83947-8247-4471-a03d-9690e9965cc4
md"""
**Q:** In actual practice, do the time-dependent versions of Kepler's Laws always get used instead of the non-time-dependent or does it depend on the situation?
"""

# ╔═╡ c651ae5b-cea8-4c61-a50c-819697d24a06
md"# Helper Code"

# ╔═╡ 58501926-8be8-47b5-b097-79bbb9a182bc
ChooseDisplayMode()

# ╔═╡ 45bc34df-1c7a-4575-846e-67faa5fca1b4
nbsp = htl"&nbsp;"

# ╔═╡ 47f460d2-6593-46ce-82bc-3d4e17c6c362
mearth=3e-6

# ╔═╡ d4be1de7-c5e9-4d83-9ef7-4ad96695b499
md"""## TTVFaster"""

# ╔═╡ eb4610ba-84c9-4959-97c8-186e689ea641
# WARNING:  This code is very old (written for Julia v0.3) and should not be used as an example for writing your own code
# Computes transit timing variations to linear order in eccentricity.  
# Please cite Agol & Deck (2015) if you make use of this in published research.
# https://github.com/ericagol/TTVFaster
module TTVFaster

export Planet_plane_hk, compute_ttv!

struct Planet_plane
# Parameters of a planet in a plane-parallel system
  # Mass ratio of the planet to the star:
  mass_ratio :: Float64
  # Initial time of transit:
  period   :: Float64
  trans0   :: Float64
  eccen    :: Float64
# longitude of periastron measured from line of sight, in radians:
  omega    :: Float64
end


struct Planet_plane_hk{T<:Number} # Parameters of a planet in a plane-parallel system
  # Mass ratio of the planet to the star:
  mass_ratio :: T
  # Initial time of transit:
  period   :: T
  trans0   :: T
  # e times cos or sin of longitude of periastron measured from line of sight, in radians:
  ecosw    :: T
  esinw    :: T
end

 
module LaplaceCoefficients

export laplace_coefficients_initialize
export laplace_wisdom

"""
#/* compute Laplace coefficients and Leverrier derivative/
#          j
#     j   d     i
#    a   ---   b (a)
#          j    s
#        da
#
#   by series summation */
#/* Code due to Jack Wisdom */
"""
function laplace_wisdom(s::Rational,i::Integer,j::Integer,a::Number)
# function laplace_wisdom,s,i,j,a  IDL
# double laplace(double s, int i, int j, double a);  c

##define LAPLACE_EPS 1.0e-12
LAPLACE_EPS = convert(eltype(a),1.0e-12)

#if (i lt 0) then i = -i
i=abs(i)

if j <= i     #/* compute first term in sum */
  factor4 = one(a)
  for k=0:j-1
    factor4 *= i - k
  end
  lap_coef_sum = factor4
  q0 = 0
else
  q0 = fld(j + 1 - i,2)
  lap_coef_sum = zero(a)
  factor4 = one(a)
end

#  /* compute factors for terms in lap_coef_sum */

factor1 = s
factor2 = s + i
factor3 = i + 1
for q=1:q0-1       #/* no contribution for q = 0 */
  factor1 *= s + q
  factor2 *= s + i + q
  factor3 *= i+q+1
end
if q0 > 1
  q=q0
else
  q=1
end
#println(j+1-i,q0)
term = a*a * factor1 * factor2 / (factor3 * q)

#  /* sum series */

while  (term*factor4) > LAPLACE_EPS
  factor4 = one(a)
  for k=0:j-1
    factor4 *= (2*q + i - k)
  end
  lap_coef_sum += term * factor4
  factor1 += 1
  factor2 += 1
  factor3 += 1
  q = q+1
  term *= a*a * factor1 * factor2 / (factor3 * q)
end

#  /* fix coefficient */

for k=0:i-1
  lap_coef_sum *= (s+k)/(k+1)
end

apower = (q0 <= 0) ?  i : 2*q0 + i - 2
lap_coef_sum *= 2 * a^apower
# Return the Laplace Coefficient:
return lap_coef_sum
end

"""
# This computes the Laplace coefficients via recursion.
"""
function initialize(jmax::Integer,alpha::Number)
  nmax=7
  b0=Array{eltype(alpha)}(undef,nmax,jmax+1) # Array to hold the coefficients
  # Compute the highest two Laplace coefficients using Wisdom's series approach:
  for j=0:jmax
    for i=0:nmax-1
      b0[i+1,j+1]=laplace_wisdom(1//2,j,i,alpha)/alpha^i
    end
  end
  return b0
end

end # module

laplace_coefficients_initialize(jmax::Integer,alpha::Number) = LaplaceCoefficients.initialize(jmax,alpha)

# Computes TTV coefficients for first-order eccentricity
# solution from Agol & Deck (2015).  Please cite this paper
# if you make use of this in your research.

u(gamma::T,c1::T,c2::T) where { T<:Number} = ((3+gamma*gamma)*c1+2*gamma*c2)/(gamma*gamma*(1-gamma*gamma))
# m=+/-1
v(z::T,d1::T,d2::T,m::Integer) where T<:Number = ((m*(1-z*z)+6*z)*d1+(2+z*z)*d2)/(z*(1-z*z)*(z+m)*(z+2*m))

function ttv_succinct!(jmax::Integer,alpha::Number,f1::Array{Float64,2},f2::Array{Float64,2},b::Array{Float64,2},alpha0::Number,b0::Array{Float64,2})

# See simple_solution.pdf 7/16/2015

# Fourth-order Taylor expansion approximation of Laplace coefficients:
dalpha = alpha-alpha0
for i=0:2
  for j=0:jmax
    b[j+1,i+1]=b0[i+1,j+1]+dalpha*(b0[i+2,j+1]+0.5*dalpha*(b0[i+3,j+1]+dalpha/3.0*(b0[i+4,j+1]+dalpha*0.25*b0[i+5,j+1])))
  end
end

sqrtalpha = sqrt(alpha)

# Loop over j:
@inbounds for j=0:jmax
  # \delta_{j1} (this is indirect coefficient which is only needed for j=1)
  dj1 = j==1 ? 1.0 : 0.0

  # Compute dimensionless frequencies (equation 30):
  beta = j*(1-alpha*sqrtalpha)
  kappa =  beta /  (alpha*sqrtalpha)

  # Compute disturbing function coefficients (equation 31):
  A_j00 = b[j+1,1]
  A_j10 =  alpha* b[j+1,2]
  A_j01 = -(A_j10 + A_j00)
  A_j20 =  alpha*alpha * b[j+1,3]
  A_j11 = -(2*A_j10 + A_j20)
  A_j02 = 2*A_j00 + 4*A_j10 + A_j20
  jd=convert(eltype(alpha),j)
  # Inner planet coefficients, in order k=0,-1,1,-2,2 (see Table 1):
  if j >=2
    f1[j+1,1]=alpha*u(beta          ,jd*(    A_j00-alpha*dj1),A_j10-alpha*dj1)
    f1[j+1,2]=alpha*u(beta-1.0      ,jd*(-jd*A_j00-0.5*A_j10+1.5*alpha*dj1),-jd*A_j10-0.5*A_j20+alpha*dj1)
    f1[j+1,3]=alpha*u(beta+1.0      ,jd*( jd*A_j00-0.5*A_j10-0.5*alpha*dj1), jd*A_j10-0.5*A_j20-alpha*dj1)
    f1[j+1,4]=alpha*u(beta-alpha*sqrtalpha,jd*( jd*A_j00-0.5*A_j01-2.0*alpha*dj1), jd*A_j10-0.5*A_j11-2.0*alpha*dj1)
    f1[j+1,5]=alpha*u(beta+alpha*sqrtalpha,jd*(-jd*A_j00-0.5*A_j01),-jd*A_j10-0.5*A_j11)
  else
    if j==0
      f1[j+1,4]=alpha*u(beta-alpha*sqrtalpha,jd*( jd*A_j00-0.5*A_j01-2.0*alpha*dj1), jd*A_j10-0.5*A_j11-2.0*alpha*dj1)
    else
      f1[j+1,1]=alpha*u(beta          ,jd*(    A_j00-alpha*dj1),A_j10-alpha*dj1)
      f1[j+1,2]=alpha*u(beta-1.0      ,jd*(-jd*A_j00-0.5*A_j10+1.5*alpha*dj1),-jd*A_j10-0.5*A_j20+alpha*dj1)
      f1[j+1,3]=alpha*u(beta+1.0      ,jd*( jd*A_j00-0.5*A_j10-0.5*alpha*dj1), jd*A_j10-0.5*A_j20-alpha*dj1)
      f1[j+1,4]=alpha*u(beta-alpha*sqrtalpha,jd*( jd*A_j00-0.5*A_j01-2.0*alpha*dj1), jd*A_j10-0.5*A_j11-2.0*alpha*dj1)
    end
  end
  # Add in the k=\pm 1 coefficients (note that d1 & d2 are the same as c1 & c2 for k=0):
  if j >= 1
    f1[j+1,2]=f1[j+1,2]+alpha*v(beta,jd*(A_j00-alpha*dj1),A_j10-alpha*dj1,-1)
    f1[j+1,3]=f1[j+1,3]+alpha*v(beta,jd*(A_j00-alpha*dj1),A_j10-alpha*dj1, 1)
  end

# Now for the outer planet:
# Outer planet coefficients, in order k=0,-2,2,-1,1 (see Table 1):
  one_over_alpha_squared = 1/(alpha*alpha)
  if j >= 2
    f2[j+1,1]=u(kappa,-jd*(A_j00-dj1*one_over_alpha_squared),A_j01-dj1*one_over_alpha_squared)
    f2[j+1,2]=u(kappa-1,-jd*(jd*A_j00-0.5*A_j01-0.5*dj1*one_over_alpha_squared),jd*A_j01-0.5*A_j02-dj1*one_over_alpha_squared)
    f2[j+1,3]=u(kappa+1,-jd*(-jd*A_j00-0.5*A_j01+1.5*dj1*one_over_alpha_squared),-jd*A_j01-0.5*A_j02+dj1*one_over_alpha_squared)
    f2[j+1,4]=u(kappa-1/(alpha*sqrtalpha),-jd*(-jd*A_j00-0.5*A_j10),-jd*A_j01-0.5*A_j11)
  else
    if j == 1
      f2[j+1,1]=u(kappa,-jd*(A_j00-dj1*one_over_alpha_squared),A_j01-dj1*one_over_alpha_squared)
      f2[j+1,2]=u(kappa-1,-jd*(jd*A_j00-0.5*A_j01-0.5*dj1*one_over_alpha_squared),jd*A_j01-0.5*A_j02-dj1*one_over_alpha_squared)
      f2[j+1,3]=u(kappa+1,-jd*(-jd*A_j00-0.5*A_j01+1.5*dj1*one_over_alpha_squared),-jd*A_j01-0.5*A_j02+dj1*one_over_alpha_squared)
    end
  end
  f2[j+1,5]=u(kappa+1/(alpha*sqrtalpha),-jd*(jd*A_j00-0.5*A_j10-2.0*dj1*one_over_alpha_squared),jd*A_j01-0.5*A_j11-2.0*dj1*one_over_alpha_squared)
# Add in the k=\pm 2 coefficients (note that d1 & d2 are the same as c1 & c2 for k=0):
  if j >= 1
    f2[j+1,2]=f2[j+1,2]+v(kappa,-jd*(A_j00-dj1*one_over_alpha_squared),A_j01-dj1*one_over_alpha_squared,-1)
    f2[j+1,3]=f2[j+1,3]+v(kappa,-jd*(A_j00-dj1*one_over_alpha_squared),A_j01-dj1*one_over_alpha_squared, 1)
  end
# That's it!
end
return 
end

"""
#/* compute Laplace coefficients and Leverrier derivative/
#          j
#     j   d     i
#    a   ---   b (a)
#          j    s
#        da
#
#   by series summation */
#/* Code due to Jack Wisdom */
"""
function laplace_wisdom(s::Rational,i::Integer,j::Integer,a::Number)
# function laplace_wisdom,s,i,j,a  IDL
# double laplace(double s, int i, int j, double a);  c

##define LAPLACE_EPS 1.0e-12
LAPLACE_EPS = convert(eltype(a),1.0e-12)

#if (i lt 0) then i = -i
i=abs(i)

if j <= i     #/* compute first term in sum */
  factor4 = one(a)
  for k=0:j-1
    factor4 *= i - k
  end
  lap_coef_sum = factor4
  q0 = 0
else
  q0 = fld(j + 1 - i,2)
  lap_coef_sum = zero(a)
  factor4 = one(a)
end

#  /* compute factors for terms in lap_coef_sum */

factor1 = s
factor2 = s + i
factor3 = i + 1
for q=1:q0-1       #/* no contribution for q = 0 */
  factor1 *= s + q
  factor2 *= s + i + q
  factor3 *= i+q+1
end
if q0 > 1
  q=q0
else
  q=1
end
#println(j+1-i,q0)
term = a*a * factor1 * factor2 / (factor3 * q)

#  /* sum series */

while  (term*factor4) > LAPLACE_EPS
  factor4 = one(a)
  for k=0:j-1
    factor4 *= (2*q + i - k)
  end
  lap_coef_sum += term * factor4
  factor1 += 1
  factor2 += 1
  factor3 += 1
  q = q+1
  term *= a*a * factor1 * factor2 / (factor3 * q)
end

#  /* fix coefficient */

for k=0:i-1
  lap_coef_sum *= (s+k)/(k+1)
end

apower = (q0 <= 0) ?  i : 2*q0 + i - 2
lap_coef_sum *= 2 * a^apower
# Return the Laplace Coefficient:
return lap_coef_sum
end




"""
# Computes transit-timing variations to linear order in
# eccentricity for non-resonant, plane-parallel planets.
# Input:
#   jmax:  Maximum j over which to sum the TTV calculation for both planets
#     p1:  Planet type for inner planet
#     p2:  Planet type for outer planet
#  time1:  Transit times for inner planet
#  time2:  Transit times for outer planet
# alpha0:  Initial alpha for Taylor expansion of coefficients
#     b0:  Laplace coefficients and derivatives for use in Taylor expansion
# Output:
#   ttv1: TTVs of the inner planet
#   ttv2: TTVs of the outer planet
#     f1: TTV coefficients for inner planet
#     f2: TTV coefficients for outer planet
#      b: Laplace coefficients (& derivatives) for outer planet
"""
function compute_ttv!(jmax::Integer,p1::Planet_plane_hk,p2::Planet_plane_hk,time1::Vector,time2::Vector,ttv1::Vector,ttv2::Vector,f1::Array,f2::Array,b::Array,alpha0::Number,b0::Array)

# Compute the semi-major axis ratio of the planets:
# println(p1.period,p2.period)
alpha = (p1.period/p2.period)^(2//3)  # Julia supports rational numbers!
# Number of times:
ntime1 = length(time1)
ntime2 = length(time2)
# Compute the coefficients:
ttv_succinct!(jmax+1,alpha,f1,f2,b,alpha0,b0)  # I need to compute coefficients one higher than jmax
# Compute TTVs for inner planet (equation 33):
# Compute since of \pomegas:
e1 = sqrt(p1.esinw*p1.esinw+p1.ecosw*p1.ecosw)
e2 = sqrt(p2.esinw*p2.esinw+p2.ecosw*p2.ecosw)
sin1om=p1.esinw/e1 
sin2om=p2.esinw/e2
cos1om=p1.ecosw/e1 
cos2om=p2.ecosw/e2
# Compute mean motions:
n1=2pi/p1.period
n2=2pi/p2.period
# Compute initial longitudes:
lam10=-n1*p1.trans0 + 2*p1.esinw # 2*p1.eccen*sin1om
lam20=-n2*p2.trans0 + 2*p2.esinw # 2*p2.eccen*sin2om
@inbounds  for i=1:ntime1
# Compute the longitudes of the planets at times of transit of planet 1 (equation 49):
  lam11 = n1*time1[i]+lam10
  lam21 = n2*time1[i]+lam20
  psi1  = lam11-lam21 # Compute difference in longitudes at times of transit of planet 1
  sinpsi1=sin(psi1)
  cospsi1=cos(psi1)
  sinlam11 = sin(lam11)
  coslam11 = cos(lam11) 
  sinlam1om1=sinlam11*cos1om-coslam11*sin1om
  coslam1om1=coslam11*cos1om+sinlam11*sin1om
  sinlam1om2=sinlam11*cos2om-coslam11*sin2om
  coslam1om2=coslam11*cos2om+sinlam11*sin2om
  ttv1[i]=zero(p1.period) #0.0
  sinjm1psi1=zero(p1.period) #0.0
  cosjm1psi1=one(p1.period) #1.0
# Sum over j:
  for j=1:jmax
    sinjpsi1=sinjm1psi1*cospsi1+cosjm1psi1*sinpsi1
    cosjpsi1=cosjm1psi1*cospsi1-sinjm1psi1*sinpsi1
    ttv1[i] += f1[j+1,1]*sinjpsi1
    ttv1[i] += f1[j+1,2]*e1*(sinjpsi1*coslam1om1-cosjpsi1*sinlam1om1)
    ttv1[i] += f1[j+1,3]*e1*(sinjpsi1*coslam1om1+cosjpsi1*sinlam1om1)
    ttv1[i] += f1[j  ,4]*e2*(sinjpsi1*coslam1om2-cosjpsi1*sinlam1om2)
    ttv1[i] += f1[j+2,5]*e2*(sinjpsi1*coslam1om2+cosjpsi1*sinlam1om2)
    sinjm1psi1=sinjpsi1
    cosjm1psi1=cosjpsi1
  end
# Multiply by period and mass ratio, and divide by 2*Pi:
  ttv1[i] = ttv1[i]*p1.period*p2.mass_ratio/(2pi)
end
# Compute TTVs for outer planet (equation 33):
@inbounds for i=1:ntime2
# Compute the longitudes of the planets at times of transit of planet 2:
  lam12 = n1*time2[i]+lam10
  lam22 = n2*time2[i]+lam20
  sinlam22 = sin(lam22)
  coslam22 = cos(lam22) 
  psi2  = lam12-lam22 # Compute difference in longitudes at times of transit of planet 2
  sinpsi2=sin(psi2)
  cospsi2=cos(psi2)
  sinlam2om1=sinlam22*cos1om-coslam22*sin1om
  coslam2om1=coslam22*cos1om+sinlam22*sin1om
  sinlam2om2=sinlam22*cos2om-coslam22*sin2om
  coslam2om2=coslam22*cos2om+sinlam22*sin2om
  ttv2[i]=zero(p2.period) #0.0
  sinjm1psi2=zero(p2.period) #0.0
  cosjm1psi2=one(p2.period) #1.0
# Sum over j:
  for j=1:jmax
    sinjpsi2=sinjm1psi2*cospsi2+cosjm1psi2*sinpsi2
    cosjpsi2=cosjm1psi2*cospsi2-sinjm1psi2*sinpsi2
    ttv2[i] += f2[j+1,1]*sinjpsi2
    ttv2[i] += f2[j+1,2]*e2*(sinjpsi2*coslam2om2-cosjpsi2*sinlam2om2)
    ttv2[i] += f2[j+1,3]*e2*(sinjpsi2*coslam2om2+cosjpsi2*sinlam2om2)
    ttv2[i] += f2[j+2,4]*e1*(sinjpsi2*coslam2om1-cosjpsi2*sinlam2om1)
    ttv2[i] += f2[j  ,5]*e1*(sinjpsi2*coslam2om1+cosjpsi2*sinlam2om1)
    sinjm1psi2=sinjpsi2
    cosjm1psi2=cosjpsi2
  end
# Multiply by period and mass ratio, and divide by 2*Pi:
  ttv2[i] = ttv2[i]*p2.period*p1.mass_ratio/(2pi)
end
# Finished!
return
end  # compute_ttv!

end # module

# ╔═╡ c5ed4ffb-bd77-4d4c-9599-1f085717c762
function test_ttv(jmax::Integer,n1::Integer,n2::Integer,data::Vector)
	@assert(jmax>=1)  # Should there be a larger minimum?
	@assert(n1>2)
	@assert(n2>2)
	@assert(length(data)==10)
	# Performs a test of the transit_times.jl routine
	# Set up planets planar-planet types for the inner and outer planets:
	p1=TTVFaster.Planet_plane_hk(data[1],data[2],data[3],data[4],data[ 5])
	p2=TTVFaster.Planet_plane_hk(data[6],data[7],data[8],data[9],data[10])
	time1 = collect(p1.trans0 .+ range(0, step=1, length=n1) .* p1.period)
	time2 = collect(p2.trans0 .+ range(0, step=1, length=n2) .* p2.period)
	alpha0=(p1.period/p2.period)^(2//3)
	# Initialize the computation of the Laplace coefficients:
	b0=TTVFaster.LaplaceCoefficients.initialize(jmax+1,alpha0)
	# Define arrays to hold the TTVs:
	ttv_el_type = eltype(data) == Float64 ? Float64 : Number
	ttv1=Array{ttv_el_type}(undef,n1)
	ttv2=Array{ttv_el_type}(undef,n2)
	# Define arrays to hold the TTV coefficients and Laplace coefficients:
	f1=Array{Float64}(undef,jmax+2,5)
	f2=Array{Float64}(undef,jmax+2,5)
	b=Array{Float64}(undef,jmax+2,3)
	TTVFaster.compute_ttv!(jmax,p1,p2,time1,time2,ttv1,ttv2,f1,f2,b,alpha0,b0)
	time1 .+= ttv1
	time2 .+= ttv2
	return (;ttv_in=ttv1,ttv_out=ttv2, tt_in=time1, tt_out=time2)
end

# ╔═╡ d80ef0ae-6bee-47c2-82a9-f1d1e4d8a786
ttvs_in, ttvs_out, tt_in, tt_out = test_ttv(6,ceil(Int64,(timespan-t0in)/Pin),ceil(Int64,(timespan-t0out)/Pout),[min*mearth,Pin,t0in,ein,ωin, mout*mearth,Pout,t0out,eout,ωout])

# ╔═╡ 08fdcdd1-06a9-44c1-ab83-ffa069273848
let
  plt_in = plot(legend=:none)
  plt_out = plot(legend=:none)
  scatter!(plt_in,tt_in,ttvs_in)
  ylabel!(plt_in,"TTVᵢₙ (d)")
  scatter!(plt_out,tt_out,ttvs_out)
  ylabel!(plt_out,"TTVₒᵤₜ (d)")
  xlabel!(plt_out,"Time (d)")
  xlims!(plt_in,0,timespan)
  xlims!(plt_out,0,timespan)
  plot(plt_in, plt_out, layout=(2,1), link=:x, size=(1000,600), leftmargin=20px, bottommargin=18px, guidefontsize=18 )	
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.4"
LaTeXStrings = "~1.3.0"
Plots = "~1.32.0"
PlutoTeachingTools = "~0.2.3"
PlutoUI = "~0.7.40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "8a494fe0c4ae21047f28eb48ac968f0b8a6fcaa7"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.4"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

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

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "1fd869cc3875b57347f7027521f561cf46d1fcd8"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.19.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "d08c20eef1f2cbc6e60fd3612ac4340b89fea322"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.9"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "5856d3031cdb1f3b2b6340dfdc66b6d9a149a374"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.2.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "5158c2b41018c5f7eb1470d558127ac274eca0c9"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.1"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.Extents]]
git-tree-sha1 = "5e1e4c53fa39afe63a7d356e30452249365fba99"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "ccd479984c7838684b3ac204b716c89955c76623"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "cf0a9940f250dc3cb6cc6c6821b4bf8a4286cf9c"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.66.2"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "2d908286d120c584abbe7621756c341707096ba4"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.66.2+0"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "fb28b5dc239d0174d7297310ef7b84a11804dfab"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.0.1"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "a7a97895780dab1085a97769316aa348830dc991"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.3"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "59ba44e0aa49b87a8c7a8920ec76f8afe87ed502"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.3.3"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "b3364212fb5d870f724876ffcd34dd8ec6d98918"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.7"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

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

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "0f960b1404abb0b244c1ece579a0ec78d056a5d1"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.15"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "1a43be956d433b5d0321197150c2f94e16c0aaa0"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.16"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "94d9c52ca447e23eac0c0f074effbcd38830deb5"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.18"

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
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "ae6676d5f576ccd21b6789c2cbe2ba24fcc8075d"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.5"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e60321e3f2616584ff98f0a4f18d98ae6f89bbb3"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.17+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "8162b2f8547bc23876edd0c5181b27702ae58dce"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.0.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "21303256d239f6b484977314674aef4bb1fe4420"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "3f9b0706d6051d8edf9959e2422666703080722a"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.32.0"

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
git-tree-sha1 = "a602d7b0babfca89005da04d89223b867b55319f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.40"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "c6c0f690d0cc7caddb74cef7aa847b824a16b256"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "e7eac76a958f8664f2718508435d058168c7953d"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "22c5201127d7b243b9ee1de3b43c408879dff60f"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.3.0"

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

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

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

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "dfec37b90740e3b9aa5dc2613892a3fc155c3b42"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.6"

[[deps.StaticArraysCore]]
git-tree-sha1 = "ec2bd695e905a3c755b33026954b119ea17f2d22"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.3.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArraysCore", "Tables"]
git-tree-sha1 = "8c6ac65ec9ab781af05b08ff305ddc727c25f680"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.12"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "58443b63fb7e465a8a7210828c91c08b92132dff"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.14+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─1aa502dc-7525-4432-aeac-ef98474f6568
# ╟─087cd2b5-2821-466d-b869-504ad97931a0
# ╟─478ae32d-7b46-43a8-b3ad-12b280a96612
# ╟─8e63323f-bf73-4674-84b0-96e6e8b92484
# ╟─28d92f9a-ec46-4fa9-b6a8-fb234610b974
# ╟─10606b2e-f494-4368-b85b-fd02132b45b2
# ╟─8c293f5f-910a-4c1d-8b7c-7c76348e8505
# ╟─89aa00c2-6d6b-4516-8041-af35050d3c8e
# ╟─1a1d349c-ba18-4d17-9123-28652469824d
# ╟─3ab2e03b-724b-452f-b4b7-3cb855dae849
# ╟─107c2f8d-24fb-49c0-bed3-5fcd7c0e86bd
# ╟─54caf8ec-22e7-46eb-960d-e318e846bcb9
# ╟─b769c22b-fa22-471d-9742-0c2d2ee77a48
# ╟─5d2b1262-4287-4d32-80ee-cc65939ea4dd
# ╟─b5d79d39-6752-4a70-8bcc-9391350b8161
# ╟─0c7dfa89-c640-4223-ae4b-f64b18191462
# ╟─3014430c-610f-4468-8e2f-5dc7ce9af16b
# ╟─8c8110c5-2565-4c61-95d9-8c2cf2a60784
# ╟─0e9a5324-e7a7-463d-aea7-6223867d6ea4
# ╟─08fdcdd1-06a9-44c1-ab83-ffa069273848
# ╟─b32c1bdb-c404-4125-914a-8b6638d1c0bc
# ╠═781e2bd4-e979-49c5-a38f-4000cae53521
# ╟─f8f1b2e2-e72d-4c6e-9d51-b7ebf812897c
# ╟─c8432773-77dd-4a78-ba90-50042f70ccad
# ╟─fd9c5332-f1e8-43e1-a77a-4e77bb58f105
# ╟─b65d5bd5-34e5-48bc-b333-2a8107f8d2ac
# ╟─631bb7a1-b09e-4594-a0b2-aa14e99a833f
# ╟─277b635d-a42d-4008-8cc0-577db676f6e0
# ╟─b9089f24-6836-49b4-a9b5-48bbf138afd5
# ╟─886279f9-e77f-4ffc-aadf-35d6fd5e64c2
# ╟─0a1c2f71-de04-4e42-b140-cafaf663ac31
# ╟─a72ea48b-c4c7-4b13-8751-e5494da2b9e8
# ╟─03b9598f-3de1-4519-ac6a-184305ff4168
# ╟─46e7c55b-8239-4399-a7c9-240d9f3e5709
# ╟─107288da-6aa8-4ca1-9095-661c93ecb2de
# ╟─40297599-858a-4f43-9eca-05757f3acca9
# ╟─a5c32806-1e5b-11ed-0f01-7f4009ba4972
# ╟─28b274a4-f666-4b44-91dd-bf2188ad073b
# ╟─2e888e9e-093d-473a-b45d-1ae3c9275591
# ╟─4369b76d-0eb9-4712-aa5d-9f27d15ca1f6
# ╟─0d7d2c3e-f3fe-4a9e-986c-463d24a30fa6
# ╟─8e9040ab-dfa8-4b9c-962a-4a07d2a064a4
# ╟─0aa6e9a3-5232-4139-8ce2-8241ef886870
# ╟─8834e7b6-fd28-4df4-9c7b-ce8fdc86e42a
# ╟─83c83947-8247-4471-a03d-9690e9965cc4
# ╟─c651ae5b-cea8-4c61-a50c-819697d24a06
# ╠═58501926-8be8-47b5-b097-79bbb9a182bc
# ╠═3d94c83d-0238-4ba5-820f-022bd6aac230
# ╟─45bc34df-1c7a-4575-846e-67faa5fca1b4
# ╟─47f460d2-6593-46ce-82bc-3d4e17c6c362
# ╟─d4be1de7-c5e9-4d83-9ef7-4ad96695b499
# ╟─d80ef0ae-6bee-47c2-82a9-f1d1e4d8a786
# ╟─c5ed4ffb-bd77-4d4c-9599-1f085717c762
# ╟─eb4610ba-84c9-4959-97c8-186e689ea641
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
