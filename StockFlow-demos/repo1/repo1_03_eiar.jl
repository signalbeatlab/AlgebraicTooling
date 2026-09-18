using StockFlow

println("EIaR")
# Exposed / Infectious-Asymptomatic / Recovered

# Flow functions
fNewPersistentAsymptomaticity(u,p,t) = u.E * p.ria
fNewRecoveryIA(u,p,t) = u.IA / p.tr

eiar = StockAndFlowp((:E, :IA, :R),
   ((:NewPersistentAsymptomaticity=>fNewPersistentAsymptomaticity, :E=>:IA) => :E,
    (:NewRecoveryIA=>fNewRecoveryIA, :IA=>:R) => :IA))

if !@isdefined(SUPPRESS_DISPLAY)
    display(eiar)
    include("ViewUtils.jl")
    ViewUtils.display_graph(Graph(eiar))
end
