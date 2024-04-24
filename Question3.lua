--[[
    Question 3
    This script print names of all guilds that have less than memberCount max members.
    -Changed the function name to removePlayerFromParty, which clearly describes what the function does;
    -Renamed membername to playerName for clarity;
    -Used ipairs instead of pairs since we are dealing with an array-like structure;
    -Created a Player object using Player(playerId) instead of directly accessing the Player class;
    -Used member:getName() to get the name of the party member.
]]

-- Remove a player from the party
function removePlayerFromParty(playerId, playerName) 
    local player = Player(playerId)
    local party = player:getParty() 

    -- Get the members of the party
    local partyMembers = party:getMembers() 

    -- Iterate through the party members
    for _, member in ipairs(partyMembers) do
        -- Check if the member's name matches the provided playerName
        if member:getName() == playerName then
            party:removeMember(member)
            -- Assuming only one player with the same name can be in the party,
            -- break the loop once the player is found and removed
            break
        end
    end
end
