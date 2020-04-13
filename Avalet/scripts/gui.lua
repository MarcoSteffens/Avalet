----------------------------------------
-- GUI-Model
-- Hier werden die Daten für die View gehalten oder erstellt,
-- außerdem sind hier die Events für die Aktualisierung der
-- View zu finden.
----------------------------------------

GUIModel = GUIModel or {}

-----------------------------------------------------
-- Charakter-Informationen rechts oben (Infobox)
-----------------------------------------------------

GUIModel.infobox = "\n"
function updateInfoBox()
	GUIModel.infobox = "\n"
	if GUI ~= nil then 
		clearWindow("Infobox") 
	end
	if string.len(player.vollername) ~= 0 then
		GUIModel.infobox = GUIModel.infobox .. "In Avalon bist Du bekannt als\n\n" .. player.vollername .. "\n\n"
		if string.len(player.gilde) ~= 0 then
			if player.gilde == "keine" then
				GUIModel.infobox = GUIModel.infobox .. "Du bist noch in keiner Gilde.\n"
			else
				if player.gilde == "Druiden" then
					GUIModel.infobox = GUIModel.infobox .. "Du bist bei den " .. player.gilde .. ".\n"
				elseif player.gilde == "Magier" then
					GUIModel.infobox = GUIModel.infobox .. "Du bist in der " .. player.gilde .. "gilde.\n"
				else
					GUIModel.infobox = GUIModel.infobox .. "Du bist " .. player.gilde .. ".\n"
				end
			end
		end
		if string.len(player.zuenfte) == 0 then
			GUIModel.infobox = GUIModel.infobox .. "Du uebst noch keine Berufe aus.\n"
		else
			local zuenfte = {}
			for i in string.gmatch(player.zuenfte, "%w+") do
				table.insert(zuenfte, i)
			end			
			str = ""
			for k,v in pairs(zuenfte) do
				if k == #zuenfte then
					str = str .. " und "
				end
				str = str .. v
				if k < #zuenfte - 1 then
					str = str .. ", "
				end
			end
			
			GUIModel.infobox = GUIModel.infobox .. "Du gehoerst den Zuenften " .. str .. " an.\n"
			--GUIModel.infobox = GUIModel.infobox .. "Deine Berufe sind: " .. player.zuenfte .. ".\n"
		end
		if string.len(player.alter) ~= 0 then
			str = player.alter
			tage = string.gsub(str, "^(%d+%sTage?)%s.*", "%1", 1)
			stunden = string.gsub(str, ".*%s(%d+%sStunden?)%s.*", "%1", 1)
			minuten = string.gsub(str, ".*%s(%d+%sMinuten?)%s.*", "%1", 1)
			sekunden = string.gsub(str, ".*%s(%d+%sSekunden?)%s.*", "%1", 1)

			str = tage .. " " .. stunden .. " und " .. minuten

			GUIModel.infobox = GUIModel.infobox .. "Du bist etwa " .. str .. " alt.\n"
			--GUIModel.infobox = GUIModel.infobox .. "Du bist " .. player.alter .. " alt\n"
		end
		if string.len(player.portfolio) ~= 0 then
			if (player.portfolio ~= "keines") then
				if player.portfolio == player.name then
					GUIModel.infobox = GUIModel.infobox .. "Du bist Erstie in Deinem Portfolio.\n\n"
				else
					GUIModel.infobox = GUIModel.infobox .. "Du bist Zweitie im Portfolio von " .. string.title(player.portfolio) .. ".\n\n"
				end
			end
		end
		if string.len(player.level) ~= 0 then
			GUIModel.infobox = GUIModel.infobox .. "Du bist Level " .. player.level .. "\n"
		end
		if string.len(player.ep) ~= 0 then
			GUIModel.infobox = GUIModel.infobox .. "Dafür hast du bisher " .. player.ep .. " Erfahrungspunkte gesammelt.\n\n"
		end
		if string.len(player.gesinnung) ~= 0 then
			GUIModel.infobox = GUIModel.infobox .. "Deine Gesinnung ist " .. player.gesinnung .. ".\n"
		end
		if string.len(player.hunger) ~= 0 then
			GUIModel.infobox = GUIModel.infobox .. "Hunger: " .. player.hunger .. ".\n"
		end
		if string.len(player.durst) ~= 0 then
			GUIModel.infobox = GUIModel.infobox .. "Durst: " .. player.durst .. ".\n"
		end
	else
		debugc("\nKeine Player-Daten vorhanden!\n")
		GUIModel.infobox = "\nWarte auf Daten...\n"
	end
end
updateInfoBox()


function onRefreshInfobox(event, args)
-- Diese Funktion kann aufgerufen werden, obwohl noch
-- kein Player-Objekt besteht. (Also obwohl der Player-Name noch nicht
-- per ATCP eingetroffen ist. Workaround: auf player.name testen.)
	if player.name ~= "" then
		writeDataToFS(characterFilePath, player, "w")
		updateInfoBox()
		--GUI.infobox:echo(args)
		GUI.infobox:echo(GUIModel.infobox)
	--GUI.Health:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
	end
end
registerAnonymousEventHandler("RefreshInfobox", "onRefreshInfobox")
--raiseEvent("RefreshCharacterVollername", ???)



--------------------------------------------
--- Tabs-Element rechts unten
-------------------------------------------

-- Generelle Variablen für das Tab-Element
GUIModel.tabElement = GUIModel.tabElement or {
  tabs = {"Reden", "Sagen", "Gruppe", "Volk", "Gilde", "Laber", "Schwafel"},
  --tabs = {"Reden"},
  --width = "10%",
  --height = "40%",
}
-- Speichert das aktuell ausgewählte Element:
GUIModel.tabElement.currentTab = GUIModel.tabElement.currentTab or GUIModel.tabElement.tabs[1]

for k,v in pairs(GUIModel.tabElement.tabs) do
	-- Schreibt für jeden Tab einen Leerstring ("\n") in eine Datei,
	-- die nach dem Tab benannt ist. In diese Datei wird der Text 
	-- für den Tab gespeichert. Durch das Reinschreiben hier wird
	-- die Datei erzeugt, wenn es sie noch nicht gibt.
	Logger:Log(v, "")
end



function GUIModel.tabElement.addTab(arg)
	if arg then
		table.insert(GUIModel.tabElement.tabs,arg)
		GUI.tabElement.createTabs()
	else
		echo("ey so gehts ja nu nicht!\n")
	end
end

function GUIModel.tabElement.removeTab(arg)
	if arg ~= nil then
		for k,v in pairs(GUIModel.tabElement.tabs) do
			if v == arg then
				--cecho("<magenta>TEST")
				table.remove(GUIModel.tabElement.tabs, k)
				--GUI.tabElement.createTabs()
				GUI.tabElement.removeTab(arg)
			end
		end	
	end
end



function onRefreshTabElement(event, channel)

	content = ""
	if GUIModel.tabElement.currentTab == channel then
		debugc("Der TAB " .. channel .. " wird aktualisiert.")
		
		content = Logger:ReadLog(channel)
	
	end
	debugc("<magenta>clearWindow: ".. channel .. "\n")
	clearWindow(channel)
	GUI.tabElement.tabs[GUIModel.tabElement.currentTab.."console"]:echo(content)
	--GUI.tabElementTSabs[v.."console"]:echo(GUIModel.tabElement["chat"..v])
end
registerAnonymousEventHandler("RefreshTabElement", "onRefreshTabElement")
--raiseEvent("RefreshTabElement", "aktiverTabName")



-------------------------------------------------------------
--- Top-Menü
-- Menü-Label dürfen nicht in einem Container sein, deshalb sind die 
-- Top-Level-Einträge direkt auf der Oberfläche positioniert.
-------------------------------------------------------------
GUIModel.TopMenuEntries = {}
--cecho("<magenta>TopMenuEntries\n")
function addTopMenuEntry(label, position, childs)
	--TODO: validierung der Parameter (insbesondere der childs)
	table.insert(GUIModel.TopMenuEntries,position,{label,childs})
end

-- Dummy-Menü:
addTopMenuEntry("Top1", 1, {{"Child1", 1, "label1", "luafun", {"a1","a2","a3"}}, {"Child2", 2, "label2", "luafun",{"a12","a22","a32"}},{"Child3", 1, "label3","luafun",{"a31", "a32", "a33"}}})
addTopMenuEntry("Top2", 2, {{"Child1", 1, "label1", "luafun", {"a1","a2","a3"}}, {"Child2", 2, "label2", "luafun",{"a12","a22","a32"}},{"Child3", 1, "label3", "luafun",{"a31", "a32", "a33"}}})
addTopMenuEntry("Top1a", 1, {{"Child1", 1, "label1", "luafun", {"a1","a2","a3"}}, {"Child2", 2, "label2", "luafun",{"a12","a22","a32"}},{"Child3", 1, "label3", "luafun",{"a31", "a32", "a33"}}})

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
			remaining = (tonumber(v["duration"]) - ((os.time() - v["starttime"])))
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

function registerTimer(name, duration , param)
	--echo("\nregisterTimer\n")
	param = param or nil
	if param ~= nil then
		--cecho("<magenta>\nParam ist nicht nil\n")
		name = name .. " " .. param
	end
	if duration == false then
		duration = "false"
	end
	table.insert(listOfTimers, {["name"] = name, ["starttime"] = os.time(), ["duration"] = duration})
	--echo("starttime: " .. os.time() .. "\n")
	sortListOfTimers()
	raiseEvent("RecreateTimerView")
end

function removeTimer(name, param)
	--echo("removeTimer\n")
	param = param or nil
	if param ~= nil then
		--cecho("<magenta>\nRemove: Param ist nicht nil sondern: "..param.."\n")
		name = name .. " " .. param
	end
	key = findTimerByName(name)
	if key ~= nil then
		table.remove(listOfTimers, key)
	end
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

--------------------------------------------------------------------------------
-- Refresh Event Handler
--------------------------------------------------------------------------------


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
	-- Das Gauge-Element wird bei einem "current value" von 0 vollständig
	-- gefüllt angezeigt. Und ich hab keine Ahnung, was bei einem negativen
	-- Wert geschehen würde. Deshalb wird hier jeder Wert unter 1 auf 1
	-- gesetzt. In dem Text auf dem Gauge muss aber natürlich der wirkliche
	-- Wert stehen, deshalb die unterschiedliche Behandlung hier.
	currentValue = args[1]
	if currentValue < 1 then
		currentValue = 1
	end
	GUI.Health:setValue(tonumber(currentValue), tonumber(args[2]), "<b><center>" .. args[1] .. "/" .. args[2] .. "</center></br><center>TP</center></b>")
	-- GUI.Health:setValue(100,100,[[<b><center>999/999</center></br><center>TP</center></b>]])
	-- [[<b><font color="]]..timerSchriftfarbe..[[">&nbsp;]] .. v["name"] .. [[</b></font>]]
end
registerAnonymousEventHandler("RefreshHealthBar", "onRefreshHealthBar")


function onRefreshEnduranceBar(event, args)
	-- Das Gauge-Element wird bei einem "current value" von 0 vollständig
	-- gefüllt angezeigt. Und ich hab keine Ahnung, was bei einem negativen
	-- Wert geschehen würde. Deshalb wird hier jeder Wert unter 1 auf 1
	-- gesetzt. In dem Text auf dem Gauge muss aber natürlich der wirkliche
	-- Wert stehen, deshalb die unterschiedliche Behandlung hier.
	currentValue = args[1]
	if currentValue < 1 then
		currentValue = 1
	end
	GUI.Endurance:setValue(tonumber(currentValue), tonumber(args[2]), "<b><center>" .. tostring(args[1]) .. "/" .. tostring(args[2]) .. "</center></br><center>AP</center></b>")
end
registerAnonymousEventHandler("RefreshEnduranceBar", "onRefreshEnduranceBar")


function onRefreshSpellpointsBar(event, args)
	-- Das Gauge-Element wird bei einem "current value" von 0 vollständig
	-- gefüllt angezeigt. Und ich hab keine Ahnung, was bei einem negativen
	-- Wert geschehen würde. Deshalb wird hier jeder Wert unter 1 auf 1
	-- gesetzt. In dem Text auf dem Gauge muss aber natürlich der wirkliche
	-- Wert stehen, deshalb die unterschiedliche Behandlung hier.
	currentValue = args[1]
	if currentValue < 1 then
		currentValue = 1
	end
	GUI.Spellpoints:setValue(tonumber(currentValue), tonumber(args[2]), "<b><center>" .. args[1] .. "/" .. args[2] .. "</center></br><center>ZP</center></b>")
end
registerAnonymousEventHandler("RefreshSpellpointsBar", "onRefreshSpellpointsBar")


function onRefreshManaBar(event, args)
	-- Das Gauge-Element wird bei einem "current value" von 0 vollständig
	-- gefüllt angezeigt. Und ich hab keine Ahnung, was bei einem negativen
	-- Wert geschehen würde. Deshalb wird hier jeder Wert unter 1 auf 1
	-- gesetzt. In dem Text auf dem Gauge muss aber natürlich der wirkliche
	-- Wert stehen, deshalb die unterschiedliche Behandlung hier.
	currentValue = args[1]
	if currentValue < 1 then
		currentValue = 1
	end
	GUI.Mana:setValue(tonumber(currentValue), tonumber(args[2]), "<b><center>" .. args[1] .. "/" .. args[2] .. " Mana</center></b>")
end
registerAnonymousEventHandler("RefreshManaBar", "onRefreshManaBar")
