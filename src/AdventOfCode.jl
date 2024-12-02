module AdventOfCode

include("Day01.jl")
include("Day02.jl")

import .Day01, .Day02

function main()
    println("Day 01")
    println("  puzzle 1: $(Day01.puzzle1())")
    println("  puzzle 1: $(Day01.puzzle2())")
    println("Day 02")
    println("  puzzle 1: $(Day02.puzzle1())")
    println("  puzzle 1: $(Day02.puzzle2())")
end

end

AdventOfCode.main()
