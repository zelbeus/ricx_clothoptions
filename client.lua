----------------------------REDEMRP_MENU----------------------------
MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)
----------------------------END REDEMRP_MENU----------------------------

local optBandana = false
local optSleeve = false
local optSleeve2 = false

local list = {}
local list_f = {}
local ComponentNumber = {}

function reversedipairsiter(t, i)
    i = i - 1
    if i ~= 0 then
        return i, t[i]
    end
end

function reversedipairs(t)
    return reversedipairsiter, t, #t + 1
end

Citizen.CreateThread(function()
    for i,v in reversedipairs(cloth_hash_names) do
        if v.category_hashname ~= "BODIES_LOWER"
            and v.category_hashname ~= "BODIES_UPPER"
            and  v.category_hashname ~= "heads"
            and  v.category_hashname ~= "hair"
            and  v.category_hashname ~= "teeth"
            and  v.category_hashname ~= "eyes"
            and  v.category_hashname ~= "beards_chin"
            and  v.category_hashname ~= "beards_chops"
            and  v.category_hashname ~= ""
            and  v.category_hashname ~= "beards_mustache" then
            if v.ped_type == "female" and v.is_multiplayer then
                ComponentNumber[v.category_hashname] = 1
                if list_f[v.category_hashname] == nil then
                    list_f[v.category_hashname] = {}
                end
                table.insert(list_f[v.category_hashname], v.hash)
            elseif v.ped_type == "male" and v.is_multiplayer then
                ComponentNumber[v.category_hashname] = 1
                if  list[v.category_hashname] == nil then
                    list[v.category_hashname] = {}
                end
                table.insert(list[v.category_hashname], v.hash)
            end
        end
    end
end)

RegisterNetEvent('ricx_clothoptions:menu')
AddEventHandler('ricx_clothoptions:menu', function()
	MenuData.CloseAll()
    local elements = {
        {label = "Bandana", value = "bandana" , desc = "Toggle ON/OFF" },
		{label = "Sleeves 1", value = "sleeves" , desc = "Toggle ON/OFF" },
		{label = "Sleeves 2", value = "sleeves2" , desc = "Toggle ON/OFF" },
    }
    MenuData.Open(
        'default', GetCurrentResourceName(), 'clothoptions',
        {
            title    = "Cloth Options",
            subtext    = '',
            align    = 'top-right',
            elements =  elements,
        },
        function(data, menu)
            if data.current.value == "bandana" then
               TriggerServerEvent("ricx_clothoptions:getClothes", 0)
            elseif data.current.value == "sleeves" then
				TriggerServerEvent("ricx_clothoptions:getClothes", 1)
			elseif data.current.value == "sleeves2" then
				TriggerServerEvent("ricx_clothoptions:getClothes", 2)
            end
        end,
        function(data, menu)
            MenuData.CloseAll()
		end)
end)

RegisterNetEvent("ricx_clothoptions:bandana")
AddEventHandler("ricx_clothoptions:bandana", function(_prop)
	local prop = tonumber(_prop)
	local clist = {}
	if IsPedMale(PlayerPedId()) then
		clist = list
	else
		clist = list_f
	end
	if not optBandana then 
		Citizen.InvokeNative(0xAE72E7DF013AAA61, PlayerPedId(), clist.neckwear[prop], GetHashKey("BANDANA_ON_RIGHT_HAND"), 1, 0, -1082130432)
		Wait(700)
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(),  clist.neckwear[prop], -1829635046, 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		optBandana = true
	else
		Citizen.InvokeNative(0xAE72E7DF013AAA61, PlayerPedId(), clist.neckwear[prop], GetHashKey("BANDANA_OFF_RIGHT_HAND"), 1, 0, -1082130432)
		Wait(700)
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(), clist.neckwear[prop], GetHashKey("base"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		optBandana = false
	end
end)

RegisterNetEvent("ricx_clothoptions:sleeves")
AddEventHandler("ricx_clothoptions:sleeves", function(_prop)
	local prop = tonumber(_prop)
	local clist = {}
	if IsPedMale(PlayerPedId()) then
		clist = list
	else
		clist = list_f
	end
	if not optSleeve then 
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(),  clist.shirts_full[prop], GetHashKey("Closed_Collar_Rolled_Sleeve"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		optSleeve = true
	else
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(),  clist.shirts_full[prop], GetHashKey("BASE"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		optSleeve = false
	end
end)


RegisterNetEvent("ricx_clothoptions:sleeves2")
AddEventHandler("ricx_clothoptions:sleeves2", function(_prop)
	local prop = tonumber(_prop)
	local clist = {}
	if IsPedMale(PlayerPedId()) then
		clist = list
	else
		clist = list_f
	end
	if not optSleeve2 then 
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(),  clist.shirts_full[prop], GetHashKey("open_collar_rolled_sleeve"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		optSleeve2 = true
	else
		Citizen.InvokeNative(0x66B957AAC2EAAEAB, PlayerPedId(),  clist.shirts_full[prop], GetHashKey("base"), 0, true, 1)
		Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
		optSleeve2 = false
	end
end)
