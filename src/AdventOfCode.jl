module AdventOfCode

include("Day01.jl")
include("Day02.jl")
include("Day03.jl")
include("Day04.jl")
include("Day05.jl")
include("Day06.jl")
include("Day07.jl")

import .Day01, .Day02, .Day03, .Day04, .Day05, .Day06, .Day07

function main()
    println("Day 01")
    println("  puzzle 1: $(Day01.puzzle1()) (2066446)")
    println("  puzzle 2: $(Day01.puzzle2()) (24931009)")
    println("Day 02")
    println("  puzzle 1: $(Day02.puzzle1()) (326)")
    println("  puzzle 2: $(Day02.puzzle2()) (381)")
    println("Day 03")
    println("  puzzle 1: $(Day03.puzzle1()) (173731097)")
    println("  puzzle 2: $(Day03.puzzle2()) (93729253)")
    println("Day 04")
    println("  puzzle 1: $(Day04.puzzle1()) (2406)")
    println("  puzzle 2: $(Day04.puzzle2()) (1807)")
    println("Day 05")
    println("  puzzle 1: $(Day05.puzzle1()) (5639)")
    println("  puzzle 2: $(Day05.puzzle2()) (5273)")
    println("Day 06")
    println("  puzzle 1: $(Day06.puzzle1()) (5404)")
    println("  puzzle 2: $(Day06.puzzle2()) (1984)")
    println("Day 07")
    println("  puzzle 1: $(Day07.puzzle1()) (882304362421)")
    println("  puzzle 2: $(Day07.puzzle2()) (145149066755184)")
end

end

AdventOfCode.main()
