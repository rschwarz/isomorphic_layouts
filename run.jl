# compute mapping
include("axis49_isomorphic.jl")

# draw mapping
include("drawing.jl")

function save_isomorphic(nw, ne, name)
    mapping = find_mapping(nw, ne)
    layout = layout_mapping(mapping)
    scene = draw_layout(layout)
    save(name, scene)
    return
end

save_isomorphic(4, -3, "rotated_harmonic_table.png")
save_isomorphic(3, 4, "harmonic_table.png")
save_isomorphic(5, 7, "wicki_hayden.png")
save_isomorphic(4, 5, "linnstrument.png")
