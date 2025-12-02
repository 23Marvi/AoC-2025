local function part1()
    local file = io.open("inputs/day_02.txt", "r")
    local content = file:read("*all"):gsub("\n", "")
    local sum = 0;
    file:close()

    for line in content:gmatch("[^,]+") do
        local firstId, lastId = line:match("(%d+)-(%d+)")
        for i=tonumber(firstId), tonumber(lastId) do
            local iString = tostring(i)
            if #iString % 2 == 0 then
                local i1, i2 = iString:sub(1, #iString / 2), iString:sub(#iString / 2 + 1, #iString)
                if i1 == i2 then sum = sum + iString end
            end
        end
    end

    print("Solution 1: " .. sum)
end

local function part2()
    local file = io.open("inputs/day_02.txt", "r")
    local content = file:read("*all"):gsub("\n", "")
    local sum = 0
    file:close()

    for line in content:gmatch("[^,]+") do
        local firstId, lastId = line:match("(%d+)-(%d+)")
        for i=tonumber(firstId), tonumber(lastId) do
            local iString = tostring(i)
            for j=1, math.floor(#iString / 2) do
                if #iString % j == 0 then
                    local pattern = iString:sub(1, j)
                    local repeated = pattern:rep(#iString / j)
                    if repeated == iString then sum = sum + iString break end
                end
            end
        end
    end

    print("Solution 2: " .. sum)
end

part1()
part2()