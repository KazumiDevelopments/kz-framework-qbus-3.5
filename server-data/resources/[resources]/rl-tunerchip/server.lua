RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Functions.CreateUseableItem("tunerlaptop",function(src)
    local source = src
    TriggerClientEvent("tuning:useLaptop", src)
end)