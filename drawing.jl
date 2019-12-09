using Printf
using AbstractPlotting, CairoMakie

function make_scene(width=WIDTH, height=HEIGHT)
    return Scene(resolution=(width, height), show_axis=false, scale_plot=false)
end

hexwidth(size) = sqrt(3.0) * size
hexheight(size) = 2.0 * size

function hexagon!(coordinates, label)
    size = 100
    w, h = hexwidth(size), hexheight(size)
    points = [
        0.0     0.50*h
        0.5*w   0.25*h
        0.5*w  -0.25*h
        0.0    -0.50*h
       -0.5*w  -0.25*h
       -0.5*w   0.25*h
        0.0     0.50*h
    ]
    center = coordinates .* [0.5*w 0.75*h]
    cx, cy = center
    lines!(center .+ points)
    text!(label, position=(cx - 35, cy - 15), textsize=30)
end

function draw_layout(layout)
    s = make_scene(400, 640)
    m, n = size(layout)
    for x in 1:n, y in 1:m
        value = layout[y, x]
        value != 0 || continue
        label = @sprintf("%02d ", value)
        hexagon!([x (m - y)], label)
    end
    return s
end
