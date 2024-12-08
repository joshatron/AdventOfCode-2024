module Day08

export puzzle1, puzzle2

function puzzle1()
    map, nodes = parsemap()
    antinodes = findantinodes(map, nodes)
    length(antinodes)
end

function parsemap()
    map = reduce(vcat, permutedims.(collect.(readlines("data/day_08.txt"))))
    nodes = Dict()
    for i in CartesianIndices(map)
        if map[i] != '.'
            nodes[map[i]] = push!(get(nodes, map[i], []), i)
        end
    end
    (map, nodes)
end

function findantinodes(map, nodes)
    antinodes = Set()
    for (_, n) in nodes
        for a in eachindex(n)
            for b in eachindex(n)[a+1:end]
                antinode1 = n[a] - (n[b] - n[a])
                antinode2 = n[b] + (n[b] - n[a])
                if checkbounds(Bool, map, antinode1)
                    push!(antinodes, antinode1)
                end
                if checkbounds(Bool, map, antinode2)
                    push!(antinodes, antinode2)
                end
            end
        end
    end
    antinodes
end

function puzzle2()
    map, nodes = parsemap()
    antinodes = findresonantantinodes(map, nodes)
    length(antinodes)
end

function findresonantantinodes(map, nodes)
    antinodes = Set()
    for (_, n) in nodes
        for a in eachindex(n)
            for b in eachindex(n)[a+1:end]
                diff = n[b] - n[a]
                current = n[a]
                while checkbounds(Bool, map, current)
                    push!(antinodes, current)
                    current -= diff
                end
                current = n[b]
                while checkbounds(Bool, map, current)
                    push!(antinodes, current)
                    current += diff
                end
            end
        end
    end
    antinodes
end

end