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

	if event == "AvalonHoehe" then echo("AvalonHoehe = " .. arg .. "\n")
	elseif event == "AuthRequest" then echo("AuthRequest = " .. arg .. "\n")
	elseif event == "AvalonDunkel" then echo("AvalonDunkel = " .. arg .. "\n")
	elseif event == "AvalonFlucht" then echo("AvalonFlucht = " .. arg .. "\n")
	elseif event == "AvalonSchutz" then echo("AvalonSchutz = " .. arg .. "\n")
	elseif event == "AvalonRoomID" then echo("AvalonRoomID = " .. arg .. "\n")
	elseif event == "AvalonGruppe" then echo("AvalonGruppe = " .. arg .. "\n")
	elseif event == "RoomBrief" then echo("RoomBrief = " .. arg .. "\n")
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

----------------------------------------------------------------------------------------
--  Charakter-Daten/Spielstand
----------------------------------------------------------------------------------------

-- event == "AvalonName"
function onATCPEventAvalonName(event, arg)
	if player.name ~= arg then
		player.name = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonName", "onATCPEventAvalonName")



-- event == "AvalonVollName"
function onATCPEventAvalonVollName(event, arg)
	if player.vollername ~= arg then
		player.vollername = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonVollName", "onATCPEventAvalonVollName")



-- event == "AvalonPortfolio"
function onATCPEventAvalonPortfolio(event, arg)
	if player.portfolio ~= arg then 
		player.portfolio = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonPortfolio", "onATCPEventAvalonPortfolio")



-- event == "AvalonGilde"
function onATCPEventAvalonGilde(event, arg)
	if player.gilde ~= arg then
		player.gilde = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonGilde", "onATCPEventAvalonGilde")


-- event == "AvalonZuenfte"
function onATCPEventAvalonZuenfte(event, arg)
	if player.zuenfte ~= arg then 
		player.zuenfte = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonZuenfte", "onATCPEventAvalonZuenfte")



-- event == "AvalonAlter"
function onATCPEventAvalonAlter(event, arg)
	if player.alter ~= arg then 
		player.alter = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonAlter", "onATCPEventAvalonAlter")



-- event == "AvalonLevel"
function onATCPEventAvalonLevel(event, arg)
	if player.level ~= arg then
		player.level = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonLevel", "onATCPEventAvalonLevel")



-- event == "AvalonEP"
function onATCPEventAvalonEP(event, arg)
	if player.ep ~= arg then
		player.ep = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonEP", "onATCPEventAvalonEP")



-- event == "AvalonGesinnung"
function onATCPEventAvalonGesinnung(event, arg)
	if player.gesinnung ~= arg then 
		player.gesinnung = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonGesinnung", "onATCPEventAvalonGesinnung")



-- event == "AvalonHunger"
function onATCPEventAvalonHunger(event, arg)
	if player.hunger ~= arg then 
		player.hunger = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonHunger", "onATCPEventAvalonHunger")



-- event == "AvalonDurst"
function onATCPEventAvalonDurst(event, arg)
	if player.durst ~= arg then
		player.durst = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonDurst", "onATCPEventAvalonDurst")



----------------------------------------------------------------------------------------
--  TP, TPMAX, AP, APMAX, ZP, ZPMAX, MP, MPMAX
----------------------------------------------------------------------------------------

-- event == "AvalonTP"
function onATCPEventAvalonTP(event, arg)
	if player.stats.tp ~= tonumber(arg) then 
		player.stats.tp = tonumber(arg)
		raiseEvent("RefreshHealthBar", {player.stats.tp, player.stats.tp_max})
	end
end
registerAnonymousEventHandler("AvalonTP", "onATCPEventAvalonTP")



-- event == "AvalonMAXTP"
function onATCPEventAvalonMAXT(event, arg)
	if player.stats.tp_max ~= tonumber(arg) then
		player.stats.tp_max = tonumber(arg)
		raiseEvent("RefreshHealthBar", {player.stats.tp, player.stats.tp_max})
	end
end
registerAnonymousEventHandler("AvalonMAXTP", "onATCPEventAvalonMAXT")



-- event == "AvalonAP"
function onATCPEventAvalonAP(event, arg)
	if player.stats.ap ~= tonumber(arg) then 
		player.stats.ap = tonumber(arg)
		raiseEvent("RefreshEnduranceBar", {player.stats.ap, player.stats.ap_max})
	end
end
registerAnonymousEventHandler("AvalonAP", "onATCPEventAvalonAP")



-- event == "AvalonMAXAP"
function onATCPEventAvalonMAXAP(event, arg)
	if player.stats.ap_max ~= tonumber(arg) then 
		player.stats.ap_max = tonumber(arg)
		raiseEvent("RefreshEnduranceBar", {player.stats.ap, player.stats.ap_max})
	end
end
registerAnonymousEventHandler("AvalonMAXAP", "onATCPEventAvalonMAXAP")



-- event == "AvalonSP"
function onATCPEventAvalonSP(event, arg)
	if player.stats.zp ~= tonumber(arg) then 
		player.stats.zp = tonumber(arg)
		raiseEvent("RefreshSpellpointsBar", {player.stats.zp, player.stats.zp_max})
	end
end
registerAnonymousEventHandler("AvalonSP", "onATCPEventAvalonSP")



-- event == "AvalonMAXSP"
function onATCPEventAvalonMAXSP(event, arg)
	if player.stats.zp_max ~= tonumber(arg) then 
		player.stats.zp_max = tonumber(arg)
		raiseEvent("RefreshSpellpointsBar", {player.stats.zp, player.stats.zp_max})
	end
end
registerAnonymousEventHandler("AvalonMAXSP", "onATCPEventAvalonMAXSP")



-- event == "AvalonMP"
function onATCPEventAvalonMP(event, arg)
	if player.stats.mp ~= tonumber(arg) then
		player.stats.mp = tonumber(arg)
		raiseEvent("RefreshManaBar", {player.stats.mp, player.stats.mp_max})
	end
end
registerAnonymousEventHandler("AvalonMP", "onATCPEventAvalonMP")



-- event == "AvalonMAXMP"
function onATCPEventAvalonMAXMP(event, arg)
	if player.stats.mp_max ~= tonumber(arg) then
		player.stats.mp_max = tonumber(arg)
		raiseEvent("RefreshManaBar", {player.stats.mp, player.stats.mp_max})
	end
end
registerAnonymousEventHandler("AvalonMAXMP", "onATCPEventAvalonMAXMP")

-----------------------

registerAnonymousEventHandler("AvalonHoehe", "onATCPEvent")
registerAnonymousEventHandler("AuthRequest", "onATCPEvent")
registerAnonymousEventHandler("AvalonDunkel", "onATCPEvent")
registerAnonymousEventHandler("AvalonFlucht", "onATCPEvent")
registerAnonymousEventHandler("AvalonSchutz", "onATCPEvent")
registerAnonymousEventHandler("AvalonRoomID", "onATCPEvent")
registerAnonymousEventHandler("AvalonGruppe", "onATCPEvent")
registerAnonymousEventHandler("RoomBrief", "onATCPEvent")
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



--------------------------------------------------------------------
-- onKill wird durch einen kill ausgelöst -- ab hier nicht funktionsfähig
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
