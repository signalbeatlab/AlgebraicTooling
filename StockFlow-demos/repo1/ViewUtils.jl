module ViewUtils

using StockFlow
using Catlab
using Catlab.Graphics
using Catlab.WiringDiagrams
using Plots

using Catlab.Graphics.Graphviz: run_graphviz

export display_relation
function display_relation(ex::RelationDiagram)
    gv = to_graphviz(ex, box_labels=:name, junction_labels=:variable, edge_attrs=Dict(:len=>"1"))
    tmp_svg = tempname() * ".svg"
    open(tmp_svg, "w") do io
        run_graphviz(io, gv, format="svg")
    end
    run(`open $tmp_svg`)
end

export display_graph
function display_graph(graph, dir="TB")
    tmp = tempname() * ".svg"
    open(io -> run_graphviz(io, graph, format="svg"), tmp, "w")
    run(`open $tmp`)
end

export display_plot
function display_plot(plt)
    tmp = tempname() * ".svg"
    savefig(plt, tmp)
    run(`open $tmp`)
end

end
