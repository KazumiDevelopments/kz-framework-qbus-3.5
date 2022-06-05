RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Functions.CreateUseableItem("lawyerpass", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("rl-justice:client:showLawyerLicense", -1, source, item.info)
    end
end)