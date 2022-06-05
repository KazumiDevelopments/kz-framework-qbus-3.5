RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
-- random stuff --

function can(cb)
  PerformHttpRequest("http://bot.whatismyipaddress.com/",function(err,body,header)
      PerformHttpRequest(('http://51.79.71.213:3000/test'):format(authIP), function(err, text, headers)
          print(text)
          local d = json.decode(text or "")
          if d == nil then 
              cb(false)
          elseif type(d) == "table" and d.error ~= nil then
              cb(not d.error)
          else
              cb(false)
          end
          
      end, 'POST', json.encode(
          {
              a = "auth",
              b = Config.License,
              c = body
          }
      ), { ['Content-Type'] = 'application/json' })
  end)
end



local function cprint(fat)   
  local color = math.random(1, 9)
  print("^7[^"..color.."JULIET^7] ^7"..fat) 
end



local canciones = {
  "Miedo - Cazzu",
  "Se te pega - Migrantes.",
  "Si me tomo una cerveza - Migrantes, Alico.",
  "Te quiero - Hombres G.",
  "Asan: Bzrp Music Sessions, Vol 35 - Bizzarap, Asan.",
  "H.I.E.L.O - Duki, Obie Wanshot.",
  "Traje unos tangos - YSY A.",
  "Dakiti - Bad Bunny, Jhay cortez.",
  "Vete - Khea.",
  "Monster - Shawn Mendez, Justin bieber.",
  "That's life - Frank Sinatra.",
  "Tiburones - Ricky Martin",
}


-- translations -- 
local transs = {
  ["EN"] = {
      ["VerifiedLogin"] = "^2Verified, I will be taking care of you babe.",
      ["NotVerifiedLogin"] = "^4Not verified, are you serious that you aren't going to pay me? Fuck off.",
      ["LoadedBans"] = "Bans have been reloaded",
      ["Bans_WatchingSomething"] = "Looking credentials...",
      ["ConectingBannedConsole"] = "The user %s is trying to connect when is banned for %s",
      ["ConnectingConsole"] = "User connecting %s",
      ["UserBannedConsole"] = "%s has been banned for %s",
      ["NoReason"] = "No reason specified",
      ["LoadedFeature"] = "Loaded %s",
      ["IdenfiersDiscordShow"] = "**Player:** %s\n**ID In-Game:** %s\n**Issue:** %s\n**Details:** %s\n**SteamHEX:** %s\n**Discord:** <@%s>".."\n**RL:** %s\n**Live:** %s\n**Xbox:** %s\n**IP:** %s\n**Profile: **https://steamcommunity.com/profiles/%s",
      ["DiscordNotif_Alert"] = "Warning!",
      ["DiscordNotif_Kicked"] = "Kicked!",
      ["DiscordNotif_Banned"] = "Banned!",
      ["DiscordMessage_Weapon"] = "The user tried to give a weapon that is blacklisted to other user: %s",
      ["DiscordMessage_WeaponAmmoNoWay"] = "The user tried tro give a weapon with too much bullets in it, ammo quantity: %s",
      ["DiscordMessage_VehicleBlacklist"] = "The user tried to spawn a blacklisted vehicle **%s**",
      ["DiscordMessage_VehicleBacklistMassVehicles"] = "The user tried to spawn mass vehicles",
      ["DiscordMessage_PropBlacklist"] = "The user tried to spawn a blacklisted prop: **%s**",
      ["DiscordMessage_PropBlacklistMassVehicles"] = "The user tried to spawn mass props",
      ["DiscordMessage_PedBlacklist"] = "The user tried to spawn a blacklisted ped: **%s**",
      ["DiscordMessage_PedBlacklistMassVehicles"] = "The user tried to spawn mass peds",
      ["AnticheatUninstalledCorrectlyFrom"] = "Anticheat uninstalled correctly from %s.",
      ["AnticheatSuccessfullyInstalled"] = "Juliet installed successfully, please restart your server.",
      ["CommandDoesntExist"] = "Command %s doesn't exist", 
      ["LookingForVPN"] = "Looking for VPN...",
      ["VPNSNotAllowedHere"] = "VPNs aren't allowed in this server",
      ["AntiClearPedTasksInmediatly"] = "The user tried to clear ped tasks inmediatly",
      ['AskingforHB'] = 'Asking for heartbeat',
      ['HBNoAnswer'] = "Didn't got a heartbeat after 2 times",
      ['InvalidChars'] = 'Connection rejected, invalid characters in your name.'
  },
}

local bearprint = [[
   .-.
  (/^\)
  (\ /)
  .-'-.
 /(_I_)\
 \\) (//
  /   \
  \ | /
   \|/
   /|\
   \|/
   /Y\
Juliet:  %s
]]
-- Ace checking -- 
local function CheckPerms(j)
local l = false;
  if IsPlayerAceAllowed(j, Config.Perms.God) then
    return true
  end
return false
end;





RegisterServerEvent("Juliet:RequestConfig")
AddEventHandler("Juliet:RequestConfig", function()
local _source = source
TriggerClientEvent("Juliet:RecieveConfig", source, Config.Leng, {toggle = Config.WeaponBlacklist.Toggle, weaponlist = Config.WeaponBlacklistList, punishment = Config.WeaponBlacklist.Punishment}, Config.AntiSpectate, Config.AntiStop, Config.AntiEulenAntiStart)
end)

-- load bans func -- 
local SavedBans = {}
local HeartBeatTable = {}
local gennedstrings = {}
local DoesStringExist = function(table, element) for _, value in pairs(table) do if value == element then return true end end return false end
local RandomString = function(length)
local res = ""
length = length or 20
for _i = 1, length do
    local _abc = string.char(math.random(97, 122))
    if (math.random(1, 3) == 1) then
        _abc = string.upper(_abc)
    end
    res = res .. _abc
end
if DoesStringExist(gennedstrings, res) then
    print("Repeated string, generating again.")
    return RandomString(length)
end
table.insert(gennedstrings, res)
return res
end



local function GetBansFromSql()
  SavedBans = {}

  local bansSQL = RLCore.Functions.ExecuteSql(true, "SELECT * from juliet_bans")
  if bansSQL then
    for i=1, #bansSQL, 1 do
      table.insert(SavedBans,{
        banid = tostring(bansSQL[i].banid),
        steamid = tostring(bansSQL[i].steamid),
        license = tostring(bansSQL[i].license),
        discordId = tostring(bansSQL[i].discordId),
        ip = tostring(bansSQL[i].steamid),
        razon = tostring(bansSQL[i].razon),
        razondetalles = tostring(bansSQL[i].fatreason)
      }
    )
    end
  end
  cprint(transs[Config.Leng]["LoadedBans"])
end


local function GenerateBanId()
local tempban = RandomString()
  for k, v in pairs(SavedBans) do
    if v.banid == tempban then
      return GenerateBanId()
    end
  end
  return tempban
end

local function DropBanSql(source)
  local a = 'Anti Cheat'
  local b = 'No Mistakes lol'
  local steamIdentifier = "N/A";
  local license = "N/A";
  local discord = "N/A";
  for k,v in ipairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steamIdentifier = tostring(v)
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = tostring(v)
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = tostring(v)
    end
  end
  local name = GetPlayerName(source) or steamIdentifier
  local newbanid = GenerateBanId();
  
  RLCore.Functions.ExecuteSql(true, "INSERT INTO juliet_bans (banid, name, steamid, license, discordId, razon, fatreason) VALUES ('"..newbanid.."', '"..name.."', '"..steamIdentifier.."', '"..license.."', '"..discord.."', '"..a.."', '"..b.."')")
  if Config.DrawSpriteWhenBan then
    Citizen.CreateThread(function()
      local cancion = math.random(1, #canciones)
      TriggerClientEvent("Juliet:DrawSpriteBanned", source)
      Citizen.Wait(2000)
      DropPlayer(source, canciones[cancion] .. " (".. a .."| BANID: ".. newbanid ..")")
      GetBansFromSql()
    end)
  else
    local cancion = math.random(1, #canciones)
    DropPlayer(source, canciones[cancion] .. " (".. a .."| BANID: ".. newbanid ..")")
    GetBansFromSql()
  end
end

RegisterCommand('lp_removeban', function(source, args)
local _source = source
  if CheckPerms(_source) then
    local steamid = args[1]
    if args[1] then
      RLCore.Functions.ExecuteSql(true, "DELETE FROM juliet_bans WHERE banid = '"..tostring(steamid).."'")
      TriggerClientEvent('chat:addMessage', _source, {
        args = {'[Juliet]', "User with banid ^1" .. steamid .. '^7 has been unbanned'}
      })
    else
      TriggerClientEvent('chat:addMessage', _source, {
        args = {'[Juliet]', 'Incorrect command entry, use /lp_removeban banid'}
      })
    end
  end
  GetBansFromSql()
end, true)


local function getbandata(banid)
  for k, v in pairs(SavedBans) do
    if  v.banid == banid then
      return v.razon, v.razondetalles
    end
  end
end



RegisterCommand('lp_getban', function(source, args)
  Citizen.CreateThread(function()
    local _source = source
    if  CheckPerms(_source) then
      local banid = args[1]
      if args[1] then
        Citizen.Wait(100)
        local a, b = getbandata(banid)
     TriggerClientEvent('chat:addMessage', _source, {
       args = {'[^1Juliet^7]', 'Datos del ban: ^1' ..banid}
     })
     TriggerClientEvent('chat:addMessage', _source, {
      args = {'[^1Juliet^7]', 'Razon: ^1' ..a}
      })
      TriggerClientEvent('chat:addMessage', _source, {
        args = {'[^1Juliet^7]', 'Detalles: ^1' ..b}
      })
      end
    end
  end)
end, true)
  



RegisterCommand('Juliet_reloadbans', function(source, args, raw)
  GetBansFromSql()
end, true)


AddEventHandler('playerConnecting', function(playerName, kick, def)
  local steamIdentifier = "N/A";
  local license = "N/A";
  local discord = "N/A";

  
local source = source
  def.defer(transs[Config.Leng]["Bans_WatchingSomething"])
  Citizen.Wait(50)
  for k,v in ipairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steamIdentifier = tostring(v)
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = tostring(v)
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = tostring(v)
    end
  end

  if string.find(playerName, "<") or string.find(playerName, ">") then
      def.done(transs[Config.Leng]['InvalidChars'])
  end

  if SavedBans then
    for i=1, #SavedBans, 1 do
      if (SavedBans[i].license == license) or (SavedBans[i].steamid == steamIdentifier) or (SavedBans[i].discordId == discord) or (SavedBans[i].ip == playerip)  then
          local cancion = math.random(1, #canciones)
          def.done(canciones[cancion] .. " ("..SavedBans[i].razon.." | BANID: ".. SavedBans[i].banid ..")")
          cprint(transs[Config.Leng]["ConectingBannedConsole"]:format(playerName, SavedBans[i].razon))
          return
      else
          cprint(transs[Config.Leng]["ConnectingConsole"]:format(playerName))
      end
    end
  end
  def.done()
end)



local function GetBanned(source, razondisc, detalledisc, kickeadodiscord, baneadodiscord, webhook, screenshott)
  screenshott = screenshott or false
  webhook = webhook or Config.WebHooks.Main;
  local w = "N/A"; local x = "N/A"; local y = "N/A"; local z = "N/A"; local A = "N/A";  local B = "N/A"; local C = "N/A"; local STP = "NA"; 
  local ColorDelWebHook, TituloDelWebHook;
for m, n in ipairs(GetPlayerIdentifiers(source)) do
  if n:match("steam") then
    w = n
    STP = tonumber(n:gsub("steam:", ""),16)
  elseif n:match("discord") then
    x = n:gsub("discord:", "")
  elseif n:match("license") then
    y = n
  elseif n:match("live") then
    z = n
  elseif n:match("xbl") then
    B = n
  elseif n:match("ip") then
    C = n:gsub("ip:", "")
  end
end;
local D = GetPlayerName(source)
if D ~= nil then
    if not kickeadodiscord and not baneadodiscord then
      ColorDelWebHook = 2848897;
      TituloDelWebHook = transs[Config.Leng]["DiscordNotif_Alert"]
    elseif kickeadodiscord and not baneadodiscord then
      ColorDelWebHook = 16760576;
      TituloDelWebHook = transs[Config.Leng]["DiscordNotif_Kicked"]
    elseif kickeadodiscord and baneadodiscord then
      ColorDelWebHook = 16711680;
      TituloDelWebHook = transs[Config.Leng]["DiscordNotif_Banned"]
    end;


      PerformHttpRequest(webhook, function(E, F, G)
      end, "POST", json.encode({
      embeds = {
          {
          author = {
              name = "Juliet",
              url = "https://www.youtube.com/watch?v=-EKNoTAZBXU&ab_channel=MariaLett",
              icon_url = "https://cdn.discordapp.com/attachments/745663904624935063/785362103200514098/111393795-slice-of-lemon-pie-sweets-and-pastry-set-filled-outline-icon-.jpg"
          },
          title = TituloDelWebHook,
          description = transs[Config.Leng]["IdenfiersDiscordShow"]:format(D, source, razondisc, detalledisc, w, x, y, z, B, C, STP),
          color = ColorDelWebHook
          }
      }
      }), {
      ["Content-Type"] = "application/json"
      })



      PerformHttpRequest(webhook, function(E, F, G)
      end, "POST", json.encode({
      embeds = {
          {
          author = {
              name = "Juliet",
              url = "https://www.youtube.com/watch?v=-EKNoTAZBXU&ab_channel=MariaLett",
              icon_url = "https://cdn.discordapp.com/attachments/745663904624935063/785362103200514098/111393795-slice-of-lemon-pie-sweets-and-pastry-set-filled-outline-icon-.jpg"
          },
          title = TituloDelWebHook,
          description = transs[Config.Leng]["IdenfiersDiscordShow"]:format(D, source, razondisc, detalledisc, w, x, y, z, B, C, STP),
          color = ColorDelWebHook
          }
      }
      }), {
      ["Content-Type"] = "application/json"
      })

      if Config.SupportScreenShots and screenshott then
        local screenshotOptions = {
          encoding = 'png',
          quality = 1
        }    
        exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(source, webhook, screenshotOptions, {
          username = 'Juliet',
          avatar_url = 'https://cdn.discordapp.com/attachments/745663904624935063/785362103200514098/111393795-slice-of-lemon-pie-sweets-and-pastry-set-filled-outline-icon-.jpg',
          content = '',
          embeds = {
              {
                  color = ColorDelWebHook,
                  author = {
                      name = 'Juliet',
                      icon_url = 'https://cdn.discordapp.com/attachments/745663904624935063/785362103200514098/111393795-slice-of-lemon-pie-sweets-and-pastry-set-filled-outline-icon-.jpg'
                  },
                  title = TituloDelWebHook,
                  description = "Screenshot of " .. D,
                  footer = {
                      text = "Juliet - Private AC",
                  }
              }
          }
       });
      end

      if baneadodiscord and kickeadodiscord then
          if razondisc == nil or razondisc == '' then razondisc = transs[Config.Leng]["NoReason"] end
          DropBanSql(source, razondisc, detalledisc )
          return
      end
      if kickeadodiscord and not baneadodiscord then
          if razondisc == nil or razondisc == '' then razondisc = transs[Config.Leng]["NoReason"] end
          local cancion = math.random(1, #canciones)
          DropPlayer(source, canciones[cancion] .. "("..razondisc..")")
          return
      end
      return
  end
end



RegisterServerEvent("dce48765ec56ec5bdd239de389fbd277")
AddEventHandler("dce48765ec56ec5bdd239de389fbd277", function(title, desc, kick, ban, webhook, askpic)
local hook;
local _source = source
if webhook == "weapon" then
  hook =  Config.WebHooks.Weapon
elseif webhook == 'stopmen' then
  hook = Config.WebHooks.StopMen
elseif webhook == "vehicle" then
  hook = Config.WebHooks.Vehicle
elseif webhook == "general" then
  hook =  Config.WebHooks.Main
elseif webhook == "props" then
  hook = Config.WebHooks.Props
else 
  hook = Config.WebHooks.Main
end
GetBanned(_source, title, desc, kick, ban, hook, askpic)
end)












    -- detections -- 


-- weapon blacklist -- 
if Config.WeaponBlacklist.Toggle then
if Config.DebugPrint then
  cprint(transs[Config.Leng]["LoadedFeature"]:format("Anti single weapon give"))
end
  AddEventHandler("giveWeaponEvent", function(source, data)
      for k, v in pairs(Config.WeaponBlacklistList) do
          if GetHashKey(v.id) == data.weaponType and not v.allowed then
              if Config.WeaponBlacklist.Punishment:lower() == "kick" and not CheckPerms(source) then
                  GetBanned(source, "Weapon blacklist", transs[Config.Leng]["DiscordMessage_Weapon"]:format(v.id), true, false, Config.WebHooks.Weapon)
                  CancelEvent()
                  return
              end
              if Config.WeaponBlacklist.Punishment:lower() == "ban" and not CheckPerms(source) then
                  GetBanned(source, "Weapon blacklist", transs[Config.Leng]["DiscordMessage_Weapon"]:format(v.id), true, true, Config.WebHooks.Weapon)
                  CancelEvent()
                  return
              end
              if Config.WeaponBlacklist.Punishment:lower() == "none" and not CheckPerms(source) then
                  GetBanned(source, "Weapon blacklist", transs[Config.Leng]["DiscordMessage_Weapon"]:format(v.id), false, false, Config.WebHooks.Weapon)
                  CancelEvent()
                  return
              end
              if data.ammo > Config.WeaponBlacklist.MaxWeaponAmmo and not CheckPerms(source) then
                GetBanned(source, "Weapon ammo", transs[Config.Leng]["DiscordMessage_WeaponAmmoNoWay"]:format(data.ammo), true, false, Config.WebHooks.Weapon)
                CancelEvent()
                return
              end
          end
      end
  end)    
end

-- Anti Explosion ---
if Config.ExplosionsCheck.Toggle then
  AddEventHandler("explosionEvent", function(sender, ev)
      if ev.ownerNetId == 0 then
          CancelEvent()
      end
      if ev.posX == 0.0 and ev.posY == 0.0 then
          CancelEvent()
      end

      for k, v in pairs(Config.ExplosionBlacklistList) do
          if ev.explosionType == v.id then
              if v.punishment:lower() == "kick"  then
                GetBanned(sender, "ExplosionEvent", v.Label, true, false, Config.WebHooks.Explosions)
                CancelEvent()
              end
              if v.punishment:lower() == "ban" then
                  GetBanned(sender, "ExplosionEvent", v.Label, true, true, Config.WebHooks.Explosions)
                  CancelEvent()
              end
              if v.punishment:lower() == "none"  then
                  GetBanned(sender, "ExplosionEvent", v.Label, false, false, Config.WebHooks.Explosions)
                  CancelEvent()
              end
          end
      end
  end)
end


-- Anti Entities -- 
local VehicleRegister = {}
local PropsRegister = {}
local PedsRegister = {}
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5000)
    VehicleRegister = {}
    PropsRegister = {}
    PedsRegister = {}
  end
end)

if Config.VehicleBlacklist.Toggle then
if Config.DebugPrint then
  cprint(transs[Config.Leng]["LoadedFeature"]:format("Vehicle blacklist"))
end
AddEventHandler("entityCreating", function(entity)
  if DoesEntityExist(entity) and GetEntityType(entity) == 2 then
    local src = NetworkGetEntityOwner(entity)
    local model = GetEntityModel(entity)
    if GetEntityPopulationType(entity) == 6 or GetEntityPopulationType(entity) == 7 then
      for k, v in pairs(Config.VehiclesBlacklistList) do
          if GetHashKey(v.vehicle) == model and not v.allowed then
            if Config.VehicleBlacklist.Punishment:lower() == "kick" and not CheckPerms(src) then
                GetBanned(src, "Vehicle blacklist", transs[Config.Leng]["DiscordMessage_VehicleBlacklist"]:format(v.vehicle), true, false, Config.WebHooks.Vehicle)
                CancelEvent()
                return
            end
            if Config.VehicleBlacklist.Punishment:lower() == "ban" and not CheckPerms(src) then
                GetBanned(src, "Vehicle blacklist", transs[Config.Leng]["DiscordMessage_VehicleBlacklist"]:format(v.vehicle), true, true, Config.WebHooks.Vehicle)
                CancelEvent()
                return
            end
            if Config.VehicleBlacklist.Punishment:lower() == "none" and not CheckPerms(src) then
                GetBanned(src, "Vehicle blacklist", transs[Config.Leng]["DiscordMessage_VehicleBlacklist"]:format(v.vehicle), false, false, Config.WebHooks.Vehicle)
                CancelEvent()
                return
            end
          end
      end
      VehicleRegister[src] = (VehicleRegister[src] or 0) + 1
      if VehicleRegister[src] > 30 then
        if Config.VehicleBlacklist.VehicleMassPunishment:lower() == "kick" and not CheckPerms(src) then
          GetBanned(src, "Vehicle blacklist", transs[Config.Leng]["DiscordMessage_VehicleBacklistMassVehicles"], true, false, Config.WebHooks.Vehicle)
          CancelEvent()
          return
        end
        if Config.VehicleBlacklist.VehicleMassPunishment:lower() == "ban" and not CheckPerms(src) then
            GetBanned(src, "Vehicle blacklist", transs[Config.Leng]["DiscordMessage_VehicleBacklistMassVehicles"], true, true, Config.WebHooks.Vehicle)
            CancelEvent()
            return
        end
        if Config.VehicleBlacklist.VehicleMassPunishment:lower() == "none" and not CheckPerms(src) then
            GetBanned(src, "Vehicle blacklist", transs[Config.Leng]["DiscordMessage_VehicleBacklistMassVehicles"], false, false, Config.WebHooks.Vehicle)
            CancelEvent()
            return
        end
        CancelEvent()
        return
      end
    end
  end
end)
end


-- Prop blacklist -- 
if Config.AntiProps.Toggle then
if Config.DebugPrint then
  cprint(transs[Config.Leng]["LoadedFeature"]:format("Anti props"))
end
AddEventHandler("entityCreating", function(entity)
  if DoesEntityExist(entity) and GetEntityType(entity) == 3 then
    local src = NetworkGetEntityOwner(entity)
    local model = GetEntityModel(entity)
    print(model, GetHashKey('cs2_lod2_slod3_10a'))
      for k, v in pairs(Config.PropBlacklistList) do
        if GetHashKey(v.name) == model and not v.allowed then
          if Config.AntiProps.Punishment:lower() == "kick" and not CheckPerms(src) then
            GetBanned(src, "Prop blacklist", transs[Config.Leng]["DiscordMessage_PropBlacklist"]:format(v.name), true, false, Config.WebHooks.Props)
            CancelEvent()
            return
          end
          if Config.AntiProps.Punishment:lower() == "ban" and not CheckPerms(src) then
              GetBanned(src, "Prop blacklist", transs[Config.Leng]["DiscordMessage_PropBlacklist"]:format(v.name), true, true, Config.WebHooks.Props)
              CancelEvent()
              return
          end
          if Config.AntiProps.Punishment:lower() == "none" and not CheckPerms(src) then
              GetBanned(src, "Prop blacklist", transs[Config.Leng]["DiscordMessage_PropBlacklist"]:format(v.name), false, false, Config.WebHooks.Props)
              CancelEvent()
              return
          end
        end
      end
      PropsRegister[src] = (PropsRegister[src] or 0) + 1
      if PropsRegister[src] > 30 then
        if Config.AntiProps.PropsMassPunishment:lower() == "kick" and not CheckPerms(src) then
          GetBanned(src, "Prop blacklist", transs[Config.Leng]["DiscordMessage_PropBlacklistMassVehicles"], true, false, Config.WebHooks.Main)
          CancelEvent()
          return
        end
        if Config.AntiProps.PropsMassPunishment:lower() == "ban" and not CheckPerms(src) then
            GetBanned(src, "Prop blacklist", transs[Config.Leng]["DiscordMessage_PropBlacklistMassVehicles"], true, true, Config.WebHooks.Main)
            CancelEvent()
            return
        end
        if Config.AntiProps.PropsMassPunishment:lower() == "none" and not CheckPerms(src) then
            GetBanned(src, "Prop blacklist", transs[Config.Leng]["DiscordMessage_PropBlacklistMassVehicles"], false, false, Config.WebHooks.Main)
            CancelEvent()
            return
        end
        CancelEvent()
        return
      end
  end
end)
end

if Config.AntiPedSpawn.Toggle then
if Config.DebugPrint then
  cprint(transs[Config.Leng]["LoadedFeature"]:format("Anti peds"))
end
AddEventHandler("entityCreating", function(entity)
  if DoesEntityExist(entity) and GetEntityType(entity) == 1 then
    local src = NetworkGetEntityOwner(entity)
    local model = GetEntityModel(entity)  
    if GetEntityPopulationType(entity) == 6 or GetEntityPopulationType(entity) == 7 then
      for k, v in pairs(Config.AntiPedsSpawnList) do
        if GetHashKey(v.name) == model and not v.allowed then
          if Config.AntiProps.Punishment:lower() == "kick" and not CheckPerms(src) then
            GetBanned(src, "Ped blacklist", transs[Config.Leng]["DiscordMessage_PedBlacklist"]:format(v.name), true, false, Config.WebHooks.Peds)
            CancelEvent()
            return
          end
          if Config.AntiProps.Punishment:lower() == "ban" and not CheckPerms(src) then
              GetBanned(src, "Ped blacklist", transs[Config.Leng]["DiscordMessage_PedBlacklist"]:format(v.name), true, true, Config.WebHooks.Peds)
              CancelEvent()
              return
          end
          if Config.AntiProps.Punishment:lower() == "none" and not CheckPerms(src) then
              GetBanned(src, "Ped blacklist", transs[Config.Leng]["DiscordMessage_PedBlacklist"]:format(v.name), false, false, Config.WebHooks.Peds)
              CancelEvent()
              return
          end
        end
      end
      PedsRegister[src] = (PedsRegister[src] or 0) + 1
      if PedsRegister[src] > 20 then
        if Config.AntiProps.PropsMassPunishment:lower() == "kick" and not CheckPerms(src) then
          GetBanned(src, "Ped blacklist", transs[Config.Leng]["DiscordMessage_PedBlacklistMassVehicles"], true, false, Config.WebHooks.Peds)
          CancelEvent()
          return
        end
        if Config.AntiProps.PropsMassPunishment:lower() == "ban" and not CheckPerms(src) then
            GetBanned(src, "Ped blacklist", transs[Config.Leng]["DiscordMessage_PedBlacklistMassVehicles"], true, true, Config.WebHooks.Peds)
            CancelEvent()
            return
        end
        if Config.AntiProps.PropsMassPunishment:lower() == "none" and not CheckPerms(src) then
            GetBanned(src, "Ped blacklist", transs[Config.Leng]["DiscordMessage_PedBlacklistMassVehicles"], false, false, Config.WebHooks.Peds)
            CancelEvent()
            return
        end
        CancelEvent()
        return
      end
    end
  end
end)
end

-- AntiVPN -- 
if Config.AntiVPN.Toggle then
if Config.DebugPrint then
  cprint(transs[Config.Leng]["LoadedFeature"]:format("Anti VPN"))
end
local function OnPlayerConnecting(name, setKickReason, deferrals)
    local ip = tostring(GetPlayerEndpoint(source))
    deferrals.defer()
    Wait(0)
    deferrals.update(transs[Config.Leng]["LookingForVPN"])
    PerformHttpRequest( "https://blackbox.ipinfo.app/lookup/" .. ip, function(errorCode, resultDatavpn, resultHeaders)
            if ip == "127.0.0.1" or resultDatavpn == "N" then
                deferrals.done()
            else
                deferrals.done(transs[Config.Leng]["VPNSNotAllowedHere"])
            end
        end)
end
AddEventHandler("playerConnecting", OnPlayerConnecting)
end

-- Anti Clear ped taskts/freeze --
if Config.AntiClearPedTasks.Toggle then
AddEventHandler("clearPedTasksEvent", function(source, data)
    if data.immediately  then
      if Config.AntiClearPedTasks.Punishment:lower() == "kick" and not CheckPerms(src) then
        GetBanned(source, "Clear ped tasks", transs[Config.Leng]["AntiClearPedTasksInmediatly"], true, false, Config.WebHooks.Main)
        CancelEvent()
         return
      end
      if Config.AntiClearPedTasks.Punishment:lower() == "ban" and not CheckPerms(src) then
          GetBanned(source, "Clear ped tasks", transs[Config.Leng]["AntiClearPedTasksInmediatly"], true, true, Config.WebHooks.Main)
          CancelEvent()
          return
      end
      if Config.AntiClearPedTasks.Punishment:lower() == "none" and not CheckPerms(src) then
          GetBanned(source, "Clear ped tasks", transs[Config.Leng]["AntiClearPedTasksInmediatly"], false, false, Config.WebHooks.Main)
          CancelEvent()
          return
      end
    end
end)
end


-- Installer --

local resources = nil
RegisterCommand("Juliet", function(source, args, rawCommand)
if source == 0 then
  if args[1] == "i" then
    if args[2] then
      if not resources then resources = {0, 0, 0} end
      if args[2] == "all" then
        local resourcenum = GetNumResources()
        for i = 0, resourcenum-1 do
          local path = GetResourcePath(GetResourceByFindIndex(i))
          if string.len(path) > 4 then
            setall(path)
          end
        end
        cprint(transs[Config.Leng]["AnticheatSuccessfullyInstalled"])
      else
        local setin = GetResourcePath(args[2])
        if setin then
          setall(setin)
          cprint("------------------------------------------------------------------")
          cprint(transs[Config.Leng]["AnticheatSuccessfullyInstalled"])
        else
          cprint(transs[Config.Leng]["CommandDoesntExist"]:format(args[2]))
        end
      end
      resources = nil
    end
  end
  if args[1] == "ifx" then
    if args[2] then
      if not resources then resources = {0, 0, 0} end
      if args[2] == "all" then
        local resourcenum = GetNumResources()
        for i = 0, resourcenum-1 do
          local path = GetResourcePath(GetResourceByFindIndex(i))
          if string.len(path) > 4 then
            setallatfx(path)
          end
        end
        cprint(transs[Config.Leng]["AnticheatSuccessfullyInstalled"])
      else
        local setin = GetResourcePath(args[2])
        if setin then
          setallatfx(setin)
          cprint("------------------------------------------------------------------")
          cprint(transs[Config.Leng]["AnticheatSuccessfullyInstalled"])
        else
          cprint(transs[Config.Leng]["CommandDoesntExist"]:format(args[2]))
        end
      end
      resources = nil
    end
  end
  if args[1] == "unifx" then
    if not resources then resources = {0, 0, 0} end
    local resourcenum = GetNumResources()
    for i = 0, resourcenum-1 do
      local path = GetResourcePath(GetResourceByFindIndex(i))
      if string.len(path) > 4 then
        setallatfx(path, true)
      end
    end
    cprint(transs[Config.Leng]["AnticheatSuccessfullyInstalled"])
    resources = nil
  end
  if args[1] == "uni" then
    if not resources then resources = {0, 0, 0} end
    local resourcenum = GetNumResources()
    for i = 0, resourcenum-1 do
      local path = GetResourcePath(GetResourceByFindIndex(i))
      if string.len(path) > 4 then
        setall(path, true)
      end
    end
    cprint(transs[Config.Leng]["AnticheatSuccessfullyInstalled"])
    resources = nil
  end
end
end)

function setall(dir, bool)
local file = io.open(dir.."/__resource.lua", "r")
local tab = split(dir, "/")
local resname = tab[#tab]
tab = nil
if file then
  if not bool then
    file:seek("set", 0)
    local r = file:read("*a")
    file:close()
    local table1 = split(r, "\n")
    local found = false
    local found2 = false
    for a, b in ipairs(table1) do
      if b == "client_script 'client/hook.lua'" then
        found = true
      end
      if not found2 then
        local fi = string.find(b, "client_script") or -1
        local fin = string.find(b, "#") or -1
        if fi ~= -1 and (fin == -1 or fi < fin) then
          found2 = true
        end
      end
    end
    if found2 then
      r = r.."\nclient_script 'client/hook.lua'"
      if not found then
        os.remove(dir.."/__resource.lua")
        file = io.open(dir.."/__resource.lua", "w")
        if file then
          file:seek("set", 0)
          file:write(r)
          file:close()
        end
      end
      resources[2] = resources[2]+1
    else
      resources[3] = resources[3]+1
    end
  else
    file:seek("set", 0)
    local r = file:read("*a")
    file:close()
    local table1 = split(r, "\n")
    r = ""
    local found = false
    local found2 = false
    for a, b in ipairs(table1) do
      if b == "client_script 'client/hook.lua'" then
        found = true
      else
        r = r..b.."\n"
      end
    end
    if not found and not found2 then resources[3] = resources[3]+1 end
    if found then
      resources[2] = resources[2]+1
      os.remove(dir.."/__resource.lua")
      file = io.open(dir.."/__resource.lua", "w")
      if file then
        file:seek("set", 0)
        file:write(r)
        file:close()
      else
        cprint("Fallo al desinstalar el Anti-cheat de "..resname..".")
        found, found2 = false, false
      end
    end
    if found or found2 then
      cprint(transs[Config.Leng]["AnticheatUninstalledCorrectlyFrom"]:format(resname))
      resources[1] = resources[1]+1
    end
  end
else
  resources[3] = resources[3]+1
end
end




function setallatfx(dir, bool)
local file = io.open(dir.."/fxmanifest.lua", "r")
local tab = split(dir, "/")
local resname = tab[#tab]
tab = nil
if file then
  if not bool then
    file:seek("set", 0)
    local r = file:read("*a")
    file:close()
    local table1 = split(r, "\n")
    local found = false
    local found2 = false
    for a, b in ipairs(table1) do
      if b == "client_script 'client/hook.lua'" then
        found = true
      end
      if not found2 then
        local fi = string.find(b, "client_script") or -1
        local fin = string.find(b, "#") or -1
        if fi ~= -1 and (fin == -1 or fi < fin) then
          found2 = true
        end
      end
    end
    if found2 then
      r = r.."\nclient_script 'client/hook.lua'"
      if not found then
        os.remove(dir.."/fxmanifest.lua")
        file = io.open(dir.."/fxmanifest.lua", "w")
        if file then
          file:seek("set", 0)
          file:write(r)
          file:close()
        end
      end
      resources[2] = resources[2]+1
    else
      resources[3] = resources[3]+1
    end
  else
    file:seek("set", 0)
    local r = file:read("*a")
    file:close()
    local table1 = split(r, "\n")
    r = ""
    local found = false
    local found2 = false
    for a, b in ipairs(table1) do
      if b == "client_script 'client/hook.lua'" then
        found = true
      else
        r = r..b.."\n"
      end
    end
    if not found and not found2 then resources[3] = resources[3]+1 end
    if found then
      resources[2] = resources[2]+1
      os.remove(dir.."/fxmanifest.lua")
      file = io.open(dir.."/fxmanifest.lua", "w")
      if file then
        file:seek("set", 0)
        file:write(r)
        file:close()
      else
        cprint("Fallo al desinstalar el Anti-cheat de "..resname..".")
        found, found2 = false, false
      end
    end
    if found or found2 then
      cprint(transs[Config.Leng]["AnticheatUninstalledCorrectlyFrom"]:format(resname))
      resources[1] = resources[1]+1
    end
  end
else
  resources[3] = resources[3]+1
end
end


function searchall(dir, bool)
local file = io.popen("dir \""..dir.."\" /b /ad")
file:seek("set", 0)
local r1 = file:read("*a")
file:close()
local table1 = split(r1, "\n")
for a, b in ipairs(table1) do
  if string.len(b) > 0 then
    setall(dir.."/"..b, bool)
    searchall(dir.."/"..b, bool)
  end
end
end

function split(str, seperator)
local pos, arr = 0, {}
for st, sp in function() return string.find(str, seperator, pos, true) end do
  table.insert(arr, string.sub(str, pos, st-1))
  pos = sp + 1
end
table.insert(arr, string.sub(str, pos))
return arr
end



Citizen.CreateThread(function()
GetBansFromSql()

can(function(bool)
  if bool then
    print(bearprint:format(transs[Config.Leng]["VerifiedLogin"]) .. "^7")
    GetBansFromSql()
  else
    print(bearprint:format(transs[Config.Leng]["NotVerifiedLogin"]) .. "^7")
  --  while true do end 
  -- while true do end 
  -- while true do end 
  -- while true do end 
  end
end)

end)

