---------------------------------------------------------------------------
-- Initialisierung des AvalonMaster-Plugins
--
-- 
---------------------------------------------------------------------------

-- Script: fSystemInit
fSystemInit = function ()

	echo("System Modul installiert...\n")

	tConfig = {}
 


	--automatisches Opfersetzen
	bAutoOpfer = nil
	-- automatisches Klettern/Schwimmen
	bAutoMove = true
	-- permanentes Schwimmen
	bAutoSchwimmen = nil

	--autometzeln ala TE oder Tintagel
	bAutoMetzeln = nil

	-- automatisch Schild erneuern ?
	bAutoSchild = nil

	-- warnungen per Sprachausgabe ?
	bSprachausgabe = true

	--Zweitiecheck im Channellog ?
	bZweitieCheck = nil


	tRoom = tRoom or {}
	-- Eine Liste der Namen die nicht aufgenommen werden sollen im room Inv:)

	tTimer = tTimer or {}

	tCounts = tCounts or {}
	tCountsToday = {}

	tChat = tChat or {}
	tChat.mp = tChat.mp or {}

	--table.load(getMudletHomeDir().."/tPlayer.lua", tPlayer)
	--table.load(getMudletHomeDir().."/tCounts.lua", tCounts)
	--table.load(getMudletHomeDir().."/tChat.lua", tChat.mp)
	--table.load(getMudletHomeDir().."/../tZweities.lua", tZweities)






-- Script: Events


-- Script: onConnect
onConnect = function ()
	sendATCP("ava_set_mapper",1)
	sendATCP("ava_set_channel",1)
	sendATCP("ava_set_comm",1)
	sendATCP("ava_set_rcomm",1)
	sendATCP("ava_set_soul",1)
	sendATCP("ava_set_rsoul",1)
	--sendATCP("ava_set_soundpack",1)
	sendATCP("ava_req_update",1)
	sendATCP("ava_req_graphics_status",1)
	--InitTopBox()
	--InitBottomBox()
	InitClock()
	InitTopMenuBar()
	InitGauges()
	InitTimer()
	InitInfoBox()
	InitShieldBox()
	fMetzelInit()
	registerAnonymousEventHandler("onOneSecTimer", "UpdateGauges")
	--registerAnonymousEventHandler("onOneSecTimer", "UpdateSchildWaffeAura")
	registerAnonymousEventHandler("onOneSecTimer", "UpdateClock")
	registerAnonymousEventHandler("onOneSecTimer", "UpdateTimer")
	registerAnonymousEventHandler("onOneSecTimer", "UpdateInfoBox")
	--registerAnonymousEventHandler("onOneSecTimer", "fMapBoxUpdate")
	if disconnectTimer ~= nil then 
		killTimer(disconnectTimer) 
	end	
	echo("onConnect...\n")
end

-- EventHandler: onConnect

-- Script: onModuleInstall
onModuleInstall = function (event,name,filename)
	_G[string.format ("t%s",name)] = {}
	_G[string.format ("f%sInit",name)]()
end

-- EventHandler: sysInstallModule

-- Script: onModuleUninstall
onModuleUninstall = function (event,name,file)
	_G[string.format ("f%sRemove",name)]()
	_G[string.format ("t%s",name)] = nil
	fEcho("Module "..name.." Uninstalliert.\n")
end

-- EventHandler: sysUninstallModule



-- Script: onSysConnect
onSysConnect = function ()

end

-- EventHandler: sysConnectionEvent

-- Script: sysExitEventHandler
sysExitEventHandler = function (event,arg)
	table.save(getMudletHomeDir().."/tPlayer.lua", tPlayer)
	table.save(getMudletHomeDir().."/tCounts.lua", tCounts)
	table.save(getMudletHomeDir().."/tChat.lua", tChat.mp)
	table.save(getMudletHomeDir().."/tZweities.lua",tZweities)
	--saveMap(getMudletHomeDir().."/../../map/map.dat")
end

-- EventHandler: sysExitEvent


-- Script: onPrompt
onPrompt = function ( eventName )
end

-- EventHandler: onPrompt

-- Script: onKill
onKill = function (event,name,file)
	--sendATCP("ava_req_inv", "hier")
	if tMetzel and tMetzel.sMode ~= nil then fMetzelGetoetet() end 
	--sendAll("r","t bewohner")
end</script>

-- EventHandler: onKill

-- Script: onDisconnect
onDisconnect = function()
	if disconnectTimer ~= nil then killTimer(disconnectTimer) end	
	disconnectTimer = tempTimer(60, [[ reconnect()]])
	echo("Disconnect Timer 60 Sek. gestartet.\n")
	table.save(getMudletHomeDir().."/tPlayer.lua", tPlayer)
	table.save(getMudletHomeDir().."/tCounts.lua", tCounts)
	table.save(getMudletHomeDir().."/tChat.lua", tChat.mp)
	saveMap(getMudletHomeDir().."/../../map/map.dat")
	table.save(getMudletHomeDir().."/../tZweities.lua", tZweities)
end

-- EventHandler: sysDisconnectionEvent

-- Script: onShieldUp
onShieldUp = function (event,name,file)
	if tMetzel and tMetzel.sMode ~= nil then fMetzelShieldUp() end 
end

-- EventHandler: onShieldUp

-- Script: onShieldDown
onShieldDown = function (event,name,file)
	if tMetzel and tMetzel.sMode ~= nil then fMetzelShieldDown() end 
end

-- EventHandler: onShieldDown

-- Script: onRoomInv
onRoomInv =  function()
end

-- EventHandler: onRoomInv</string>


-- Ende ScriptGroup



















