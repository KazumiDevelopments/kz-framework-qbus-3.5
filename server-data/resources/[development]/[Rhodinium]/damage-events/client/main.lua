-- Original resource made by Vespura https://github.com/DevTestingPizza/DamageEvents
-- I ported this resource awhile back but it should work properly

AddEventHandler('gameEventTriggered', function(event, data)
	if event == 'CEventNetworkEntityDamage' then
		local victim = tonumber(data[1])
		local attacker = tonumber(data[2])
		local victimDied = tonumber(data[4]) == 1
		local weapon = tonumber(data[7])
		local isMelee = tonumber(data[11]) ~= 0
		local vehicleDamageTypeFlag = tonumber(data[12])

		if victim ~= nil and attacker ~= nil then
			if victimDied then
				if IsEntityAVehicle(victim) then
					VehicleDestroyed(victim, attacker, weapon, isMelee, vehicleDamageTypeFlag)
				else
					if IsEntityAPed(victim) then
						if IsEntityAVehicle(attacker) then
							PedKilledByVehicle(victim, attacker)
						elseif IsEntityAPed(attacker) then
							if IsPedAPlayer(attacker) then
								local player = NetworkGetPlayerIndexFromPed(attacker)

								PedKilledByPlayer(victim, player, weapon, isMelee)
							else
								PedKilledByPed(victim, attacker, weapon, isMelee)
							end
						else
							PedDied(victim, attacker, weapon, isMelee)
						end
					else
						EntityKilled(victim, attacker, weapon, isMelee)
					end
				end
			else
				if not IsEntityAVehicle(victim) then
					EntityDamaged(victim, attacker, weapon, isMelee)
				else
					VehicleDamaged(victim, attacker, weapon, isMelee, vehicleDamageTypeFlag)
				end
			end
		end
	end
end)

function VehicleDestroyed(victim, attacker, weapon, isMelee, damageTypeFlag)
	TriggerEvent('DamageEvents:VehicleDestroyed', victim, attacker, weapon, isMelee, damageTypeFlag)
end

function PedKilledByVehicle(ped, vehicle)
	TriggerEvent('DamageEvents:PedKilledByVehicle', ped, vehicle)
end

function PedKilledByPlayer(ped, player, weapon, isMelee)
	TriggerEvent('DamageEvents:PedKilledByPlayer', ped, player, weapon, isMelee)
end

function PedKilledByPed(ped, attacker, weapon, isMelee)
	TriggerEvent('DamageEvents:PedKilledByPed', ped, attacker, weapon, isMelee)
end

function PedDied(ped, attacker, weapon, isMelee)
	TriggerEvent('DamageEvents:PedDied', ped, attacker, weapon, isMelee)
end

function EntityKilled(entity, attacker, weapon, isMelee)
	TriggerEvent('DamageEvents:EntityKilled', entity, attacker, weapon, isMelee)
end

function VehicleDamaged(vehicle, attacker, weapon, isMelee, damageTypeFlag)
	TriggerEvent('DamageEvents:VehicleDamaged', vehicle, attacker, weapon, isMelee, damageTypeFlag)
end

function EntityDamaged(entity, attacker, weapon, isMelee)
	TriggerEvent('DamageEvents:EntityDamaged', entity, attacker, weapon, isMelee)
end
