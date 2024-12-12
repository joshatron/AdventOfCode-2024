module Day11

export puzzle1, puzzle2

function puzzle1()
    stones = map(n -> parse.(Int, n), split(readlines("data/day_11.txt")[1], " "))
    total = 0
    memo = Dict()
    for stone in stones
        total += stonesfromblinks(stone, 25, memo)
    end
    total

end

function puzzle2()
    stones = map(n -> parse.(Int, n), split(readlines("data/day_11.txt")[1], " "))
    total = 0
    memo = Dict()
    for stone in stones
        total += stonesfromblinks(stone, 75, memo)
    end
    total
end

function stonesfromblinks(stone, blinks, memo)
    if blinks == 0
        return 1
    end
    if haskey(memo, (stone, blinks))
        return memo[(stone, blinks)]
    end

    if stone == 0
        stones = stonesfromblinks(1, blinks - 1, memo)
        memo[(stone, blinks)] = stones
        return stones
    elseif (floor(Int, log10(stone)) + 1) % 2 == 0
        digits = floor(Int, log10(stone)) + 1
        first = floor(Int, stone / 10^(digits / 2))
        second = floor(Int, stone % 10^(digits / 2))
        stones = stonesfromblinks(first, blinks - 1, memo) + stonesfromblinks(second, blinks - 1, memo)
        memo[(stone, blinks)] = stones
        return stones
    else
        stones = stonesfromblinks(stone * 2024, blinks - 1, memo)
        memo[(stone, blinks)] = stones
        return stones
    end
end

end