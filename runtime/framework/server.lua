-- Some frameworks require an import to access their core functionality so we define
-- the object globally in the runtime on server start to avoid doing it during runtime
if GetResourceState('qb-core') == 'started' then
  QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('es_extended') == 'started' then
  ESX = exports['es_extended']:getSharedObject()
elseif GetResourceState('ox_core') == 'started' then
  Ox = require '@ox_core.lib.init'
end