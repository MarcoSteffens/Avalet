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

GUIModel.Infobox = "\n"
if string.len(player.vollername) ~= 0 then
	GUIModel.Infobox = GUIModel.Infobox .. "In Avalon bist Du bekannt als\n\n  " .. player.vollername .. "\n\n"
	if string.len(player.gilde) ~= 0 then
		if player.gilde == "keine" then
			GUIModel.Infobox = GUIModel.Infobox .. "Du bist noch in keiner Gilde.\n"
		else
			GUIModel.Infobox = GUIModel.Infobox .. "Du bist " .. player.gilde .. ".\n"
		end
	end
	if string.len(player.zuenfte) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Deine Berufe sind: " .. player.zuenfte .. ".\n"
	end
	if string.len(player.alter) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Dein Alter: " .. player.alter .. "\n"
	end
	if string.len(player.portfolio) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Portfolio: " .. player.portfolio .. "\n\n"
	end
	if string.len(player.level) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Dein Level: " .. player.level .. "\n"
	end
	if string.len(player.ep) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Dafür hast du bisher " .. player.ep .. " Erfahrungspunkte gesammelt.\n\n"
	end
	if string.len(player.gesinnung) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Gesinnung: " .. player.gesinnung .. "\n"
	end
	if string.len(player.hunger) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Hunger: " .. player.hunger .. "\n"
	end
	if string.len(player.durst) ~= 0 then
		GUIModel.Infobox = GUIModel.Infobox .. "Durst: " .. player.durst .. "\n"
	end
end

--------------------------------------------
--- Tabs-Element rechts unten
-------------------------------------------

-- Generelle Variablen für das Tab-Element
GUIModel.menu = GUIModel.menu or {
  tabs = {"Schwafel","Laber","Volk","Gilde", "Gruppe", "Sag", "Rede"},
  color1 = "rgb(0,0,70)",
  color2 = "rgb(0,0,50)",
--  color1 = "red",
--  color2 = "white",
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

-- Dummy-Daten für die Timer-Liste. Die Startzeit ist später einfach os.time()
listOfTimers = {
	{["name"] = "Arkanschild", ["starttime"] = (os.time() - 550), ["duration"] = 600},
	{["name"] = "Kampfbeschwörung", ["starttime"] = (os.time() - 580), ["duration"] = 600},
	{["name"] = "Erdaura", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Schild", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Magiertrance", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Magieaufladung", ["starttime"] = (os.time() - math.random(600)), ["duration"] = 600},
	{["name"] = "Steinhaut", ["starttime"] = false, ["duration"] = false},
	{["name"] = "Windhaut", ["starttime"] = false, ["duration"] = false},
	{["name"] = "Manarausch", ["starttime"] = false, ["duration"] = false},
}

function registerTimer(name, starttime, duration)
	table.insert(listOfTimers, {["name"] = name, ["starttime"] = starttime, ["duration"] = duration})
end

function removeTimer(name)
	--table.
end


sortedListOfTimers = {}
for k, v in pairs(listOfTimers) do
	if v["starttime"] == false then
		table.insert(sortedListOfTimers, {["name"] = v["name"], ["remaining"] = 600, ["duration"] = 600})
	else
		-- remaining < 0 abfangen!
		table.insert(sortedListOfTimers, {["name"] = v["name"], ["remaining"] = v["duration"] - ((os.time() - v["starttime"])), ["duration"] = 600})
	end
	--table.insert(sortedListOfTimers, {})
end

sortMyTimers = function(a, b) return a["remaining"] > b["remaining"] end
table.sort(sortedListOfTimers, sortMyTimers)

-----------------------------------
-- Gauges für TP, AP, ZP und Mana
-----------------------------------

-- Daten hier halten oder direkt aus dem character-objekt?

----------------------------
-- Refresh Event Handler
-----------------------------

function onRefreshCharacterVollername(event, args)
	GUI.Spielstand:echo(args)
	--GUI.Health:setValue(tonumber(args[1]), tonumber(args[2]), "<b>" .. args[1] .. "/" .. args[2] .. "</b>")
end
registerAnonymousEventHandler("RefreshCharacterVollername", "onRefreshCharacterVollername")

--raiseEvent("RefreshCharacterVollername", ???)


