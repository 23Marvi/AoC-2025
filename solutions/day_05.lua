local function mergeRanges(ranges)
    local merged = true
    while merged do
        merged = false
        for i = 1, #ranges do
            for j = i + 1, #ranges do
                if (ranges[i][1] <= ranges[j][2] and ranges[i][2] >= ranges[j][1]) then
                    local lowestFirstId = math.min(ranges[i][1], ranges[j][1])
                    local highestLastId = math.max(ranges[i][2], ranges[j][2])
                    ranges[i] = {lowestFirstId, highestLastId}
                    table.remove(ranges, j)
                    merged = true
                    break
                end
            end
            if merged then break end
        end
    end
    return ranges
end

local function solve(part)
    local file = io.open("inputs/day_05.txt", "r")
    local content = file:read("*all")
    file:close()
    local ranges = {}
    local freshIds = {}
    local solution = 0

    for line in content:gmatch("[^\n]+") do
        if line:find("-") then
            local firstId, lastId = line:match("(%d+)-(%d+)")
            firstId = tonumber(firstId)
            lastId = tonumber(lastId)
            table.insert(ranges, {firstId, lastId})
        elseif (part == 1) then
            local id = tonumber(line)

            for _, range in ipairs(ranges) do
                if id >= range[1] and id <= range[2] then
                    solution = solution + 1
                    break
                end
            end
        end
    end

    if part == 2 then
        ranges = mergeRanges(ranges)
        for _, range in ipairs(ranges) do
            solution = solution + (range[2] - range[1] + 1)
        end
    end

    print("Solution " .. part .. ": " .. solution)
end

local timer = require("timer")
timer.time(function() solve(1) end, "part 1")
timer.time(function() solve(2) end, "part 2")