local function getSurroundingRolls(content, i, lineLength)
    local surroundingRolls = 0
    local lineIndex = i % lineLength

    local function isFirstRow() return i <= lineLength end
    local function isLastRow() return i > #content - lineLength end
    local function isFirstColumn() return lineIndex == 1 end
    local function isLastColumn() return lineIndex == 0 end
    local indexOffset = { -lineLength - 1, -lineLength, -lineLength + 1, -1, 1, lineLength - 1,  lineLength,  lineLength + 1 }

    for _, offset in ipairs(indexOffset) do
        local neighborIndex = i + offset
        local firstRowOOB = isFirstRow() and offset < -1
        local lastRowOOB = isLastRow() and offset > 1
        local firstColOOB = isFirstColumn() and (offset == -lineLength - 1 or offset == -1 or offset == lineLength - 1)
        local lastColOOB = isLastColumn() and (offset == -lineLength + 1 or offset == 1 or offset == lineLength + 1)

        if
            not firstRowOOB and
            not lastRowOOB and
            not firstColOOB and
            not lastColOOB and
            content:sub(neighborIndex, neighborIndex) == '@'
        then
            surroundingRolls = surroundingRolls + 1
        end
    end
    return surroundingRolls
end

local function solve(part)
    local file = io.open("inputs/day_04.txt", "r")
    local lineLength = file:read("*l"):len()
    file:seek("set")
    local content = file:read("*all"):gsub("\n", "")
    file:close()
    local validRolls = 0
    local initialRolls = content:gsub("[^@]", ""):len()

    local newRolls = true
    while newRolls do
        newRolls = false

        for i = 1, #content do
            local char = content:sub(i, i)
            if char == '@' and getSurroundingRolls(content, i, lineLength) < 4 then
                validRolls = validRolls + 1

                if part == 2 then
                    content = content:sub(1, i - 1) .. '.' .. content:sub(i + 1)
                    newRolls = true
                end
            end
        end
    end

    print("Solution " .. part .. ": " .. validRolls)
end

local timer = require("timer")
timer.time(function() solve(1) end, "part 1")
timer.time(function() solve(2) end, "part 2")