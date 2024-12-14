module Day14

export puzzle1, puzzle2

function puzzle1()
    quadrants = [0,0,0,0]
    for robot in parserobots()
        finalquadrant = findfinalquadrant(robot, 101, 103, 100)
        if finalquadrant != 0
            quadrants[finalquadrant] += 1
        end
    end
    quadrants[1] * quadrants[2] * quadrants[3] * quadrants[4]
end

mutable struct Robot
    px::Int
    py::Int
    vx::Int
    vy::Int
end

function parserobots()
    map(parserobot, readlines("data/day_14.txt"))
end

function parserobot(line)
    parts = split(line, "=")
    position = parsenumberpair(split(parts[2], " ")[1])
    velocity = parsenumberpair(parts[3])
    Robot(position[1], position[2], velocity[1], velocity[2])
end

function parsenumberpair(pair)
    map(n -> parse.(Int, n), split(pair, ","))
end

function findfinalquadrant(robot, xsize, ysize, seconds)
    walkrobotforseconds(robot, xsize, ysize, seconds)
    getquadrant(robot, xsize, ysize)
end

function walkrobotforseconds(robot, xsize, ysize, seconds)
    startx = robot.px
    starty = robot.py
    secondsincycle = 0
    secondsleft = seconds
    while secondsleft > 0
        walkrobot(robot, xsize, ysize)
        secondsincycle += 1
        if robot.px == startx && robot.py == starty
            secondsleft = seconds % secondsincycle
            secondsincycle = 0
        else
            secondsleft -= 1
        end
    end
end

function walkrobot(robot, xsize, ysize)
    robot.px = (robot.px + robot.vx) % xsize
    while robot.px < 0
        robot.px = xsize + robot.px
    end
    robot.py = (robot.py + robot.vy) % ysize
    while robot.py < 0
        robot.py = ysize + robot.py
    end
end

function getquadrant(robot, xsize, ysize)
    middlex = xsize ÷ 2
    middley = ysize ÷ 2
    if robot.px < middlex && robot.py < middley
        return 1
    elseif robot.px > middlex && robot.py < middley
        return 2
    elseif robot.px < middlex && robot.py > middley
        return 3
    elseif robot.px > middlex && robot.py > middley
        return 4
    else
        return 0
    end
end

function puzzle2()
    robots = parserobots()
    xcycle = 0
    ycycle = 0
    for i in 1:103
        for robot in robots
            walkrobot(robot, 101, 103)
        end
        if islowxvariance(robots, 101)
            xcycle = i
        end
        if islowyvariance(robots, 103)
            ycycle = i
        end
    end
    xcycle + ((invmod(101, 103)*(ycycle-xcycle)) % 103) * 101
end

function islowxvariance(robots, xsize)
    maxx = 0
    for x in 0:(xsize-1)
        maxx = max(maxx, length(filter(r -> r.px == x, robots)))
    end
    maxx > 20
end

function islowyvariance(robots, ysize)
    maxy = 0
    for y in 0:(ysize-1)
        maxy = max(maxy, length(filter(r -> r.py == y, robots)))
    end
    maxy > 20
end

function printrobots(robots, xsize, ysize)
    for y in 0:(ysize-1)
        for x in 0:(xsize-1)
            if robotinspot(x, y, robots)
                print("#")
            else
                print(" ")
            end
        end
        print("\n")
    end
end

function robotinspot(x, y, robots)
    any(r -> r.px == x && r.py == y, robots)
end

end