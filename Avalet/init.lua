---------------------------------------------------------------------------
-- Initialisierung des Avalet-Plugins
--
-- 
---------------------------------------------------------------------------

require "Avalet.scripts.logger"


-- DEBUG
debug_mode = false

if debug_mode then
	--echo("debug ist an\n")
else
	--echo("debug ist aus\n")
end


-- Folgende Ausgabe erscheint in der Error-Console des Script-Editors von Mudlet:
--debugc(" Trigger successful!")

-- ENDE DEBUG

--function firstToUpper(str)
--    return (str:gsub("^%l", string.upper))
--end


function readFileFromFS(path, mode)
	data = {}
	file = io.open (path, mode)
	data = yajl.to_value(file:read())
	file:close()
	return data
end

function writeDataToFS(path, data, mode)
	file = io.open (path, mode)
	file:write(yajl.to_string(data))
	file:flush()
	file:close()
	return true
end

require "Avalet.scripts.character"
--require "Avalet.scripts.gui" -- jetzt weiter unten
require "Avalet.scripts.atcp"
require "Avalet.scripts.timer"

--if io.exists("/home/vadi/Desktop/file.tx") then
--  echo("This file exists!")
--else
--  echo("This file doesn't exist.")
--end

echo("Avalet init ...\n")

player = {}
player = Character()

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

-----------------------------------------------------------
-- Dateien, die vom Modul geschrieben bzw. gelesen werden:
-----------------------------------------------------------
-- Die Charakter-Daten werden in eine Datei persistiert und von da auch
-- geladen. Der Grund ist, dass nach einem disconnect und einem anschliessenden
-- reconnect die Daten nicht unbedingt sofort per ATCP gesendet werden. (Nach 
-- normalen Login aber schon(?)) Weshalb die Character-Informationen auf der
-- Oberfläche nicht oder nicht vollständig vorhanden wären. Und genau so wenig
-- die Anzeige für TP, ZP etc. Oder übrig gebliebene Timer. Also es wäre dann
-- nix da.
-- Das Problem ist, dass nicht alle Spieler für jeden Char ein eigenes Profil haben,
-- sondern dass sie oft mehrere Chars mit einem Profil spielen. Hier muss irgendwie
-- entschieden werden, welches die richtigen Character-Daten sind. (Und es müssen
-- auch verschiedene Versionen dieser Daten rausgeschrieben werden. Vermutlich 
-- unterschieden durch den Character-Namen im Dump-File-Namen. Aber der steht
-- erst zur Verfügung, wenn ATCP das erste Mal den Character-Namen geschickt hat.)
-- Lösung: Hier wird das Player-Objekt leer initialisiert, die Anzeige auf der
-- Oberfläche wird entsprechend gestaltet. ("Warten auf Daten...", "Du bist offline"
-- oder so) Wenn das Mud den CharNamen sendet, wird die dazugehörige Char-Datei ge-
-- laden und von da an verwendet.
--avaletCharacterFile = ""
avaletCharacterFilePrefix = "AvaletCharacter"
avaletCharacterFileExtension = ".json"
function loadCharacterFileFromDisk(charName)
	--debugc("<magenta>Unerwünschter Aufruf?\n")
	characterFilePath = getMudletHomeDir() .. "/" .. avaletCharacterFilePrefix .. string.title(charName) .. avaletCharacterFileExtension
	--echo(characterFilePath .. "\n")
	if io.exists(characterFilePath) then
		--echo("Charakter-Datei ist vorhanden, versuche Datei zu laden:\n" .. characterFilePath .. "\n")
		player = readFileFromFS(characterFilePath, "r")
		--echo("...done\n")
	else
	    --echo("Charakter-Datei nicht gefunden.\n")
		--echo("Erzeuge Character-Objekt\n")
		player = Character()
		--echo("...done\n")
		writeDataToFS(characterFilePath, player, "w")
	end
end



chatLaber = ""
chatSchwafel = ""
chatRede = ""
chatSag = ""
function loadFileFromDisk(filePath)
	if io.exists(filePath) then
		--echo("Datei ist vorhanden.\n")
	end
	--echo("Datei ist vorhanden oder wird erzeugt:\n" .. filePath .. "\n")
	--return [[readFileFromFS(filePath, "a")]]
	--return "verdammte Axt!"
	--echo("...done\n")
	--if io.exists(filePath) then
	--	echo("FEHLER: Datei immer noch nicht vorhanden.\n")
	--end
	return "bla"
end

-----------------------------------------------------------
-- Dateien, in die Chatverläufe gespeichert werden (und die
-- dann in den Tabs angezeigt werden):
-----------------------------------------------------------
chatLaberFileName = "AvaletComLaber.txt"
chatLaberFile = getMudletHomeDir() .. "/" .. chatLaberFileName
--chatLaber = loadFileFromDisk(chatLaberFile)
--writeDataToFS(chatLaberFile, chatLaber, "w")

chatSchwafelFileName = "AvaletComSchwafel.txt"
chatSchwafelFile = getMudletHomeDir() .. "/" .. chatSchwafelFileName
--chatSchwafel = loadFileFromDisk(chatSchwafelFile)

chatRedeFileName = "AvaletComRede.txt"
chatRedeFile = getMudletHomeDir() .. "/" .. chatRedeFileName
--chatRede = loadFileFromDisk(chatRedeFile)

chatSagFileName = "AvaletComSag.txt"
chatSagFile = getMudletHomeDir() .. "/" .. chatSagFileName
--chatSag = loadFileFromDisk(chatSagFile)

-- volk
-- gilde
-- zunft?
-- gruppe





require "Avalet.scripts.gui"
require "Avalet.scripts.gui_view"

-------------------------------------------------------------------------------------
--
-- Timer
--
-------------------------------------------------------------------------------------
-- create a timer in the "first timer group" group
--permTimer("my timer", "first timer group", 4.5, [[send ("my timer that's in my first timer group fired!")]])
-- create a timer that's not in any group; just at the top
--permTimer("my timer", "", 4.5, [[send ("my timer that's in my first timer group fired!")]])

-- enable timer - they start off disabled until you're ready
--enableTimer("my timer")

-------------------------------------------------------------------------------------
--
-- Trigger
--
-------------------------------------------------------------------------------------

-- Create a regex trigger that will match on the prompt to record your status
--permRegexTrigger("Prompt", "", {"^(\d+)h, (\d+)m"}, [[health = tonumber(matches[2]); mana = tonumber(matches[3])]])



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
	player.lastMove = tDirections[key]
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
	debugc("<red>sysConnectionEventHandler() running at this point.\n")
	--echo("onConnect...\n")
	-- Die ganzen "sendATCP" funktionieren hier noch nicht

--	Nach einem Reconnect braucht Avalet den Charakternamen. Dieser
--	Trigger reagiert auf 
--		Du bist bereits am Spielen!   (nee, hierauf nicht, das ist plan b)
--		Verwende alten Koerper...
--	und löst dann einen Event aus, der eine Anfrage nach aktuellen
--  ATCP-Daten an den Server schickt. 
	if exists("OnReconnect", "trigger") == 0 then
		luaCode = [[raiseEvent("afterReconnectEvent")]]
		permRegexTrigger("OnReconnect", "Avalet", {"^Verwende alten Koerper\.\.\.$"}, luaCode)
	end
end
registerAnonymousEventHandler("sysConnectionEvent", "onSysConnectionEvent")

function onSysExitEvent()
	debugc("<red>onSysExitEvent\n")
	--echo("Schreibe Character in Datei...\n")
	writeDataToFS(characterFilePath, player, "w")
	--echo("...done\n")
end
registerAnonymousEventHandler("sysExitEvent", "onSysExitEvent")

function onSysDisconnectionEvent()
	debugc("<red>onSysDisconnectionEvent()\n")
	--echo("Schreibe Character in Datei...\n")
	writeDataToFS(characterFilePath, player, "w")
end
registerAnonymousEventHandler("sysDisconnectionEvent", "onSysDisconnectionEvent")

function afterReconnectEvent()
	debugc("<red>afterReconnectEvent()\n")
	sendATCP("ava_req_update")
end
registerAnonymousEventHandler("afterReconnectEvent", "afterReconnectEvent")

-- Weitere interessante Events:
-- sysInstall
--Raised right after a module or package is being installed by any means. This can be used to display post-installation information or setup things.
--Event handlers receive the name of the installed package or module as additional argument. 
--sysUninstall
--Raised right before a module or package is being uninstalled by any means. This can be used to display post-removal information or for cleanup.
--Event handlers receive the name of the removed package or module as additional argument. 


-- Func: fsysProtocolEnabled
-- Ich hab versucht, hier auch auf "GMCP" zu prüfen und eine
-- Warnung auszugeben. Aber offenbar wird GMCP nicht wie die
-- anderen Protokolle aktiviert, ich hatte jedenfalls keinen
-- Auslöser des "elseif", trotz aktiviertem GMCP.
function onSysProtocolEnabled(event,arg)
	debugc("<red>onSysProtocolEnabled() running at this point.\n")
	if arg =="ATCP" then
		--echo("ATCP Support aktiviert.\n")
		sendATCP("ava_set_mapper",1)
		sendATCP("ava_set_channel",1)
		sendATCP("ava_set_comm",1)
		sendATCP("ava_set_rcomm",1)
		sendATCP("ava_set_soul",1)
		sendATCP("ava_set_rsoul",1)
		--sendATCP("ava_set_soundpack",1)
		sendATCP("ava_req_update",1)
		sendATCP("ava_req_graphics_status",1)
	elseif arg=="GMCP" then
		debugc("<red>GMCP ist offenbar aktiviert. So wird Avalet nicht funktionieren.\nBitte GMXP in den Einstellungen deaktivieren und neu starten.")
	else
		--echo("Support fuer "..arg.." ist aktiv.\n")
	end
end
registerAnonymousEventHandler("sysProtocolEnabled", "onSysProtocolEnabled")

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