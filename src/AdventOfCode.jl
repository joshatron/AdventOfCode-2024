module AdventOfCode

include("Day01.jl")

import .Day01

function main()
    println("Day 01")
    println("  puzzle 1: $(Day01.puzzle1())")
    println("  puzzle 1: $(Day01.puzzle2())")
end

end

AdventOfCode.main()
