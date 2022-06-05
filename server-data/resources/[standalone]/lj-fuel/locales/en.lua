local Translations = {
    notify = {
        ["no_money"] = "Don't not have enough money",
        ["refuel_cancel"] = "Refueling Canceled",
        ["jerrycan_full"] = "This jerry can is already full",
        ["vehicle_full"] = "This vehicle is already full",
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
