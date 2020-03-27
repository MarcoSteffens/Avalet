----------------------------------------
-- ATCP-Handling
-- In diesem Script findet der Umgang mit den ATCP-Daten statt,
-- die Avalon sendet (und empfängt) 
-- Eine Beschreibung der ATCP-Schnittstelle von Avalon findet sich im Wiki:
-- https://avalon.mud.de/wiki/avalon:atcp


---------------------------------------------------------------------------------------------
-- ab hier Twrx
-- ScriptGroup: ATCP
---------------------------------------------------------------------------------------------

--Script: fsysProtocolEnabled
fsysProtocolEnabled = function(event,arg)
	if arg =="ATCP" then
		echo("ATCP Support aktiviert.\n")
		sendATCP("ava_set_mapper",1)
		sendATCP("ava_set_channel",1)
		sendATCP("ava_set_comm",1)
		sendATCP("ava_set_rcomm",1)
		sendATCP("ava_set_soul",1)
		sendATCP("ava_set_rsoul",1)
		--sendATCP("ava_set_soundpack",1)
		sendATCP("ava_req_update",1)
		sendATCP("ava_req_graphics_status",1)
	else
		echo("Support fuer "..arg.." aktiv ?!?\n")
	end
end

-- EventHandler: sysProtocolEnabled



-- gehört zur "Script Group":

-- kein Event-Handler


-- Script: AvalonChannel
function AvalonChannel(event,arg)
	local kanal,txt,farbe,tab
	onATCP (event,arg)
	kanal,txt = rex.match( arg, [[(\w+) (.*)]] )
	
	if table.contains(tChat.kanaele,kanal) == true then
		tab = tChat.kanaele[kanal] 
	else 
		tab = tChat.kanaele["default"] 
	end
	
	if table.contains(tChat.colors,kanal) == true then 
		farbe = tChat.colors[kanal] 
	else 
		farbe = tChat.colors["default"]
	end

	if bZweitieCheck == true then
		txt = fZweitieCheck(txt)
	end
	
	decho("con"..tab,farbe.."<:32,32,32>"..os.date("[%H:%M] ")..txt .. "\n" )
	
	if tab ~= "Info" then 
		decho("conInfo",farbe.."<:32,32,32>"..os.date("[%H:%M] ")..txt .. "\n" ) 
	end
	
	Logger:Mp(tab,txt, { "timestamp" })
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonChannel", "AvalonChannel")
 
 -- Script: AvalonComm
function AvalonComm(event,arg)
	AvalonChannel (event,arg)
end
registerAnonymousEventHandler("AvalonComm", "AvalonComm")

-- Script: AvalonContainer
function AvalonContainer(event,arg)
	local tBlub,i
	onATCP (event,arg)
	--tBlub = string.split(string.sub(arg,6),",")
	--display(tBlub)
	--if tBlub and #tBlub>0 then
	--	for i = 1,#tBlub do
	--	fEcho("TEST:"..string.sub(tBlub[i],15).."\n")
	--sendATCP("ava_req_inv",tBlub[i])
	--end
	--if #tBlub == 1 then 
	--	tPlayer.sPrimaerbehaelter = tBlub[1] 
	--end
end
registerAnonymousEventHandler("AvalonContainer", "AvalonContainer")
 
-- Script: AvalonDatabase
function AvalonDatabase(event,arg)
	onATCP (event,arg)
	--muenze objekt/821c4b2f8a8a4ef8ab3755ea4f05d524 "Muenze" Muenze des Ungluecks
	--display(arg)
	--if string.find(arg,"Muenze") and string.find(arg,"821c4b2f8a8a4ef8ab3755ea4f05d524") then
	--	fEcho("Muenze des Ungluecks gefunden!")
	--	tMapper.Muenze = true
	--	tMapper.MuenzeWoher = ""
	--end
	--display(arg)
end
registerAnonymousEventHandler("AvalonDatabase", "AvalonDatabase")

-- Script: AvalonDunkel
function AvalonDunkel (event,arg)
	onATCP (event,arg)
	if tonumber(arg) == 1 then 
		if tMapper.Mode and tMapper.Mode == "Speedwalk" then
			speedWalkCounter = speedWalkCounter + 1
			continueSpeedWalk();
		end  
	end
end
registerAnonymousEventHandler("AvalonDunkel", "AvalonDunkel")

-- Script: AvalonDurst
function AvalonDurst(event,arg)
	onATCP (event,arg)
	if arg == "Du hast ausreichend getrunken " then tPlayer.bDurst = false end
	if arg == "Es schwappt und gluckert in Deinem Bauch " then tPlayer.bDurst = false end
	if arg == "Deine Zunge klebt Dir am Gaumen " then tPlayer.bDurst = true end
	if arg == "Du hast ein trockenes Gefuehl in der Kehle " then tPlayer.bDurst = true end
	if arg == "Wenn Du Dir jetzt nicht bald was zwischen die Kiemen kippst " then tPlayer.bDurst = true end
end
registerAnonymousEventHandler("AvalonDurst", "AvalonDurst")

-- Script: AvalonEP
function AvalonEP(event,arg)
	tPlayer.diffep = tonumber(arg) - tonumber(tPlayer.ep)
	--if tPlayer.diffep >=11 then echo("[EP "..tPlayer.diffep.."]\n") end
	--mal auf 1 gesetzt um die 10 skillep zu catchen
	if tPlayer.diffep >=1 then 
		echo("[EP "..tPlayer.diffep.."]\n") 
	end
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonEP", "AvalonEP")

-- Script: AvalonGefuehrt
function AvalonGefuehrt(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonGefuehrt", "AvalonGefuehrt")

-- Script: AvalonGesenkt
function AvalonGesenkt(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonGesenkt", "AvalonGesenkt")

-- Script: AvalonGesinnung
function AvalonGesinnung(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonGesinnung", "AvalonGesinnung")

-- Script: AvalonGetoetet
function AvalonGetoetet(event,arg)
	onATCP (event,arg)
	raiseEvent("onKill",arg)
	--sendAll("r","t bewohner","t bewohner")
end
registerAnonymousEventHandler("AvalonGetoetet", "AvalonGetoetet")

-- Script: AvalonGilde
function AvalonGilde(event,arg)
	onATCP (event,arg)
	if _G["t"..arg] == nil then 
		if io.exists(getMudletHomeDir()..[[\..\..\modules\Gilden\]]..arg..[[.xml]]) == true then
			installModule(getMudletHomeDir()..[[\..\..\modules\Gilden\]]..arg..[[.xml]])
			_G[string.format ("f%sInit",arg)]()
		end
	end
end
registerAnonymousEventHandler("AvalonGilde", "AvalonGilde")

-- Script: AvalonGrafikVermeiden
function AvalonGrafikVermeiden(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonGrafikVermeiden", "AvalonGrafikVermeiden")

-- Script: AvalonGruppe
function AvalonGruppe(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonGruppe", "AvalonGruppe")

-- Script: AvalonGruppeGetoetet
function AvalonGruppeGetoetet(event,arg)
	onATCP (event,arg)
	raiseEvent("onKill",arg)
end
registerAnonymousEventHandler("AvalonGruppeGetoetet", "AvalonGruppeGetoetet")

-- Script: AvalonHoehe
function AvalonHoehe(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonHoehe", "AvalonHoehe")

-- Script: AvalonHunger
function AvalonHunger(event,arg)
	onATCP (event,arg)
	if arg == "Du hast ausreichend gegessen " then tPlayer.bHunger = false end
	if arg == "Du hast ein unangenehmes Voellegefuehl " then tPlayer.bHunger = false end								 
end
registerAnonymousEventHandler("AvalonHunger", "AvalonHunger")

-- Script: AvalonInventarRaus
function AvalonInventarRaus(event,arg)
	onATCP (event,arg)
	--sendATCP("ava_req_inv", "mich")
end
registerAnonymousEventHandler("AvalonInventarRaus", "AvalonInventarRaus")

-- Script: AvalonInventarRein
function AvalonInventarRein(event,arg)
	--ObjectHash, ObjectName = rex.match( arg, [[avalon/objekt/([^ ]+) ?([^ ]+)]] ) 
	--echo("Test:"..avalua.ObjectHash)
	onATCP (event,arg)
	--sendATCP("ava_req_inv", "mich")
	--display(arg)
end
registerAnonymousEventHandler("AvalonInventarRein", "AvalonInventarRein")

-- Script: AvalonInstance
function AvalonInstance(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonInstance", "AvalonInstance")

-- Script: AvalonKampf
function AvalonKampf(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonKampf", "AvalonKampf")

-- Script: AvalonLevel
function AvalonLevel(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonLevel", "AvalonLevel")

-- Script: AvalonMAXAP
function AvalonMAXAP(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonMAXAP", "AvalonMAXAP")

-- Script: AvalonMAXMP
function AvalonMAXMP(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonMAXMP", "AvalonMAXMP")

-- Script: AvalonMAXSP
function AvalonMAXSP(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonMAXSP", "AvalonMAXSP")

-- Script: AvalonMAXTP
function AvalonMAXTP(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonMAXTP", "AvalonMAXTP")

-- Script: AvalonMP
function AvalonMP(event,arg)
	tPlayer.diffmp = tonumber(arg) - tonumber(tPlayer.mp)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonMP", "AvalonMP")

-- Script: AvalonName
function AvalonName(event,arg)
	onATCP (event,arg)
	arg = string.title(arg)
	if _G["t"..arg] == nil then 
		if io.exists(getMudletHomeDir()..[[\..\..\modules\Spieler\]]..arg..[[.xml]]) == true then
			installModule(getMudletHomeDir()..[[\..\..\modules\Spieler\]]..arg..[[.xml]])
			_G[string.format ("f%sInit",arg)]()
		end
	end
end
registerAnonymousEventHandler("AvalonName", "AvalonName")

-- Script: AvalonPortfolio
function AvalonPortfolio(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonPortfolio", "AvalonPortfolio")

-- Script: AvalonRComm
function AvalonRComm(event,arg)
	AvalonChannel (event,arg)
end
registerAnonymousEventHandler("AvalonRComm", "AvalonRComm")

-- Script: AvalonRSoul
function AvalonRSoul(event,arg)
	AvalonChannel (event,"SEELE "..arg)
end
registerAnonymousEventHandler("AvalonRSoul", "AvalonRSoul")

-- Script: AvalonSchutz
function AvalonSchutz(event,arg)
	local tBlub,name,staerke,i
	if arg == "ungeschuetzt" then 
		--tPlayer.bSchild = false
		--tPlayer.bAura = false
		--tPlayer.sSchild = nil
		--tPlayer.sAura = nil
	else
		tBlub = string.split(arg,",")
		for i = 1,#tBlub do
			name,staerke = rex.match( tBlub[i], [[([A-z]+)( V| IV| III| II| I|)]] )
			if staerke == "" then staerke ="I" end
			if table.contains({"Schild","Holzhaut","Windhaut","Steinhaut","Kampfbeschwoerung","Kernschild"},name) == true then
				--tPlayer.bSchild = true
				if name == "Kampfbeschwoerung" then name = "KB" end
				tPlayer.sSchild = name.." "..string.trim(staerke)
				tPlayer.sSchildname = name
			end
			if table.contains({"Feueraura","Erdaura","Luftaura","Wasseraura","Lebensaura","Todesaura","TodKonvertieren"},name) == true then
				--tPlayer.bAura = true
				if name == "TodKonvertieren" then name = "TKonv" end
				tPlayer.sAura = name.." "..string.trim(staerke)
			end
		end -- for #tblub
	end
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonSchutz", "AvalonSchutz")

-- Script: AvalonSoul
function AvalonSoul(event,arg)
	--AvalonChannel (event,"SEELE "..arg)
end
registerAnonymousEventHandler("AvalonSoul", "AvalonSoul")

-- Script: AvalonSP
function AvalonSP(event,arg)
	tPlayer.diffsp = tonumber(arg) - tonumber(tPlayer.sp)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonSP", "AvalonSP")

-- Script: AvalonSite
function AvalonSite(event,arg)
	onATCP (event,arg)
	tRoom.Site = arg
end
registerAnonymousEventHandler("AvalonSite", "AvalonSite")

-- Script: AvalonTP
function AvalonTP(event,arg)
	tPlayer.difftp = tonumber(arg) - tonumber(tPlayer.tp)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonTP", "AvalonTP")

-- Script: AvalonVollName
function AvalonVollName(event,arg)
	onATCP (event,arg)
end
registerAnonymousEventHandler("AvalonVollName", "AvalonVollName")

-- Script: AvalonZaubern
function AvalonZaubern(event,arg)
	onATCP (event,arg)
end
-- Kein EventHandler

-- Script: AvalonWeg
function AvalonWeg(event,arg)
	onATCP (event,arg)
	tRoom.Weg = arg
end
registerAnonymousEventHandler("AvalonWeg", "AvalonWeg")

-- Script: AvalonIcon16
function AvalonIcon16(event,arg)
	onATCP(event,arg)
	if tMapper and tMapper.Mode and tMapper.Mode == "Map" then
		tRoom = tRoom or {}
		tRoom.Color = "MAP_WHITE"
		tRoom.Char = nil
		tRoom.Color,tRoom.Char = rex.match( arg, [[%\^(\w+)%\^(.)]] )
	end
end
registerAnonymousEventHandler("AvalonIcon16", "AvalonIcon16")

-- Script: AvalonRoomID
function AvalonRoomID(event, arg)
	tRoom.OldHash = tRoom.Hash or -1
	tRoom.OldID = tRoom.ID or -1
	tRoom.OldAreaName = tRoom.AreaName or -1
	tRoom.Oldy = tRoom.y or 0
	tRoom.Oldx = tRoom.x or 0
	tRoom.Oldz = tRoom.z or 0
	tRoom.Hash, tRoom.AreaName, tRoom.tmpx, tRoom.tmpy = rex.match(arg, [[raum/([^ ]+) ?([^ ]+)? ?(?:x=(.*) y=(.*))?]])
	tRoom.ID = getRoomIDbyHash(tRoom.Hash) or -1
	tRoom.y = 0
	tRoom.x = 0
	tRoom.z = 0
	tRoom.Weg = -1
	tRoom.Site = nil
	tRoom.MapRoom = false
 
	--Fuer Dungeons die keine eigene Area haben:
	--z.B tRoom.AreaNameOverwrite = "Duestergarten"
	--tRoom.AreaNameOverwrite = "Kratylon"

	if tRoom.AreaNameOverwrite then tRoom.AreaName = tRoom.AreaNameOverwrite end
	tRoom.AreaID = addAreaName(tRoom.AreaName)
 
	--Room id im Output anzeigen lassen, z.B fuer Datensammlung Questskripte :)
	--display(arg)
 
	if not tRoom.AreaID then 
		tRoom.AreaID = getRoomAreaName(tRoom.AreaName)
	else 
		echo("Neues Gebiet " .. tRoom.AreaName .. " mit ID " .. tRoom.AreaID .." hinzugefuegt, ggfs Map Mode einschalten.\n")
	end
	if tRoom.tmpx and tRoom.tmpy then
		tRoom.MapRoom = true
	end
 
	centerview(tRoom.ID)
	if tMapper.Mode then
		if tMapper.Mode == "Walk" then
			sendATCP("ava_req_inv", "hier")
		end--mode walk
		if tMapper.Mode == "Map" then
			sendATCP("ava_req_inv", "hier")
		end-- mode map
		if tMapper.Mode == "Speedwalk" then
			if tonumber(tRoom.ID) == tonumber(speedWalkPath[#speedWalkPath]) then
				tMapper.Mode = "Walk"
				--echo(string.format("Angekommen! Brauchten %.1fs fuer %.1f Schritte.\n",stopStopWatch(speedWalkWatch),#speedWalkPath))
				speedWalkPath = {}
				speedWalkDir = {}
				speedWalkCounter = 0
				stopStopWatch(speedWalkWatch)
				speedWalkPath = {}
				sendATCP("ava_req_inv", "hier")
				send("grafik an")
				send("schau")
			elseif tonumber(speedWalkPath[speedWalkCounter]) == tRoom.ID then
				speedWalkMoved = true
				speedWalkCounter = speedWalkCounter + 1
				continueSpeedWalk()
			end
		end -- mode speedwalk
	end --if tMapper.Mode
	
	if bAutoMetzeln == true and map[tRoom.Hash] ~= nil then 
		fDebug("Raum vorhanden! ("..tRoom.Hash.." ".. map[tRoom.Hash]..")")
	end
end
registerAnonymousEventHandler("AvalonRoomID", "AvalonRoomID")
 
-- Script: RoomBrief
RoomBrief = function (event,arg)
	atcp.RoomBrief = nil
	atcp.AvalonRoomBrief = arg
	tRoom.Brief = arg
	onATCP()
end
registerAnonymousEventHandler("RoomBrief", "RoomBrief")

-- Script: AvalonExits
AvalonExits = function (event,arg)
	tRoom.exits = arg or {}
	--display(arg)
	onATCP(event,arg)
end
registerAnonymousEventHandler("AvalonExits", "AvalonExits")

-- Script: AvalonInv
AvalonInv = function (event,arg)
	local bla,blub,tBlub,pos,i,x,y,objhash,name,was,hash,j,exclude,inv
	--display(ATCP)
	onATCP (event,arg)
	--display(arg)
	if string.sub(arg,1,4) == "hier" then
		tBlub = string.split(string.sub(arg,6),",")
		tRoom = tRoom or {}
		tRoom.tObject={}
		tRoom.tPlayer={}
		tRoom.tMobs={}
		for i = 1,#tBlub do
			if string.sub(tBlub[i],1,6) ~= "wesen/" then 
				was,hash,name = rex.match( tBlub[i], [[avalon/(.*)/([A-z0-9]+) "([A-z\- ]*)"]] )
			else 
				was = "wesen"
				hash,name = rex.match( tBlub[i],[[wesen/([a-z]*) "([A-z\- ]*)"]])
			end
			if was == "wesen" then
				exclude = nil
				for j = 1, #tRoom.tExclude do
					if string.find(tRoom.tExclude[j],name) then
						exclude = true
					end
				end -- for #tRoom.exclude
				if tGolemkultisten and tGolemkultisten.sGolemName and tGolemkultisten.sGolemName == name then 
					exclude = true
				end
				if name == "Bubbler" then 
					exclude = true
				end
				if not exclude then
					table.insert(tRoom.tMobs,{"avalon/wesen/"..hash,name}) 
				end
			end -- wesen
			if was == "objekt" then 
				table.insert(tRoom.tObject,{"avalon/objekt/"..hash,name}) 
			end
			if was == "spieler" then
				if not string.find(string.lower(name),tPlayer.name) then
					if tGruppe and table.contains(tGruppe,name) == true then
						--nix spieler in gruppe...alles gut..weiter skripten :) 
					else
						-- spieler ist fremdkoerper, ggfs skriptbehinderer...frechheit! 
						table.insert(tRoom.tPlayer,{hash,name})
					end
				end
 			end -- spieler
		end -- for #tblub

		if bAutoOpfer and #tRoom.tMobs >0 then 
			tPlayer.sOpfer = string.lower(tRoom.tMobs[1][2]) send ("grins "..tRoom.tMobs[1][2]) 
		end
		if tMapper then 
			fMapperCheckRoom(tRoom.Hash) 
		end
		centerview(tRoom.ID)
		AvalonSpecialRooms()
		raiseEvent("onRoomInv",arg)
		fMapBoxUpdate()

		--schauen obs metzelskript aktiv und so
		if tMetzel and tMetzel.bStop ~= true then
			if tRoom.tMobs and #tRoom.tMobs>=1 then
				for x=1,#tRoom.tMobs do
					if table.contains(tMetzel.tAutokill,tRoom.tMobs[x][2]) and tRoom.tPlayer and #tRoom.tPlayer == 0 then
						tMetzel.bAutokill = true
						tPlayer.sOpfer = tRoom.tMobs[x][2]
						if tBarden == nil then 
							send("toete "..tPlayer.sOpfer) 
						else
						end
						fMetzelAngriff()
					end
				end -- for
			end --if mobs
			--if tMetzel.iGoOnTimer then killTimer(tMetzel.iGoOnTimer) end tMetzel.iGoOnTimer = tempTimer(0.5, [[tMetzel.GoOn()]])
			if tMetzel.sMode == "Auto" then
				if tMetzel.iGoOnTimer then 
					killTimer(tMetzel.iGoOnTimer) 
				end 
				tMetzel.iGoOnTimer =  tempTimer(0.3, [[fMetzelGoOn()]])
			end
		end --tmetzel
	end -- hier

	if string.sub(arg,1,4) == "mich" then
		tPlayer.tInventory = {} 
		tBlub = string.split(string.sub(arg,6),",")
		--display(tBlub)
		for i = 1,#tBlub do
			was,hash,name = rex.match( tBlub[i], [[avalon/(.*)/([A-z0-9]+) "([A-z]*)"]] )
			--if hash and name then table.insert(tPlayer.tInventory,{hash,name}) end
			if hash and name then 
				tPlayer.tInventory[hash] = {} tPlayer.tInventory[string.format ("%s",hash)].name = name 
			end 
			if name == "Muenze" then 
				sendATCP("ava_req_dbid", name) 
			end
			if name == "Lapis" or name == "Obsidian" or name == "Konochen" then
				if tPlayer.sPrimaerbehaelter ~= nil then 
					addCommand("lege mein "..name.." in mein "..tPlayer.sPrimaerbehaelter,0.3)
				else
					--send("zaehle "..name)
					--tPlayer.sMoney = hash
				end
			end
		end --for
		--display (tPlayer.tInventory)
		sendATCP("ava_req_container", "mich")
	end -- mich
  
	--fEcho("BLA:"..string.sub(arg,1,14))
	if string.sub(arg,1,14) == "avalon/objekt/" then
		objhash = string.sub(arg,15,46) -- boeser hack, hoffen wir das der hash immer 32 lang ist :)
		--objhash = string.sub(arg,1,46)
		if table.contains(tPlayer.tInventory,objhash) == true then --ist ein behaelter
			tBlub = string.split(string.sub(arg,48),",") -- nur den inhalt
			--tPlayer.tInventory[objhash].inhalt = {}
			for i = 1,#tBlub do
				was,hash,name = rex.match( tBlub[i], [[avalon/(.*)/([A-z0-9]+) "([A-z]*)"]] )
				if hash and name then
					tPlayer.tInventory[hash] = {}
					tPlayer.tInventory[string.format ("%s",hash)].name = name 
					tPlayer.tInventory[string.format ("%s",hash)].behaelter = objhash
					--inv = { [hash] = { ["name"] = name }}
					--table.insert(tPlayer.tInventory[objhash].inhalt,inv)
					--tPlayer.tInventory][inhalt][string.format ("%s",hash)] = {}
					--tPlayer.tInventory[string.format ("%s",objhash)][inhalt][string.format ("%s",hash)].name = name end 
				end
				if name == "Lapis" or name == "Obsidian" or name == "Konochen" then
					--send("zaehle "..name.." in avalon/objekt/"..objhash)
					--tPlayer.sMoney = hash
				end	 
				if name == "Muenze" then 
					sendATCP("ava_req_dbid", string.format ("%s in %s",name,string.sub(arg,1,46))) 
				end -- Unglueckmuenze ?
			end--for
			--display(tPlayer.tInventory)
		end -- contains objhahsh
	end --inv objects z.B Saecke
end -- fun

registerAnonymousEventHandler("AvalonInv", "AvalonInv")



