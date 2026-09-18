# Solve ODEs - COVID19 model

using LabelledArrays
using OrdinaryDiffEq
using Plots

SUPPRESS_DISPLAY2 = true
include("demo1_05_compose_covid19.jl")

model = COVID19

# COVID19 parameters
params = LVector(
    β=0.8, N=38010001.0, tr=12.22, tw=2*365.0,
    fH=0.002, fICU=0.23, tICU=6.0, tH = 12.0,
    rv=0.01, eP=0.6, eF=0.85, ri=0.207, ria=0.138
)

initial_state = LVector(
    S=38010000.0, E=0.0, I=1.0, IA=0.0, R=0.0, HICU=0.0, HNICU=0.0, VP=0.0, VF=0.0
)

# vectorfield uses flow functions on model to build a derivative calculator

problem = ODEProblem(vectorfield(model), initial_state, (0.0,300.0), params)

solution = solve(problem, Tsit5(), abstol=1e-8)

# Vector of time samples, from 0 to 300
t = solution.t

# Matching state vectors
states = solution.u

println("Trajectory of first dose")
# Function fFirstdoseVaccine defined in SEIV demo
firstdoseVaccine = map(i->fFirstdoseVaccine(states[i], params, t[i]), collect(1:length(t)))
println(firstdoseVaccine)

# Plot one curve per stock
include("ViewUtils.jl")
ViewUtils.display_plot(plot(solution))

#=
### Data inspection ###

julia> t
73-element Vector{Float64}:
   0.0
   3.7206169202586676e-11
   4.0926786122845343e-10
...
 281.086772372351
 288.82536106617505
 296.63416705831963
 300.0

julia> states[30]
9-element LArray{Float64, 1, Vector{Float64}, (:S, :E, :I, :IA, :R, :HICU, :HNICU, :VP, :VF)}:
     :S => 2.6212146498288732e7
     :E => 1352.3587835548803
     :I => 1090.731079790548
    :IA => 727.1246166553149
     :R => 817.38142849561
  :HICU => 0.11919886419269941
 :HNICU => 0.5996771542708277
    :VP => 9.710340742415464e6
    :VF => 2.083525444511299e6
=#
