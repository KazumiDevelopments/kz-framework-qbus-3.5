local JSON = json.decode(LoadResourceFile(GetCurrentResourceName(), "/config/pursuitModes.json"))

RPC.register("pursuit:getJSON",function()
    return JSON
end)