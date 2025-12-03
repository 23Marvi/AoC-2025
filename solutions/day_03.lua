local Jolt = {}
function Jolt:new(index, value) return { index = index, value = value } end

local function resetBatteries(batteries, startIndex, amount)
    for i = startIndex, amount do batteries[i] = Jolt:new(0, 0) end
    return batteries
end

local function fitJolt(batteries, jolt, bankLength)
    for i = 1, #batteries do
        local battery = batteries[i]
        if jolt.value > battery.value and jolt.index <= bankLength - (#batteries - i) then
            batteries[i] = Jolt:new(jolt.index, jolt.value)
            if i < #batteries then batteries = resetBatteries(batteries, i + 1, #batteries) end
            break
        end
    end
    return batteries
end

local function solve(puzzle, batteriesCount)
    local totalJolts = 0

    for bank in io.lines("inputs/day_03.txt") do
        local batteries = resetBatteries({}, 1, batteriesCount)

        for i = 1, #bank do
            local jolt = Jolt:new(i, tonumber(bank:sub(i, i)))
            batteries = fitJolt(batteries, jolt, #bank)
        end

        local totalBattery = ""
        for i = 1, #batteries do totalBattery = totalBattery .. batteries[i].value end
        totalJolts = totalJolts + tonumber(totalBattery)
    end

    print("Solution" .. puzzle .. ": " .. totalJolts)
end

local timer = require("timer")
timer.time(function() solve(1, 2) end, "part 1")
timer.time(function() solve(2, 12) end, "part 2")