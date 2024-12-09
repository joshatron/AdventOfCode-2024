module Day09

export puzzle1, puzzle2

function puzzle1()
    blocks = parseblocksizes()
    calculatechecksum(blocks)
end

function parseblocksizes()
    map(n -> parse.(Int, n), collect.(readlines("data/day_09.txt"))[1])
end

function calculatechecksum(blocks)
    checksum = 0
    currentblock = 0
    frontposition = 1
    frontpositionleft = blocks[1]
    backposition = length(blocks)
    backpositionleft = blocks[end]
    onspace = false

    while frontposition < backposition
        if !onspace
            if frontpositionleft > 0
                checksum += currentblock * ((frontposition - 1) ÷ 2)
                currentblock += 1
                frontpositionleft -= 1
            else
                frontposition += 1
                frontpositionleft = blocks[frontposition]
                onspace = true
            end
        else
            if frontpositionleft > 0
                if backpositionleft > 0
                    checksum += currentblock * ((backposition - 1) ÷ 2)
                    currentblock += 1
                    frontpositionleft -= 1
                    backpositionleft -= 1
                else
                    backposition -= 2
                    backpositionleft = blocks[backposition]
                end
            else
                frontposition += 1
                frontpositionleft = blocks[frontposition]
                onspace = false
            end
        end
    end

    if !onspace
        while backpositionleft > 0
            checksum += currentblock * ((backposition - 1) ÷ 2)
            currentblock += 1
            backpositionleft -= 1
        end
    end

    checksum
end

function puzzle2()
    drive = constructharddrive(parseblocksizes())
    reformatdrive(drive)
    calculatechecksum2(drive)
end

function constructharddrive(blocks)
    drive = []
    onspace = false
    id = 0

    for block in blocks
        if onspace
            push!(drive, fill(-1, block)...)
        else
            push!(drive, fill(id, block)...)
            id += 1
        end
        onspace = !onspace
    end
    
    drive
end

function reformatdrive(drive)
    i = length(drive)
    while i > 0
        if drive[i] == -1
            i -= 1
        end

        filevalue = drive[i]
        filesize = 0
        while i > 0 && drive[i] == filevalue
            filesize += 1
            i -= 1
        end

        if tryinsertingfileindrive(drive, filevalue, filesize)
            j = i + 1
            while j <= length(drive) && drive[j] == filevalue
                drive[j] = -1
                j += 1
            end
        end
    end
end

function tryinsertingfileindrive(drive, filevalue, filesize)
    i = 1
    while drive[i] != filevalue
        if drive[i] == -1
            gapsize = getgapsize(drive, i)
            if gapsize >= filesize
                for j in i:(i+filesize-1)
                    drive[j] = filevalue
                end
                return true
            else
                i += gapsize
            end
        else
            i += 1
        end
    end
    false
end

function getgapsize(drive, start)
    i = start
    while drive[i] == -1
        i += 1
    end
    return i - start
end

function calculatechecksum2(drive)
    checksum = 0

    for i in eachindex(drive)
        if drive[i] != -1
            checksum += (i-1) * drive[i]
        end
    end

    checksum
end

end