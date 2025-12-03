local function part1()
    local pos = 50
    local timesZero = 0

    for line in io.lines("inputs/day_01.txt") do
        local direction = line:match("%a")
        local step = tonumber(line:match("%d+"))

        if direction == 'L' then
            pos = pos - step
        elseif direction == 'R' then
            pos = pos + step
        end
        pos = pos % 100

        if pos == 0 then timesZero = timesZero + 1 end
    end

    print("Solution 1: " .. timesZero)
end

local function part2()
    local pos = 50
    local totalWraps = 0

    for line in io.lines("inputs/day_01.txt") do
        local direction = line:match("%a")
        local step = line:match("%d+")
        local wraps = 0
        local prevpos = pos

        if direction == 'L' then
            pos = pos - step

            if (prevpos ~= 0) or (prevpos == 0 and tonumber(step) > 99) then
                wraps = math.abs(math.floor((pos - 1) / 100))
            end

            if (prevpos == 0 and tonumber(step) > 99) then
                wraps = wraps - 1
            end
        elseif direction == 'R' then
            pos = pos + step

            if (prevpos ~= 0) or (prevpos == 0 and tonumber(step) > 99) then
                wraps = math.abs(math.floor(pos / 100))
            end
        end
        pos = pos % 100
        totalWraps = totalWraps + wraps
        -- print(line, "->", prevpos, "to", pos, "wraps:", wraps)
    end

    print("Solution 2: " .. totalWraps)
end

local timer = require("timer")
timer.time(part1, "part 1")
timer.time(part2, "part 2")