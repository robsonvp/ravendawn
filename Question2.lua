--[[
    Question 2
    This script print names of all guilds that have less than memberCount max members.
]]

function printSmallGuildNames(memberCount)
    
    -- This query selects names of guilds with max members less than memberCount
    local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
    
    -- Executing the query
    local resultId = db.storeQuery(selectGuildQuery)
    
    -- Looping through the results
    while resultId:next() do
        local guildName = resultId:getID("name")
        print(guildName)
    end
    
    resultId:free()
end
