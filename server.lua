RegisterServerEvent('ricx_clothoptions:getClothes')
AddEventHandler('ricx_clothoptions:getClothes', function(id)
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        TriggerEvent("redemrp_clothing:retrieveClothes", identifier, charid, function(call)
            if call then
                local comps = json.decode(call.clothes)
                if tonumber(id) == 0 then
                    if tonumber(comps.neckwear) ~= 1 then
                        TriggerClientEvent("ricx_clothoptions:toggle", _source, comps.neckwear, tonumber(id))
                    end
                elseif tonumber(id) == 1 then
                    if tonumber(comps.shirts_full) ~= 1 then
                        TriggerClientEvent("ricx_clothoptions:toggle", _source, comps.shirts_full, tonumber(id))
                    end
                elseif tonumber(id) == 2 then
                    if tonumber(comps.shirts_full) ~= 1 then
                        TriggerClientEvent("ricx_clothoptions:toggle", _source, comps.shirts_full, tonumber(id))
                    end
                end
            end
        end)
    end)
end)

RegisterCommand("clothoptions", function(source, args) 
    local _source = source
    TriggerClientEvent("ricx_clothoptions:menu",_source)
end)

