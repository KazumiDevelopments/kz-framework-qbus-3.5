local Resource, Promises, Functions, CallIdentifier = GetCurrentResourceName(), {}, {}, 0

RPC = {}

function GetNextId(idx)
    return idx + 1
end
    

function ClearPromise(callID)
    Citizen.SetTimeout(5000, function()
        Promises[callID] = nil
    end)
end

function ParamPacker(...)
    local params, pack = {...} , {}

    for i = 1, 15, 1 do
        pack[i] = {param = params[i]}
    end

    return pack
end

function ParamUnpacker(params, index)
    local idx = index or 1

    if idx <= #params then
        return params[idx]["param"], ParamUnpacker(params, idx + 1)
    end
end

function UnPacker(params, index)
    local idx = index or 1

    if idx <= 15 then
        return params[idx], UnPacker(params, idx + 1)
    end
end

------------------------------------------------------------------
--                  (Trigger Client Calls)
------------------------------------------------------------------

RPC = {
    EXECUTE = {
        
    }
}

function RPC.execute(name, ...)
    local callID, solved = CallIdentifier, false
	local src = source
    CallIdentifier = CallIdentifier + 1

    Promises[callID] = promise:new()

    TriggerClientEvent("rpc:request", src, Resource, name, callID, ParamPacker(...), true)

    Citizen.SetTimeout(20000, function()
        if not solved then
            Promises[callID]:resolve({nil})
            TriggerClientEvent("rpc:server:timeout", src, Resource, name)
        end
    end)

    local response = Citizen.Await(Promises[callID])

    solved = true

    ClearPromise(callID)

    return ParamUnpacker(response)
end

function RPC.executeLatent(name, timeout, ...)
    local callID, solved = CallIdentifier, false
    CallIdentifier = CallIdentifier + 1
    Promises[callID] = promise:new()

    TriggerLatentClientEvent("rpc:latent:request", 50000, Resource, name, callID, ParamPacker(...), true)

    Citizen.SetTimeout(timeout, function()
        if not solved then
            Promises[callID]:resolve({nil})
            TriggerClientEvent("rpc:server:timeout", src, srcResource, name)
        end
    end)

    local response = Citizen.Await(Promises[callID])

    solved = true

    ClearPromise(callID)

    return ParamUnpacker(response)
end

RegisterNetEvent("rpc:response")
AddEventHandler("rpc:response", function(origin, callID, response)
    if Resource == origin and Promises[callID] then
        Promises[callID]:resolve(response)
    end
end)

------------------------------------------------------------------
--                  (Receive Remote Calls)
------------------------------------------------------------------

function RPC.register(name, func)
    Functions[name] = func
end

function RPC.remove(name)
    Functions[name] = nil
end

RegisterNetEvent("rpc:request")
AddEventHandler("rpc:request", function(origin, name, callID, params)
    local response
    local src = source

    if Functions[name] == nil then return end

    local success, error = pcall(function()
        if packaged then
            response = ParamPacker(Functions[name](ParamUnpacker(params)))
        else
            response = ParamPacker(Functions[name](UnPacker(params)))
        end
    end)

    if not success then
        TriggerClientEvent("rpc:client:error", src, Resource, origin, name, error)
    end

    if response == nil then
        response = {}
    end

    TriggerClientEvent("rpc:response", src, origin, callID, response)
end)

RegisterNetEvent("rpc:latent:request")
AddEventHandler("rpc:latent:request", function(origin, name, callID, params)
    local respon 
    local src = source
	
    if Functions[name] == nil then return end

    local success, error = pcall(function()
        if packaged then
            response = ParamPacker(Functions[name](ParamUnpacker(params)))
        else
            response = ParamPacker(Functions[name](UnPacker(params)))
        end
    end)

    if not success then
        TriggerClientEvent("rpc:client:error", src, Resource, origin, name, error)
    end

    if response == nil then
        response = {}
    end

    TriggerLatentClientEvent("rpc:response", 50000, src, origin, callID, response,  true)
end)