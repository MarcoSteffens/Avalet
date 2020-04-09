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
	cecho("<magenta>Wer dies lesen kann, hat einen Fehler gefunden! (atcp.lua, funct. onATCPEvent\n")
end



----------------------------------------------------------------------------------------
-- Misc
----------------------------------------------------------------------------------------

-- event == "AvalonGrafikVermeiden"
function onATCPEventAvalonGrafikVermeiden(event, arg)
	debugc("AvalonGrafikVermeiden = " .. tostring(arg) .. "\n")

--	channel = "ATCP"
--	message = "AvalonGrafikVermeiden = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonGrafikVermeiden", "onATCPEventAvalonGrafikVermeiden")



-- event == "AuthRequest"
function onATCPEventAuthRequest(event, arg)
	debugc("AuthRequest = " .. tostring(arg) .. "\n")

--	channel = "ATCP"
--	message = "AuthRequest = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AuthRequest", "onATCPEventAuthRequest")



----------------------------------------------------------------------------------------
--  Charakter-Daten/Spielstand
----------------------------------------------------------------------------------------

-- event == "AvalonName"
function onATCPEventAvalonName(event, arg)
	debugc("<magenta>AvalonName per ATCP empfangen!\n")
	if player.name ~= arg then
		if string.len(player.name) == 0 then
			loadCharacterFileFromDisk(arg)
		end
		player.name = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonName", "onATCPEventAvalonName")



-- event == "AvalonVollName"
function onATCPEventAvalonVollName(event, arg)
	debugc("<magenta>AvalonVollName per ATCP empfangen!\n")
	if player.vollername ~= arg then
		player.vollername = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonVollName", "onATCPEventAvalonVollName")



-- event == "AvalonPortfolio"
function onATCPEventAvalonPortfolio(event, arg)
	debugc("<magenta>AvalonPortfolio per ATCP empfangen!\n")
	if player.portfolio ~= arg then 
		player.portfolio = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonPortfolio", "onATCPEventAvalonPortfolio")



-- event == "AvalonGilde"
function onATCPEventAvalonGilde(event, arg)
	debugc("<magenta>AvalonGilde per ATCP empfangen!\n")
	if player.gilde ~= arg then
		player.gilde = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonGilde", "onATCPEventAvalonGilde")


-- event == "AvalonZuenfte"
function onATCPEventAvalonZuenfte(event, arg)
	debugc("<magenta>AvalonZuenfte per ATCP empfangen!\n")
	if player.zuenfte ~= arg then 
		player.zuenfte = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonZuenfte", "onATCPEventAvalonZuenfte")



-- event == "AvalonAlter"
function onATCPEventAvalonAlter(event, arg)
	debugc("<magenta>AvalonAlter per ATCP empfangen: " .. arg .. "\n")
	if player.alter ~= arg then 
		player.alter = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonAlter", "onATCPEventAvalonAlter")



-- event == "AvalonLevel"
function onATCPEventAvalonLevel(event, arg)
	debugc("<magenta>AvalonLevel per ATCP empfangen!\n")
	if player.level ~= arg then
		player.level = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonLevel", "onATCPEventAvalonLevel")



-- event == "AvalonEP"
function onATCPEventAvalonEP(event, arg)
	debugc("<magenta>AvalonEP per ATCP empfangen!\n")
	if player.ep ~= arg then
		player.ep = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonEP", "onATCPEventAvalonEP")



-- event == "AvalonGesinnung"
function onATCPEventAvalonGesinnung(event, arg)
	debugc("<magenta>AvalonGesinnung per ATCP empfangen!\n")
	if player.gesinnung ~= arg then 
		player.gesinnung = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonGesinnung", "onATCPEventAvalonGesinnung")



-- event == "AvalonHunger"
-- Die Texte für Hunger und für Durst haben am Ende ein Leerzeichen zu viel.
function onATCPEventAvalonHunger(event, arg)
	debugc("<magenta>AvalonHunger per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.hunger ~= arg then 
		player.hunger = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonHunger", "onATCPEventAvalonHunger")



-- event == "AvalonDurst"
-- Die Texte für Hunger und für Durst haben am Ende ein Leerzeichen zu viel.
function onATCPEventAvalonDurst(event, arg)
	debugc("<magenta>AvalonDurst per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.durst ~= arg then
		player.durst = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonDurst", "onATCPEventAvalonDurst")



-- event == "AvalonDurst"
-- Die Texte für Hunger und für Durst haben am Ende ein Leerzeichen zu viel.
function onATCPEventAvalonDurst(event, arg)
	debugc("<magenta>AvalonDurst per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.durst ~= arg then
		player.durst = arg
		raiseEvent("RefreshInfobox", arg)
	end
end
registerAnonymousEventHandler("AvalonDurst", "onATCPEventAvalonDurst")



-- event == "AvalonHoehe"
function onATCPEventAvalonHoehe(event, arg)
	debugc("<magenta>AvalonHoehe per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.hoehe ~= arg then
		player.hoehe = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonHoehe = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonHoehe", "onATCPEventAvalonHoehe")



-- event == "AvalonFlucht"
function onATCPEventAvalonFlucht(event, arg)
	debugc("<magenta>AvalonFlucht per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.flucht ~= arg then
		player.flucht = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonFlucht = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonFlucht", "onATCPEventAvalonFlucht")



-- event == "AvalonSchutz"
function onATCPEventAvalonSchutz(event, arg)
	debugc("<magenta>AvalonSchutz per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.schutz ~= arg then
		player.schutz = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonSchutz = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonSchutz", "onATCPEventAvalonSchutz")



-- event == "AvalonGruppe"
function onATCPEventAvalonGruppe(event, arg)
	debugc("<magenta>AvalonGruppe per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.gruppenname ~= arg then
		player.gruppenname = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonGruppe = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonGruppe", "onATCPEventAvalonGruppe")



-- event == "AvalonZaubern"
function onATCPEventAvalonZaubern(event, arg)
	debugc("<magenta>AvalonZaubern per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.zaubern ~= arg then
		player.zaubern = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonZaubern = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonZaubern", "onATCPEventAvalonZaubern")



-- event == "AvalonKampf"
function onATCPEventAvalonKampf(event, arg)
	debugc("<magenta>AvalonKampf per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.kampf ~= arg then
		player.kampf = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonKampf = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonKampf", "onATCPEventAvalonKampf")



-- event == "AvalonAngegriffen"
function onATCPEventAvalonAngegriffen(event, arg)
	debugc("<magenta>AvalonAngegriffen per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.angegriffen ~= arg then
		player.angegriffen = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonAngegriffen = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonAngegriffen", "onATCPEventAvalonAngegriffen")



-- event == "AvalonGetoetet"
function onATCPEventAvalonGetoetet(event, arg)
	debugc("<magenta>AvalonGetoetet per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.getoetet ~= arg then
		player.getoetet = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonGetoetet = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonGetoetet", "onATCPEventAvalonGetoetet")



-- event == "AvalonGruppeGetoetet"
function onATCPEventAvalonGruppeGetoetet(event, arg)
	debugc("<magenta>AvalonGruppeGetoetet per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.gruppeGetoetet ~= arg then
		player.gruppeGetoetet = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonGruppeGetoetet = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonGruppeGetoetet", "onATCPEventAvalonGruppeGetoetet")



-- event == "AvalonAllyGetoetet"
function onATCPEventAvalonAllyGetoetet(event, arg)
	debugc("<magenta>AvalonAllyGetoetet per ATCP empfangen!\n")
	arg = string.trim(arg)
	if player.allyGetoetet ~= arg then
		player.allyGetoetet = arg
		-- raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonAllyGetoetet = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonAllyGetoetet", "onATCPEventAvalonAllyGetoetet")



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



----------------------------------------------------------------------------------------
--  Kommunikation
--
-- Meldungen über channel:
-- Avalon.Channel [kanalname] [Nachricht]
----------------------------------------------------------------------------------------

-- In der per ATCP empfangenen Kommunikation gibt es Formatierungsanweisungen,
-- die hier rausgefiltert werden.
function clearMessage(str)
	message = str
	message = string.gsub(message, "%%%^ITALIC%%%^", "")
	message = string.gsub(message, "%%%^NO_ITALIC%%%^", "")
	message = string.gsub(message, "%%%^NC_html_begin_colour%(%#[A-Za-z0-9]+%)%%%^", "")
	message = string.gsub(message, "%%%^NC_html_end_colour%%%^", "")

	return message
end


-- event == "AvalonChannel"
function onATCPEventAvalonChannel(event, arg)
	debugc("AvalonChannel = " .. arg .. "\n")
	
	channel = string.title(string.match(arg, "(%w+)"))
	message = arg:gsub("^.-%s", "", 1)
	message = clearMessage(message)

	-- Die Channelnamen hängen davon ab, in welcher Gilde, Zunft, in welchem Volk etc. der Char ist.
	-- Keine Ahnung wie die alle heißen... 
	-- Aber ich plünder mal das Script von Twrx und hoffe ansonsten, dass sich Spieler melden,
	-- wenn ihr Kanal nicht abgedeckt ist. Diese Spieler haben dann in ihrem Profil-Verzeichnis, dort
	-- im Ordner "log", eine Datei mit dem Kanalnamen + ".txt". Diesen Namen - ohne ".txt" - hier 
	-- sinnig einbauen.

	if channel == "Hyraskrieger" then channel = "Gilde" end
	if channel == "Golemkultisten" then channel = "Gilde" end
	if channel == "Daemonenkrieger" then channel = "Gilde" end
	if channel == "Runenschmied" then channel = "Gilde" end
	if channel == "Barden" then channel = "Gilde" end
	if channel == "Kleriker" then channel = "Gilde" end
	if channel == "Druiden" then channel = "Gilde" end
	if channel == "Nekromanten" then channel = "Gilde" end
	if channel == "Magier" then channel = "Gilde" end

	if channel == "Mensch" then channel = "Volk" end
	if channel == "Hobbit" then channel = "Volk" end
	if channel == "Elf" then channel = "Volk" end
	if channel == "Dunkelelf" then channel = "Volk" end
	if channel == "Zwerg" then channel = "Volk" end
	if channel == "Chaoszentaur" then channel = "Volk" end
	if channel == "Amphib" then channel = "Volk" end
	
	Logger:Log(channel, message, {"timestamp"})
	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonChannel", "onATCPEventAvalonChannel")



-- event == "AvalonComm"
function onATCPEventAvalonComm(event, arg)
	debugc("AvalonComm = " .. arg .. "\n")
	--Logger:Log(file, line_to_save, options_table)
	channel = "Sagen"
	message = arg:gsub("^.-%s", "", 1)
	message = clearMessage(message)
	Logger:Log(channel, message, {"timestamp"})
	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonComm", "onATCPEventAvalonComm")



-- event == "AvalonRComm"
function onATCPEventAvalonRComm(event, arg)
	debugc("AvalonRComm = " .. arg .. "\n")
	--if player.stats.mp_max ~= tonumber(arg) then
	--	player.stats.mp_max = tonumber(arg)
	--	raiseEvent("RefreshManaBar", {player.stats.mp, player.stats.mp_max})
	--end
	channel = "Reden"
	message = arg:gsub("^.-%s", "", 1)
	message = clearMessage(message)
	Logger:Log(channel, message, {"timestamp"})
	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonRComm", "onATCPEventAvalonRComm")



-- event == "AvalonSoul"
function onATCPEventAvalonSoul(event, arg)
	debugc("AvalonSoul = " .. arg .. "\n")
	--if player.stats.mp_max ~= tonumber(arg) then
	--	player.stats.mp_max = tonumber(arg)
	--	raiseEvent("RefreshManaBar", {player.stats.mp, player.stats.mp_max})
	--end
	channel = "Sagen"
	message = arg:gsub("^.-%s", "", 1)
	message = clearMessage(message)
	Logger:Log(channel, message, {"timestamp"})
	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonSoul", "onATCPEventAvalonSoul")



-- event == "AvalonRSoul"
function onATCPEventAvalonRSoul(event, arg)
	debugc("AvalonRSoul = " .. arg .. "\n")
	--if player.stats.mp_max ~= tonumber(arg) then
	--	player.stats.mp_max = tonumber(arg)
	--	raiseEvent("RefreshManaBar", {player.stats.mp, player.stats.mp_max})
	--end
	channel = "Reden"
	message = arg:gsub("^.-%s", "", 1)
	message = clearMessage(message)
	Logger:Log(channel, message, {"timestamp"})
	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonRSoul", "onATCPEventAvalonRSoul")



----------------------------------------------------------------------------------------
--  ??? Item-Handling
----------------------------------------------------------------------------------------

-- event == "AvalonInventarRein"
function onATCPEventAvalonInventarRein(event, arg)
	debugc("AvalonInventarRein = " .. arg .. "\n")
	
	if player.inventarRein ~= arg then
		player.inventarRein = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonInventarRein = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonInventarRein", "onATCPEventAvalonInventarRein")



-- event == "AvalonInventarRaus"
function onATCPEventAvalonInventarRaus(event, arg)
	debugc("AvalonInventarRaus = " .. arg .. "\n")
	
	if player.inventarRaus ~= arg then
		player.inventarRaus = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonInventarRaus = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonInventarRaus", "onATCPEventAvalonInventarRaus")



-- event == "AvalonBehaelterRein"
function onATCPEventAvalonBehaelterRein(event, arg)
	debugc("AvalonBehaelterRein = " .. arg .. "\n")
	
	if player.behaelterRein ~= arg then
		player.behaelterRein = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonBehaelterRein = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonBehaelterRein", "onATCPEventAvalonBehaelterRein")



-- event == "AvalonBehaelterRaus"
function onATCPEventAvalonBehaelterRaus(event, arg)
	debugc("AvalonBehaelterRaus = " .. arg .. "\n")
	
	if player.behaelterRaus ~= arg then
		player.behaelterRaus = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonBehaelterRaus = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonBehaelterRaus", "onATCPEventAvalonBehaelterRaus")



-- event == "AvalonGefuehrt"
function onATCPEventAvalonGefuehrt(event, arg)
	debugc("AvalonAvalonGefuehrt = " .. arg .. "\n")
	
	if player.gefuehrt ~= arg then
		player.gefuehrt = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonGefuehrt = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonGefuehrt", "onATCPEventAvalonGefuehrt")



-- event == "AvalonGesenkt"
function onATCPEventAvalonGesenkt(event, arg)
	debugc("AvalonGesenkt = " .. arg .. "\n")
	
	if player.gesenkt ~= arg then
		player.gesenkt = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonGesenkt = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonGesenkt", "onATCPEventAvalonGesenkt")



-- event == "AvalonAngezogen"
function onATCPEventAvalonAngezogen(event, arg)
	debugc("AvalonAvalonAngezogen = " .. arg .. "\n")
	
	if player.angezogen ~= arg then
		player.angezogen = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonAngezogen = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonAngezogen", "onATCPEventAvalonAngezogen")



-- event == "AvalonAusgezogen"
function onATCPEventAvalonAusgezogen(event, arg)
	debugc("AvalonGesenkt = " .. arg .. "\n")
	
	if player.ausgezogen ~= arg then
		player.ausgezogen = arg
--		raiseEvent("RefreshInfobox", arg)
	end
--	channel = "ATCP"
--	message = "AvalonAusgezogen = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonAusgezogen", "onATCPEventAvalonAusgezogen")



--------------------------------------------------------------------
-- Map/Mapper
--------------------------------------------------------------------

-- event == "AvalonDunkel"
function onATCPEventAvalonDunkel(event, arg)
	debugc("AvalonDunkel = " .. tostring(arg) .. "\n")

--	-- mapper.dunkel gibt es nicht, bei bedarf anlegen	
--	if tmapper.dunkel ~= arg then
--		tmapper.dunkel = arg
--	end
--	channel = "ATCP"
--	message = "AvalonDunkel = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonDunkel", "onATCPEventAvalonDunkel")



-- event == "AvalonRoomID"
function onATCPEventAvalonRoomID(event, arg)
	debugc("AvalonRoomID = " .. tostring(arg) .. "\n")

--	-- tMapper.roomID gibt es nicht, bei bedarf anlegen	
--	if tMapper.roomID ~= arg then
--		tMapper.roomID = arg
--	end
--	channel = "ATCP"
--	message = "AvalonRoomID = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonRoomID", "onATCPEventAvalonRoomID")



-- event == "AvalonRoomBrief"
function onATCPEventAvalonRoomBrief(event, arg)
	debugc("AvalonRoomBrief = " .. tostring(arg) .. "\n")

--	-- tMapper.roomBrief gibt es nicht, bei bedarf anlegen	
--	if tMapper.roomBrief ~= arg then
--		tMapper.roomBrief = arg
--	end
--	channel = "ATCP"
--	message = "AvalonRoomBrief = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonRoomBrief", "onATCPEventAvalonRoomBrief")



-- event == "AvalonArea"
function onATCPEventAvalonArea(event, arg)
	debugc("AvalonArea = " .. tostring(arg) .. "\n")

--	-- tMapper.area gibt es nicht, bei bedarf anlegen	
--	if tMapper.area ~= arg then
--		tMapper.area = arg
--	end
--	channel = "ATCP"
--	message = "AvalonArea = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonArea", "onATCPEventAvalonArea")



-- event == "AvalonInv"
function onATCPEventAvalonInv(event, arg)
	debugc("AvalonInv = " .. tostring(arg) .. "\n")

--	-- tMapper.inv gibt es nicht, bei bedarf anlegen	
--	if tMapper.inv ~= arg then
--		tMapper.inv = arg
--	end
--	channel = "ATCP"
--	message = "AvalonInv = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonInv", "onATCPEventAvalonInv")



-- event == "AvalonSite"
function onATCPEventAvalonSite(event, arg)
	debugc("AvalonSite = " .. tostring(arg) .. "\n")

--	-- tMapper.site gibt es nicht, bei bedarf anlegen	
--	if tMapper.site ~= arg then
--		tMapper.site = arg
--	end
--	channel = "ATCP"
--	message = "AvalonSite = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonSite", "onATCPEventAvalonSite")



-- event == "AvalonExits"
function onATCPEventAvalonExits(event, arg)
	debugc("AvalonExits = " .. tostring(arg) .. "\n")

--	-- tMapper.exits gibt es nicht, bei bedarf anlegen	
--	if tMapper.exits ~= arg then
--		tMapper.exits = arg
--	end
--	channel = "ATCP"
--	message = "AvalonExits = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonExits", "onATCPEventAvalonExits")



-- event == "AvalonAvalonWeg"
function onATCPEventAvalonAvalonWeg(event, arg)
	debugc("AvalonAvalonWeg = " .. tostring(arg) .. "\n")

--	-- tMapper.avalonWeg gibt es nicht, bei bedarf anlegen	
--	if tMapper.avalonWeg ~= arg then
--		tMapper.avalonWeg = arg
--	end
--	channel = "ATCP"
--	message = "AvalonAvalonWeg = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonAvalonWeg", "onATCPEventAvalonAvalonWeg")



-- event == "AvalonAvalonIcon16"
function onATCPEventAvalonAvalonIcon16(event, arg)
	debugc("AvalonAvalonWeg = " .. tostring(arg) .. "\n")

--	-- tMapper.avalonIcon16 gibt es nicht, bei bedarf anlegen	
--	if tMapper.avalonIcon16 ~= arg then
--		tMapper.avalonIcon16 = arg
--	end
--	channel = "ATCP"
--	message = "AvalonAvalonIcon16 = " .. arg .. "\n"
--	Logger:Log(channel, message, {"timestamp"})
--	raiseEvent("RefreshTabElement", channel)
end
registerAnonymousEventHandler("AvalonAvalonIcon16", "onATCPEventAvalonAvalonIcon16")



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

-- Script: AvalonAP
function AvalonAP(event,arg)
	tPlayer.diffap = tonumber(arg) - tonumber(tPlayer.ap)
	onATCP (event,arg)
end
--registerAnonymousEventHandler("AvalonAP", "AvalonAP")


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
