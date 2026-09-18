using StockFlow

println("SEIRH")
# Susceptible / Exposed / Infected / Recovered / Hospitalized-ICU / Hospitalized-non-ICU

# Flow functions
fNewIncidence(u,p,t)=p.β*u.S*u.I/p.N
fNewInfectious(u,p,t)=u.E*p.ri
fNewRecovery(u,p,t)=u.I/p.tr * (1.0-p.fH )
fWaningImmunityR(u,p,t)=u.R/p.tw
fHICUAdmission(u,p,t) = u.I/p.tr * p.fH * p.fICU
fHNICUAdmission(u,p,t) = u.I/p.tr * p.fH * (1.0-p.fICU)
fOutICU(u,p,t) = u.HICU/p.tICU
fRecoveryH(u,p,t)= u.HNICU/p.tH

# StockAndFlowp constructor signature:
# - List[stock]
# - List[Triple[flow-name=>flow-function, upstream-stock=>downstream-stock, List[parent-stock]]
# (flattening out the pairs)
#
# Model instance
seirh = StockAndFlowp((:S, :E, :I, :R, :HICU, :HNICU),
   ((:NewIncidence=>fNewIncidence, :S=>:E) => (:S, :I),
    (:NewInfectious=>fNewInfectious, :E=>:I) => :E,
    (:NewRecovery=>fNewRecovery, :I=>:R) => :I,
    (:WaningImmunityR=>fWaningImmunityR, :R=>:S) => :R,
    (:HICUAdmission=>fHICUAdmission, :I=>:HICU) => :I,
    (:HNICUAdmission=>fHNICUAdmission, :I=>:HNICU) => :I,
    (:OutICU=>fOutICU, :HICU=>:HNICU) => :HICU,
    (:RecoveryH=>fRecoveryH, :HNICU=>:R) => :HNICU))

# StockAndFlowp DSL Syntax Key:
#
# Structure: StockAndFlowp((Stocks...), (FlowRules...))
#
# 1. Stocks Vector: (:Stock1, :Stock2, ...)
#    (:S, :E, :I, :R, :HICU, :HNICU)
#    - Declares all state variables (stocks) in the system.
#
# 2. Flow Rule Format:
#    (:FlowName => RateFunction, :SourceStock => :TargetStock) => (:ObservedStocks...)
#
# Example breakdown:
# (:NewIncidence => fNewIncidence, :S => :E) => (:S, :I)
# - Flow Name:        :NewIncidence        (Name of the mass transfer pipe)
# - Rate Function:    fNewIncidence        (Julia function calculating flow speed)
# - Stock Transition: :S => :E             (Mass moves OUT of :S and IN to :E)
# - Observed Inputs:  (:S, :I)             (Stocks whose values feed into fNewIncidence)
#
# Single Input Example:
# (:NewInfectious => fNewInfectious, :E => :I) => :E
# - Mass moves from :E to :I; rate function fNewInfectious depends ONLY on stock :E.

if !@isdefined(SUPPRESS_DISPLAY)
    display(seirh)
    include("ViewUtils.jl")
    ViewUtils.display_graph(Graph(seirh))
end

# Graph(seirh, "LR") - left-to-right - default
# Graph(seirh, "TB") - top-to-bottom

using ACSets

println("\n--- RAW ACSET TABLES ---")
show(stdout, "text/plain", seirh)
#
println("\n--- TABLE SIZES ---")
println("Stocks count: ", nparts(seirh, :Stock))  # Capitalized :Stock
println("Flows count:  ", nparts(seirh, :Flow))   # Capitalized :Flow
#
println("\n--- FOREIGN KEYS ---")
# u = upstream (is), d = downstream (os)
println("Flow Upstream Stocks (u):   ", subpart(seirh, :u))
println("Flow Downstream Stocks (d): ", subpart(seirh, :d))
