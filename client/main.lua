local cooldowns = {}
AddEventHandler('entityDamaged',function(victim)
  if cooldowns[victim] and cooldowns[victim] >= GetGameTimer() then return end

  if not IsPedAPlayer(victim) then return end
  if victim ~= PlayerPedId() then return end
  if not IsEntityDead(victim) then return end

  local killerPed = GetPedSourceOfDeath(victim)
  if not IsPedAPlayer(killerPed) then return end

  local killerPlayer = NetworkGetPlayerIndexFromPed(killerPed)
  local killerSource = GetPlayerServerId(killerPlayer)

  local player = NetworkGetPlayerIndexFromPed(victim)
  TriggerServerEvent('elimination',killerSource,GetPlayerName(player))

  cooldowns[victim] = GetGameTimer() + 1000
end)

RegisterNetEvent('elimination',function(dead)
  SendNUIMessage({ action = 'toddy:elimination', data = dead })
end)