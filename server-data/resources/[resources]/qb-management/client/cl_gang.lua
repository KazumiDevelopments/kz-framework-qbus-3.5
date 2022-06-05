local RLCore = exports['rl-core']:GetCoreObject()
local PlayerGang = {}
local shownGangMenu = false

-- UTIL
local function CloseMenuFullGang()
    exports['qb-menu']:closeMenu()
    shownGangMenu = false
end

local function DrawText3DGang(v, text)
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

local function comma_valueGang(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

--//Events
AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerGang = RLCore.Functions.GetPlayerData().gang
    end
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded', function()
    PlayerGang = RLCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('RLCore:Client:OnGangUpdate', function(InfoGang)
    PlayerGang = InfoGang
end)

RegisterNetEvent('qb-gangmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerGang.name, {
        maxweight = 4000000,
        slots = 100,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerGang.name)
end)

RegisterNetEvent('qb-gangmenu:client:Warbobe', function()
    TriggerEvent('rl-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qb-gangmenu:client:OpenMenu', function()
    shownGangMenu = true
    local gangMenu = {
        {
            header = "Gang Management  - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
        {
            header = "📋 Manage Gang Members",
            txt = "Recruit or Fire Gang Members",
            params = {
                event = "qb-gangmenu:client:ManageGang",
            }
        },
        {
            header = "💛 Recruit Members",
            txt = "Hire Gang Members",
            params = {
                event = "qb-gangmenu:client:HireMembers",
            }
        },
        {
            header = "🗄️ Storage Access",
            txt = "Open Gang Stash",
            params = {
                event = "qb-gangmenu:client:Stash",
            }
        },
        {
            header = "🚪 Outfits",
            txt = "Change Clothes",
            params = {
                event = "rl-outfits-ido:client:openOutfits",
            }
        },
        {
            header = "💰 Money Management",
            txt = "Check your Gang Balance",
            params = {
                event = "qb-gangmenu:client:SocietyMenu",
            }
        },
        {
            header = "Exit",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(gangMenu)
end)

RegisterNetEvent('qb-gangmenu:client:ManageGang', function()
    local GangMembersMenu = {
        {
            header = "Manage Gang Members - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
    }
    RLCore.Functions.TriggerCallback('qb-gangmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            GangMembersMenu[#GangMembersMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                params = {
                    event = "qb-gangmenu:lient:ManageMember",
                    args = {
                        player = v,
                        work = PlayerGang
                    }
                }
            }
        end
        GangMembersMenu[#GangMembersMenu + 1] = {
            header = "< Return",
            params = {
                event = "qb-gangmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(GangMembersMenu)
    end, PlayerGang.name)
end)

RegisterNetEvent('qb-gangmenu:lient:ManageMember', function(data)
    local MemberMenu = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
    }
    for k, v in pairs(RLCore.Shared.Gangs[data.work.name].grades) do
        MemberMenu[#MemberMenu + 1] = {
            header = v.name,
            txt = "Grade: " .. k,
            params = {
                isServer = true,
                event = "qb-gangmenu:server:GradeUpdate",
                args = {
                    cid = data.player.empSource,
                    degree = tonumber(k),
                    named = v.name
                }
            }
        }
    end
    MemberMenu[#MemberMenu + 1] = {
        header = "Fire",
        params = {
            isServer = true,
            event = "qb-gangmenu:server:FireMember",
            args = data.player.empSource
        }
    }
    MemberMenu[#MemberMenu + 1] = {
        header = "< Return",
        params = {
            event = "qb-gangmenu:client:ManageGang",
        }
    }
    exports['qb-menu']:openMenu(MemberMenu)
end)

RegisterNetEvent('qb-gangmenu:client:HireMembers', function()
    local HireMembersMenu = {
        {
            header = "Hire Gang Members - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
    }
    RLCore.Functions.TriggerCallback('qb-gangmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMembersMenu[#HireMembersMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    params = {
                        isServer = true,
                        event = "qb-gangmenu:server:HireMember",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMembersMenu[#HireMembersMenu + 1] = {
            header = "< Return",
            params = {
                event = "qb-gangmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(HireMembersMenu)
    end)
end)

RegisterNetEvent('qb-gangmenu:client:SocietyMenu', function()
    RLCore.Functions.TriggerCallback('qb-gangmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Balance: $" .. comma_valueGang(cb) .. " - " .. string.upper(PlayerGang.label),
                isMenuHeader = true,
            },
            {
                header = "💸 Deposit",
                txt = "Deposit Money",
                params = {
                    event = "qb-gangmenu:client:SocietyDeposit",
                    args = comma_valueGang(cb)
                }
            },
            {
                header = "💸 Withdraw",
                txt = "Withdraw Money",
                params = {
                    event = "qb-gangmenu:client:SocietyWithdraw",
                    args = comma_valueGang(cb)
                }
            },
            {
                header = "< Return",
                params = {
                    event = "qb-gangmenu:client:OpenMenu",
                }
            },
        }
        exports['qb-menu']:openMenu(SocietyMenu)
    end, PlayerGang.name)
end)

RegisterNetEvent('qb-gangmenu:client:SocietyDeposit', function(saldoattuale)
    local deposit = exports['qb-input']:ShowInput({
        header = "Deposit Money <br> Available Balance: $" .. saldoattuale,
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
        TriggerServerEvent("qb-gangmenu:server:depositMoney", tonumber(deposit.amount))
    end
end)

RegisterNetEvent('qb-gangmenu:client:SocietyWithdraw', function(saldoattuale)
    local withdraw = exports['qb-input']:ShowInput({
        header = "Withdraw Money <br> Available Balance: $" .. saldoattuale,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = '$'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("qb-gangmenu:server:withdrawMoney", tonumber(withdraw.amount))
    end
end)
