using StockFlow

println("SEIV")
# Susceptible / Exposed/ Infected / Vaccinated-Partially / Vaccinated-Fully

# Flow functions
fFirstdoseVaccine(u,p,t) = u.S * p.rv
fSeconddoseVaccine(u,p,t) = u.VP * p.rv
fWaningImmunityVP(u,p,t) = u.VP / p.tw
fWaningImmunityVF(u,p,t) = u.VF / p.tw
fNewIncidenceVP(u,p,t) = p.β*u.VP*u.I*(1.0-p.eP)/p.N
fNewIncidenceVF(u,p,t) = p.β*u.VF*u.I*(1.0-p.eF)/p.N

# Vaccine model instance
seiv = StockAndFlowp((:S, :E, :I, :VP, :VF),
   ((:FirstdoseVaccine=>fFirstdoseVaccine, :S=>:VP) => :S,
    (:SeconddoseVaccine=>fSeconddoseVaccine, :VP=>:VF) => :VP,
    (:WaningImmunityVP=>fWaningImmunityVP, :VP=>:S) => :VP,
    (:WaningImmunityVF=>fWaningImmunityVF, :VF=>:VP) => :VF,
    (:NewIncidenceVP=>fNewIncidenceVP, :VP=>:E) => (:VP, :I),
    (:NewIncidenceVF=>fNewIncidenceVF, :VF=>:E) => (:VF, :I)))

if !@isdefined(SUPPRESS_DISPLAY)
    display(seiv)
    include("ViewUtils.jl")
    ViewUtils.display_graph(Graph(seiv))
end
