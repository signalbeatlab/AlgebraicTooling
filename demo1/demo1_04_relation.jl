using Catlab

println("Relation graph")

covid = @relation (S, E, I, R) begin
    SEIRH(S,E,I,R)
    SEIV(S,E,I)
    EIaR(E,R)
end;

if !@isdefined(SUPPRESS_DISPLAY)
    display(covid)
    include("ViewUtils.jl")
    ViewUtils.display_relation(covid)
end

using ACSets

println("\n--- RAW UWD ACSET TABLES ---")
show(stdout, "text/plain", covid)

println("\n--- UWD STRUCTURE ---")
println("Box count (sub-models): ", nparts(covid, :Box))
println("Port count (total interfaces): ", nparts(covid, :Port))
println("Junction count (shared variables): ", nparts(covid, :Junction))

println("\n--- PORT TO JUNCTION MAP ---")
println("Port -> Junction mapping: ", subpart(covid, :junction))
println("Port -> Box mapping:      ", subpart(covid, :box))
