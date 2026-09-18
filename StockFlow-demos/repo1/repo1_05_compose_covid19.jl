using StockFlow
using StockFlow: Graph

SUPPRESS_DISPLAY = true
include("repo1_01_seirh.jl")
include("repo1_02_seiv.jl")
include("repo1_03_eiar.jl")
include("repo1_04_relation.jl")

# Open three SF diagrams
open_seirh = Open(seirh, [:S], [:E], [:I], [:R])
open_seiv = Open(seiv, [:S], [:E], [:I])
open_eiar = Open(eiar, [:E], [:R])

# Compose with UWD-algebra
open_covid = oapply(covid, [open_seirh, open_seiv, open_eiar])
COVID19 = apex(open_covid)

if !@isdefined(SUPPRESS_DISPLAY2)
    display(COVID19)
    include("ViewUtils.jl")
    ViewUtils.display_graph(Graph(COVID19,"TB"))
end

#=
using ACSets
println("\n--- COMPOSITE ACSET (`covid19`) TABLES ---")
show(stdout, "text/plain", covid19)
println("\n--- MERGED METRICS ---")
println("Total Stocks (after consolidation): ", nparts(covid19, :Stock))
println("Total Flows (disjoint unioned):     ", nparts(covid19, :Flow))
println("Total Links (disjoint unioned):     ", nparts(covid19, :Link))
println("\n--- CONSOLIDATED STOCK NAMES ---")
println("Stock names: ", subpart(covid19, :sname))
println("\n--- RETARGETED FOREIGN KEYS ---")
println("Flow Upstream (u):   ", subpart(covid19, :u))
println("Flow Downstream (d): ", subpart(covid19, :d))
=#
