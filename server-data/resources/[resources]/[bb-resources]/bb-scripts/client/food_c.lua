function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function TaskItem(dictionary,animation,typeAnim,timer,message,func,remove,itemid,playerVeh)
    loadAnimDict(dictionary) 
    TaskPlayAnim(PlayerPedId(), dictionary, animation, 8.0, 1.0, -1, typeAnim, 0, 0, 0, 0 )
    local timer = tonumber(timer)
    if timer > 0 then
        RLCore.Functions.Progressbar("idkidk", message, timer, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        }, {}, {}, {}, function() -- Done
            TriggerEvent(func, itemid)
        end, {})
    else
        TriggerEvent(func, itemid)
    end
end

function AttachPropAndPlayAnimation(dictionary,animation,typeAnim,timer,message,func,remove,itemid,vehicle)
    if itemid == "burger" or itemid == "heartstopper" or itemid == "bleederburger" or itemid == "moneyshot" then
        TriggerEvent("attachItem", "hamburger")
    elseif itemid == "sandwich" then
        TriggerEvent("attachItem", "sandwich") 
    elseif itemid == "toast" then
        TriggerEvent("attachItem", "sandwich") 
    elseif itemid == "donut" then
        TriggerEvent("attachItem", "donut")
    elseif itemid == "beer" or itemid == "vodka" or itemid == "whiskey" or itemid == "glassbeer" or itemid == "champagne" or itemid == "glasschampagne" or itemid == "tequila" or itemid == "tequilashot" or itemid == "whitewine" or itemid == "pinacolada" then
        TriggerEvent("attachItem", itemid)
    elseif itemid == "taco" or itemid == "fishtaco" or itemid == "twinkie" then
        TriggerEvent("attachItem", "taco")
    elseif itemid == "frappuccino" or itemid == "coffee" or itemid == "latte" or itemid == "capuchino" then
        TriggerEvent("attachItem", "coffee")
    elseif itemid == "twerks_candy" or itemid == "snikkel_candy" then
        TriggerEvent("attachItem", "ego")
    elseif itemid == "greencow" then
        TriggerEvent("attachItem", "energydrink")
    elseif itemid == "glasswine" or itemid == "bloodymary" then
        TriggerEvent("attachItem", "glasswine")
    elseif itemid == "water_bottle" then
        TriggerEvent("attachItem", "water")
    elseif itemid == "dusche" then
        TriggerEvent("attachItem", "dusche")
    elseif itemid == "glasswhiskey" then
        TriggerEvent("attachItem", "glasswhiskey") 
    elseif itemid == "slushy" or itemid == "orangeslushy" or itemid == "greenslushy" or itemid == "blueslushy" or itemid == "yellowslushy" then
        TriggerEvent("attachItem", "cup")
    elseif itemid == "cocacola" then
        TriggerEvent("attachItem", "cola")
    elseif itemid == "spirte" then
        TriggerEvent("attachItem", "sprunk")
    end
    TaskItem(dictionary, animation, typeAnim, timer, message, func, remove, itemid,vehicle)
end

function AddArmor()
    local a = 15
    while a > 0 do
        Citizen.Wait(math.random(750, 1150))
        a = a - 1
        AddArmourToPed(PlayerPedId(), 1)
    end
end

function AddHealth()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 30
    while count > 0 do
        Citizen.Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1) 
    end
    healing = false
end

RegisterNetEvent('bb-food:useFood')
AddEventHandler('bb-food:useFood', function(itemid)
    print(itemid)

    if (itemid == "burger" or itemid == "taco" or itemid == "fishtaco" or itemid == "burrito" or itemid == "torpedo" or itemid == "torta" or itemid == "fowlburger" or itemid == "bleederburger" or itemid == "moneyshot" or itemid == "heartstopper" or itemid == "meatfree" or itemid == "sandwich" or itemid == "toast" or itemid == "jailfood") then
        AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000, "Eating", "consumables:client:EatS", true,itemid,playerVeh)
    end
	
    if (itemid == "wings" or itemid == "donut" or itemid == "fries" or itemid == "frenchtoast" or itemid == "waffle" or itemid == "twerks_candy" or itemid == "snikkel_candy" or itemid == "twinkie") then
        AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating", "consumables:client:EatS", true,itemid,playerVeh)
    end
	
    if (itemid == "eggsbacon" or itemid == "hotdog" or itemid == "churro") then
        AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating", "food:Condiment", true,itemid,playerVeh)
    end

    if (itemid == "spirte" or itemid == "beer" or itemid == "whiskey" or itemid == "vodka" or itemid == "champagne" or itemid == "glasswhiskey" or itemid == "glasswine" or itemid == "glassbeer" or itemid == "bloodymary" or itemid == "glasschampagne" or itemid == "dusche" or itemid == "tequila" or itemid == "tequilashot" or itemid == "whitewine" or itemid == "pinacolada") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drink", "consumables:client:DrinkS", true,itemid,playerVeh)
    end

    if (itemid == "water_bottle" or itemid == "cocacola") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@beer@female@idle_a", "idle_e", 49,6000,"Drink", "consumables:client:DrinkS", true,itemid,playerVeh)
    end
	
    if (itemid == "greencow") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@beer@female@idle_a", "idle_e", 49,6000,"Drink", "food:Condiment", true,itemid,playerVeh)
    end
	
    if (itemid == "slushy") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@beer@female@idle_a", "idle_e", 49,6000,"Eating", "consumables:client:DrinkS", true,itemid,playerVeh)
		AddHealth()
    end
	
    if (itemid == "orangeslushy" or itemid == "greenslushy" or itemid == "blueslushy" or itemid == "yellowslushy") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@beer@female@idle_a", "idle_e", 49, 6000,"Drinking", "consumables:client:DrinkS", true,itemid,playerVeh)
        AddArmor()
    end
	
    if (itemid == "coffee" or itemid == "frappuccino" or itemid == "latte" or itemid == "capuchino") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drink","consumables:client:DrinkS", true,itemid,playerVeh)
    end

    if (itemid == "icecream" or itemid == "mshake") then
        TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating", "consumables:client:EatS", true,itemid,playerVeh)
	end

    if (itemid == "fudge") then
        TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating", "consumables:client:EatS", true,itemid,playerVeh)
	end
end)

local Consumeables = {
    ["coffee"] = math.random(25, 50),
	["latte"] = math.random(20, 40),
	["capuchino"] = math.random(20, 40),
	["frappuccino"] = math.random(20, 40),
	["cocacola"] = math.random(15, 25),
	["greencow"] = math.random(15, 25),
	["spirte"] = math.random(15, 25),
	["slushy"] = math.random(15, 27),
	["orangeslushy"] = math.random(15, 27),
	["greenslushy"] = math.random(15, 27),
	["blueslushy"] = math.random(15, 27),
	["yellowslushy"] = math.random(15, 27),
	["taco"] = math.random(25, 50),
    ["fishtaco"] = math.random(20, 40),
	["torpedo"] = math.random(20, 40),
	["torta"] = math.random(20, 40),
    ["burrito"] = math.random(20, 40),
	["eggsbacon"] = math.random(20, 40),
    ["churro"] = math.random(15, 25),
    ["donut"] = math.random(15, 25),
	["waffle"] = math.random(15, 25),
	["frenchtoast"] = math.random(15, 25),
	["fries"] = math.random(20, 35),
	["wings"] = math.random(20, 40),
    ["hotdog"] = math.random(20, 40),
	["jailfood"] = math.random(25, 50),
	["moneyshot"] = math.random(20, 40),
	["heartstopper"] = math.random(20, 40),
	["bleederburger"] = math.random(20, 40),
	["meatfree"] = math.random(20, 40),
	["fowlburger"] = math.random(20, 40),
    ["icecream"] = math.random(20, 25),
    ["fudge"] = math.random(20, 25),
    ["mshake"] = math.random(20, 30),
	["sandwich"] = math.random(20, 30),
    ["water_bottle"] = math.random(23, 46),
    ["toast"] = math.random(20, 35),
	["burger"] = math.random(25, 50),
    ["twerks_candy"] = math.random(5, 15),
    ["snikkel_candy"] = math.random(5, 15),
    ["twinkie"] = math.random(20, 25),
    ["champagne"] = math.random(20, 45),
    ["whitewine"] = math.random(20, 40),
    ["whiskey"] = math.random(10, 25),
    ["beer"] = math.random(10, 25),
    ["tequila"] = math.random(10, 25),
    ["dusche"] = math.random(10, 25),
    ["pinacolada"] = math.random(10, 20),
    ["glasswhiskey"] = math.random(10, 20),
    ["glasswine"] = math.random(10, 20),
    ["glassbeer"] = math.random(10, 20),
    ["bloodymary"] = math.random(10, 20),
    ["glasschampagne"] = math.random(10, 20),
    ["tequilashot"] = math.random(10, 20),
}

RegisterNetEvent('food:Condiment')
AddEventHandler('food:Condiment', function(itemName)
    local startStamina = 23
	TriggerEvent("destroyProp")
	TriggerServerEvent("RLCore:Server:RemoveItem", itemName, 1)
	Citizen.Wait(2500)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.14)
	StartScreenEffect("RaceTurbo", 30.0, 0)
	Citizen.Wait(1500)
	StartScreenEffect("RaceTurbo", 0.0, 0)
	TriggerServerEvent("RLCore:Server:SetMetaData", "hunger", RLCore.Functions.GetPlayerData().metadata["hunger"] + Consumeables[itemName])
	TriggerServerEvent("RLCore:Server:SetMetaData", "thirst", RLCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end)

RegisterNetEvent("consumables:client:EatS")
AddEventHandler("consumables:client:EatS", function(itemName)
    TriggerEvent("destroyProp")
    TriggerServerEvent("RLCore:Server:RemoveItem", itemName, 1)
    TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items[itemName], "remove")
    TriggerServerEvent("RLCore:Server:SetMetaData", "hunger", RLCore.Functions.GetPlayerData().metadata["hunger"] + Consumeables[itemName])
    TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
end)

RegisterNetEvent("consumables:client:DrinkS")
AddEventHandler("consumables:client:DrinkS", function(itemName)
    TriggerEvent("destroyProp")
    TriggerServerEvent("RLCore:Server:RemoveItem", itemName, 1)
    TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items[itemName], "remove")
    TriggerServerEvent("RLCore:Server:SetMetaData", "thirst", RLCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
end)

RegisterNetEvent("payanimation")
AddEventHandler("payanimation", function()
	TriggerEvent('animations:client:EmoteCommandStart', {"id"})
end)