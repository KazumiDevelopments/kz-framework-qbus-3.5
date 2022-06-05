RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)


RegisterNetEvent('rl-metaldetector:checkForWeapons')
AddEventHandler('rl-metaldetector:checkForWeapons', function(detector)
  local src = source
  local xPlayer = RLCore.Functions.GetPlayer(src)

  for _,v in pairs(Config.IllegalItems) do
    local item = xPlayer.Functions.GetItemByName(v:lower())
    if item ~= nil and item.amount > 0 then
      TriggerClientEvent('rl-metaldetector:playSound', -1, detector)
    end
  end
end)
