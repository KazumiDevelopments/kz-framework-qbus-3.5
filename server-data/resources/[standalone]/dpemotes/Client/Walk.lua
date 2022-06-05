function WalkMenuStart(name)
  RequestWalking(name)
  SetPedMovementClipset(PlayerPedId(), name, 0.2)
  RemoveAnimSet(name)
end

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

function WalksOnCommand(source, args)
  local WalksCommand = ""
  for a in pairsByKeys(DP.Walks) do
    WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("To reset do /walk reset")
end

function WalkCommandStart(source, args)
  local name = firstToUpper(args[1])

  if name == "Reset" then
      ResetPedMovementClipset(PlayerPedId()) return
  end

  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
    WalkMenuStart(name2) 
    TriggerServerEvent("dpemotes:saveWalkMode", name)
  else
    EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end

RegisterNetEvent("dpemotes:WalkCommandStart")
AddEventHandler("dpemotes:WalkCommandStart", function(walk)
  local walk = walk ~= nil and walk or RLCore.Functions.GetPlayerData().metadata.walk
  WalkCommandStart(PlayerId(), {walk})
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
  TriggerEvent("dpemotes:WalkCommandStart")
end)