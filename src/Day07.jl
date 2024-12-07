module Day07

export puzzle1, puzzle2

function puzzle1()
    equations = parseequations()
    total = 0
    for equation in equations
        if issolvable(equation)
            total += equation[1]
        end
    end
    total
end

function parseequations()
    map(toequation, readlines("data/day_07.txt"))
end

function toequation(line)
    parts = split(line, " ")
    (parse.(Int, parts[1][1:end-1]), map(n -> parse.(Int, n), parts[2:end]))
end

function issolvable(equation)
    recursesolvable((equation[1], equation[2][2:end]), equation[2][1])
end

function recursesolvable(equation, runningtotal)
    if (runningtotal > equation[1])
        return false
    end

    if length(equation[2]) == 0
        return runningtotal == equation[1]
    end

    recursesolvable((equation[1], equation[2][2:end]), runningtotal + equation[2][1]) || recursesolvable((equation[1], equation[2][2:end]), runningtotal * equation[2][1])
end

function puzzle2()
    equations = parseequations()
    total = 0
    for equation in equations
        if issolvable2(equation)
            total += equation[1]
        end
    end
    total
end

function issolvable2(equation)
    recursesolvable2((equation[1], equation[2][2:end]), equation[2][1])
end

function recursesolvable2(equation, runningtotal)
    if (runningtotal > equation[1])
        return false
    end

    if length(equation[2]) == 0
        return runningtotal == equation[1]
    end

    recursesolvable2((equation[1], equation[2][2:end]), runningtotal + equation[2][1]) || 
    recursesolvable2((equation[1], equation[2][2:end]), runningtotal * equation[2][1]) ||
    recursesolvable2((equation[1], equation[2][2:end]), parse.(Int, string(runningtotal, equation[2][1])))
end

end