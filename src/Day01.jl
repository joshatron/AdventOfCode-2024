module Day01

using DelimitedFiles

export puzzle1, puzzle2

function puzzle1()
    lists = readdlm("data/day_01.txt", Int)
    getdistances(sort(lists[:,1]), sort(lists[:,2]))
end

function getdistances(list1, list2)
    total = 0
    for i in eachindex(list1)
        total += abs(list1[i] - list2[i])
    end
    total
end

function puzzle2()
    lists = readdlm("data/day_01.txt", Int)
    list1 = lists[:,1]
    list2occurences = listtooccurencehashmap(lists[:,2])
    getsimilaritytotal(list1, list2occurences)
end

function listtooccurencehashmap(list)
    occurences = Dict()
    for l in list
        occurences[l] = get(occurences, l, 0) + 1
    end
    occurences
end

function getsimilaritytotal(list1, list2occurences)
    total = 0
    for n in list1
        total += n * get(list2occurences, n, 0)
    end
    total
end

end