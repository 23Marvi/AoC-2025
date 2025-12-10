local Beam = {}
function Beam:new(x, y, falling) return { x = x, y = y, falling = falling } end
local Splitter = {}
function Splitter:new(x, y, splitResult) return { x = x, y = y, splitResult = splitResult } end

local function insertBeam(beams, x, y)
    for i = 1, #beams do
        local beam = beams[i]
        if beam.x == x and beam.y == y then return false end
    end
    table.insert(beams, Beam:new(x, y, true))
    return true
end

local function splitterExistsAt(splitters, x, y)
    for i = 1, #splitters do
        local splitter = splitters[i]
        if splitter.x == x and splitter.y == y then return splitter end
    end
    return nil
end

local function getSplitterLocations()
    local locations = {}
    local y = 1
    for row in io.lines("inputs/day_07.txt") do
        for x = 1, #row do
            if row:sub(x, x) == '^' then table.insert(locations, Splitter:new(x, y, 0)) end
        end
        y = y + 1
    end
    local reversedLocations = {}
    for i = #locations, 1, -1 do table.insert(reversedLocations, locations[i]) end
    return reversedLocations
end

local function runSimulation(splitters, startX, startY, part)
    local beams = {}
    insertBeam(beams, startX, startY)

    local file = io.open("inputs/day_07.txt"):read("*a")
    local _, rows = file:gsub("\n", "\n")
    rows = rows + 1
    local splits = 0

    for step = startY, rows do
        local newBeams = {}
        for i = 1, #beams do
            local beam = beams[i]
            if beam.falling then
                local existingSplitter = splitterExistsAt(splitters, beam.x, beam.y + 1)
                if existingSplitter then
                    if part == 2 and existingSplitter.splitResult > 0 then
                        splits = splits + existingSplitter.splitResult
                    else
                        local insert1 = insertBeam(newBeams, beam.x - 1, beam.y + 1)
                        local insert2 = insertBeam(newBeams, beam.x + 1, beam.y + 1)
                        if insert1 or insert2 then splits = splits + 1 end
                    end
                else
                    table.insert(newBeams, Beam:new(beam.x, beam.y + 1, true))
                end
                beams[i].falling = false
            end
        end
        for i = 1, #newBeams do table.insert(beams, newBeams[i]) end
    end
    return splits
end

local function solve(part)
    local solution = 0
    local splitters = getSplitterLocations()
    local startLocation = nil
    local iterations = 0

    if part == 1 then
        startLocation = splitters[#splitters]
        iterations = 1
    elseif part == 2 then
        iterations = #splitters
    end

    for i = 1, iterations do
        local splitter = splitters[i]
        local splits = 0
        if startLocation == nil then
            splits = runSimulation(splitters, splitter.x, splitter.y - 1, part)
        else
            splits = runSimulation(splitters, startLocation.x, startLocation.y - 1, part)
        end
        splitter.splitResult = splits
        solution = splits
    end

    if part == 2 then solution = solution + 1 end

    print("Solution " .. part .. ": " .. solution)
end

local timer = require("timer")
timer.time(function() solve(1) end, "part 1")
timer.time(function() solve(2) end, "part 2")