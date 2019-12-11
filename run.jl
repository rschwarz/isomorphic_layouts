# compute mapping
include("axis49_isomorphic.jl")

# MIDI map config
include("midi_map.jl")

# draw mapping
include("drawing.jl")

function save_isomorphic(nw, ne, name, scalen=12)
    # mapping between MIDI notes
    mapping = find_mapping(nw, ne)

    # config file for midimap.lv2
    write_config("$(name).cfg", mapping)

    # visualize layout
    layout = layout_mapping(mapping)
    scene = draw_layout(layout, scalen)
    save("$(name).png", scene)

    return
end

# 12 tet
save_isomorphic(4, -3, "rotated_harmonic_table_4_m3__12")
save_isomorphic(3, 4, "harmonic_table_3_4__12")
save_isomorphic(5, 7, "wicki_hayden_5_7__12")
save_isomorphic(4, 5, "linnstrument_4_5__12")

# 10 tet
save_isomorphic(2, 3, "2_3__10", 10)
save_isomorphic(3, 4, "3_4__10", 10)
save_isomorphic(4, 5, "4_5__10", 10)

# 13 tet / Bohlen Pierce
save_isomorphic(2, 3, "2_3__13", 13)
save_isomorphic(3, 4, "3_4__13", 13)
save_isomorphic(4, 5, "4_5__13", 13)
