local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.Jobnaam) then
            for k in pairs(Config.Klerenkast) do
                DrawMarker(Config.KlerenkastMarkerTypen, Config.Klerenkast[k].x, Config.Klerenkast[k].y, Config.Klerenkast[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.KlerenkastMarkerGroten.x, Config.KlerenkastMarkerGroten.y, Config.KlerenkastMarkerGroten.z, Config.KlerenkastMarkerKleur.r, Config.KlerenkastMarkerKleur.g, Config.KlerenkastMarkerKleur.b, 100, false, true, 2, true, false, false, false)
            end
        end
        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    while true do
        if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.Jobnaam) then
            for k in pairs(Config.Klerenkast) do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Klerenkast[k].x, Config.Klerenkast[k].y, Config.Klerenkast[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.KlerenkastMarkerGroten.x, Config.KlerenkastMarkerGroten.y, Config.KlerenkastMarkerGroten.z, Config.KlerenkastMarkerKleur.r, Config.KlerenkastMarkerKleur.g, Config.KlerenkastMarkerKleur.b, 100, false, true, 2, true, false, false, false)

                if dist <= 1.5 then 
				    hintToDisplay(_U('menu_knop'))
				
				    if IsControlJustPressed(0, Keys['E']) then
					    JobLocker()
                    end
				end			
            end
        end
        Citizen.Wait(5)
    end
end)

function JobLocker()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gang_cloakroom', {
		title    = _U('kleren_menu'),
		align    = 'top-right',
		elements = {
			{label = _U('burger_kleren'),  value = 'wear_citizen'},
			{label = _U('jobkleren_1'),    value = 'wear_work'},
            {label = _U('jobkleren_2'),    value = 'wear_work2'},
            {label = _U('jobkleren_3'),    value = 'wear_work3'},
            {label = _U('jobkleren_4'),    value = 'wear_work4'},
            {label = _U('jobkleren_5'),    value = 'wear_work5'},
            {label = _U('jobkleren_6'),    value = 'wear_work6'}
	}}, function(data, menu)
        menu.close()
		if data.current.value == 'wear_citizen' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
                ESX.ShowNotification(_U('kleren_burger'))
			end)
		elseif data.current.value == 'wear_work' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if Config.JobKleren.jobSkin.male ~= nil then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin.male)
					ESX.ShowNotification(_U('kleren_job'))

                elseif Config.JobKleren.jobSkin.female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin.female)
					ESX.ShowNotification(_U('kleren_job'))
				end
			end)
        elseif data.current.value == 'wear_work2' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if Config.JobKleren.jobSkin2.male ~= nil then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin2.male)
					ESX.ShowNotification(_U('kleren_job'))

                elseif Config.JobKleren.jobSkin2.female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin2.female)
					ESX.ShowNotification(_U('kleren_job'))
				end
            end)
        elseif data.current.value == 'wear_work3' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if Config.JobKleren.jobSkin3.male ~= nil then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin3.male)
					ESX.ShowNotification(_U('kleren_job'))

                elseif Config.JobKleren.jobSkin3.female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin3.female)
					ESX.ShowNotification(_U('kleren_job'))
				end
            end)
        elseif data.current.value == 'wear_work4' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if Config.JobKleren.jobSkin4.male ~= nil then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin4.male)
					ESX.ShowNotification(_U('kleren_job'))

                elseif Config.JobKleren.jobSkin4.female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin4.female)
					ESX.ShowNotification(_U('kleren_job'))
				end
            end)
        elseif data.current.value == 'wear_work5' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if Config.JobKleren.jobSkin5.male ~= nil then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin5.male)
					ESX.ShowNotification(_U('kleren_job'))

                elseif Config.JobKleren.jobSkin5.female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin5.female)
					ESX.ShowNotification(_U('kleren_job'))
				end
            end)
        elseif data.current.value == 'wear_work6' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if Config.JobKleren.jobSkin6.male ~= nil then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin6.male)
					ESX.ShowNotification(_U('kleren_job'))

                elseif Config.JobKleren.jobSkin6.female ~= nil then
					TriggerEvent('skinchanger:loadClothes', skin, Config.JobKleren.jobSkin6.female)
					ESX.ShowNotification(_U('kleren_job'))
				end
            end)
        end

	end, function(data, menu)
		menu.close()
	end)
end

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end