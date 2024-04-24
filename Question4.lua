--[[
    Question 4
    -Before exiting the function, the dynamically allocated Player object is deleted using delete player; 
    -If the creation of the item fails, the allocated Player object is deleted before returning from the function;
]]

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    
    if (!player) {
        -- Player does not exist, attempt to load from storage
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; -- Delete the allocated player object
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        -- Failed to create item, clean up and return
        if (!player->isOnline()) {
            -- Save player only if they are offline
            IOLoginData::savePlayer(player);
        }
        delete player; -- Delete the allocated player object
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (!player->isOnline()) {
        -- Save player only if they are offline
        IOLoginData::savePlayer(player);
    }

    -- Clean up allocated memory for player
    delete player;
}
