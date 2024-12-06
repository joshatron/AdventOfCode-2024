module Day06

export puzzle1, puzzle2

function puzzle1()
    map = parsemap()
    current = findstartingpoint(map)
    visited = Set()

    while checkbounds(Bool, map, current[1])
        push!(visited, current[1])
        current = movetonextlocation(map, current)
    end

    length(visited)
end

function parsemap()
    reduce(vcat, permutedims.(collect.(readlines("data/day_06.txt"))))
end

@enum DIR north south east west

function findstartingpoint(map)
    (findfirst(l -> l == '^', map), north)
end

function movetonextlocation(map, current)
    if checkbounds(Bool, map, moveone(current)) && map[moveone(current)] == '#'
        return (current[1], rotateright(current[2]))
    end
    (moveone(current), current[2])
end

function moveone(current)
    if current[2] == north
        return current[1] + CartesianIndex(-1, 0)
    elseif current[2] == east
        return current[1] + CartesianIndex(0, 1)
    elseif current[2] == south
        return current[1] + CartesianIndex(1, 0)
    else
        return current[1] + CartesianIndex(0, -1)
    end
end

function rotateright(dir)
    if dir == north
        return east
    elseif dir == east
        return south
    elseif dir == south
        return west
    else
        return north
    end
end

function puzzle2()
    map = parsemap()
    current = findstartingpoint(map)
    visited = Set()
    obstacles = Set()

    while checkbounds(Bool, map, current[1])
        push!(visited, current[1])
        if (checkbounds(Bool, map, moveone(current)) && map[moveone(current)] != '#' && !(moveone(current) in visited)) && checkifrightvisited(map, current)
            push!(obstacles, moveone(current))
        end
        current = movetonextlocation(map, current)
    end

    length(obstacles)
end

function checkifrightvisited(map, current)
    obstacle = moveone(current)
    visited = Set()
    push!(visited, current)
    current = (current[1], rotateright(current[2]))
    while checkbounds(Bool, map, current[1])
        if current in visited
            return true
        end
        push!(visited, current)
        next = movetonextlocation(map, current)
        if next[1] == obstacle
            current = (current[1], rotateright(current[2]))
        else
            current = next
        end
    end
    false
end

end