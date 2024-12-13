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
    bmax = inlessorequal(machine.bx, machine.prizex)
    bs = logfindbs(machine, 0, bmax)
    if bs == 0
        return 0
    else
        as = inlessorequal(machine.ax, machine.prizex - (machine.bx * bs))
        return bs + (as * 3)
    end
end

function logfindbs(machine, bmin, bmax)
    bmid = (bmax + bmin) ÷ 2
    anum = inlessorequal(machine.ax, machine.prizex - (machine.bx * bmid))
    anummax = inlessorequal(machine.ax, machine.prizex - (machine.bx * bmax))

    if (machine.bx * bmid + machine.ax * anum == machine.prizex) && (machine.by * bmid + machine.ay * anum == machine.prizey)
        return bmid
    elseif bmax - bmin <= 100
        for bs in bmax:-1:bmin
            as = inlessorequal(machine.ax, machine.prizex - (machine.bx * bs))
            if (machine.bx * bs + machine.ax * as == machine.prizex) && (machine.by * bs + machine.ay * as == machine.prizey)
                return bs
            end
        end
        return 0
    elseif (machine.by * bmid + machine.ay * anum < machine.prizey) == (machine.by * bmax + machine.ay * anummax < machine.prizey)
        return logfindbs(machine, bmin, bmid)
    else
        return logfindbs(machine, bmid, bmax)
    end
end

function inlessorequal(num, target)
    floor(Int, target / num)
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