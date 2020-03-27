---------------------------------------------------------------------------
-- Initialisierung des Avalet-Plugins
--
-- 
---------------------------------------------------------------------------

echo("verdammte axt\n")

-- Speicherort des Moduls
-- C:/Users/<usrdir>/Documents/Avalet/Avalet.mpackage
path = getModulePath("Avalet")
echo("Path zu Avalet-Modul: " .. path .. "\n" )

path = getMudletHomeDir()
echo("Path MudletHomeDir: " .. path .. "\n" )






--if _LOADED["character"] ~= nil then
--	echo("vorher: character ist schon geladen")
--else
--	echo("vorher: character ist noch nicht geladen")
--end
require "Avalet.scripts.character"
require "Avalet.scripts.gui"
require "Avalet.scripts.atcp"
--if _LOADED["character"] ~= nil then
--	echo("nachher: character ist schon geladen")
--else
--	echo("nachher: character ist noch nicht geladen")
--end

echo("Erzeuge Player\n")
player = Character()
echo("fertig mit Erzeuge Player\n")
echo("PlayerTP: " .. player.stats.tp .. "\n")
echo("PlayerTPMAX: " .. player.stats.tp_max .. "\n")
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