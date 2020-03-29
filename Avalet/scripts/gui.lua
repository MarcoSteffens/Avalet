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

textInfobox = "\n"
if string.len(player.vollername) ~= 0 then
	textInfobox = textInfobox .. "In Avalon bist Du bekannt als\n\n  " .. player.vollername .. "\n\n"
	if string.len(player.gilde) ~= 0 then
		if player.gilde == "keine" then
			textInfobox = textInfobox .. "Du bist noch in keiner Gilde.\n"
		else
			textInfobox = textInfobox .. "Du bist " .. player.gilde .. ".\n"
		end
	end
	if string.len(player.zuenfte) ~= 0 then
		textInfobox = textInfobox .. "Deine Berufe sind: " .. player.zuenfte .. ".\n"
	end
	if string.len(player.alter) ~= 0 then
		textInfobox = textInfobox .. "Dein Alter: " .. player.alter .. "\n"
	end
	if string.len(player.portfolio) ~= 0 then
		textInfobox = textInfobox .. "Portfolio: " .. player.portfolio .. "\n\n"
	end
	if string.len(player.level) ~= 0 then
		textInfobox = textInfobox .. "Dein Level: " .. player.level .. "\n"
	end
	if string.len(player.ep) ~= 0 then
		textInfobox = textInfobox .. "Dafür hast du bisher " .. player.ep .. " Erfahrungspunkte gesammelt.\n\n"
	end
	if string.len(player.gesinnung) ~= 0 then
		textInfobox = textInfobox .. "Gesinnung: " .. player.gesinnung .. "\n"
	end
	if string.len(player.hunger) ~= 0 then
		textInfobox = textInfobox .. "Hunger: " .. player.hunger .. "\n"
	end
	if string.len(player.durst) ~= 0 then
		textInfobox = textInfobox .. "Durst: " .. player.durst .. "\n"
	end
end



--------------------------------------------
--- Tabs-Element rechts unten
-------------------------------------------

-- Generelle Variablen für das Tab-Element
menu = menu or {
  tabs = {"Schwafel","Laber","Volk","Gilde", "Gruppe", "Sag", "Rede"},
  color1 = "rgb(0,0,70)",
  color2 = "rgb(0,0,50)",
--  color1 = "red",
--  color2 = "white",
  width = "10%",
  height = "40%",
}
-- Speichert das aktuell ausgewählte Element:
menu.current = menu.current or menu.tabs[1]

for k,v in pairs(menu.tabs) do
	-- Erzeugt einen Text-Variable für jeden Eintrag in der Menu-Liste
	menu["chat"..v] = v  
end

-- HIer muss der INhalt der Dateien vorhanden sein, in dene die Chats stehen sollen.


-------------------------------------------------------------
--- Top-Menü
-- Menü-Label dürfen nicht in einem Container sein, deshalb sind die 
-- Top-Level-Einträge direkt auf der Oberfläche positioniert.
-------------------------------------------------------------


HeaderMenu = {}
HeaderMenuItem = {
	parent = nil,
	name = "",
	item = nil,
	orderNr = nil,
}


-- Ein Menü ohne Sub-Einträge:
--table.insert(HeaderMenu, {name = randomString(math.random(8,12)), parent = nil})
table.insert(HeaderMenu, {name = "Einstellungen", parent = nil})
table.insert(HeaderMenu, {name = "Menu1", parent=nil})
table.insert(HeaderMenu, {name = "SubMenu1.1", parent="Menu1"})
table.insert(HeaderMenu, {name = "SubMenu1.2", parent="Menu1"})
table.insert(HeaderMenu, {name = "SubMenu1.3", parent="Menu1"})
table.insert(HeaderMenu, {name = "Menu2", parent=nil})
table.insert(HeaderMenu, {name = "SubMenu2.1", parent="Menu2"})
table.insert(HeaderMenu, {name = "SubMenu2.2", parent="Menu2"})
table.insert(HeaderMenu, {name = "SubMenu2.3", parent="Menu2"})
table.insert(HeaderMenu, {name = "Menu3", parent=nil})
table.insert(HeaderMenu, {name = "SubMenu3.1", parent="Menu3"})
table.insert(HeaderMenu, {name = "SubMenu3.2", parent="Menu3"})
table.insert(HeaderMenu, {name = "SubMenu3.3", parent="Menu3"})
table.insert(HeaderMenu, {name = "Menu4", parent=nil})
table.insert(HeaderMenu, {name = "SubMenu4.1", parent="Menu4"})
table.insert(HeaderMenu, {name = "SubMenu4.2", parent="Menu4"})
table.insert(HeaderMenu, {name = "SubMenu4.3", parent="Menu4"})


-- Menü-Eintrags-Tabelle sortieren und in ein Menü verwandeln:

-- menuList = {
--   {bName = "Trumer Pils", bCountry = "Austria", bType = "Pilsner"},
--   {bName = "Samichlaus", bCountry = "Austria", bType = "Lager"},
--  	{bName = "Foster's Oil Can", bCountry = "Australia", bType = "Lager"},
--  	{bName = "Newcastle Ale", bCountry = "UK", bType = "Ale"},
-- }

local sort_func = function( a,b ) return a.name < b.name end
table.sort( HeaderMenu, sort_func )

for i, record in ipairs( HeaderMenu ) do
--echo(i .. " -" .. record.name .. "\n")
end

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


