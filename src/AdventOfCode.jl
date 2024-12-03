module AdventOfCode

include("Day01.jl")
include("Day02.jl")
include("Day03.jl")

import .Day01, .Day02, .Day03

function main()
    println("Day 01")
    println("  puzzle 1: $(Day01.puzzle1()) (2066446)")
    println("  puzzle 1: $(Day01.puzzle2()) (24931009)")
    println("Day 02")
    println("  puzzle 1: $(Day02.puzzle1()) (326)")
    println("  puzzle 1: $(Day02.puzzle2()) (381)")
    println("Day 03")
    println("  puzzle 1: $(Day03.puzzle1()) (173731097)")
    println("  puzzle 1: $(Day03.puzzle2()) (93729253)")
end

end

AdventOfCode.main()
