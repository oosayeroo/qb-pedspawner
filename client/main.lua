local initialSpawn = true
local QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
function QBCore.Functions.GetPlayerData(cb)
    if cb then
        cb(QBCore.PlayerData)
    else
        return QBCore.PlayerData
    end
end

RegisterNetEvent("spawnnpcs")
AddEventHandler("spawnnpcs", function()
    Wait(0)
	for k,v in ipairs(Config.Peds) do
		RequestModel(GetHashKey(v.Model))
		while not HasModelLoaded(GetHashKey(v.Model)) do
			Citizen.Wait(20)
		end
		if v.Anim ~= nil and v.AnimName ~= nil then
			RequestAnimDict(v.AnimDict)
			while not HasAnimDictLoaded(v.AnimDict) do
				Citizen.Wait(20)
			end
		end
		local npcSpawn = CreatePed(4, GetHashKey(v.Model), v.x, v.y, v.z, v.a, true, true)
		SetModelAsNoLongerNeeded(GetHashKey(v.Model))
		SetEntityAsMissionEntity(npcSpawn, true, true)
		SetNetworkIdExistsOnAllMachines(netid, true)
		if v.Relationship ~= nil then
			SetPedRelationshipGroupHash(npcSpawn, GetHashKey(v.Relationship))
		end
		if v.EnableBlip == true then
			blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite (blip, v.BlipSprite)
    		SetBlipDisplay(blip, 2)
   			SetBlipScale  (blip, v.BlipScale)
    		SetBlipAsShortRange(blip, true)
    		SetBlipColour(blip, v.BlipColour)
    		BeginTextCommandSetBlipName("STRING")
    		AddTextComponentSubstringPlayerName(v.BlipName)
    		EndTextCommandSetBlipName(blip)
		end
		if v.IgnoreEvents == true then
			SetBlockingOfNonTemporaryEvents(npcSpawn, true)
			SetPedFleeAttributes(npcSpawn, 0, 0)
		end
		if v.WalkAround == true then
			FreezeEntityPosition(npcSpawn, false)
			TaskWanderStandard(npcSpawn, 10.0, 10)
			SetPedKeepTask(npcSpawn, true)
		end
		if v.PatrolArea == true then
			FreezeEntityPosition(npcSpawn, false)
			TaskWanderInArea(npcSpawn, v.x, v.y, v.z, v.Radius, v.WalkBeforeRest, v.RestBreak)
			SetPedKeepTask(npcSpawn, true)
		end
		if v.CustomHealth == true and v.Male == true then
			SetPedMaxHealth(npcSpawn, v.HealthAmount)
			SetEntityHealth(npcSpawn, v.HealthAmount)
		else
			SetPedMaxHealth(npcSpawn, 100)
			SetEntityHealth(npcSpawn, 100)
		end
		if v.Soldier == true then
			SetPedSeeingRange(npcSpawn, v.SightRange)
			SetPedHearingRange(npcSpawn, v.HearRange)
			SetPedCombatAttributes(npcSpawn, 46, 1)
			SetPedFleeAttributes(npcSpawn, 0, true)
			SetPedCombatRange(npcSpawn,2)
			SetPedAccuracy(npcSpawn, v.Accuracy)
		end
		if v.CustomMovement == true then
			SetPedMovementClipset(npcSpawn, v.MovementClipset)
		end
		if v.GiveArmour == true then
			SetPedArmour(npcSpawn, v.ArmourAmount)
		end
		if v.Armed == true then
			GiveWeaponToPed(npcSpawn, GetHashKey(v.Weapon), v.AmmoCount, false, true)
		end
		if v.God == true then
			SetEntityProofs(npcSpawn, true, true, true, false, true, true, true, true)
		end
		if v.Target == true then
			if v.JobLocked == true then
				exports[Config.TargetName]:AddTargetEntity(npcSpawn, {
					options = {
						{
							type = v.Type,
							event = v.Event,
							icon = v.Icon,
							label = v.Label,
							job = v.Job,
					}
				},
				distance = v.Distance
			})
			elseif v.GangLocked == true then
				exports[Config.TargetName]:AddTargetEntity(npcSpawn, {
					options = {
						{
							type = v.Type,
							event = v.Event,
							icon = v.Icon,
							label = v.Label,
							gang = v.Gang,
					}
				},
				distance = v.Distance
			})
			elseif v.CitizenLocked == true then
				exports[Config.TargetName]:AddTargetEntity(npcSpawn, {
					options = {
						{
							type = v.Type,
							event = v.Event,
							icon = v.Icon,
							label = v.Label,
							citizenid = v.CitizenID,
					}
				},
				distance = v.Distance
			})
			else
			exports[Config.TargetName]:AddTargetEntity(npcSpawn, {
				options = {
					{
						type = v.Type,
						event = v.Event,
						icon = v.Icon,
						label = v.Label,
				}
			},
			distance = v.Distance
			})
			end
		end
		if v.AnimDict ~= nil and v.AnimName ~= nil then
			TaskPlayAnim(npcSpawn, v.AnimDict, v.AnimName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		end
	end
end)

AddEventHandler("playerSpawned", function()
	if initialSpawn and GetNumberOfPlayers() == 1 then
		TriggerServerEvent("collectnpcs")
		initialSpawn = false
	end
end)
