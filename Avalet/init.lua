---------------------------------------------------------------------------
-- Initialisierung des Avalet-Plugins
--
-- 
---------------------------------------------------------------------------
require "Avalet.scripts.character"
--require "Avalet.scripts.gui"
require "Avalet.scripts.atcp"


--if io.exists("/home/vadi/Desktop/file.tx") then
--  echo("This file exists!")
--else
--  echo("This file doesn't exist.")
--end

echo("Avalet init ...\n")

--on Install:
--setModulePriority("Avalet", 1)

-- Speicherort des Moduls
-- C:/Users/<usrdir>/Documents/Avalet/Avalet.mpackage
modulePath = getModulePath("Avalet")
--echo("Path zu Avalet-Modul: " .. path .. "\n" )

-- Speicherort des geladenen Profils
-- C:/Users/<usrdir>/.config/mudlet/profiles/Ava - Groundsel1
mudletHomeDir = getMudletHomeDir()
--echo("Path MudletHomeDir: " .. path .. "\n" )


function readFileFromFS(path)
	data = {}
	file = io.open (path, "r")
	data = yajl.to_value(file:read())
	file:close()
	return data
end

function writeDataToFS(path, data)
	file = io.open (path, "w")
	file:write(yajl.to_string(data))
	file:flush()
	file:close()
	return true
end

-- Dateien, die vom Modul geschrieben bzw. gelesen werden:
player = {}
avaletCharacterFile = "AvaletCharacter.json"
characterFilePath = getMudletHomeDir() .. "/" .. avaletCharacterFile
if io.exists(characterFilePath) then
	echo("Charakter-Datei ist vorhanden, versuche Datei zu laden...\n")
	player = readFileFromFS(characterFilePath)
	echo("...done\n")
else
  echo("Charakter-Datei nicht gefunden.\n")
	echo("Erzeuge Character-Objekt\n")
	player = Character()
	echo("...done\n")
	echo("Geladen: " .. player.vollername .. "\n")
	--echo("PlayerTPMAX: " .. player.stats.tp_max .. "\n")
end

echo("PlayerTP: " .. player.stats.tp .. "\n")
echo("PlayerTPMAX: " .. player.stats.tp_max .. "\n")

require "Avalet.scripts.gui"


--yajl.to_string(data)
--Encodes a Lua table into JSON data and returns it as a string. This function is very efficient - if you need to encode into JSON, use this.
--
--yajl.to_value(data)
--Decodes JSON data (as a string) into a Lua table. This function is very efficient - if you need to dencode into JSON, use this.


--if _LOADED["character"] ~= nil then
--	echo("vorher: character ist schon geladen")
--else
--	echo("vorher: character ist noch nicht geladen")
--end
--if _LOADED["character"] ~= nil then
--	echo("nachher: character ist schon geladen")
--else
--	echo("nachher: character ist noch nicht geladen")
--end

--echo("Erzeuge Player\n")
--player = Character()
--echo("fertig mit Erzeuge Player\n")
--echo("PlayerTP: " .. player.stats.tp .. "\n")
--echo("PlayerTPMAX: " .. player.stats.tp_max .. "\n")

--player.writeToFS()

--echo("Player auf Platte geschrieben\n")

--writeCharacterToFS(player)



--player = nil
--echo("Player gelöscht:\n")
--if player == nil then
--	echo ("nil\n")
--end

--player = readCharacterFromFS()


--echo("Player von Platte gelesen:\n")
--echo("PlayerTP: " .. player.stats.tp .. "\n")
--echo("PlayerTPMAX: " .. player.stats.tp_max .. "\n")



--table.save(getMudletHomeDir().."/avaletCharacterFile.json", player)

--player.writeToFS()
--raiseEvent("RefreshHealthBar", {"1", "10"})
--GUI.Health:setValue(player.stats.tp, player.stats.tp_max)
--GUI.Health:setValue(_G.player.stats.tp, _G.player.stats.tp_max)
--GUI.Health.front:echo("TP: (" .. _G.player.stats.tp .. "/" .. _G.player.stats.tp_max .. ")")

--raiseEvent("RefreshHealthBar", {5, 10})		


-- require "scripts.character"
--player = Character()
--require "scripts.gui"
--require "scripts.atpc"

--GUI.Health:setValue(player.stats.tp, _G.player.stats.tp_max)
--GUI.Health.front:echo("TP: (" .. player.stats.tp .. "/" .. _G.player.stats.tp_max .. ")")

--echo("player.stats.tp: " .. player.stats.tp .. "/n")
--echo("player.stats.tp_max: " .. player.stats.tp_max .. "/n")


--player = Character()
--gui = Gui()
-- gui = {}




-- Script: onKeyPad
-- fuer das Laufen per Keypad, und fuer das Catchen
-- der letzten Bewegung fuer den Mapper
-- und fuer das automatische Schwimmen/ Klettern
onKeyPadEvent = function ( eventName,key,tDirections )
	tDirections = {"sw","s","so","w","sc","o","nw","n","no","h","r","rein","raus"}
	--tPlayer.sLastMoveDirection=tDirections[key]
	send(tDirections[key],false)
--	if bAutoSchwimmen == true then
--		send("schwimm "..tDirections[key],false)
--		--send("b karte")
--	else
--		send(tDirections[key],false)
--		--send("b pflanzen")
--	end
end --function
registerAnonymousEventHandler("keyPadEvent", "onKeyPadEvent")


function onSysConnectionEvent()
	cecho("<red>sysConnectionEventHandler() running at this point.\n")
	echo("onConnect...\n")
	sendATCP("ava_set_mapper",1)
	sendATCP("ava_set_channel",1)
	sendATCP("ava_set_comm",1)
	sendATCP("ava_set_rcomm",1)
	sendATCP("ava_set_soul",1)
	sendATCP("ava_set_rsoul",1)
	--sendATCP("ava_set_soundpack",1)
	sendATCP("ava_req_update",1)
	sendATCP("ava_req_graphics_status",1)

end
registerAnonymousEventHandler("sysConnectionEvent", "onSysConnectionEvent")

function onSysExitEvent()
	cecho("<red>onSysExitEvent\n")
	echo("Schreibe Character in Datei...\n")
	writeDataToFS(characterFilePath, player)
	echo("...done\n")
end
registerAnonymousEventHandler("sysExitEvent", "onSysExitEvent")

-- Weitere interessante Events:
-- sysDisconnectionEvent
-- sysInstall
--Raised right after a module or package is being installed by any means. This can be used to display post-installation information or setup things.
--Event handlers receive the name of the installed package or module as additional argument. 
--sysUninstall
--Raised right before a module or package is being uninstalled by any means. This can be used to display post-removal information or for cleanup.
--Event handlers receive the name of the removed package or module as additional argument. 


----Script: fsysProtocolEnabled
--function onSysProtocolEnabled(event,arg)
--	if arg =="ATCP" then
--		echo("ATCP Support aktiviert.\n")
--		sendATCP("ava_set_mapper",1)
--		sendATCP("ava_set_channel",1)
--		sendATCP("ava_set_comm",1)
--		sendATCP("ava_set_rcomm",1)
--		sendATCP("ava_set_soul",1)
--		sendATCP("ava_set_rsoul",1)
--		--sendATCP("ava_set_soundpack",1)
--		sendATCP("ava_req_update",1)
--		sendATCP("ava_req_graphics_status",1)
--	else
--		echo("Support fuer "..arg.." aktiv ?!?\n")
--	end
--end
--registerAnonymousEventHandler("sysProtocolEnabled", "onSysProtocolEnabled")

-- Script: onConnect
--onConnect = function ()
--	echo("onConnect...\n")
--	sendATCP("ava_set_mapper",1)
--	sendATCP("ava_set_channel",1)
--	sendATCP("ava_set_comm",1)
--	sendATCP("ava_set_rcomm",1)
--	sendATCP("ava_set_soul",1)
--	sendATCP("ava_set_rsoul",1)
	--sendATCP("ava_set_soundpack",1)
--	sendATCP("ava_req_update",1)
--	sendATCP("ava_req_graphics_status",1)
--	--InitTopBox()
--	--InitBottomBox()
--	InitClock()
--	InitTopMenuBar()
--	InitGauges()
--	InitTimer()
--	InitInfoBox()
--	InitShieldBox()
--	fMetzelInit()
--	registerAnonymousEventHandler("onOneSecTimer", "UpdateGauges")
--	--registerAnonymousEventHandler("onOneSecTimer", "UpdateSchildWaffeAura")
--	registerAnonymousEventHandler("onOneSecTimer", "UpdateClock")
--	registerAnonymousEventHandler("onOneSecTimer", "UpdateTimer")
--	registerAnonymousEventHandler("onOneSecTimer", "UpdateInfoBox")
--	--registerAnonymousEventHandler("onOneSecTimer", "fMapBoxUpdate")
--	if disconnectTimer ~= nil then 
--		killTimer(disconnectTimer) 
--	end	
--end

-- registerAnonymousEventHandler("onConnectEvent", "onConnect")