RLCore = nil
SavedRadio = {}

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Functions.CreateUseableItem("radio", function(source, item)
	local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("ls-radio:use", source)
	end
end)

RLCore.Functions.CreateCallback('radio:server:GetItem', function(source, cb, item)
  local src = source
  local Player = RLCore.Functions.GetPlayer(src)
  if Player ~= nil then 
    local RadioItem = Player.Functions.GetItemByName(item)
    if RadioItem ~= nil then
      cb(true)
    else
      cb(false)
    end
  else
    cb(false)
  end
end)

RegisterServerEvent("RLCore:Player:OnRemovedItem")
AddEventHandler("RLCore:Player:OnRemovedItem", function(source, item)
    if item.name == 'radio' and GetItem(source, item.name).count < 1 then
      TriggerEvent("TokoVoip:removePlayerFromAllRadio", source)
    end
end)

function GetItem(source, item)
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local count = 0

	for k,v in pairs(xPlayer['PlayerData']['items']) do
		if v.name == item then
			count = count + v.amount
		end
	end
	
	return { name = item, count = count }
end