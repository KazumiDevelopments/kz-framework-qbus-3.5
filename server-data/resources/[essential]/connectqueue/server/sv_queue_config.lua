Config = {}

-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
--[[     ["STEAM_0:1:0000####"] = 1,
    ["steam:110000107aff8a1"] = 95, -- DOOFY
    ["steam:110000136f8f5d8"] = 95, -- FRAG
    ["steam:11000010b15d112"] = 20, -- Small_wenis
    ["steam:1100001129665FE"] = 20, -- SouthAmherst
    ["steam:1100001036be9ab"] = 70, -- NME 
    ["steam:11000010ce10a89"] = 30, -- pkrack5
    ["steam:11000010e0f20bb"] = 20, -- SacrificeHero -- Temp stream prio



    --ADMIN

    ["steam:110000105344178"] = 95, -- 
    ["steam:11000010feefcb4"] = 95, -- 
    ["steam:110000105359843"] = 95, -- 
    ["steam:110000106c9046a"] = 95, -- 
    ["steam:110000113024c28"] = 95, -- 
    ["steam:110000112c95f47"] = 95, --
    ["steam:1100001072f839f"] = 95, -- 
    ["steam:1100001088e9711"] = 95, -- 
    ["steam:110000117737a5a"] = 95, -- 

    ["ip:127.0.0.0"] = 85 ]]
}

Config.donorLevels = {
    --[1] = {Role = "Developer", Priority = 99},
    --[2] = {Role = "Staff", Priority = 90},
    --[3] = {Role = "Hero", Priority = 35},
    --[4] = {Role = "God", Priority = 30},
    --[5] = {Role = "VIP", Priority = 25},
    --[6] = {Role = "Platinum", Priority = 20},
    --[7] = {Role = "Silver", Priority = 15},
    --[8] = {Role = "Bronze", Priority = 10},
    --[9] = {Role = "Nitro", Priority = 5},
    --[10] = {Role = "Streamer", Priority = 4}
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 75

-- how long grace time lasts in seconds
Config.GraceTime = 480

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 30000 -- Change Back Later

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Joining...",
    connecting = "\xE2\x8F\xB3Connecting...",
    idrr = "\xE2\x9D\x97[Queue] Error: Couldn't retrieve any of your id's, try restarting.",
    err = "\xE2\x9D\x97[Queue] There was an error",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d in queue \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[Queue] Error: Error adding you to connecting list",
    timedout = "\xE2\x9D\x97[Queue] Error: Timed out?",
    --wlonly = "\xE2\x9D\x97[Queue] You must be whitelisted to join this server",
    wlonly = "\xE2\x9D\x97[Queue] You need to join the discord to play here.",
    steam = "\xE2\x9D\x97 [Queue] Error: Steam must be running"
}