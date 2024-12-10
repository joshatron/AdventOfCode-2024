module Day10

export puzzle1, puzzle2

function puzzle1()
    topo = parsetopology()

    total = 0
    for i in CartesianIndices(topo)
        if topo[i] == 0
            total += length(gettrailheadscore(topo, i))
        end
    end
    total
end

function gettrailheadscore(topo, start)
    if topo[start] == 9
        return Set([start])
    end

    total = Set()
    above = start + CartesianIndex(-1, 0)
    if checkbounds(Bool, topo, above) && topo[above] == topo[start] + 1
        union!(total, gettrailheadscore(topo, above))
    end
    below = start + CartesianIndex(1, 0)
    if checkbounds(Bool, topo, below) && topo[below] == topo[start] + 1
        union!(total, gettrailheadscore(topo, below))
    end
    left = start + CartesianIndex(0, -1)
    if checkbounds(Bool, topo, left) && topo[left] == topo[start] + 1
        union!(total, gettrailheadscore(topo, left))
    end
    right = start + CartesianIndex(0, 1)
    if checkbounds(Bool, topo, right) && topo[right] == topo[start] + 1
        union!(total, gettrailheadscore(topo, right))
    end
    total
end

function parsetopology()
    map(n -> parse.(Int, n), reduce(vcat, permutedims.(collect.(readlines("data/day_10.txt")))))
end

function puzzle2()
    topo = parsetopology()

    total = 0
    for i in CartesianIndices(topo)
        if topo[i] == 0
            total += gettrailheadrating(topo, i)
        end
    end
    total
end

function gettrailheadrating(topo, start)
    if topo[start] == 9
        return 1
    end

    total = 0
    above = start + CartesianIndex(-1, 0)
    if checkbounds(Bool, topo, above) && topo[above] == topo[start] + 1
        total += gettrailheadrating(topo, above)
    end
    below = start + CartesianIndex(1, 0)
    if checkbounds(Bool, topo, below) && topo[below] == topo[start] + 1
        total += gettrailheadrating(topo, below)
    end
    left = start + CartesianIndex(0, -1)
    if checkbounds(Bool, topo, left) && topo[left] == topo[start] + 1
        total += gettrailheadrating(topo, left)
    end
    right = start + CartesianIndex(0, 1)
    if checkbounds(Bool, topo, right) && topo[right] == topo[start] + 1
        total += gettrailheadrating(topo, right)
    end
    total
end


end