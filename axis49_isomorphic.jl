
# MIDI note assigment for every cell in the grid. We turn the Axis-49 controller
# by 90° counter-clockwise (CCW), to get pointy-top hexagons. "Doubled"
# coordinates are used, with 0 filling the gaps.
selfless_layout_ccw = [
     0 92  0 93  0 94  0 95  0 96  0 97  0 98  0
     0  0 85  0 86  0 87  0 88  0 89  0 90  0 91
     0 78  0 79  0 80  0 81  0 82  0 83  0 84  0
     0  0 71  0 72  0 73  0 74  0 75  0 76  0 77
     0 64  0 65  0 66  0 67  0 68  0 69  0 70  0
     0  0 57  0 58  0 59  0 60  0 61  0 62  0 63
     0 50  0 51  0 52  0 53  0 54  0 55  0 56  0
    43  0 44  0 45  0 46  0 47  0 48  0 49  0  0
     0 36  0 37  0 38  0 39  0 40  0 41  0 42  0
    29  0 30  0 31  0 32  0 33  0 34  0 35  0  0
     0 22  0 23  0 24  0 25  0 26  0 27  0 28  0
    15  0 16  0 17  0 18  0 19  0 20  0 21  0  0
     0  8  0  9  0 10  0 11  0 12  0 13  0 14  0
     1  0  2  0  3  0  4  0  5  0  6  0  7  0  0
]

rev_layout_ccw = [ci.I for ci in indexin(1:98, selfless_layout_ccw)]

# First index is for vertical index, second for horizontal.
# Array indices increase while going south and east!
#                   nw     ne    e    se   sw    w
neighbor_offsets = [-1 -1; -1 1; 0 2; 1 1; 1 -1; 0 -2]

"Coordinates of neigbors; might be out of bounds."
raw_neighbors(i, j) = [i j] .+ neighbor_offsets

"MIDI note offsets for neighbors"
note_offsets(nw, ne) = [nw, ne, ne - nw, -nw, -ne, nw - ne]
#                               e        se   sw   w

function find_mapping(nw, ne)
    # initial mapping with anchor
    mapping = zeros(Int, 98)
    mapping[53] = 60

    # note offsets in all 6 directions
    offsets = note_offsets(nw, ne)

    # repeat propagation until nothing changes anymore
    while true
        had_change = false

        # try all existing entries in mapping
        for (key, val) in enumerate(mapping)
            val == 0 && continue

            # find coordinate of key in Axis-49 layout
            i, j = rev_layout_ccw[key]

            # see if we can propagate to any neighbor
            for (nb, off) in zip(eachrow(raw_neighbors(i, j)), offsets)
                (k, l) = nb

                # only use valid neighbors (in bounds)
                checkbounds(Bool, selfless_layout_ccw, k, l) || continue
                key_nb = selfless_layout_ccw[k, l]
                key_nb != 0 || continue

                # skip existing mapping entries
                mapping[key_nb] == 0 || continue

                # propagate!
                mapping[key_nb] = val + off
                had_change = true
            end
        end

        had_change || break
    end

    return mapping
end

function layout_mapping(m)
    layout = zeros(Int, 14, 15)
    for (k, v) in zip(rev_layout_ccw, m)
        layout[k...] = v
    end
    return layout
end

# Some mappings:
#   Original Harmonic Table: ( 4, -3)
#   Rotated Harmonic Table:  ( 3,  4)
#   Wicki Hayden Layout:     ( 5,  7)
#   Linnstrument:            ( 4,  5)
