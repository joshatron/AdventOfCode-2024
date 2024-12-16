module Day15

export puzzle1, puzzle2

function puzzle1()
    warehouse = parsewarehouse()
    location = findfirst(l -> warehouse.warehouse[l] == '@', CartesianIndices(warehouse.warehouse))
    for i in warehouse.instructions
        location = processinstruction(warehouse, location, i)
    end
    coordinatesums(warehouse)
end

mutable struct Warehouse
    warehouse::Matrix
    instructions::Vector
end

function printwarehouse(warehouse)
    for x in 1:size(warehouse.warehouse, 1)
        for y in 1:size(warehouse.warehouse, 2)
            print(warehouse.warehouse[CartesianIndex(x, y)])
        end
        print("\n")
    end
end

function parsewarehouse()
    lines = readlines("data/day_15.txt")
    warehousepart = []
    instructions = ""
    inwarehouse = true
    for l in lines
        if l == ""
            inwarehouse = false
        elseif inwarehouse
            push!(warehousepart, l)
        else
            instructions = instructions * l
        end
    end
    Warehouse(convertwarehouse(warehousepart), convertinstructions(instructions))
end

function convertwarehouse(warehouse)
    reduce(vcat, permutedims.(collect.(warehouse)))
end

function convertinstructions(instructions)
    map(convertinstruction, collect(instructions))
end

function convertinstruction(instruction)
    if instruction == '^'
        CartesianIndex(-1, 0)
    elseif instruction == 'v'
        CartesianIndex(1, 0)
    elseif instruction == '<'
        CartesianIndex(0, -1)
    elseif instruction == '>'
        CartesianIndex(0, 1)
    else
        CartesianIndex(0, 0)
    end
end

function processinstruction(warehouse, location, instruction)
    if canmove(warehouse, location, instruction)
        move(warehouse, location, instruction)
        return location + instruction
    else
        return location
    end
end

function canmove(warehouse, location, instruction)
    while checkbounds(Bool, warehouse.warehouse, location)
        if warehouse.warehouse[location] == '.'
            return true
        elseif warehouse.warehouse[location] == '#'
            return false
        end
        location = location + instruction
    end
    false
end

function move(warehouse, location, instruction)
    warehouse.warehouse[location] = '.'
    next = '@'
    while next != '.'
        n = warehouse.warehouse[location + instruction]
        warehouse.warehouse[location + instruction] = next
        next = n
        location = location + instruction
    end
end

function coordinatesums(warehouse)
    sum(map(l -> (l[1]-1) * 100 + (l[2]-1), filter(l -> warehouse.warehouse[l] == 'O', CartesianIndices(warehouse.warehouse))))
end

function puzzle2()
    warehouse = parsewarehouse2()
    location = findfirst(l -> warehouse.warehouse[l] == '@', CartesianIndices(warehouse.warehouse))
    for i in warehouse.instructions
        location = processinstruction2(warehouse, location, i)
    end
    coordinatesums2(warehouse)
end

function parsewarehouse2()
    lines = readlines("data/day_15.txt")
    warehousepart = []
    instructions = ""
    inwarehouse = true
    for l in lines
        if l == ""
            inwarehouse = false
        elseif inwarehouse
            push!(warehousepart, reprocessline(l))
        else
            instructions = instructions * l
        end
    end
    Warehouse(convertwarehouse(warehousepart), convertinstructions(instructions))
end

function reprocessline(line)
    join(map(reprocessletter, collect(line)))
end

function reprocessletter(letter)
    if letter == '#'
        return "##"
    elseif letter == 'O'
        return "[]"
    elseif letter == '.'
        return ".."
    elseif letter == '@'
        return "@."
    else
        return ".."
    end
end

function processinstruction2(warehouse, location, instruction)
    if canmove2(warehouse, location, instruction)
        move2(warehouse, location, instruction)
        return location + instruction
    else
        return location
    end
end

function canmove2(warehouse, location, instruction)
    while checkbounds(Bool, warehouse.warehouse, location)
        if warehouse.warehouse[location] == '.'
            return true
        elseif warehouse.warehouse[location] == '#'
            return false
        elseif instruction[2] == 0 && warehouse.warehouse[location] == '[' && !canmove2(warehouse, location + CartesianIndex(0, 1) + instruction, instruction)
            return false
        elseif instruction[2] == 0 && warehouse.warehouse[location] == ']' && !canmove2(warehouse, location + CartesianIndex(0, -1) + instruction, instruction)
            return false
        end
        location = location + instruction
    end
    false
end

function move2(warehouse, location, instruction)
    nextlocation = location + instruction
    if instruction[2] == 0 && warehouse.warehouse[nextlocation] == '['
        move2(warehouse, nextlocation, instruction)
        move2(warehouse, nextlocation + CartesianIndex(0, 1), instruction)
    elseif instruction[2] == 0 && warehouse.warehouse[nextlocation] == ']'
        move2(warehouse, nextlocation, instruction)
        move2(warehouse, nextlocation + CartesianIndex(0, -1), instruction)
    elseif instruction[2] != 0 && warehouse.warehouse[nextlocation] != '.'
        move2(warehouse, nextlocation, instruction)
    end
    warehouse.warehouse[nextlocation] = warehouse.warehouse[location]
    warehouse.warehouse[location] = '.'
end

function coordinatesums2(warehouse)
    sum(map(l -> (l[1]-1) * 100 + (l[2]-1), filter(l -> warehouse.warehouse[l] == '[', CartesianIndices(warehouse.warehouse))))
end
    
end