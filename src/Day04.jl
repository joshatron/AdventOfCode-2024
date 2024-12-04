module Day04

using LinearAlgebra

export puzzle1, puzzle2

function puzzle1()
    letters = parselettergrid()
    checkhorizontalmatches(letters) + checkhorizontalmatches(rotl90(letters)) + 
    checkdiagonalmatches(letters) + checkdiagonalmatches(rotl90(letters))
end

function parselettergrid()
    reduce(vcat, permutedims.(collect.(readlines("data/day_04.txt"))))
end

function checkhorizontalmatches(letters)
    total = 0
    for row in eachrow(letters)
        total += countrowformatches(row)
    end
    total
end

function checkdiagonalmatches(letters)
    total = 0
    s = maximum(size(letters))
    for i in (s*-1):s
        total += countrowformatches(diag(letters, i))
    end
    total
end

function countrowformatches(row)
    total = 0
    for i in eachindex(row)[1:end-3]
        if (row[i] == 'X' && row[i+1] == 'M' && row[i+2] == 'A' && row[i+3] == 'S') ||
           (row[i] == 'S' && row[i+1] == 'A' && row[i+2] == 'M' && row[i+3] == 'X')
            total += 1
        end
    end
    total
end

function puzzle2()
    letters = parselettergrid()
    countcrossedmas(letters)
end

function countcrossedmas(letters)
    total = 0
    for i in 1:(size(letters, 1)-2)
        for j in 1:(size(letters, 2)-2)
            if iscrossedmas(letters[i:(i+2),j:(j+2)])
                total += 1
            end
        end
    end
    total
end

function iscrossedmas(threebythree)
    (hasforwarddiagonalmas(threebythree) && hasbackwarddiagonalmas(threebythree))
end

function hasforwarddiagonalmas(threebythree)
    (threebythree[1,3] == 'M' && threebythree[2,2] == 'A' && threebythree[3,1] == 'S') ||
    (threebythree[1,3] == 'S' && threebythree[2,2] == 'A' && threebythree[3,1] == 'M')
end

function hasbackwarddiagonalmas(threebythree)
    (threebythree[1,1] == 'M' && threebythree[2,2] == 'A' && threebythree[3,3] == 'S') ||
    (threebythree[1,1] == 'S' && threebythree[2,2] == 'A' && threebythree[3,3] == 'M')
end

end