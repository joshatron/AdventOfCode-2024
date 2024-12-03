module Day03

export puzzle1, puzzle2

function puzzle1()
    validmul = r"mul\((\d\d?\d?),(\d\d?\d?)\)"
    commands = read("data/day_03.txt", String)
    total = 0
    for m in eachmatch(validmul, commands)
        total += parse(Int, m.captures[1]) * parse(Int, m.captures[2])
    end
    total
end

function puzzle2()
    validcommand = r"mul\((\d\d?\d?),(\d\d?\d?)\)|do\(\)|don't\(\)"
    commands = read("data/day_03.txt", String)
    total = 0
    enabled = true
    for m in eachmatch(validcommand, commands)
        if m.match == "do()"
            enabled = true
        elseif m.match == "don't()"
            enabled = false
        elseif enabled
            total += parse(Int, m.captures[1]) * parse(Int, m.captures[2])
        end
    end
    total
end

end