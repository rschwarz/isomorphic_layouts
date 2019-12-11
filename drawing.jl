using Printf
using AbstractPlotting, CairoMakie
using ColorTypes

function make_scene(width=WIDTH, height=HEIGHT)
    return Scene(resolution=(width, height), show_axis=false, scale_plot=false)
end

hexwidth(size) = sqrt(3.0) * size
hexheight(size) = 2.0 * size

function hexagon!(coordinates, value)
    size = 100
    w, h = hexwidth(size), hexheight(size)
    center = coordinates .* [0.5*w 0.75*h]
    vertices = center .+ [
        0.0     0.50*h
        0.5*w   0.25*h
        0.5*w  -0.25*h
        0.0    -0.50*h
       -0.5*w  -0.25*h
       -0.5*w   0.25*h
    ]
    cx, cy = center
    points = [Point2f0(r) for r in eachrow(vertices)]

    note = value % 12
    octave = (value + 32) / (128 + 32)
    fillcolor = HSL(note * 360 / 12, 0.6, octave)
    poly!(points, strokewidth=2, strokecolor=:black, color=fillcolor)

    label = @sprintf("%02d ", value)
    text!(label, position=(cx - 35, cy - 15), textsize=30)
end

function draw_layout(layout)
    s = make_scene(400, 640)
    m, n = size(layout)
    for x in 1:n, y in 1:m
        value = layout[y, x]
        value != 0 || continue
        hexagon!([x (m - y)], value)
    end
    return s
end
