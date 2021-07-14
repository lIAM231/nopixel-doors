--LiamInChains#9999 Do not dm for support.
local doors = {}
local elevators = {}

RegisterNetEvent('np-doors:request-lock-state')
AddEventHandler('np-doors:request-lock-state', function()
    local src = source
    TriggerClientEvent('np-doors:initial-lock-state', src, doors)
end)

RegisterNetEvent('np-doors:change-lock-state')
AddEventHandler('np-doors:change-lock-state', function(pDoorId, pDoorLockState)
    if doors[pDoorId] then
        doors[pDoorId].lock = pDoorLockState
        TriggerClientEvent('np-doors:change-lock-state', -1, pDoorId, pDoorLockState)
    end
end)

Citizen.CreateThread(function()
    for _,door in ipairs(DOOR_CONFIG) do
        doors[#doors + 1] = door
    end
end)

RegisterNetEvent("np-doors:save-config")
AddEventHandler("np-doors:save-config", function(pDoorData)
    if pDoorData ~= nil then
        local fileHandle = io.open("doorCoords.log", "a")
        if fileHandle then
            fileHandle:write(json.encode(pDoorData))
        end
        fileHandle:close()
    end
end)

RPC.register("np-doors:elevators:fetch", function()
    return NPX.Elevators or {}
end)

