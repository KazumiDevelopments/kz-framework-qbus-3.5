----------------------------------------
--- Discord Whitelist, Made by FAXES ---
----------------------------------------

--- Config ---
roleNeeded = "Citizen"
--notWhitelisted = "You are not whitelisted. Our gates for public are open between 9am and 7pm GMT. Head over to www.twitchparadise.com to apply." -- Message displayed when they are not whitelist with the role
notWhitelisted = "You need to be in the discord join this server, Please join > https://discord.io/ConnectRP"
noDiscord = "You must have Discord open to join this server." -- Message displayed when discord is not found

roles = { -- Role nickname(s) needed to pass the whitelist
    "Citizen",
}


--- Code ---

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    deferrals.defer()
    Citizen.Wait(100)
    deferrals.update("Checking Permissions")

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        for i = 1, #roles do
            if exports.discord_perms:IsRolePresent(src, roles[i]) then
                Citizen.Wait(100)
                deferrals.done()
            else
                Citizen.Wait(100)
                --local time = os.date("*t")
                --if time.hour >= 9 and time.hour <= 19 then
                --    deferrals.done()
		--	print("thef")
                --else
                    deferrals.done(notWhitelisted)
                --end
            end
        end
    else
        Citizen.Wait(100)
        deferrals.done(noDiscord)
    end
end)