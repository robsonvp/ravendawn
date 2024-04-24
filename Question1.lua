--[[
    Question 2
    This script defines a function related to player storage management.
    
]]

-- Function to release player storage value
local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

--[[
    Called when a player logs out.
]]
function onLogout(player)
    -- Checks if the storage value is 1
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end
