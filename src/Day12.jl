module Day12

export puzzle1, puzzle2

function puzzle1()
    farm = parselettergrid()
    price = 0
    visited = Set()
    for point in CartesianIndices(farm)
        if !(point in visited)
            price += priceplot(farm, point, visited)
        end
    end
    price
end

function parselettergrid()
    reduce(vcat, permutedims.(collect.(readlines("data/day_12.txt"))))
end

function priceplot(farm, start, visited)
    area, perimeter = areaandperimeterplot(farm, start, visited)
    area * perimeter
end

function areaandperimeterplot(farm, start, visited)
    push!(visited, start)
    area = 1
    perimeter = getperimeter(farm, start)

    if checkbounds(Bool, farm, start + CartesianIndex(-1, 0)) && !(start + CartesianIndex(-1, 0) in visited) && farm[start] == farm[start + CartesianIndex(-1, 0)]
        a, p = areaandperimeterplot(farm, start + CartesianIndex(-1, 0), visited)
        area += a
        perimeter += p
    end
    if checkbounds(Bool, farm, start + CartesianIndex(1, 0)) && !(start + CartesianIndex(1, 0) in visited) && farm[start] == farm[start + CartesianIndex(1, 0)]
        a, p = areaandperimeterplot(farm, start + CartesianIndex(1, 0), visited)
        area += a
        perimeter += p
    end
    if checkbounds(Bool, farm, start + CartesianIndex(0, -1)) && !(start + CartesianIndex(0, -1) in visited) && farm[start] == farm[start + CartesianIndex(0, -1)]
        a, p = areaandperimeterplot(farm, start + CartesianIndex(0, -1), visited)
        area += a
        perimeter += p
    end
    if checkbounds(Bool, farm, start + CartesianIndex(0, 1)) && !(start + CartesianIndex(0, 1) in visited) && farm[start] == farm[start + CartesianIndex(0, 1)]
        a, p = areaandperimeterplot(farm, start + CartesianIndex(0, 1), visited)
        area += a
        perimeter += p
    end

    (area, perimeter)
end

function getperimeter(farm, point)
    l = farm[point]

    edges = 0
    if !checkbounds(Bool, farm, point + CartesianIndex(-1, 0)) || l != farm[point + CartesianIndex(-1, 0)]
        edges += 1
    end
    if !checkbounds(Bool, farm, point + CartesianIndex(1, 0)) || l != farm[point + CartesianIndex(1, 0)]
        edges += 1
    end
    if !checkbounds(Bool, farm, point + CartesianIndex(0, -1)) || l != farm[point + CartesianIndex(0, -1)]
        edges += 1
    end
    if !checkbounds(Bool, farm, point + CartesianIndex(0, 1)) || l != farm[point + CartesianIndex(0, 1)]
        edges += 1
    end
    edges
end

function puzzle2()
    farm = parselettergrid()
    price = 0
    visited = Set()
    for point in CartesianIndices(farm)
        if !(point in visited)
            price += priceplot2(farm, point, visited)
        end
    end
    price

end

function priceplot2(farm, start, visited)
    area, corners = areaandcornersplot(farm, start, visited)
    area * corners
end

function areaandcornersplot(farm, start, visited)
    push!(visited, start)
    area = 1
    corners = getcorners(farm, start)

    if checkbounds(Bool, farm, start + CartesianIndex(-1, 0)) && !(start + CartesianIndex(-1, 0) in visited) && farm[start] == farm[start + CartesianIndex(-1, 0)]
        a, c = areaandcornersplot(farm, start + CartesianIndex(-1, 0), visited)
        area += a
        corners += c
    end
    if checkbounds(Bool, farm, start + CartesianIndex(1, 0)) && !(start + CartesianIndex(1, 0) in visited) && farm[start] == farm[start + CartesianIndex(1, 0)]
        a, c = areaandcornersplot(farm, start + CartesianIndex(1, 0), visited)
        area += a
        corners += c
    end
    if checkbounds(Bool, farm, start + CartesianIndex(0, -1)) && !(start + CartesianIndex(0, -1) in visited) && farm[start] == farm[start + CartesianIndex(0, -1)]
        a, c = areaandcornersplot(farm, start + CartesianIndex(0, -1), visited)
        area += a
        corners += c
    end
    if checkbounds(Bool, farm, start + CartesianIndex(0, 1)) && !(start + CartesianIndex(0, 1) in visited) && farm[start] == farm[start + CartesianIndex(0, 1)]
        a, c = areaandcornersplot(farm, start + CartesianIndex(0, 1), visited)
        area += a
        corners += c
    end

    (area, corners)
end

function getcorners(farm, point)
    l = farm[point]

    edges = 0
    if notsame(farm, l, point + CartesianIndex(-1, 0)) && notsame(farm, l, point + CartesianIndex(0, -1))
        edges += 1
    end
    if notsame(farm, l, point + CartesianIndex(-1, 0)) && notsame(farm, l, point + CartesianIndex(0, 1))
        edges += 1
    end
    if notsame(farm, l, point + CartesianIndex(1, 0)) && notsame(farm, l, point + CartesianIndex(0, -1))
        edges += 1
    end
    if notsame(farm, l, point + CartesianIndex(1, 0)) && notsame(farm, l, point + CartesianIndex(0, 1))
        edges += 1
    end
    if same(farm, l, point + CartesianIndex(-1, 0)) && same(farm, l, point + CartesianIndex(0, -1)) && notsame(farm, l, point + CartesianIndex(-1, -1))
        edges += 1
    end
    if same(farm, l, point + CartesianIndex(-1, 0)) && same(farm, l, point + CartesianIndex(0, 1)) && notsame(farm, l, point + CartesianIndex(-1, 1))
        edges += 1
    end
    if same(farm, l, point + CartesianIndex(1, 0)) && same(farm, l, point + CartesianIndex(0, -1)) && notsame(farm, l, point + CartesianIndex(1, -1))
        edges += 1
    end
    if same(farm, l, point + CartesianIndex(1, 0)) && same(farm, l, point + CartesianIndex(0, 1)) && notsame(farm, l, point + CartesianIndex(1, 1))
        edges += 1
    end
    edges
end

function same(farm, letter, other)
    checkbounds(Bool, farm, other) && letter == farm[other]
end

function notsame(farm, letter, other)
    !checkbounds(Bool, farm, other) || letter != farm[other]
end

end