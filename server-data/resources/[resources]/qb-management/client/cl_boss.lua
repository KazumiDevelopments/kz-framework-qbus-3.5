local RLCore = exports['rl-core']:GetCoreObject()
local PlayerJob = {}
local shownBossMenu = false

-- UTIL
local function CloseMenuFull()
    exports['qb-menu']:closeMenu()
    shownBossMenu = false
end

local function DrawText3D(v, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(v, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 0)
    ClearDrawOrigin()
end

local function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerJob = RLCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded', function()
    PlayerJob = RLCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('qb-bossmenu:client:OpenMenu', function()
    shownBossMenu = true
    local bossMenu = {
        {
            header = "Boss Menu - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
        {
            header = "📋 Manage Employees",
            txt = "Check your Employees List",
            params = {
                event = "qb-bossmenu:client:employeelist",
            }
        },
        {
            header = "💛 Hire Employees",
            txt = "Hire Nearby Civilians",
            params = {
                event = "qb-bossmenu:client:HireMenu",
            }
        },
        {
            header = "🗄️ Storage Access",
            txt = "Open Storage",
            params = {
                event = "qb-bossmenu:client:Stash",
            }
        },
        {
            header = "🚪 Outfits",
            txt = "See Saved Outfits",
            params = {
                event = "rl-outfits-ido:client:openOutfitsMenu",
            }
        },
        {
            header = "💰 Money Management",
            txt = "Check your Company Balance",
            params = {
                event = "qb-bossmenu:client:SocietyMenu",
            }
        },
        {
            header = "Exit",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('qb-bossmenu:client:employeelist', function()
    local EmployeesMenu = {
        {
            header = "Manage Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
    }
    RLCore.Functions.TriggerCallback('qb-bossmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            EmployeesMenu[#EmployeesMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                params = {
                    event = "qb-bossmenu:client:ManageEmployee",
                    args = {
                        player = v,
                        work = PlayerJob
                    }
                }
            }
        end
        EmployeesMenu[#EmployeesMenu + 1] = {
            header = "< Return",
            params = {
                event = "qb-bossmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(EmployeesMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:ManageEmployee', function(data)
    local EmployeeMenu = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
    }
    for k, v in pairs(RLCore.Shared.Jobs[data.work.name].grades) do
        EmployeeMenu[#EmployeeMenu + 1] = {
            header = v.name,
            txt = "Grade: " .. k,
            params = {
                isServer = true,
                event = "qb-bossmenu:server:GradeUpdate",
                args = {
                    cid = data.player.empSource,
                    grado = tonumber(k),
                    nomegrado = v.name
                }
            }
        }
    end
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Fire Employee",
        params = {
            isServer = true,
            event = "qb-bossmenu:server:FireEmployee",
            args = data.player.empSource
        }
    }
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "< Return",
        params = {
            event = "qb-bossmenu:client:OpenMenu",
        }
    }
    exports['qb-menu']:openMenu(EmployeeMenu)
end)

RegisterNetEvent('qb-bossmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerJob.name, {
        maxweight = 4000000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:Wardrobe', function()
    TriggerEvent('rl-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qb-bossmenu:client:HireMenu', function()
    local HireMenu = {
        {
            header = "Hire Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
    }
    RLCore.Functions.TriggerCallback('qb-bossmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMenu[#HireMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    params = {
                        isServer = true,
                        event = "qb-bossmenu:server:HireEmployee",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMenu[#HireMenu + 1] = {
            header = "< Return",
            params = {
                event = "qb-bossmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(HireMenu)
    end)
end)

RegisterNetEvent('qb-bossmenu:client:SocietyMenu', function()
    RLCore.Functions.TriggerCallback('qb-bossmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Balance: $" .. comma_value(cb) .. " - " .. string.upper(PlayerJob.label),
                isMenuHeader = true,
            },
            {
                header = "💸 Deposit",
                txt = "Deposit Money into account",
                params = {
                    event = "qb-bossmenu:client:SocetyDeposit",
                    args = comma_value(cb)
                }
            },
            {
                header = "💸 Withdraw",
                txt = "Withdraw Money from account",
                params = {
                    event = "qb-bossmenu:client:SocetyWithDraw",
                    args = comma_value(cb)
                }
            },
            {
                header = "< Return",
                params = {
                    event = "qb-bossmenu:client:OpenMenu",
                }
            },
        }
        exports['qb-menu']:openMenu(SocietyMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qb-bossmenu:client:SocetyDeposit', function(money)
    local deposit = exports['qb-input']:ShowInput({
        header = "Deposit Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        TriggerServerEvent("qb-bossmenu:server:depositMoney", tonumber(deposit.amount))
    end
end)

RegisterNetEvent('qb-bossmenu:client:SocetyWithDraw', function(money)
    local withdraw = exports['qb-input']:ShowInput({
        header = "Withdraw Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("qb-bossmenu:server:withdrawMoney", tonumber(withdraw.amount))
    end
end)

-- MAIN THREAD
--[[ CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local inRangeBoss = false
        local nearBossmenu = false
        for k, v in pairs(Config.Jobs) do
            if k == PlayerJob.name and PlayerJob.isboss then
                if #(pos - v) < 5.0 then
                    inRangeBoss = true
                    if #(pos - v) <= 1.5 then
                        if not shownBossMenu then DrawText3D(v, "~b~E~w~ - Open Job Management") end
                        nearBossmenu = true
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("qb-bossmenu:client:OpenMenu")
                        end
                    end
                    
                    if not nearBossmenu and shownBossMenu then
                        CloseMenuFull()
                        shownBossMenu = false
                    end
                end
            end
        end
        if not inRangeBoss then
            Wait(1500)
            if shownBossMenu then
                CloseMenuFull()
                shownBossMenu = false
            end
        end
        Wait(3)
    end
end) ]]
