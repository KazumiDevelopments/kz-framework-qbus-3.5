How to Make Inventory Working To Your QB Server

NoPixel Inventory Is Standalone

All Item At : shared_list.js

All Item Use Function : functions.lua

Export Function At np-inventory

Client Side :
exports["np-inventory"]:getFreeSpace() will return how much slot leave at your inventory
exports["np-inventory"]:hasEnoughOfItem(itemid,amount,shouldReturnText,checkQuality, metaInformation) will return true / false 
exports["np-inventory"]:getQuantity(itemid, checkQuality, metaInformation) will return quantiry item
exports["np-inventory"]:GetCurrentWeapons() will return all weapon data at your inventory
exports["np-inventory"]:GetItemInfo(slotid) will return information item with parameter slot (parameter muss filled)
exports["np-inventory"]:GetInfoForFirstItemOfName(item_id) will return info item at your inv with parameter item_id (parameter muss filled)
exports["np-inventory"]:GetItemsByItemMetaKV(item_id, meta_key, meta_value) will return item info with specific parameter (parameter muss filled)

If You Use NoPixel Inventory Please Dont Start :
stop qb-inventory
stop qb-weapons
stop qb-crafting

Start To :
ensure damage-events

ensure np-actionbar
ensure np-inventory
ensure np-keybinds
ensure np-propattach
ensure np-target
ensure np-taskbar
ensure np-taskbarskill
ensure np-tasknotify
ensure np-weapons
ensure shops

Minus For Trigger Event When Character Spawn !!

---------------------------------------------------------------------------

For Use Item U Can Add This Event "np-inventory:itemUsed" At Your Script

Example : 

AddEventHandler("np-inventory:itemUsed", function(item, info)
  -- Item Will Return Name Item
  -- Info Will Return Item Metadata
  if item ~= "musictape" then return end
  if not exports["np-inventory"]:hasEnoughOfItem("musicwalkman", 1, false, true) then -- This For Checking If U Have That Item Or Not
    -- Trigger Your Alert Notify For Information Player Dont Have Item
    return
  end
  -- Your Think Here
end)

For Receive Item U Can Change This Event

Example : 

Player.Functions.AddItem('musictape', 1)

To :

TriggerClientEvent("player:receiveItem", src, "musictape", 1)

For Remove Item U Can Change This Event

Example : 

Player.Functions.RemoveItem('musictape', 1)

To :

TriggerClientEvent("inventory:removeItem", src, "musictape", 1)

---------------------------------------------------------------------------

For Create Shop & Craft And Open Stash TriggerEvent

Open Stash & Shop

Example :

-- This For Shop & Craft

TriggerEvent("server-inventory-open", "1106", "Shop");
TriggerEvent("server-inventory-open", "1107", "Craft");

-- This For Stash

TriggerEvent("server-inventory-open", "1", "Stash")


Create Shop & Craft

First : np-inventory -> server.js

Search This : 

else if(secondInventory == "997")
{
    var targetinvname = targetName;
    var shopArray = prison();
    var shopAmount = 7;
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  

-- If You Want Add New Shop 


else if(secondInventory == "1106") -- Random Number (See What Number You Like)
{
    var targetinvname = targetName;
    var shopArray = Shop(); -- Function Name
    var shopAmount = 1; -- Function Amount
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  

-- If You Want Add New Craft Table

else if(secondInventory == "1107") -- Random Number (See What Number You Like)
{
    var targetinvname = targetName;
    var shopArray = Craft(); -- Function Name
    var shopAmount = 1; -- Function Amount
    emitNet("inventory-open-target", src, [invArray,arrayCount,playerinvname,shopArray,shopAmount,targetinvname,500,false]);
}  

Two : np-inventory -> server_shops.js

-- This For New Shop !

function Shop() {
    var shopItems = [
        { item_id: "sandwich", id: 0, name: "Shop", information: "{}", slot: 1, amount: 5 },
    ];
    return JSON.stringify(shopItems);
}

-- This For New Craft Table !

function Craft() {
    var shopItems = [
        { item_id: "icecream", id: 0, name: "Craft", information: "{}", slot: 1, amount: 1 },
    ];
    return JSON.stringify(shopItems);
}




