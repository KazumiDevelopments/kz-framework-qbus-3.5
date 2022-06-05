local Resource, Promises, Functions, CallIdentifier = GetCurrentResourceName(), {}, {}, 0

RPC = {}

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

---EVENT

function RPC.register(name, func)
    Functions[name] = func
end

function RPC.remove(name)
    Functions[name] = nil
end

function RPC.execute(name, ...)
    local callID, solved = CallIdentifier, false
    CallIdentifier = CallIdentifier + 1

    Promises[callID] = promise:new()

    TriggerClientEvent("rpc:request", Resource, name, callID, ParamPacker(...))

    Citizen.SetTimeout(20000, function()
        if not solved then
            Promises[callID]:resolve({nil})
        end
    end)

    local response = Citizen.Await(Promises[callID])

    solved = true

    ClearPromise(callID)

    return ParamUnpacker(response)
end

RegisterServerEvent("rpc:response")
AddEventHandler("rpc:response",function(origin, callID, response, state)
    if Resource == origin and Promises[callID] then
        Promises[callID]:resolve(response)
    end
end)

RegisterServerEvent("rpc:server:timeout")
AddEventHandler("rpc:server:timeout",function(origin, name)
    print("RPC [Timeout]",origin, name)
end)

RegisterServerEvent("rpc:client:error")
AddEventHandler("rpc:client:error",function(Resource, origin, name, error)
    print("RPC [Error]",Resource, origin, name, error)
end)

RegisterServerEvent("rpc:request")
AddEventHandler("rpc:request",function(origin, name, callID, params,state)
    local src = source
    local response

    if Functions[name] == nil then
        return 
    end

    local success, error = pcall(function()
        if packaged then
            response = ParamPacker(Functions[name](src,ParamUnpacker(params)))
        else
            response = ParamPacker(Functions[name](src,UnPacker(params)))
        end
    end)

    if not success then
        TriggerClientEvent("rpc:client:error", src, Resource, origin, name, error)
    end
    
    if response == nil then
        response = {}
    end

    TriggerClientEvent("rpc:response",src,origin, callID, response)
end)
