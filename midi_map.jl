# Generate configuration files for the LV2 plugin x42-midimap.
#
# For documentation of the format, see
# https://github.com/x42/midimap.lv2/blob/master/cfg/doc.cfg

function write_config(io::IO, mapping::Vector{Int})
    # version of midimap format
    println(io, "midimap v1")

    # only forward matched events
    # println(io, "forward-unmatched")

    # for each note in the mapping, add a separate rule
    for (origin, target) in enumerate(mapping)
        # Match specific number not any channel.
        # Replace with other note number, keep everything else same.
        println(io, "NOTE $(origin) ANY | SAME $(target) SAME")
    end
end

function write_config(filename::String, mapping::Vector{Int})
    open(filename, "w") do io
        write_config(io, mapping)
    end
end
