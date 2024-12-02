module Day01

export puzzle1, puzzle2

function puzzle1()
    lines = readlines("data/day_01.txt")
    list1 = sort(parselist1(lines))
    list2 = sort(parselist2(lines))
    getdistances(list1, list2)
end

function parselist1(lines)
    map(s -> parse(Int, s[1:5]), lines)
end

function parselist2(lines)
    map(s -> parse(Int, s[9:13]), lines)
end

function getdistances(list1, list2)
    total = 0
    for i in eachindex(list1)
        total += abs(list1[i] - list2[i])
    end
    total
end

function puzzle2()
    lines = readlines("data/day_01.txt")
    list1 = sort(parselist1(lines))
    list2 = sort(parselist2(lines))
    getsimilaritytotal(list1, list2)
end

function getsimilaritytotal(list1, list2)
    total = 0
    for n in list1
        total += n * getsimilarityscore(n, list2)
    end
    total
end

function getsimilarityscore(number, list)
    total = 0
    for n in list
        if number == n
            total += 1
        end
    end
    total
end

end