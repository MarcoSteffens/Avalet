----------------------------------------
-- GUI-Model
-- Hier werden die Daten für die View gehalten oder erstellt,
-- außerdem sind hier die Events für die Aktualisierung der
-- View zu finden.
----------------------------------------

GUIModel = GUIModel or {}

-----------------------------------------------------
-- Charakter-Informationen rechts oben
-----------------------------------------------------

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end


GUIModel.Infobox = "\n"
function updateInfoBox()
	GUIModel.Infobox = "\n"
	clearWindow("Spielstand")
	if string.len(player.vollername) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "In Avalon bist Du bekannt als\n\n" .. player.vollername .. "\n\n"
		if string.len(player.gilde) ~= 0 then
			if player.gilde == "keine" then
				GUIModel.Infobox = GUIModel.Infobox .. "Du bist noch in keiner Gilde.\n"
			else
				GUIModel.Infobox = GUIModel.Infobox .. "Du bist " .. player.gilde .. ".\n"
			end
		end
		if string.len(player.zuenfte) == 0 then
			GUIModel.Infobox = GUIModel.Infobox .. "Du übst noch keine Berufe aus.\n"
		else
			GUIModel.Infobox = GUIModel.Infobox .. "Deine Berufe sind: " .. player.zuenfte .. ".\n"
		end
		if string.len(player.alter) ~= 0 then
			GUIModel.Infobox = GUIModel.Infobox .. "Dein Alter: " .. player.alter .. "\n"
		end
		if string.len(player.portfolio) ~= 0 then
			if player.portfolio == player.name then
				GUIModel.Infobox = GUIModel.Infobox .. "Du bist Erstie.\n\n"
			else
				GUIModel.Infobox = GUIModel.Infobox .. "Du bist Zweitie im Portfolio von " .. firstToUpper(player.portfolio) .. ".\n\n"
			end
		end
		if string.len(player.level) ~= 0 then
			GUIModel.Infobox = GUIModel.Infobox .. "Dein Level: " .. player.level .. "\n"
		end
		if string.len(player.ep) ~= 0 then
			GUIModel.Infobox = GUIModel.Infobox .. "Dafür hast du bisher " .. player.ep .. " Erfahrungspunkte gesammelt.\n\n"
		end
		if string.len(player.gesinnung) ~= 0 then
			GUIModel.Infobox = GUIModel.Infobox .. "Du bist " .. player.gesinnung .. " drauf.\n"
		end
		if string.len(player.hunger) ~= 0 then
			GUIModel.Infobox = GUIModel.Infobox .. "Hunger: " .. player.hunger .. "\n"
		end
		if string.len(player.durst) ~= 0 then
			GUIModel.Infobox = GUIModel.Infobox .. "Durst: " .. player.durst .. "\n"
		end
	end

end
updateInfoBox()

--------------------------------------------
--- Tabs-Element rechts unten
-------------------------------------------

-- Generelle Variablen für das Tab-Element
GUIModel.menu = GUIModel.menu or {
  tabs = {"Schwafel","Laber","Volk","Gilde", "Gruppe", "Sag", "Rede"},
  color1 = "rgb(0,0,70)",
  color2 = "rgb(0,0,50)",
  --color1 = "red",
  --color2 = "white",
  width = "10%",
  height = "40%",
}
-- Speichert das aktuell ausgewählte Element:
GUIModel.menu.current = GUIModel.menu.current or GUIModel.menu.tabs[1]

for k,v in pairs(GUIModel.menu.tabs) do
	-- Erzeugt einen Text-Variable für jeden Eintrag in der Menu-Liste
	GUIModel.menu["chat"..v] = v  
end

-- HIer muss der INhalt der Dateien vorhanden sein, in dene die Chats stehen sollen.

-------------------------------------------------------------
--- Top-Menü
-- Menü-Label dürfen nicht in einem Container sein, deshalb sind die 
-- Top-Level-Einträge direkt auf der Oberfläche positioniert.
-------------------------------------------------------------
GUIModel.TopMenuEntries = {}

function addTopMenuEntry(label, position, childs)
	--TODO: validierung der Parameter (insbesondere der childs)
	table.insert(GUIModel.TopMenuEntries,position,{label,childs})
end

--addTopMenuEntry("titel", position)
--addSubMenuEntry("parent", postition, "titel", "label", "luafun", args = {})
--addSubMenuEntry("Top1",1,"Child","label","luafun",{"a1","a2","a3"})
--function blubb()
addTopMenuEntry("Top1", 1, {{"Child1", 1, "label1", "luafun", {"a1","a2","a3"}}, {"Child2", 2, "label2", "luafun",{"a12","a22","a32"}},{"Child3", 1, "label3","luafun",{"a31", "a32", "a33"}}})
addTopMenuEntry("Top2", 2, {{"Child1", 1, "label1", "luafun", {"a1","a2","a3"}}, {"Child2", 2, "label2", "luafun",{"a12","a22","a32"}},{"Child3", 1, "label3", "luafun",{"a31", "a32", "a33"}}})
addTopMenuEntry("Top1a", 1, {{"Child1", 1, "label1", "luafun", {"a1","a2","a3"}}, {"Child2", 2, "label2", "luafun",{"a12","a22","a32"}},{"Child3", 1, "label3", "luafun",{"a31", "a32", "a33"}}})
--end
--addTopMenuEntry(
--	"Top1", 
--	1, 
--	{
--		{"childName1", 1, "childBeschriftung1", "luafun", {"a1","a2","a3"}}, 
--		{"childName2", 2, "childBeschriftung2", "luafun", {"a1","a2","a3"}}, 
--		{"childName1a", 1, "childBeschriftung1a", "luafun", {"a1","a2","a3"}}
--	}
--)

----------------------------------------
-- Mapper (Karte) links oben
----------------------------------------


---------------------------------------------------------------------------
-- Gauges für die Timer
---------------------------------------------------------------------------

-- Dummy-Daten für die Timer-Liste. Die Startzeit ist später einfach os.time()
listOfTimers = {
	{["name"] = "Arkanschild", ["starttime"] = (os.time() - 550), ["duration"] = 600},
	{["name"] = "Kampfbeschwörung", ["starttime"] = (os.time() - 580), ["duration"] = 600},
	{["name"] = "Erdaura", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Schild", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Magiertrance", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Magieaufladung", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Steinhaut", ["starttime"] = "false", ["duration"] = "false"},
	{["name"] = "Windhaut", ["starttime"] = "false", ["duration"] = "false"},
	{["name"] = "Manarausch", ["starttime"] = "false", ["duration"] = "false"},
}

listOfTimers = {}


function sortListOfTimers()
	-- echo("\nfunc sortListOfTimers()\n")
	sortedListOfTimers = {}
	for k, v in pairs(listOfTimers) do
		
		-- echo("NAME: " .. v["name"] .. "\n")
	
		if v["duration"] == "false" then
			-- echo("add permanent timer\n")
			table.insert(sortedListOfTimers, {["name"] = v["name"], ["remaining"] = 600, ["duration"] = 600})
		else
			-- echo("add temporary timer ... gleich kommt ein ture\n")
			remaining = (v["duration"] - ((os.time() - v["starttime"])))
			if remaining <= -30 then 
-- TODO: 		hier einr emoveTimer könnte Probleme machen, weil removeTimer wieder sortListOfTimers aufruft - aber
--       		im MOment scheint es zu funktionieren.
--       		Problem ist, dass Timer irgendwanng elöscht werden müssen, da sie nach einem längeren disconnect vielleicht
--       		schon grundlos laufen, aber dann eben auch nie vom entsprechenden trigger beendet werden.
--       		die methode hier funzt nur bei temporären timern, nicht bei permanenten. lösung dafür?
				removeTimer(v["name"])
				break
			end
			if remaining <= 0 then 
				remaining = 0 
			end
			-- echo("remaining: " .. tostring(remaining) .. "\n")
			table.insert(sortedListOfTimers, {["name"] = v["name"], ["remaining"] = remaining, ["duration"] = v["duration"]})
			-- table.insert(sortedListOfTimers, {["name"] = v["name"], ["remaining"] = v["duration"] - ((os.time() - v["starttime"])), ["duration"] = 600})
		end
		-- table.insert(sortedListOfTimers, {})
	end

	sortMyTimers = function(a, b) return a["remaining"] > b["remaining"] end
	table.sort(sortedListOfTimers, sortMyTimers)
	--echo("Anzahl Elemente in sortedListOfTimers(): "..#sortedListOfTimers.."\n")
end

sortListOfTimers()

function findTimerByName(name)
	--echo("findTimerByName\n")
    for k, v in pairs(listOfTimers) do
        if v["name"] == name then return k end
    end
    return nil
end

function registerTimer(name, duration)
	--echo("\nregisterTimer\n")
	if duration == false then
		duration = "false"
	end
	table.insert(listOfTimers, {["name"] = name, ["starttime"] = os.time(), ["duration"] = duration})
	--echo("starttime: " .. os.time() .. "\n")
	sortListOfTimers()
	raiseEvent("RecreateTimerView")
end

function removeTimer(name)
	--echo("removeTimer\n")
	key = findTimerByName(name)
	table.remove(listOfTimers, key)
	sortListOfTimers()
	raiseEvent("RecreateTimerView")
end
--removeTimer("Magiertrance")



function recreateTimer()
	--echo("func recreateTimer\n")
	sortListOfTimers()

	for k = 1, 9, 1 do
		hideWindow("GUI.Timer"..k.."_front")
		hideWindow("GUI.Timer"..k.."_back")	
		GUI["Timer"..k]:setText ("")
	end

	timerSchriftfarbe="white"

	for k, v in pairs(sortedListOfTimers) do
		showWindow("GUI.Timer"..k.."_front")
		showWindow("GUI.Timer"..k.."_back")		
		if v["remaining"] < 1 then
			v["remaining"] = 1
			timerSchriftfarbe="fuchsia"
		elseif v["remaining"] < 30 then
			timerSchriftfarbe="red"
		elseif v["remaining"] < 60 then
			timerSchriftfarbe="yellow"
		else
			timerSchriftfarbe="white"
		end
		--GUI["Timer"..k]:setValue(tonumber(v["remaining"]), tonumber(v["duration"]), v["name"])
		GUI["Timer"..k]:setValue(tonumber(v["remaining"]), tonumber(v["duration"]), [[<b><font color="]]..timerSchriftfarbe..[[">&nbsp;]] .. v["name"] .. [[</b></font>]])
		--echo("\nRECREATE remaining: " .. v["remaining"] .. ", duration: " .. v["duration"] .. ", name: " .. v["name"] .. "\n\n")
	end
end


function refreshTimer()
	--echo("func refreshTimer\n")
	sortListOfTimers()

	timerSchriftfarbe="white"
	for k, v in pairs(sortedListOfTimers) do
		showWindow("GUI.Timer"..k.."_front")
		showWindow("GUI.Timer"..k.."_back")		
		if v["remaining"] < 1 then
			v["remaining"] = 1
			timerSchriftfarbe="fuchsia"
		elseif v["remaining"] < 30 then
			timerSchriftfarbe="red"
		elseif v["remaining"] < 60 then
			timerSchriftfarbe="yellow"
		else
			timerSchriftfarbe="white"
		end
		--GUI["Timer"..k]:setValue(tonumber(v["remaining"]), tonumber(v["duration"]), v["name"])
		GUI["Timer"..k]:setValue(tonumber(v["remaining"]), tonumber(v["duration"]), [[<b><font color="]]..timerSchriftfarbe..[[">&nbsp;]] .. v["name"] .. [[</b></font>]])	
		--echo("REFRESH remaining: " .. tostring(v["remaining"]) .. ", duration: " .. tostring(v["duration"]) .. ", name: " .. tostring(v["name"]) .. "\n")		
	end
end

-----------------------------------
-- Gauges für TP, AP, ZP und Mana
-----------------------------------

-- Daten hier halten oder direkt aus dem character-objekt?

----------------------------
-- Refresh Event Handler
-----------------------------

function onRefreshInfobox(event, args)
	updateInfoBox()
	--GUI.Spielstand:echo(args)
	GUI.Spielstand:echo(GUIModel.Infobox)
	--GUI.Health:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
end
registerAnonymousEventHandler("RefreshInfobox", "onRefreshInfobox")
--raiseEvent("RefreshCharacterVollername", ???)

function onRefreshTimerView(event, args)
	--echo("onRefreshTimerView DAS SOLLTE NICHT PASSIEREN\n")
	if #listOfTimers ~= nil then
		--echo("listOfTimers ist nicht nil\n")
		if #listOfTimers > 0 then
			--echo("listOfTimers ist > 0\n")
			--timersStopWatch = timersStopWatch or createStopWatch()
			enableTimer("avaletTimersTimer")
		else
			--echo("timer disabled\n")
			disableTimer("avaletTimersTimer")
		end
	else
		--echo("#listOfTimers == nil\n")
		disableTimer("avaletTimersTimer")
	end
end
registerAnonymousEventHandler("RefreshTimerView", "onRefreshTimerView")

function onRecreateTimerView(event, args)
	--echo("onRecreateTimerView\n")

	if #listOfTimers ~= nil then
		--echo("listOfTimers ist nicht nil\n")
		if #listOfTimers > 0 then
			--echo("listOfTimers ist > 0\n")
			enableTimer("avaletTimersTimer")
		else
			--echo("timer disabled\n")
			disableTimer("avaletTimersTimer")
		end
	else
		--echo("#listOfTimers == nild\n")
		disableTimer("avaletTimersTimer")
	end
	recreateTimer()
end
registerAnonymousEventHandler("RecreateTimerView", "onRecreateTimerView")

function onRefreshHealthBar(event, args)
	GUI.Health:setValue(tonumber(args[1]), tonumber(args[2]), "<b><center>" .. args[1] .. "/" .. args[2] .. "</center></br><center>TP</center></b>")
	-- GUI.Health:setValue(100,100,[[<b><center>999/999</center></br><center>TP</center></b>]])
	-- [[<b><font color="]]..timerSchriftfarbe..[[">&nbsp;]] .. v["name"] .. [[</b></font>]]
end
registerAnonymousEventHandler("RefreshHealthBar", "onRefreshHealthBar")

function onRefreshEnduranceBar(event, args)
	GUI.Endurance:setValue(tonumber(args[1]), tonumber(args[2]), "<b><center>" .. args[1] .. "/" .. args[2] .. "</center></br><center>AP</center></b>")
end
registerAnonymousEventHandler("RefreshEnduranceBar", "onRefreshEnduranceBar")

function onRefreshSpellpointsBar(event, args)
	GUI.Spellpoints:setValue(tonumber(args[1]), tonumber(args[2]), "<b><center>" .. args[1] .. "/" .. args[2] .. "</center></br><center>ZP</center></b>")
end
registerAnonymousEventHandler("RefreshSpellpointsBar", "onRefreshSpellpointsBar")

function onRefreshManaBar(event, args)
	GUI.Mana:setValue(tonumber(args[1]), tonumber(args[2]), "<b><center>" .. args[1] .. "/" .. args[2] .. " Mana</center></b>")
end
registerAnonymousEventHandler("RefreshManaBar", "onRefreshManaBar")
