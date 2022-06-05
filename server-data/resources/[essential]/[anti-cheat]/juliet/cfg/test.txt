Config = {}
Config.Leng = "EN"
Config.DebugPrint = true
Config.WebHooks = {
    Main = "https://discord.com/api/webhooks/809638607320907776/FlI4GK5w92L8Y8p8TNCmM6hGujUbb1voke9M0jBT66RuULMGZdLl5WUU7Q9KHPTvtGId",
    Weapon = "https://discord.com/api/webhooks/809638818465841162/-K-PF7VrjWcMGfrvlVs4n7CjijcN4SnpvVlRwaMQOB_CHQb-ylcxdYYcdV5-hwFQJ2YQ",
    Vehicle = "https://discord.com/api/webhooks/809638933322530868/zTzvC5OjBQ-BtId0e4RcFhhIkZziSyObLBF8yiGzntQoL0kPDqXP8q94Qn-Ind_Ca3DV",
    Props = "https://discord.com/api/webhooks/809639048410562580/dRniPX-Wp5lZrjvITHYJmv7KM3pQmOl1kMEiOHlwEwYIJPGUV7Rk0L7OxUmaAnyo0NxJ",
    Explosions = "https://discord.com/api/webhooks/809639146501963798/f1XTS_vrDoLJ5qMR2VtlC96TtT_VXURXe9m8m5UWgU2RE_A8PobZFhw3Ktr8vHxHo0ZT",
    Peds = "https://discord.com/api/webhooks/809639223610441728/uCqEUmBLAdPkJyNNsN7Amcqvw_3YBDwO5EeIAySiyP1xvSBvQkE_3Sh7XFuBYfBCgxsu",
    HeartBeat = "https://discord.com/api/webhooks/809639288895438878/wXZhYY6I0sjF9CokQpAv3EXHEh-EEe4net5d0uNg4c2xMX150i5wh70ABxYUhnAfCFOR",
    StopMen = "https://discord.com/api/webhooks/809886698855071784/VFgDVYxvlezAq45jlpyugUmSpxNtiIErw6hTyXTyRvVx7tqJB2iAIL2YMYzqf3yC2hip",
}
Config.License = ''
Config.SupportScreenShots = true-- requierements https://github.com/jaimeadf/discord-screenshot  and https://github.com/jaimeadf/screenshot-basic
Config.DrawSpriteWhenBan = false
Config.RenewUserBan = true -- If the user is banned and he tries to connect it wil ban the new credentials
Config.WeaponBlacklist = {
    Toggle = true,
    Punishment = "NONE", -- BAN/KICK/NONE
    MaxAmmo = 250, -- max ammo for users
}

Config.VehicleBlacklist = {
    Toggle = true,
    Punishment = "NONE",
    VehicleMassPunishment = "NONE"
}

Config.AntiProps = {
    Toggle = true,
    Punishment = "NONE",
    PropsMassPunishment = "NONE"
}

Config.AntiPedSpawn = {
    Toggle = true, 
    Punishment = "NONE",
    PedsMassPuunishment = "NONE"
}

Config.AntiSpectate = {
    Toggle = true,
    Punishment = "NONE"
}

Config.AntiStop = {
    Toggle = true,
    Punishment = "NONE"
}

Config.AntiEulenAntiStart = {
    -- this checks the resource count
    Toggle = true,
    Punishment = "NONE"
}

Config.AntiVPN = {
    Toggle = true,
    Punishment = "NONE"
}

Config.AntiClearPedTasks = {
    Toggle = true,
    Punishment = "NONE",
}

Config.ExplosionsCheck = {
    Toggle = true,
}


Config.Perms = {
    God = "JulietAll", -- this will allow the user all the perms below and bypass all the protections (NOT RECOMENDED)
}

