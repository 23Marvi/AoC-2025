local function getColumns(rows)
    local columns = {}
    local columnWidth = {}

    for row in io.lines("inputs/day_06.txt") do
        local i = 1
        for record in row:gmatch("%S+") do
            if columnWidth[i] == nil then columnWidth[i] = #record
            elseif #record > columnWidth[i] then columnWidth[i] = #record end
            i = i + 1
        end
    end

    for row in io.lines("inputs/day_06.txt") do
        local j = 1
        local i = 1

        while i <= #row do
            local width = columnWidth[j]
            local endPos = i + width - 1
            local value = row:sub(i, endPos)
            i = endPos + 2
            j = j + 1
            if columns[j - 1] == nil then columns[j - 1] = {} end
            table.insert(columns[j - 1], value)
        end
    end

    return columns
end

local function solve(part)
    local solution = 0
    local columns = getColumns()

    for i = 1, #columns do
        local column = columns[i]
        local operation = column[#column]
        local sum = 0

        if part == 1 then
            for j = 1, #column - 1 do
                local number = tonumber(column[j])
                if sum == 0 then sum = number
                elseif operation:find("*") then sum = sum * number
                elseif operation:find("+") then sum = sum + number end
            end
        elseif part == 2 then
            local number = column[1]
            local localSum = 0
            for j = 1, #number do
                local digit = number:sub(j, j)
                for k = 2, #column - 1 do
                    digit = digit .. column[k]:sub(j, j)
                end
                if localSum == 0 then localSum = tonumber(digit)
                elseif operation:find("*") then localSum = localSum * tonumber(digit)
                elseif operation:find("+") then localSum = localSum + tonumber(digit) end
            end
            sum = sum + localSum
        end
        solution = solution + sum
    end

    print("Solution " .. part .. ": " .. solution)
end

local timer = require("timer")
timer.time(function() solve(1) end, "part 1")
timer.time(function() solve(2) end, "part 2")