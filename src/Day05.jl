module Day05

export puzzle1, puzzle2

function puzzle1()
    rules, printings = parseinput()

    total = 0
    for printing in printings
        if isvalidorder(printing, rules)
            total += getmiddlevalue(printing)
        end
    end
    total
end

function parseinput()
    lines = readlines("data/day_05.txt")
    rules = Set()
    printings = []

    onrules = true
    for l in lines
        if l == ""
            onrules = false
        elseif onrules
            push!(rules, map(n -> parse.(Int, n), split(l, "|")))
        else
            push!(printings, map(n -> parse.(Int, n), split(l, ",")))
        end
    end

    (rules, printings)
end

function isvalidorder(printing, rules)
    for r in generateinverserules(printing)
        if r in rules
            return false
        end
    end
    true
end

function generateinverserules(printing)
    inverserules = []
    for i in eachindex(printing)
        for j in eachindex(printing)[i+1:end]
            push!(inverserules, [printing[j], printing[i]])
        end
    end
    inverserules
end

function getmiddlevalue(printing)
    printing[(length(printing) ÷ 2) + 1]
end

function puzzle2()
    rules, printings = parseinput()

    total = 0
    for printing in printings
        if !isvalidorder(printing, rules)
            total += getmiddlevalue(fixprintingorder(printing, rules))
        end
    end
    total
end

function fixprintingorder(printing, rules)
    sort(printing, lt=(a, b) -> [a, b] in rules)
end

end