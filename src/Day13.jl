module Day13

export puzzle1, puzzle2

function puzzle1()
    sum(map(wincost, parsemachines()))
end

mutable struct Machine
    ax::Int
    ay::Int
    bx::Int
    by::Int
    prizex::Int
    prizey::Int
end

function parsemachines()
    machines = []
    lines = readlines("data/day_13.txt")
    i = 1
    while i < length(lines)
        ax, ay = readbuttonline(lines[i])
        bx, by = readbuttonline(lines[i+1])
        prizex, prizey = readprizeline(lines[i+2])
        push!(machines, Machine(ax, ay, bx, by, prizex, prizey))
        i += 4
    end
    machines
end

function readbuttonline(line)
    xwithstuff = split(line, "+")[2]
    x = split(xwithstuff, ",")[1]
    y = split(line, "+")[3]
    (parse.(Int, x), parse.(Int, y))
end

function readprizeline(line)
    xwithstuff = split(line, "=")[2]
    x = split(xwithstuff, ",")[1]
    y = split(line, "=")[3]
    (parse.(Int, x), parse.(Int, y))
end

function wincost(machine)
    a = (machine.prizex*machine.by - machine.prizey*machine.bx) ÷ (machine.ax*machine.by - machine.ay*machine.bx)
    b = (machine.prizey*machine.ax - machine.prizex*machine.ay) ÷ (machine.ax*machine.by - machine.ay*machine.bx)

    if (machine.bx * b + machine.ax * a == machine.prizex) && (machine.by * b + machine.ay * a == machine.prizey)
        return b + (a * 3)
    end
    0
end

function puzzle2()
    sum(map(wincost, map(adjustmachine, parsemachines())))
end

function adjustmachine(machine)
    machine.prizex += 10000000000000
    machine.prizey += 10000000000000
    machine
end

end