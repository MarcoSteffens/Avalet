----------------------------------------
-- ATCP-Handling
-- In diesem Script findet der Umgang mit den ATCP-Daten statt,
-- die Avalon sendet (und empfängt) 
-- Eine Beschreibung der ATCP-Schnittstelle von Avalon findet sich im Wiki:
-- https://avalon.mud.de/wiki/avalon:atcp
-- Dieses Script basiert auf einem Demo-Script von Vadi aus dem mudlet.org-Forum,
-- das ich hier gefunden habe:
-- https://forums.mudlet.org/viewtopic.php?f=6&t=1243
----------------------------------------

-- The following scripts attach handlers to the ATCP functions and echos them. 
-- It also parses the stats line and stores all stats in a easily accecble table,
-- and exits too.

-- Anscheinend wird ein einer Tabelle mit dem Namen "atcp", wenn es existiert,
-- alles gespeichert, was per atcp reinkommt.
atcp = {}

-- Convert a lua table into a lua syntactically correct string
function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

----------------------------------------
-- onATCPEvent
----------------------------------------

function onATCPEvent(event, arg)
	--echo("AvalonDunkel.event = " .. event .. "\n")
	--echo("AvalonDunkel.arg = " .. arg .. "\n")
	--echo("\n" .. table_to_string(atcp) .. "\n\n\n")
	
--	local i,v
--	for i,v in pairs(atcp) do
--		tPlayer[string.format ("%s",string.lower(string.sub(i,7)))] = string.trim(v)
--		echo("onATCP",os.date("[%H:%M] ")..i.."  = "..v.."\n")
--	end
--	atcp={}

	if event == "AvalonName" then 
		echo ("AvalonName = " .. arg .. "\n")
		player.name = arg
	elseif event == "AvalonGilde" then 
		echo("AvalonGilde = " .. arg .. "\n")
		player.gilde = arg
	elseif event == "AvalonVollName" then
		echo("AvalonVollName = " .. arg .. "\n")
		player.vollername = arg
		--raiseEvent("RefreshCharacterVollername", arg)
	elseif event == "AvalonHoehe" then echo("AvalonHoehe = " .. arg .. "\n")
	elseif event == "AuthRequest" then echo("AuthRequest = " .. arg .. "\n")
	elseif event == "AvalonDurst" then 
		echo("AvalonDurst = " .. arg .. "\n")
		player.durst = arg
	elseif event == "AvalonDunkel" then echo("AvalonDunkel = " .. arg .. "\n")
	elseif event == "AvalonZuenfte" then 
		echo("AvalonZuenfte = " .. arg .. "\n")
		player.zuenfte = arg
	elseif event == "AvalonPortfolio" then 
		echo("AvalonPortfolio = " .. arg .. "\n")
		player.portfolio = arg
	elseif event == "AvalonFlucht" then echo("AvalonFlucht = " .. arg .. "\n")
	elseif event == "AvalonSchutz" then echo("AvalonSchutz = " .. arg .. "\n")
	elseif event == "AvalonTP" then 
		player.stats.tp = tonumber(arg)
		raiseEvent("RefreshHealthBar", {player.stats.tp, player.stats.tp_max})
	elseif event == "AvalonMAXTP" then
		player.stats.tp_max = tonumber(arg)
		raiseEvent("RefreshHealthBar", {player.stats.tp, player.stats.tp_max})
	elseif event == "AvalonAP" then 
		player.stats.ap = tonumber(arg)
		raiseEvent("RefreshEnduranceBar", {player.stats.ap, player.stats.ap_max})
	elseif event == "AvalonMAXAP" then 
		player.stats.ap_max = tonumber(arg)
		raiseEvent("RefreshEnduranceBar", {player.stats.ap, player.stats.ap_max})
	elseif event == "AvalonSP" then 
		player.stats.zp = tonumber(arg)
		raiseEvent("RefreshSpellpointsBar", {player.stats.zp, player.stats.zp_max})
	elseif event == "AvalonMAXSP" then 
		player.stats.zp_max = tonumber(arg)
		raiseEvent("RefreshSpellpointsBar", {player.stats.zp, player.stats.zp_max})
	elseif event == "AvalonMP" then 
		player.stats.mp = tonumber(arg)
		raiseEvent("RefreshManaBar", {player.stats.mp, player.stats.mp_max})
	elseif event == "AvalonMAXMP" then 
		player.stats.mp_max = tonumber(arg)
		raiseEvent("RefreshManaBar", {player.stats.mp, player.stats.mp_max})
	elseif event == "AvalonHunger" then 
		echo("AvalonHunger = " .. arg .. "\n")
		player.hunger = arg
	elseif event == "AvalonRoomID" then echo("AvalonRoomID = " .. arg .. "\n")
	elseif event == "AvalonAlter" then 
		echo("AvalonAlter = " .. arg .. "\n")
		player.alter = arg
	elseif event == "AvalonGesinnung" then 
		echo("AvalonGesinnung = " .. arg .. "\n")
		player.gesinnung = arg
	elseif event == "AvalonGruppe" then echo("AvalonGruppe = " .. arg .. "\n")
	elseif event == "RoomBrief" then echo("RoomBrief = " .. arg .. "\n")
	elseif event == "AvalonEP" then 
		echo("AvalonEP = " .. arg .. "\n")
		player.ep = arg
	elseif event == "AvalonLevel" then 
		echo("AvalonLevel = " .. arg .. "\n")
		player.level = arg
	elseif event == "AvalonArea" then echo("AvalonArea = " .. arg .. "\n")
	elseif event == "AvalonInv" then echo("AvalonInv = " .. arg .. "\n")
	elseif event == "AvalonSite" then echo("AvalonSite = " .. arg .. "\n")
	elseif event == "AvalonExits" then echo("AvalonExits = " .. arg .. "\n")
	elseif event == "AvalonZaubern" then echo("AvalonZaubern = " .. arg .. "\n")
	elseif event == "AvalonChannel" then echo("AvalonChannel = " .. arg .. "\n")
	elseif event == "AvalonComm" then echo("AvalonComm = " .. arg .. "\n")
	elseif event == "AvalonRComm" then echo("AvalonRComm = " .. arg .. "\n")
	elseif event == "AvalonGrafikVermeiden" then echo("AvalonGrafikVermeiden = " .. arg .. "\n")
	elseif event == "AvalonAvalonIcon16" then echo("AvalonAvalonIcon16 = " .. arg .. "\n")
	elseif event == "AvalonAvalonWeg" then echo("AvalonAvalonWeg = " .. arg .. "\n")
	elseif event == "AvalonInventarRein" then echo("AvalonInventarRein = " .. arg .. "\n")
	elseif event == "AvalonInventarRaus" then echo("AvalonInventarRaus = " .. arg .. "\n")
	elseif event == "AvalonBehaelterRein" then echo("AvalonBehaelterRein = " .. arg .. "\n")
	elseif event == "AvalonBehaelterRaus" then echo("AvalonBehaelterRaus = " .. arg .. "\n")
	elseif event == "AvalonGefuehrt" then echo("AvalonGefuehrt = " .. arg .. "\n")
	elseif event == "AvalonGesenkt" then echo("AvalonGesenkt = " .. arg .. "\n")
	elseif event == "AvalonAngezogen" then echo("AvalonAngezogen = " .. arg .. "\n")
	elseif event == "AvalonAusgezogen" then echo("AvalonAusgezogen = " .. arg .. "\n")
	elseif event == "AvalonKampf" then echo("AvalonKampf = " .. arg .. "\n")
	elseif event == "AvalonAngegriffen" then echo("AvalonAngegriffen = " .. arg .. "\n")
	elseif event == "AvalonGetoetet" then echo("AvalonGetoetet = " .. arg .. "\n")
	elseif event == "AvalonGruppeGetoetet" then echo("AvalonGruppeGetoetet = " .. arg .. "\n")
	elseif event == "AvalonAllyGetoetet" then echo("AvalonAllyGetoetet = " .. arg .. "\n")
	else
		echo("Fehler in der Funktion onATCPEvent: " .. event .. " - " .. arg .. "\n")
	end
end

registerAnonymousEventHandler("AvalonName", "onATCPEvent")
registerAnonymousEventHandler("AvalonGilde", "onATCPEvent")
registerAnonymousEventHandler("AvalonVollName", "onATCPEvent")
registerAnonymousEventHandler("AvalonMAXTP", "onATCPEvent")
registerAnonymousEventHandler("AvalonHoehe", "onATCPEvent")
registerAnonymousEventHandler("AuthRequest", "onATCPEvent")
registerAnonymousEventHandler("AvalonDurst", "onATCPEvent")
registerAnonymousEventHandler("AvalonMP", "onATCPEvent")
registerAnonymousEventHandler("AvalonDunkel", "onATCPEvent")
registerAnonymousEventHandler("AvalonZuenfte", "onATCPEvent")
registerAnonymousEventHandler("AvalonMAXMP", "onATCPEvent")
registerAnonymousEventHandler("AvalonPortfolio", "onATCPEvent")
registerAnonymousEventHandler("AvalonAP", "onATCPEvent")
registerAnonymousEventHandler("AvalonFlucht", "onATCPEvent")
registerAnonymousEventHandler("AvalonSchutz", "onATCPEvent")
registerAnonymousEventHandler("AvalonTP", "onATCPEvent")
registerAnonymousEventHandler("AvalonHunger", "onATCPEvent")
registerAnonymousEventHandler("AvalonMAXSP", "onATCPEvent")
registerAnonymousEventHandler("AvalonRoomID", "onATCPEvent")
registerAnonymousEventHandler("AvalonAlter", "onATCPEvent")
registerAnonymousEventHandler("AvalonSP", "onATCPEvent")
registerAnonymousEventHandler("AvalonGesinnung", "onATCPEvent")
registerAnonymousEventHandler("AvalonGruppe", "onATCPEvent")
registerAnonymousEventHandler("RoomBrief", "onATCPEvent")
registerAnonymousEventHandler("AvalonEP", "onATCPEvent")
registerAnonymousEventHandler("AvalonMAXAP", "onATCPEvent")
registerAnonymousEventHandler("AvalonLevel", "onATCPEvent")
registerAnonymousEventHandler("AvalonArea", "onATCPEvent")
registerAnonymousEventHandler("AvalonInv", "onATCPEvent")
registerAnonymousEventHandler("AvalonSite", "onATCPEvent")
registerAnonymousEventHandler("AvalonExits", "onATCPEvent")
registerAnonymousEventHandler("AvalonZaubern", "onATCPEvent")
registerAnonymousEventHandler("AvalonChannel", "onATCPEvent")
registerAnonymousEventHandler("AvalonComm", "onATCPEvent")
registerAnonymousEventHandler("AvalonRComm", "onATCPEvent")
registerAnonymousEventHandler("AvalonGrafikVermeiden", "onATCPEvent")
registerAnonymousEventHandler("AvalonAvalonIcon16", "onATCPEvent")
registerAnonymousEventHandler("AvalonAvalonWeg", "onATCPEvent")
registerAnonymousEventHandler("AvalonInventarRein", "onATCPEvent")
registerAnonymousEventHandler("AvalonInventarRaus", "onATCPEvent")
registerAnonymousEventHandler("AvalonBehaelterRein", "onATCPEvent")
registerAnonymousEventHandler("AvalonBehaelterRaus", "onATCPEvent")
registerAnonymousEventHandler("AvalonGefuehrt", "onATCPEvent")
registerAnonymousEventHandler("AvalonGesenkt", "onATCPEvent")
registerAnonymousEventHandler("AvalonAngezogen", "onATCPEvent")
registerAnonymousEventHandler("AvalonAusgezogen", "onATCPEvent")
registerAnonymousEventHandler("AvalonKampf", "onATCPEvent")
registerAnonymousEventHandler("AvalonAngegriffen", "onATCPEvent")
registerAnonymousEventHandler("AvalonGetoetet", "onATCPEvent")
registerAnonymousEventHandler("AvalonGruppeGetoetet", "onATCPEvent")
registerAnonymousEventHandler("AvalonAllyGetoetet", "onATCPEvent")

function onRefreshCharacterVollername(event, args)
	GUI.Spielstand:echo(args)
	--GUI.Health:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
end
registerAnonymousEventHandler("RefreshCharacterVollername", "onRefreshCharacterVollername")

--raiseEvent("RefreshCharacterVollername", ???)


function onRefreshHealthBar(event, args)
	GUI.Health:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
end
registerAnonymousEventHandler("RefreshHealthBar", "onRefreshHealthBar")

function onRefreshEnduranceBar(event, args)
	GUI.Endurance:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
end
registerAnonymousEventHandler("RefreshEnduranceBar", "onRefreshEnduranceBar")

function onRefreshSpellpointsBar(event, args)
	GUI.Spellpoints:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
end
registerAnonymousEventHandler("RefreshSpellpointsBar", "onRefreshSpellpointsBar")

function onRefreshManaBar(event, args)
	GUI.Mana:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
end
registerAnonymousEventHandler("RefreshManaBar", "onRefreshManaBar")

--------------------------------------------------------------------
-- onKill wird durch einen kill ausgelöst
--------------------------------------------------------------------

function onKillEvent(event,name,file)
	--sendATCP("ava_req_inv", "hier")
	if tMetzel and tMetzel.sMode ~= nil then fMetzelGetoetet() end 
	--sendAll("r","t bewohner")
end
--registerAnonymousEventHandler("KillEvent", "onKillEvent")

-- Script: AvalonAllyGetoetet
function AvalonAllyGetoetet(event,arg)
	onATCP (event,arg)
	raiseEvent("onKillEvent",arg)
end
--registerAnonymousEventHandler("AvalonAllyGetoetet", "AvalonAllyGetoetet")

-- Script: AvalonAlter
function AvalonAlter(event,arg)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonAlter", "AvalonAlter")

-- Script: AvalonAngegriffen
function AvalonAngegriffen(event,arg)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonAngegriffen", "AvalonAngegriffen")

-- Script: AvalonAngezogen
function AvalonAngezogen(event,arg)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonAngezogen", "AvalonAngezogen")

-- Script: AvalonAusgaenge
function AvalonAusgaenge(event,arg)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonAusgaenge", "AvalonAusgaenge")

-- Script: AvalonAusgezogen
function AvalonAusgezogen(event,arg)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonAusgezogen", "AvalonAusgezogen")

-- Script: AvalonAP
function AvalonAP(event,arg)
	tPlayer.diffap = tonumber(arg) - tonumber(tPlayer.ap)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonAP", "AvalonAP")

-- Script: AvalonArea
function AvalonArea(event,arg)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonArea", "AvalonArea")

-- Script: AvalonBehaelterRaus
function AvalonBehaelterRaus(event,arg)
	onATCP (event,arg)
	--sendATCP("ava_req_inv", "mich")
end
--registerAnonymousEventHandler("AvalonBehaelterRaus", "AvalonBehaelterRaus")

-- Script: AvalonBehaelterRein
function AvalonBehaelterRein(event,arg)
	onATCP (event,arg)
	--sendATCP("ava_req_inv", "mich")
end
--registerAnonymousEventHandler("AvalonBehaelterRein", "AvalonBehaelterRein")
