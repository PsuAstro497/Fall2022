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

# ╔═╡ 8be9bf52-a0a3-11ec-045f-3962ad227049
begin
	using DataFrames, Query
	using Optim
	using Plots, LaTeXStrings, Plots.Measures
	using PlutoUI, PlutoTeachingTools
end

# ╔═╡ 82d5eb4f-5724-4c72-b6e0-f6d5fc7f4313
md"""
# Exoplanet Detection:  Radial Velocity Method
**Astro 497:  Week 4, Day 3**
"""

# ╔═╡ 57141374-dd5a-4eaa-8235-b2310ef2d600
TableOfContents()

# ╔═╡ e119353c-15d2-415b-b612-20a639cb8903
md"""
## Logistics
- TBD
"""

# ╔═╡ c516e3bd-0858-498f-9db8-94395ad72ea0
md"""
# Circular RV Model

Velocity of Planet: 

$$v_{pl} = 2\pi a_{pl} / P$$

$$a = a_{pl} + a_\star$$ 

Velocity of Star:   

$$M_\star v_\star = m_{pl} v_{pl}$$

$$v_\star = \frac{m_{pl}}{M_\star+m_{pl}} \frac{2\pi a}{P}$$

Doppler effective is only sensitive to motion projected onto observer's line of sight

$$RV_{\star} = \frac{m_{pl}}{M_\star+m_{pl}} \frac{2\pi a}{P} \sin i$$

"""

# ╔═╡ 6be0b0bf-24e3-417c-a257-c4f61a31e1e3
md"""
# Keplerian Orbit

$(Resource("https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Orbit1.svg/1137px-Orbit1.svg.png"))
Credit: [Lasunncty](https://en.wikipedia.org/wiki/User:Lasunncty) via [Wikipedia](https://commons.wikimedia.org/wiki/File:Orbit1.svg) ([CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/deed.en) license)
"""

# ╔═╡ 4eace0ad-5222-4e1d-9760-7e139478e866
md"""
## Keplerian RV Model

$$\Delta RV(t) = \frac{K}{\sqrt{1-e^2}} \left[\cos(\omega+ν(t)) + e \cos(\omega) \right]$$

```math
\begin{eqnarray}
K & = & \frac{2\pi a \sin i}{P} \frac{m_{pl}}{M_\star+m_{pl}} \\
%  & = & \frac{2\pi a \sin i}{P} \\
\end{eqnarray}
```

$$\tan\left(\frac{\nu(t)}{2}\right) = \sqrt{\frac{1+e}{1-e}} \tan\left(\frac{E(t)}{2}\right)$$

- Mean anomaly ($M(t)$) increases linear with time
- Eccentric anomaly ($E(t)$) specifies position in orbit using angle from center of elipse 
- True anomaly ($\nu(t)$ or $f(t)$ or $T(t)$) specifies position in orbit using angle from focus of ellipse
"""

# ╔═╡ 8bc702c6-b3b2-4a81-901c-ce361b8c10e5
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Eccentric_and_True_Anomaly.svg/1229px-Eccentric_and_True_Anomaly.svg.png"))
Credit: [CheCheDaWaff](https://commons.wikimedia.org/wiki/User:CheCheDaWaff) via [Wikipedia](https://commons.wikimedia.org/wiki/File:Eccentric_and_True_Anomaly.svg) ([CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.en) license)
"""

# ╔═╡ 637a5d00-0e91-4227-aac5-829094935d91
md"""
### Keplerian Orbit in Time

$$M(t) = \frac{2π t}{P} + M_0$$


#### Kepler Equation
$$M(t) = E(t) - e \sin(E(t))$$
"""

# ╔═╡ 4bdcca25-c37f-4079-b222-be773adc2b8f
md"### Interactive Keplerian RV Model"

# ╔═╡ 2306a2d5-2924-45e0-adec-b90d536d2949
md"""
P: $(@bind P_plt NumberField(1:0.1:100, default=4))
K: $(@bind K_plt NumberField(0:0.1:10, default=3))
e: $(@bind e_plt NumberField(0:0.05:1, default=0))
ω: $(@bind ω_plt NumberField(0:0.05:2π, default=0))
M₀: $(@bind M0_plt NumberField(0:0.05:2π, default=0))
"""

# ╔═╡ 689c0cf1-ab41-460d-914b-b1f7d64f0894
md"""
# Pros & Cons

## Strengths
- Can detect planets with wide range of orbital inclinations
- RV amplitude decreases slowly with orbital period
- Provides information about planet mass
- Effective tool for studying planets around sun-like stars
- Can study stars at wide range of distances from Earth
- Can characterize planetary systems with multiple planets
- RV method has characterized hundreds of planetary systems

## Weaknesses
- Less sensitive to planets with nearly face-on orbits
- Less sensitive to planets with large orbital periods
- Characterizing long-period planets requires long-term observing programs
- Mass information subject to uncertainties in $\sin i$ and $M_\star$.
- Little Doppler information in spectra of stars with large $T_{\mathrm{eff}}$ or $v \sin i$
- Applying RV to faint stars requires large telescopes
- Characterizing planetary systems with low-mass planets and/or multiple planets can require hundreds of observations
- Interpretting observations can be tricky:
  - Unknown number of planets
  - Potential for degeneracies between model parameters
- Requires advanced high-resolution spectrographs & calibration system
- Relatively few observatories have precision RV capabilities
"""

# ╔═╡ 3d1821a6-f134-49d6-a4b0-39d6d28ab420
md"""
# Example RV Data
"""

# ╔═╡ d5febe7d-bf9b-4793-96f3-9c31b641b3ae
md"""
### Ingest data
"""

# ╔═╡ 8b1f8b91-12b5-4e61-a8ff-63538189cf34
t_offset = 2450000;  # So labels on x-axis are more digestable

# ╔═╡ 21834080-14de-4926-9766-5a3ad994e2a1
md"""
# Fitting RV Model to data
"""

# ╔═╡ d2d1cf44-255a-47bf-ba3d-42169c6af060
md"""
## Fit one planet
"""

# ╔═╡ a318c478-f71c-457b-9c54-fe69e964849a
θinit1 = [496.9, 10, 0.1, 0.1, 0.1, 1, 2, 1e-4, 2.0]

# ╔═╡ 55034abb-34e3-4fab-9b80-c82019a67756
md"""
## Fit 2nd planet to residuals
"""

# ╔═╡ 26c601fb-d62f-47f2-a7ff-e7ca63ad9dcd
θinit_resid = [4319.0, 5.0, 0.1, 0.1, π/4, 1.0, -1.0 , 0.0001, 1.0];

# ╔═╡ de533ac4-6870-40f8-8bad-f8c62694e719
md"""
## Fit 2-planet model
"""

# ╔═╡ b60aadbc-4e70-414e-9fdc-c3b042cb17bf
md"# Setup"

# ╔═╡ c3a9ed24-93a0-4cec-8233-3a93be5408f3
notebook_id = PlutoRunner.notebook_id[] |> string

# ╔═╡ 69f40924-6b24-4014-8c1b-f600a0759aab
md"## Keplerian Radial Velocity Model Code"

# ╔═╡ a7514405-af4c-4f16-8508-91ee624d8a1c
function calc_true_anom(ecc_anom::Real, e::Real)
	true_anom = 2*atan(sqrt((1+e)/(1-e))*tan(ecc_anom/2))
end

# ╔═╡ 4f047081-a4d6-414b-9c3e-0eb055c730b3
"""
   ecc_anom_init_guess_danby(mean_anomaly, eccentricity)

Returns initial guess for the eccentric anomaly for use by itterative solvers of Kepler's equation for bound orbits.  

Based on "The Solution of Kepler's Equations - Part Three"
Danby, J. M. A. (1987) Journal: Celestial Mechanics, Volume 40, Issue 3-4, pp. 303-312 (1987CeMec..40..303D)
"""
function ecc_anom_init_guess_danby(M::Real, ecc::Real)
	@assert -2π<= M <= 2π
	@assert 0 <= ecc <= 1.0
    if  M < zero(M)
		M += 2π
	end
    E = (M<π) ? M + 0.85*ecc : M - 0.85*ecc
end;

# ╔═╡ 8f700e72-df0f-4e68-85fe-7fbe8da7fbb1
"""
   update_ecc_anom_laguerre(eccentric_anomaly_guess, mean_anomaly, eccentricity)

Update the current guess for solution to Kepler's equation
  
Based on "An Improved Algorithm due to Laguerre for the Solution of Kepler's Equation"
   Conway, B. A.  (1986) Celestial Mechanics, Volume 39, Issue 2, pp.199-211 (1986CeMec..39..199C)
"""
function update_ecc_anom_laguerre(E::Real, M::Real, ecc::Real)
  #es = ecc*sin(E)
  #ec = ecc*cos(E)
  (es, ec) = ecc .* sincos(E)  # Does combining them provide any speed benefit?
  F = (E-es)-M
  Fp = one(M)-ec
  Fpp = es
  n = 5
  root = sqrt(abs((n-1)*((n-1)*Fp*Fp-n*F*Fpp)))
  denom = Fp>zero(E) ? Fp+root : Fp-root
  return E-n*F/denom
end;

# ╔═╡ 690205fb-0b95-4614-9b66-dec362ed693c
begin
	calc_ecc_anom_cell_id = PlutoRunner.currently_running_cell_id[] |> string
	calc_ecc_anom_url = "#$(calc_ecc_anom_cell_id)"
	"""
	   calc_ecc_anom( mean_anomaly, eccentricity )
	   calc_ecc_anom( param::Vector )
	
	Estimates eccentric anomaly for given 'mean_anomaly' and 'eccentricity'.
	If passed a parameter vector, param[1] = mean_anomaly and param[2] = eccentricity. 
	
	Optional parameter `tol` specifies tolerance (default 1e-8)
	"""
	function calc_ecc_anom end
	
	function calc_ecc_anom(mean_anom::Real, ecc::Real; tol::Real = 1.0e-8)
	  	if !(0 <= ecc <= 1.0)
			println("mean_anom = ",mean_anom,"  ecc = ",ecc)
		end
		@assert 0 <= ecc <= 1.0
		@assert 1e-16 <= tol < 1
	  	M = rem2pi(mean_anom,RoundNearest)
	    E = ecc_anom_init_guess_danby(M,ecc)
		local E_old
	    max_its_laguerre = 200
	    for i in 1:max_its_laguerre
	       E_old = E
	       E = update_ecc_anom_laguerre(E_old, M, ecc)
	       if abs(E-E_old) < tol break end
	    end
	    return E
	end
	
	function calc_ecc_anom(param::Vector; tol::Real = 1.0e-8)
		@assert length(param) == 2
		calc_ecc_anom(param[1], param[2], tol=tol)
	end;
end

# ╔═╡ 4d4d3ea6-3d87-4ec3-9625-7ba00e17dbcf
Markdown.parse("""
No closed form solution for \$E\$, so solve for \$E(t)\$ iteratively 
(see [code for `calc_ecc_anom(M, e)`]($(calc_ecc_anom_url))
""")

# ╔═╡ 3fbcc50d-9f6a-4aec-9a8f-f2f525223f0e
begin 
	""" Calculate RV from t, P, K, e, ω and M0	"""
	function calc_rv_keplerian end 
	#calc_rv(t, p::Vector) = calc_rv(t, p[1],p[2],p[3],p[4],p[5])
	calc_rv_keplerian(t, p::Vector) = calc_rv_keplerian(t, p...)
	function calc_rv_keplerian(t, P,K,e,ω,M0) 
		mean_anom = t*2π/P-M0
		ecc_anom = calc_ecc_anom(mean_anom,e)
		true_anom = calc_true_anom(ecc_anom,e)
		rv = K/sqrt((1-e)*(1+e))*(cos(ω+true_anom)+e*cos(ω))
	end
end

# ╔═╡ bab9033c-b9ee-45c1-9466-838e40bdb920
function make_rv_vs_phase_panel(e, ω; P::Real=1, K::Real=1, M0::Real =0, panel_label="", t_max::Real = P, xticks=false, yticks=false )
	plt = plot(legend=:none, widen=false, xticks=xticks, yticks=yticks, margin=0mm, link=:none)
	t_plt = collect(range(0,stop=t_max,length=1000))
	rv_plt = calc_rv_keplerian.(t_plt, P, K, e, ω, M0)
	plot!(plt,t_plt,rv_plt, linecolor=:black) #, lineweight=4)
	xlims!(0,P)
	ylims!(-3.0,3.0)
	if length(panel_label)>0
		annotate!(plt, 0.505,2.1, text(panel_label,24,:center))
	end
	return plt
end

# ╔═╡ 8d0a2a57-1bbe-4145-9e1b-de125c7635ef
let
	ω_list = [0,π/4,π/2, 3π/4, π]
	ωstr_list = [L"0",L"\frac{\pi}{4}",L"\frac{\pi}{2}", L"\frac{3\pi}{4}", L"\pi"]
	e_list = [0.2, 0.4, 0.6, 0.8]
	plts = [ make_rv_vs_phase_panel(e,ω_list[ωi], panel_label = L"e=" * latexstring(e) * L"\;\; \omega=" * ωstr_list[ωi] ) for ωi in 1:length(ω_list),  e in e_list ]
	#annotate!(plts[3,4],0.5,-4,text(L"\mathrm{Time}",48))
	#annotate!(plts[1,3],-0.25,4,text(L"\mathrm{RV}",48,rotation=90))
	l = @layout [  b{0.04w} [ grid(4,5); c{0.03h} ]  ]
	plt_top = [ plot(link=:none,xlabel="", ylabel="",xticks=false,yticks=false,frame=:none) for e in e_list ]
	
	#annotate!(plt_top[1],0.5,0.5,text(L"\omega=0",36))
	plt_left = plot(link=:none,xlabel="", ylabel="",xticks=false,yticks=false,frame=:none)
	annotate!(plt_left,0.5,0.525,text(L"\mathrm{RV}",36,rotation=90,:center))
	plt_bottom = plot(link=:none,xlabel="", ylabel="",xticks=false,yticks=false,frame=:none)
	annotate!(plt_bottom,0.5,0.5,text(L"\mathrm{Time}",36,:center))
	plt = plot(plt_left,plts...,plt_bottom,  link=:none, layout = l, size=(2400,2400), thinkness_scaling=8)
end

# ╔═╡ ee7aaab9-5e4f-46ab-8100-75be142fba72
let 
	plt = make_rv_vs_phase_panel(e_plt, ω_plt, P=P_plt, K=K_plt, M0=M0_plt, t_max = 100, xticks=true, yticks=true)
	xlabel!(plt, L"Time")
	ylabel!(plt, L"\Delta RV(t)")
	xlims!(0,100)
	ylims!(-6,6)
end

# ╔═╡ 7047d464-efdd-4315-b930-5b2e8a3d93c5
md"""
### Fitting Keplerian RV model
"""

# ╔═╡ cc7006c7-e3ef-470a-b93e-5743a27a32d9
begin 
	""" Calculate RV from t, P, K, e, ω, M0	and C"""
	function calc_rv_keplerian_plus_const end 
	calc_rv_keplerian_plus_const(t, p::Vector) = calc_rv_keplerian_plus_const(t, p...)
	
	function calc_rv_keplerian_plus_const(t, P,K,e,ω,M0,C) 
		calc_rv_keplerian(t, P,K,e,ω,M0) + C
	end
end

# ╔═╡ 5677766e-6466-4b0b-b703-61f9aaaf5cd3
begin
	""" Calculate RV from t, P1, K1, e1, ω1, M01, P2, K2, e2, ω2, M02 and C"""
	calc_rv_2keplerians_plus_const(t, p::Vector) = calc_rv_2keplerians_plus_const(t, p...)
	function calc_rv_2keplerians_plus_const(t, P1,K1,e1,ω1,M01,P2,K2,e2,ω2,M02,C) 
		calc_rv_keplerian(t, P1,K1,e1,ω1,M01) + calc_rv_keplerian(t, P2,K2,e2,ω2,M02) + C
	end
end

# ╔═╡ 56d09fea-e2c2-4345-a089-419ac863ac43
""" Calculate RV from t, P, K, e, ω, M0	and C with optional slope and t_mean"""
function model_1pl(t, P, K, e, ω, M, C; slope=0.0, t_mean = 0.0)
	calc_rv_keplerian(t-t_mean,P,K,e,ω,M) + C + slope * (t-t_mean)
end

# ╔═╡ 19a96558-4c9f-4bad-8fc2-735c813bd756
""" Calculate RV from t, P1, K1, e1, ω1, M01, P2, K2, e2, ω2, M02 and C with optional slope and t_mean"""
function model_2pl(t, P1, K1, e1, ω1, M1, P2, K2, e2, ω2, M2, C; slope=0.0, t_mean = 0.0)
	rv = calc_rv_keplerian(t-t_mean,P1,K1,e1,ω1,M1) + 
		 calc_rv_keplerian(t-t_mean,P2,K2,e2,ω2,M2) + 
		 C + slope * (t-t_mean)
end

# ╔═╡ 3932fb9d-2897-4d64-8dba-a51799d1aa7a
""" Convert vector of (P,K,h,k,ω+M0) to vector of (P, K, e, ω, M0) """
function PKhkωpM_to_PKeωM(x::Vector) 
	(P, K, h, k, ωpM) = x
	ω = atan(h,k)
	return [P, K, sqrt(h^2+k^2), ω, ωpM-ω]
end

# ╔═╡ d4e5cd92-21c0-4073-ab3e-8cd5804976c8
md"""
### Loss functions
The functions below:
- assume observations from exactly two instruments.
- make use of the global variables `data1`, `data2` and `t_mean`.
"""

# ╔═╡ 93d115f3-ab51-4425-8bc8-33dc9b37bd87
md"""
## Code for parsing machine readable tables from AAS Journals
"""

# ╔═╡ bc7e067b-a170-40e0-b9f1-11b097e72a09
function extract_entry(line::AbstractString, fmt_info)
	substr = line[parse(Int,fmt_info[1]):parse(Int,fmt_info[2])]
	if occursin("--",substr)
		return missing
	end
	if  fmt_info[3] == "A" 
		return strip(substr)
	end
	if !occursin(r"\d",substr) 
		return missing
	end
	if fmt_info[3] == "I" 
		return parse(Int,substr)
	elseif  fmt_info[3] == "F" 
		return parse(Float64,substr)
	else
		@warn "Need to add instructions for parsing type " fmt_info[1][3]
		return nothing
	end
end

# ╔═╡ d5036d21-76b3-41f9-8c34-59c8afe9ffe2
function read_apj_mrt(fn::AbstractString)
	lines = readlines(fn)
	line_start_fmt_specs = findfirst(l->occursin("Bytes",l),lines)+2
	line_stop_fmt_specs = findfirst(l->occursin(r"^\-+$",l),lines[line_start_fmt_specs:end]) + (line_start_fmt_specs-1) -1
	line_data_start = findlast(l->occursin(r"^\-+$",l),lines) +1
	fmt_info = map(l->match(r"^\s*(\d+)-\s+(\d+)\s+(\w)(\d\.?\d*)\s*(\S+)\s+(\S+)\s+(.*)$",l).captures,lines[line_start_fmt_specs:line_stop_fmt_specs]) 
	colnames = map(f->f[6],fmt_info)
	data = map(fmt->Base.Fix2(extract_entry,fmt).(lines[line_data_start:length(lines)]),fmt_info)
	df = DataFrame(data,colnames )
end

# ╔═╡ ad74edd0-5056-48f6-9f5c-19a46c0b7277
begin
	fn = joinpath("../_assets/week4/","apjsabe23ct6_mrt.txt");
	df_all = read_apj_mrt(fn)
	star_names = unique(df_all.Name)
end;

# ╔═╡ bead2981-e94f-4743-866b-7ecf7a2bae84
md"""
Star ID: $(@bind starid NumberField(1:length(star_names), default=40))
"""  # try 40, 52, 92, 198


# ╔═╡ 5e92054a-ca9e-4949-9727-5a9ed14003c0
begin
	star_name = star_names[starid]
	df_star = df_all |> @filter( _.Name == star_name ) |> DataFrame
end;

# ╔═╡ bce3f35c-07a1-48ef-8a29-243b2215fcb5
df_star_by_inst = df_star |> @groupby( _.Inst ) |> @map( {bjd = _.d, rv = _.RVel, σrv = _.e_RVel, inst= key(_), nobs_inst=length(_) }) |> DataFrame;

# ╔═╡ fcf19e04-3e35-4a01-8036-fd5b283fdd37
begin  # Warning: Assume exactly 2 instruments providing RV data
	data1 = (t=collect(df_star_by_inst[1,:bjd]).-t_offset, rv=collect(df_star_by_inst[1,:rv]), σrv=collect(df_star_by_inst[1,:σrv]))
	data2 = (t=collect(df_star_by_inst[2,:bjd]).-t_offset, rv=collect(df_star_by_inst[2,:rv]), σrv=collect(df_star_by_inst[2,:σrv]))
	
	t_mean = (sum(data1.t)+sum(data2.t))/(length(data1.t).+length(data2.t))
	t_plt = range(minimum(vcat(data1.t,data2.t)), stop=maximum(vcat(data1.t,data2.t)), step=1.0)
end

# ╔═╡ 9da83c61-cbcb-4c13-83d1-21a26b1c59d1
function loss_1pl(θ) 
	(P1, K1, h1, k1, Mpω1, C1, C2, slope, σj ) = θ
	( P1, K1, e1, ω1, M1 ) = PKhkωpM_to_PKeωM([P1, K1, h1, k1, Mpω1])
	if e1>1 return 1e6*e1 end
	rv_model1 = model_1pl.(data1.t,P1,K1,e1,ω1,M1,C1, slope=slope, t_mean=t_mean)
	loss = 0.5*sum(((rv_model1.-data1.rv)./(data1.σrv.+σj^2)).^2)
	rv_model2 = model_1pl.(data2.t,P1,K1,e1,ω1,M1,C2, slope=slope, t_mean=t_mean)
	loss += 0.5*sum((rv_model2.-data2.rv).^2 ./(data2.σrv.^2 .+σj^2))
	loss += 0.5*sum(log.(2π*(data1.σrv.^2 .+σj^2)))
	loss += 0.5*sum(log.(2π*(data2.σrv.^2 .+σj^2)))
	return loss
end

# ╔═╡ 41b2eea0-3049-4fa5-803e-83a54b74ef27
result1 = Optim.optimize(loss_1pl, θinit1, BFGS(), autodiff=:forward);

# ╔═╡ fa3fe244-75cf-434b-8de1-5fca5db06c8b
pred_1pl = map(t->model_1pl(t,PKhkωpM_to_PKeωM(result1.minimizer[1:5])...,0.0,slope=result1.minimizer[8], t_mean=t_mean),t_plt);

# ╔═╡ 278d1fbd-7c64-4544-b37a-8258f493b3db
resid1 = vcat(
	 data1.rv .- model_1pl.(data1.t,PKhkωpM_to_PKeωM(result1.minimizer[1:5])...,result1.minimizer[6],slope=result1.minimizer[8], t_mean=t_mean),
	data2.rv .- model_1pl.(data2.t,PKhkωpM_to_PKeωM(result1.minimizer[1:5])...,result1.minimizer[7],slope=result1.minimizer[8], t_mean=t_mean) )


# ╔═╡ ba141b21-ab58-400a-a41a-9cdd4dd5987d
function loss_1pl_resid(θ) 
	(P1, K1, h1, k1, Mpω1, C1, C2, slope, σj  ) = θ
	( P1, K1, e1, ω1, M1 ) = PKhkωpM_to_PKeωM([P1, K1, h1, k1, Mpω1])
	if e1>1 return 1e6*e1 end
	rv_model1 = model_1pl.(data1.t,P1,K1,e1,ω1,M1,C1, slope=slope, t_mean=t_mean)
	loss = 0.5*sum(((rv_model1.-resid1[1:length(data1.t)])./(data1.σrv.+σj^2)).^2)
	rv_model2 = model_1pl.(data2.t,P1,K1,e1,ω1,M1,C2, slope=slope, t_mean=t_mean)
	loss += 0.5*sum(((rv_model2.-resid1[length(data1.t)+1:end])./(data2.σrv.+σj^2)).^2)
	loss += 0.5*sum(log.(2π*(data1.σrv.^2 .+σj^2)))
	loss += 0.5*sum(log.(2π*(data2.σrv.^2 .+σj^2)))
	return loss
end

# ╔═╡ a847e31d-9007-478b-b1e3-ffb8e55a6f3c
result_resid = Optim.optimize(loss_1pl_resid, θinit_resid, BFGS(), autodiff=:forward );

# ╔═╡ abc38d23-8665-4377-9a25-9e9c5a10a7bf
model_resid = map(t->calc_rv_keplerian(t.-t_mean,PKhkωpM_to_PKeωM(result_resid.minimizer[1:5])...),t_plt);

# ╔═╡ 250c4487-0963-4f35-9b75-fa5901f8aaa5
θinit2 = [result1.minimizer[1:5]..., result_resid.minimizer[1:5]..., result1.minimizer[6]+result_resid.minimizer[6],result1.minimizer[7]+result_resid.minimizer[7], result1.minimizer[8]+result_resid.minimizer[8], result_resid.minimizer[9]];

# ╔═╡ 393c7568-a234-4ef5-97a6-4af630e355e5
function loss_2pl(θ) 
	(P1, K1, h1, k1, Mpω1, P2, K2, h2, k2, Mpω2, C1, C2, slope, σj ) = θ
	(P1, K1, e1, ω1, M1 ) = PKhkωpM_to_PKeωM([P1, K1, h1, k1, Mpω1])
	(P2, K2, e2, ω2, M2 ) = PKhkωpM_to_PKeωM([P2, K2, h2, k2, Mpω2])
	if e1>1 return 1e6*e1 end
	if e2>1 return 1e6*e2 end
	rv_model1 = model_2pl.(data1.t,P1,K1,e1,ω1,M1,P2,K2,e2,ω2,M2,C1, slope=slope, t_mean=t_mean)
	loss = 0.5*sum((rv_model1.-data1.rv).^2 ./(data1.σrv.^2 .+σj^2))
	loss += 0.5*sum(log.(2π*(data1.σrv.^2 .+σj^2)))
	rv_model2 = model_2pl.(data2.t,P1,K1,e1,ω1,M1,P2,K2,e2,ω2,M2,C2, slope=slope, t_mean=t_mean)
	loss += 0.5*sum((rv_model2.-data2.rv).^2 ./(data2.σrv.^2 .+σj^2))
	loss += 0.5*sum(log.(2π*(data2.σrv.^2 .+σj^2)))
	return loss
end

# ╔═╡ 2f328d44-1b5d-4257-a6a1-9cebb5bb5e8a
result2 = Optim.optimize(loss_2pl, θinit2, BFGS(), autodiff=:forward);

# ╔═╡ 7fdf5c7e-e360-472a-abf4-9f2404a4f883
result2.minimizer

# ╔═╡ 78fa1f36-5a09-4d9d-a562-3476cebdbfff
pred_2pl = map(t->model_2pl(t,PKhkωpM_to_PKeωM(result2.minimizer[1:5])...,PKhkωpM_to_PKeωM(result2.minimizer[6:10])...,0.0,slope=result2.minimizer[13], t_mean=t_mean),t_plt);

# ╔═╡ 62dd3278-6f02-416c-9bbb-f0de8b786d52
resid2 = vcat(
	 data1.rv .- model_2pl.(data1.t,PKhkωpM_to_PKeωM(result2.minimizer[1:5])...,PKhkωpM_to_PKeωM(result2.minimizer[6:10])...,result2.minimizer[11],slope=result2.minimizer[13], t_mean=t_mean),
	data2.rv .- model_2pl.(data2.t,PKhkωpM_to_PKeωM(result2.minimizer[1:5])...,PKhkωpM_to_PKeωM(result2.minimizer[6:10])...,result2.minimizer[12],slope=result2.minimizer[13], t_mean=t_mean) );

# ╔═╡ 849d5f32-f7c4-45cf-bc9d-85eae6c13d4f
begin
	plt_resid = plot(legend=:none)
	
	scatter!(data1.t, resid2[1:length(data1.t)], yerr=data1.σrv)
	scatter!(data2.t, resid2[length(data1.t)+1:end], yerr=data2.σrv)
	plot!(t_plt,t_plt.*0, linestyle=:dot, linecolor=:black)
	xlabel!("Time (d)")
	ylabel!("ΔRV (m/s)")
end;

# ╔═╡ 1b260d22-e035-4991-bd42-4abd6f6b0333
begin
	#upscale
	plt_fit = plot(widen=true, xticks=false)
	num_inst = size(df_star_by_inst,1)
	rvoffset = result2.minimizer[11:12]
	slope = result2.minimizer[13]
	#rvoffset[1:2] .= result2.minimizer[11:12]
	for inst in 1:num_inst
		lab = df_star_by_inst[inst,:inst]
		if lab == "lick" continue end
		if lab == "k" lab = "Keck (pre)" end
		if lab == "j" lab = "Keck (post)" end
		if lab == "apf" lab = "APF" end
		scatter!(df_star_by_inst[inst,:bjd].-t_offset,
				df_star_by_inst[inst,:rv].-rvoffset[inst],
				yerr=collect(df_star_by_inst[inst,:σrv]),
				label=lab)
				#markersize=3*upscale, legendfontsize=upscale*12,
		#plot!(t_plt,model_1pl)
		#plot!(t_plt.-2450000,model_2pl)
		#scatter!(df_star_by_inst[2,:bjd].-2450000,df_star_by_inst[2,:rv], yerr=collect(df_star_by_inst[2,:σrv]),label=:none)
		#scatter!(df_star_by_inst[3,:bjd].-2450000,df_star_by_inst[3,:rv], yerr=collect(df_star_by_inst[3,:σrv]),label=:none)
		#scatter!(df_star_by_inst[4,:bjd].-2450000,df_star_by_inst[4,:rv], yerr=collect(df_star_by_inst[4,:σrv]),label=:none)
	end
	plot!(t_plt,pred_2pl,linecolor=:black, label=:none)
	xlabel!("Time (d)")
	ylabel!("RV (m/s)")
	#title!("HD " * star_name )
	#savefig(plt_fit,joinpath(homedir(),"Downloads","RvEx.pdf"))
	plt_fit
end;

# ╔═╡ 449a4faf-0ba8-4325-a902-427951c60036
let
	l = @layout [a{0.7h} ; b ]
	plt_combo = 
	plot(plt_fit, plt_resid, layout = l)
	plt_combo
end

# ╔═╡ 5edc2a2d-6f63-4ac6-8c33-2c5d670bc466
let
	#upscale
	plt = plot() #legend=:none, widen=true)
	num_inst = size(df_star_by_inst,1)
	rvoffset = zeros(4) # [result2.minimizer[11], result2.minimizer[12], 0, 0]
	#rvoffset[1:2] .= result1.minimizer[6:7]
	#slope = result1.minimizer[8]
	#rvoffset[1:2] .= result2.minimizer[11:12]
	for inst in 1:num_inst
		lab = df_star_by_inst[inst,:inst]
		if lab == "lick" continue end
		if lab == "k" lab = "Keck (pre)" end
		if lab == "j" lab = "Keck (post)" end
		if lab == "apf" lab = "APF" end
		scatter!(df_star_by_inst[inst,:bjd].-t_offset,
				df_star_by_inst[inst,:rv].-rvoffset[inst],
				yerr=collect(df_star_by_inst[inst,:σrv]),
				label=lab)
				#markersize=4*upscale, legendfontsize=upscale*12
		#plot!(t_plt,model_1pl)
		#plot!(t_plt.-2450000,model_2pl)
		#scatter!(df_star_by_inst[2,:bjd].-2450000,df_star_by_inst[2,:rv], yerr=collect(df_star_by_inst[2,:σrv]),label=:none)
		#scatter!(df_star_by_inst[3,:bjd].-2450000,df_star_by_inst[3,:rv], yerr=collect(df_star_by_inst[3,:σrv]),label=:none)
		#scatter!(df_star_by_inst[4,:bjd].-2450000,df_star_by_inst[4,:rv], yerr=collect(df_star_by_inst[4,:σrv]),label=:none)
	end
	xlabel!("Time (d)")
	ylabel!("RV (m/s)")
	title!("HD " * star_name )
	#savefig(plt,joinpath(homedir(),"Downloads","RvEx.pdf"))
	plt
end

# ╔═╡ 43ae8d15-6381-4c86-b08d-2d12cd4bc653
let
	#upscale
	plt = plot() #legend=:none, widen=true)
	num_inst = size(df_star_by_inst,1)
	rvoffset = zeros(4) # [result2.minimizer[11], result2.minimizer[12], 0, 0]
	rvoffset[1:2] .= result1.minimizer[6:7]
	slope = result1.minimizer[8]
	#rvoffset[1:2] .= result2.minimizer[11:12]
	for inst in 1:num_inst
		lab = df_star_by_inst[inst,:inst]
		if lab == "lick" continue end
		if lab == "k" lab = "Keck (pre)" end
		if lab == "j" lab = "Keck (post)" end
		if lab == "apf" lab = "APF" end
		scatter!(df_star_by_inst[inst,:bjd].-t_offset,
				df_star_by_inst[inst,:rv].-rvoffset[inst],
				yerr=collect(df_star_by_inst[inst,:σrv]),
				label=lab)
		#plot!(t_plt,model_1pl)
		#plot!(t_plt.-2450000,model_2pl)
		#scatter!(df_star_by_inst[2,:bjd].-2450000,df_star_by_inst[2,:rv], yerr=collect(df_star_by_inst[2,:σrv]),label=:none)
		#scatter!(df_star_by_inst[3,:bjd].-2450000,df_star_by_inst[3,:rv], yerr=collect(df_star_by_inst[3,:σrv]),label=:none)
		#scatter!(df_star_by_inst[4,:bjd].-2450000,df_star_by_inst[4,:rv], yerr=collect(df_star_by_inst[4,:σrv]),label=:none)
	end
	plot!(t_plt,pred_1pl, label=:none)
	xlabel!("Time (d)")
	ylabel!("RV (m/s)")
	title!("HD " * star_name )
	#savefig(plt,joinpath(homedir(),"Downloads","RvEx.pdf"))
	plt
end

# ╔═╡ 844ede38-9596-47a6-b30b-9eff622a2330
let
	#upscale
	plt = plot(legend=:none, widen=true)
	num_inst = size(df_star_by_inst,1)
	rvoffset = result1.minimizer[6:7]
	slope = result1.minimizer[8]

	scatter!(data1.t,
				data1.rv.-
				model_1pl.(data1.t,PKhkωpM_to_PKeωM(result1.minimizer[1:5])...,rvoffset[1],slope=result1.minimizer[8], t_mean=t_mean),
				yerr=data1.σrv) #,
				#markersize=4*upscale, legendfontsize=upscale*12)
	scatter!(data2.t,
				data2.rv.-
				model_1pl.(data2.t,PKhkωpM_to_PKeωM(result1.minimizer[1:5])...,rvoffset[2],slope=result1.minimizer[8], t_mean=t_mean),
				yerr=data2.σrv),
				#markersize=4*upscale, legendfontsize=upscale*12)
	plot!(t_plt, model_resid)
	xlabel!("Time (d)")
	ylabel!("RV (m/s)")
	title!("HD " * star_name * " (residuals to 1 planet model)")
	#savefig(plt,joinpath(homedir(),"Downloads","RvEx.pdf"))
	plt
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Optim = "429524aa-4258-5aef-a3af-852621145aeb"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Query = "1a8c2f83-1ff3-5112-b086-8aa67b057ba1"

[compat]
DataFrames = "~1.3.2"
LaTeXStrings = "~1.3.0"
Optim = "~1.7.2"
Plots = "~1.26.0"
PlutoTeachingTools = "~0.1.7"
PlutoUI = "~0.7.37"
Query = "~1.0.0"
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

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.ArrayInterfaceCore]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "40debc9f72d0511e12d817c7ca06a721b6423ba3"
uuid = "30b0a656-2188-435a-8636-2ec0e6a096e2"
version = "0.1.17"

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
git-tree-sha1 = "c9a6160317d1abe9c44b3beb367fd448117679ca"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.13.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "1833bda4a027f4b2a1c984baddcf755d77266818"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.1.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "12fc73e5e0af68ad3137b886e3f7c1eacfca2640"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.17.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "96b0bc6c52df76506efc8a441c6cf1adcb1babc4"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.42.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "fb21ddd70a051d882a1686a5a550990bbe371a95"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.4.1"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "ae02104e835f219b8930c7664b8012c93475c340"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.2"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

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

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DiffResults]]
deps = ["StaticArrays"]
git-tree-sha1 = "c18e98cba888c6c25d1c3b048e4b3380ca956805"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.0.3"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "992a23afdb109d0d2f8802a30cf5ae4b1fe7ea68"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.11.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

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
git-tree-sha1 = "ae13fcbc7ab8f16b0856729b050ef0c446aa3492"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "3399bbad4c9e9a2fd372a54d7b67b3c7121b6402"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.3"

[[deps.FiniteDiff]]
deps = ["ArrayInterfaceCore", "LinearAlgebra", "Requires", "Setfield", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "5a2cff9b6b77b33b89f3d97a4d367747adce647e"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.15.0"

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

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "187198a4ed8ccd7b5d99c41b69c679269ea2b2d4"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.32"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "51d2dfe8e590fbd74e7a842cf6d13d8a2f45dc01"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.6+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "9f836fb62492f4b0f0d3b06f55983f2704ed0883"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.0"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a6c850d77ad5118ad3be4bd188919ce97fffac47"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.0+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "83ea630384a13fc4f002b77690bc0afeb4255ac9"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.2"

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
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

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
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

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
git-tree-sha1 = "91b5dcf362c5add98049e6c29ee756910b03051d"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.3"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

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
git-tree-sha1 = "4f00cc36fede3c04b8acf9b2e2763decfdcecfa6"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.13"

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
git-tree-sha1 = "c9551dd26e31ab17b86cbd00c2ede019c08758eb"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LineSearches]]
deps = ["LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "Printf"]
git-tree-sha1 = "f27132e551e959b3667d8c93eae90973225032dd"
uuid = "d3d80556-e9d4-5f37-9878-2ab0fcc64255"
version = "7.1.1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "3f7cb7157ef860c637f3f4929c8ed5d9716933c6"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.7"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

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
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

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

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "50310f934e55e5ca3912fb941dec199b49ca9b68"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.2"

[[deps.NaNMath]]
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

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
git-tree-sha1 = "648107615c15d4e09f7eca16307bc821c1f718d8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.13+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Optim]]
deps = ["Compat", "FillArrays", "ForwardDiff", "LineSearches", "LinearAlgebra", "NLSolversBase", "NaNMath", "Parameters", "PositiveFactorizations", "Printf", "SparseArrays", "StatsBase"]
git-tree-sha1 = "ad8de074ed5dad13e87d76c467a82e5eff9c693a"
uuid = "429524aa-4258-5aef-a3af-852621145aeb"
version = "1.7.2"

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

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "6f1b25e8ea06279b5689263cc538f51331d7ca17"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.1.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "23d109aad5d225e945c813c6ebef79104beda955"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.26.0"

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
git-tree-sha1 = "67c917d383c783aeadd25babad6625b834294b30"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.1.7"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[deps.PositiveFactorizations]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "17275485f373e6673f7e7f97051f703ed5b15b20"
uuid = "85a6dd25-e78a-55b7-8502-1745935b8125"
version = "0.2.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "de893592a221142f3db370f48290e3a2ef39998f"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.4"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "c6c0f690d0cc7caddb74cef7aa847b824a16b256"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+1"

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

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "995a812c6f7edea7527bb570f0ac39d0fb15663c"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.1"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

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
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

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
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "74fb527333e72ada2dd9ef77d98e4991fb185f04"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.1"

[[deps.StaticArraysCore]]
git-tree-sha1 = "ec2bd695e905a3c755b33026954b119ea17f2d22"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.3.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c3d8ba7f3fa0625b062b82853a7d5229cb728b6b"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.1"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "57617b34fa34f91d536eb265df67c2d4519b8b98"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.5"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

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
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

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
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

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
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─82d5eb4f-5724-4c72-b6e0-f6d5fc7f4313
# ╟─57141374-dd5a-4eaa-8235-b2310ef2d600
# ╟─e119353c-15d2-415b-b612-20a639cb8903
# ╟─c516e3bd-0858-498f-9db8-94395ad72ea0
# ╟─6be0b0bf-24e3-417c-a257-c4f61a31e1e3
# ╟─4eace0ad-5222-4e1d-9760-7e139478e866
# ╟─8bc702c6-b3b2-4a81-901c-ce361b8c10e5
# ╟─637a5d00-0e91-4227-aac5-829094935d91
# ╟─4d4d3ea6-3d87-4ec3-9625-7ba00e17dbcf
# ╟─8d0a2a57-1bbe-4145-9e1b-de125c7635ef
# ╟─bab9033c-b9ee-45c1-9466-838e40bdb920
# ╟─4bdcca25-c37f-4079-b222-be773adc2b8f
# ╟─ee7aaab9-5e4f-46ab-8100-75be142fba72
# ╟─2306a2d5-2924-45e0-adec-b90d536d2949
# ╟─689c0cf1-ab41-460d-914b-b1f7d64f0894
# ╟─3d1821a6-f134-49d6-a4b0-39d6d28ab420
# ╟─d5febe7d-bf9b-4793-96f3-9c31b641b3ae
# ╠═ad74edd0-5056-48f6-9f5c-19a46c0b7277
# ╠═5e92054a-ca9e-4949-9727-5a9ed14003c0
# ╠═bce3f35c-07a1-48ef-8a29-243b2215fcb5
# ╠═8b1f8b91-12b5-4e61-a8ff-63538189cf34
# ╟─bead2981-e94f-4743-866b-7ecf7a2bae84
# ╟─5edc2a2d-6f63-4ac6-8c33-2c5d670bc466
# ╟─21834080-14de-4926-9766-5a3ad994e2a1
# ╠═fcf19e04-3e35-4a01-8036-fd5b283fdd37
# ╟─d2d1cf44-255a-47bf-ba3d-42169c6af060
# ╠═a318c478-f71c-457b-9c54-fe69e964849a
# ╠═41b2eea0-3049-4fa5-803e-83a54b74ef27
# ╠═fa3fe244-75cf-434b-8de1-5fca5db06c8b
# ╟─43ae8d15-6381-4c86-b08d-2d12cd4bc653
# ╠═278d1fbd-7c64-4544-b37a-8258f493b3db
# ╟─844ede38-9596-47a6-b30b-9eff622a2330
# ╟─55034abb-34e3-4fab-9b80-c82019a67756
# ╠═26c601fb-d62f-47f2-a7ff-e7ca63ad9dcd
# ╠═a847e31d-9007-478b-b1e3-ffb8e55a6f3c
# ╠═abc38d23-8665-4377-9a25-9e9c5a10a7bf
# ╟─de533ac4-6870-40f8-8bad-f8c62694e719
# ╠═250c4487-0963-4f35-9b75-fa5901f8aaa5
# ╠═2f328d44-1b5d-4257-a6a1-9cebb5bb5e8a
# ╠═7fdf5c7e-e360-472a-abf4-9f2404a4f883
# ╠═78fa1f36-5a09-4d9d-a562-3476cebdbfff
# ╟─62dd3278-6f02-416c-9bbb-f0de8b786d52
# ╟─1b260d22-e035-4991-bd42-4abd6f6b0333
# ╟─849d5f32-f7c4-45cf-bc9d-85eae6c13d4f
# ╟─449a4faf-0ba8-4325-a902-427951c60036
# ╟─b60aadbc-4e70-414e-9fdc-c3b042cb17bf
# ╠═8be9bf52-a0a3-11ec-045f-3962ad227049
# ╠═c3a9ed24-93a0-4cec-8233-3a93be5408f3
# ╟─69f40924-6b24-4014-8c1b-f600a0759aab
# ╠═3fbcc50d-9f6a-4aec-9a8f-f2f525223f0e
# ╠═a7514405-af4c-4f16-8508-91ee624d8a1c
# ╠═690205fb-0b95-4614-9b66-dec362ed693c
# ╠═4f047081-a4d6-414b-9c3e-0eb055c730b3
# ╠═8f700e72-df0f-4e68-85fe-7fbe8da7fbb1
# ╟─7047d464-efdd-4315-b930-5b2e8a3d93c5
# ╟─cc7006c7-e3ef-470a-b93e-5743a27a32d9
# ╟─5677766e-6466-4b0b-b703-61f9aaaf5cd3
# ╟─56d09fea-e2c2-4345-a089-419ac863ac43
# ╟─19a96558-4c9f-4bad-8fc2-735c813bd756
# ╟─3932fb9d-2897-4d64-8dba-a51799d1aa7a
# ╟─d4e5cd92-21c0-4073-ab3e-8cd5804976c8
# ╟─9da83c61-cbcb-4c13-83d1-21a26b1c59d1
# ╟─ba141b21-ab58-400a-a41a-9cdd4dd5987d
# ╟─393c7568-a234-4ef5-97a6-4af630e355e5
# ╟─93d115f3-ab51-4425-8bc8-33dc9b37bd87
# ╟─d5036d21-76b3-41f9-8c34-59c8afe9ffe2
# ╟─bc7e067b-a170-40e0-b9f1-11b097e72a09
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
