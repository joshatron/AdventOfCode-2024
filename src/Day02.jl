module Day02

export puzzle1, puzzle2

function puzzle1()
    length(filter(r -> isreportsafe(r), parsereports()))
end

function parsereports()
    map(l -> parse.(Int, split(l)), readlines("data/day_02.txt"))
end

function isreportsafe(report)
    increasing = report[2] > report[1]
    for i in eachindex(report)[2:end]
        if !isdiffsafe(report[i-1], report[i], increasing)
            return false
        end 
    end
    true
end

function isdiffsafe(first, second, increasing)
    diff = second - first 
    diff != 0 && abs(diff) <= 3 && ((diff > 0 && increasing) || (diff < 0 && !increasing))
end

function puzzle2()
    length(filter(r -> isreportsafewithdampener(r), parsereports()))
end

function isreportsafewithdampener(report)
    if isreportsafe(report)
        return true
    end

    for i in eachindex(report)
        if isreportsafe([report[1:i-1]; report[i+1:end]])
            return true
        end
    end
    false
end

end