local M = {}

function M.time(func, label)
    local start_time = os.clock()
    local results = {func()}

    local timeInSec = os.clock() - start_time

    print(string.format("Time for %s: %.4f seconds", label, timeInSec))
end

return M