local framework = require 'modules/framework'

if framework.Name == 'custom' then
  -- TOOD: Add Event Handlers for when a CHARACTER is loaded / unloaded 
  --       And trigger the versa_sdk:framework:playerLoaded event
  --       And trigger the client event versa_sdk:framework:playerLoaded

  -- REPLACE ME :)
  AddEventHandler('YourCustomFramework:CharacterLoaded', function(source)
    TriggerEvent('versa_sdk:framework:playerLoaded', source)
    TriggerClientEvent('versa_sdk:framework:playerLoaded', source)
  end)

  -- REPLACE ME :)
  AddEventHandler('YourCustomFramework:CharacterUnloaded', function(source)
    TriggerEvent('versa_sdk:framework:playerUnloaded', source)
    TriggerClientEvent('versa_sdk:framework:playerUnloaded', source)
  end)

elseif framework.Name == 'qbox' then
  AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    TriggerEvent('versa_sdk:framework:playerLoaded', Player.PlayerData.source)
    TriggerClientEvent('versa_sdk:framework:playerLoaded', Player.PlayerData.source)
  end)

  AddEventHandler('QBCore:Server:OnPlayerUnload', function(source)
    TriggerEvent('versa_sdk:framework:playerUnloaded', source)
    TriggerClientEvent('versa_sdk:framework:playerUnloaded', source)
  end)

elseif framework.Name == 'qbcore' then
  AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    TriggerEvent('versa_sdk:framework:playerLoaded', Player.PlayerData.source)
    TriggerClientEvent('versa_sdk:framework:playerLoaded', Player.PlayerData.source)
  end)

  AddEventHandler('QBCore:Server:OnPlayerUnload', function(source)
    TriggerEvent('versa_sdk:framework:playerUnloaded', source)
    TriggerClientEvent('versa_sdk:framework:playerUnloaded', source)
  end)

elseif framework.Name == 'esx' then
  AddEventHandler('esx:playerLoaded', function(playerId, xPlayer, isNew)
    TriggerEvent('versa_sdk:framework:playerLoaded', playerId)
    TriggerClientEvent('versa_sdk:framework:playerLoaded', playerId)
  end)

  AddEventHandler('esx:playerLogout', function(playerId)
    TriggerEvent('versa_sdk:framework:playerUnloaded', playerId)
    TriggerClientEvent('versa_sdk:framework:playerUnloaded', playerId)
  end)

else
  CreateThread(function()
    while true do
      error('Missing Framework Runtime setup for framework: ' .. tostring(framework.Name))
      Wait(5000)
    end
  end)
end