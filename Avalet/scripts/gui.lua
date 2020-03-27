----------------------------------------
-- GUI-Geraffel
-- In diesem Script wird das User-Interface erzeugt. Das Ziel ist, ein 
-- Interface mit Funktionen zu erhalten, das auch von anderen Modulen
-- mit benutzt werden kann. 
-- Dieses Script basiert auf einem Template von Akaya aus dem mudlet.org-Forum,
-- das ich hier gefunden habe:
-- https://forums.mudlet.org/viewtopic.php?t=4098
-- Es enthält außerdem Arbeiten von Vadi aus dem gleichen Forum:
-- https://forums.mudlet.org/viewtopic.php?f=6&t=3502&p=17268&hilit=CSSMan#p17264
----------------------------------------


----------------------------------------
-- CSSMan
----------------------------------------

CSSMan = {}
CSSMan.__index = CSSMan

function CSSMan.new(stylesheet)
  local obj  = { stylesheet = {} }
  setmetatable(obj,CSSMan)
  local trim = string.trim

  assert(type(stylesheet) == "string", "CSSMan.new: no stylesheet provided. A possible error is that you might have used CSSMan.new, not CSSMan:new")

  for line in stylesheet:gmatch("[^\r\n]+") do
    local attribute, value = line:match("^(.-):(.-);$")
    if attribute and value then
      attribute, value = trim(attribute), trim(value)
      obj.stylesheet[attribute] = value
    end
  end

  return obj
end

function CSSMan:set(key, value)
  self.stylesheet[key] = value
end

function CSSMan:get(key)
  return self.stylesheet[key]
end

function CSSMan:getCSS(key)
  local lines, concat = {}, table.concat
  for k,v in pairs(self.stylesheet) do lines[#lines+1] = concat({k,": ", v, ";"}) end
  return concat(lines, "\n")
end

function CSSMan:gettable()
  return self.stylesheet
end

function CSSMan:settable(tbl)
  assert(type(tbl) == "table", "CSSMan:settable: table expected, got "..type(tbl))

  self.stylesheet = tbl
end

----------------------------------------
-- GUI
----------------------------------------

GUI = GUI or {}

----------------------------------------
-- Set Borders
----------------------------------------

local w,h = getMainWindowSize()
setBorderLeft(w*0.16)
setBorderTop(h*0.05)
setBorderBottom(h*0.0)
setBorderRight(w*0.35)

----------------------------------------
-- Create Background
----------------------------------------

GUI.BackgroundCSS = CSSMan.new([[
  background-color: rgb(20,0,20);
]])

GUI.Left = Geyser.Label:new({
  name = "GUI.Left",
  x = "0%", y = "0%",
  width = "15%",
  height = "100%",
})
GUI.Left:setStyleSheet(GUI.BackgroundCSS:getCSS())

GUI.Right = Geyser.Label:new({
  name = "GUI.Right",
  x = "-35%", y = "0%",
  width = "35%",
  height = "100%",
})
GUI.Right:setStyleSheet(GUI.BackgroundCSS:getCSS())

GUI.Top = Geyser.Label:new({
  name = "GUI.Top",
  x = "15%", y = "0%",
  width = "50%",
  height = "5%",
})
GUI.Top:setStyleSheet(GUI.BackgroundCSS:getCSS())

--GUI.Bottom = Geyser.Label:new({
--  name = "GUI.Bottom",
--  x = "25%", y = "90%",
--  width = "50%",
--  height = "10%",
--})
--GUI.Bottom:setStyleSheet(GUI.BackgroundCSS:getCSS())


----------------------------------------
-- Boxes
----------------------------------------

GUI.BoxCSS = CSSMan.new([[
  background-color: rgba(0,0,0,100);
  border-style: solid;
  border-width: 1px;
  border-radius: 10px;
  border-color: white;
  font: TypeWriter;
  margin: 10px;
]])

GUI.Box1 = Geyser.Label:new({
  name = "GUI.Box1",
  x = 0, y = 0,
  width = "100%",
  height = "50%",
},GUI.Right)
GUI.Box1:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box1:echo("<center>GUI.Box1")


GUI.Spielstand = Geyser.MiniConsole:new({
  name="Spielstand",
  x="3%", y="3%",
  width = "94%",
  height = "94%",
  --autoWrap = true,
  color = "black",
  scrollBar = false,
  fontSize = 9,
}, GUI.Box1)
GUI.Spielstand:setColor("black") -- give it a nice black background
GUI.Spielstand:setFont("Bitstream Vera Sans Mono")
clearWindow("Spielstand")
GUI.Spielstand:echo("                                                                     \n")
GUI.Spielstand:echo("        Handelsvertreter Ryley Rofhessa, der angesehene Mann         \n")
GUI.Spielstand:echo("                                                                     \n")
GUI.Spielstand:echo("Staerke.........: 100   Ausdauer........:  51   Geschicklichkeit:  55\n")
GUI.Spielstand:echo("Intelligenz.....:  65   Weisheit........:  70   Aura............:  48\n")
GUI.Spielstand:echo("Schnelligkeit...:  68   Vitalitaet......:  75   Konzentration...: 100\n")
GUI.Spielstand:echo("                                                                     \n")
GUI.Spielstand:echo("                           0%       25%        50%       75%     100%\n")
GUI.Spielstand:echo("Tragkraft             92%  #######################################   \n")
GUI.Spielstand:echo("                                                                     \n")
GUI.Spielstand:echo("Erfahrungspunkte:          502762     Flucht bei:          (80 TP) an\n")
GUI.Spielstand:echo("Raetselpunkte:           685/1180     Angriff:                     an\n")
GUI.Spielstand:echo("Spielepunkte:            204/ 659     Gegenangriff:                an\n")
GUI.Spielstand:echo("Lernpunkte:                 10425     Verteidigung:                an\n")
GUI.Spielstand:echo("Erfahrung heute:             2210     Kampfmodus:            defensiv\n")
GUI.Spielstand:echo("                                                                     \n")
GUI.Spielstand:echo("Tipp:   Mit Freunden \"verabreden\".                             Magier\n")
GUI.Spielstand:echo("Alter:  16 Tage 19 Stunden 36 Minuten                  Stufe 2 in S46\n")
GUI.Spielstand:echo("                                                                      ")


GUI.Box2 = Geyser.Label:new({
  name = "GUI.Box2",
  x = 0, y = "50%",
  width = "100%",-- 50%
  height = "50%",
},GUI.Right)
GUI.Box2:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box2:echo("<center>GUI.Box2")

--GUI.Box3 = Geyser.Label:new({
--  name = "GUI.Box3",
--  x = "50%", y = "50%",
--  width = "50%",
--  height = "50%",
--},GUI.Right)
--GUI.Box3:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box3:echo("<center>GUI.Box3")

GUI.Box4 = Geyser.Label:new({
  name = "GUI.Box4",
  x = "0%", y = "0%",
  width = "100%",
  height = "50%",
},GUI.Left)
GUI.Box4:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box4:echo("<center>GUI.Box4")


GUI.Mapper = Geyser.Mapper:new({ name = "Mapper",x = "5%", y = "5%", width = "90%", height = "90%"}, GUI.Box4)


--GUI.Box5 = Geyser.Label:new({
--  name = "GUI.Box5",
--  x = "0%", y = "50%",
--  width = "100%",
--  height = "35%",
--},GUI.Left)
--GUI.Box5:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box5:echo("<center>GUI.Box5")


GUI.Box5 = Geyser.Container:new({
  name = "GUI.Box5",
  x = "0%", y = "50%",
  width = "100%",
  height = "35%",
},GUI.Left)
-- GUI.Box5:setStyleSheet(GUI.BoxCSS:getCSS())
-- GUI.Box5:echo("<center>GUI.Box5")



--GUI.Box6 = Geyser.Label:new({
--  name = "GUI.Box6",
--  x = "50%", y = "25%",
--  width = "50%",
--  height = "50%",
--},GUI.Left)
--GUI.Box6:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box6:echo("<center>GUI.Box6")

GUI.Box7 = Geyser.Container:new({
  name = "GUI.Box7",
  x = "0%", y = "85%",
  width = "100%",
  height = "15%",
},GUI.Left)
--GUI.Box7:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box7:echo("<center>GUI.Box7")

--GUI.Box7 = Geyser.Label:new({
--  name = "GUI.Box7",
--  x = "0%", y = "75%",
--  width = "100%",
--  height = "25%",
--},GUI.Left)
--GUI.Box7:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box7:echo("<center>GUI.Box7")



-- Arkanschild-Gauge (Test):
----  background-color: rgba(0,0,0,0);
--GUI.myGaugeBackCSS = CSSMan.new([[
--  background-color: QRadialGradient(cx:.3,cy:1,radius:1,stop:0 rgb(0,0,50),stop:.5 rgb(0,0,100),stop:1 rgb(0,0,255));
--  border-style: solid;
--  border-color: white;
--  border-width: 1px;
--  border-radius: 2px;
--  margin: 2px;
--]])
--
----   background-color: rgba(0,0,0,0);
--GUI.myGaugeFrontCSS = CSSMan.new([[
--  background-color: QRadialGradient(cx:.3,cy:1,radius:1,stop:0 rgb(50,0,0),stop:.5 rgb(100,0,0),stop:1 rgb(255,0,0));
--  border-style: solid;
--  border-color: white;
--  border-width: 1px;
--  border-radius: 2px;
--  margin: 2px;
--]])

--GUI.Arkanschild = Geyser.Gauge:new({
--  name = "GUI.Arkanschild",
--  width="100px", height="100px",
--  orientation="vertical",
--},GUI.Box1)
--GUI.Arkanschild.back:setStyleSheet(GUI.myGaugeBackCSS:getCSS())
----GUI.myGaugeFrontCSS:set("background-color","red")
--GUI.Arkanschild.front:setStyleSheet(GUI.myGaugeFrontCSS:getCSS())
----GUI.Arkanschild:setValue(math.random(100),100)
--GUI.Arkanschild:setValue(100,100)
----GUI.Arkanschild.front:echo("GUI.Arkanschild")
--GUI.Arkanschild.front:echo([[<span style = "color: black">GUI.Arkanschild</span>]])






----------------------------------------
-- Header Icons
----------------------------------------

GUI.Header = Geyser.HBox:new({
  name = "GUI.Header",
  x = "0%", y = "0%",
  width = "100%",
  height = "100%",
},GUI.Top)

--GUI.IconCSS = CSSMan.new([[
--  background-color: rgba(0,0,0,100);
--  border-style: solid;
--  border-width: 1px;
--  border-color: white;
--  border-radius: 5px;                   
--  margin: 5px;
--  qproperty-wordWrap: true;
--]])

--GUI.IconCSS = CSSMan.new([[
--  background-color: rgba(0,0,0,100);
--  border-style: solid;
--  border-width: 1px;
--  border-color: white;
--  border-radius: 5px;                       ]]..tostring(compass.back:get_width()/2-14)..[[px; margin: 10px;
--  margin: 5px;
--  qproperty-wordWrap: true;
--]])

--for i=1,12 do
--  GUI["Icon"..i] = Geyser.Label:new({
--    name = "GUI.Icon"..i,
--  },GUI.Header)
--  GUI["Icon"..i]:setStyleSheet(GUI.IconCSS:getCSS())
--  GUI["Icon"..i]:echo("<center>GUI. Icon"..i)
--end



-----------------------------------
-- Gauges
-----------------------------------

--GUI.Footer = Geyser.HBox:new({
--  name = "GUI.Footer",
--  x = 0, y = 0,
--  width = "100%",
--  height = "100%",
--},GUI.Bottom)

--GUI.LeftColumn = Geyser.VBox:new({
--  name = "GUI.LeftColumn",
--},GUI.Footer)

--GUI.RightColumn = Geyser.VBox:new({
--  name = "GUI.RightColumn",
--},GUI.Footer)

GUI.GaugeBackCSS = CSSMan.new([[
  background-color: rgba(0,0,0,0);
  border-style: solid;
  border-color: white;
  border-width: 1px;
  border-radius: 5px;
  padding: 5px;
  width: 30%;
  height: 80%;
]])

GUI.GaugeFrontCSS = CSSMan.new([[
  background-color: rgba(0,0,0,0);
  border-style: solid;
  border-color: white;
  border-width: 1px;
  border-radius: 5px;
  padding: 5px;
  width: 30%;
  height: 80%;
]])

--	background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #78bd33, stop: 0.1 #6ebd20, stop: 0.49 #4c9900, stop: 0.5 #387000, stop: 1 #4c9900);
GUI.GaugeTextCSS = CSSMan.new([[
	padding: 25px;
]])

GUI.Health = Geyser.Gauge:new({
  name = "GUI.Health",
  x = "2%", y = "0%",
  width="30%", height="80%",
  orientation="vertical",
},GUI.Box7)
GUI.Health.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","red")
GUI.Health.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Health.text:setStyleSheet(GUI.GaugeTextCSS:getCSS())
GUI.Health:setValue(100,100)
--GUI.Health.front:echo("TP")
--GUI.Health:setValue(player.stats.tp, player.stats.tp_max, "<b>" .. tostring(player.stats.tp) .. "/" .. tostring(player.stats.tp_max) .. "</b>")
--GUI.Health.front:echo("<b>" .. player.stats.tp .. "/" .. player.stats.tp_max .. "</b>")

GUI.Endurance = Geyser.Gauge:new({
  name = "GUI.Endurance",
  x = "34%", y = "0%",
  width="30%", height="80%",
  orientation="vertical",
},GUI.Box7)
GUI.Endurance.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","yellow")
GUI.Endurance.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Endurance.text:setStyleSheet(GUI.GaugeTextCSS:getCSS())
GUI.Endurance:setValue(100,100)
--GUI.Endurance.front:echo("GUI.Endurance")
--GUI.Endurance.front:echo([[<span style = "color: black">AP</span>]])

GUI.Spellpoints = Geyser.Gauge:new({
  name = "GUI.Spellpoints",
  x = "66%", y = "0%",
  width="30%", height="80%",
  orientation="vertical",
},GUI.Box7)
GUI.Spellpoints.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","blue")
GUI.Spellpoints.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Spellpoints.text:setStyleSheet(GUI.GaugeTextCSS:getCSS())
GUI.Spellpoints:setValue(100,100)
--GUI.Spellpoints.front:echo("ZP")

GUI.Mana = Geyser.Gauge:new({
  name = "GUI.Mana",
  x = "2%", y = "80%",
  width="96%", height="20%",
},GUI.Box7)
GUI.Mana.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","green")
GUI.Mana.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Mana:setValue(9999,9999)
--GUI.Mana.front:echo("Mana")

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

for k, v in pairs(sortedListOfTimers) do
--  print(k, v["name"])
  GUI["Timer"..k] = Geyser.Gauge:new({
    name = "GUI.Timer"..k,
    x = "4%", y = (100-(k*10)-5).."%",
    width="90%", height="9%",
	orientation = "goofy",
  },GUI.Box5)
  if v["remaining"] < 30 then
	echo("kleiner als 30")
	GUI.GaugeBackCSS:set("background-color","red")
  elseif v["remaining"] < 60 then
	echo("kleiner als 60")
	GUI.GaugeBackCSS:set("background-color","yellow")
  end
  GUI["Timer"..k].back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
  GUI.GaugeFrontCSS:set("background-color","purple")
  GUI["Timer"..k].front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
  --GUI["Timer"..k]:echo("<center>GUI.Timer"..k)
  echo("Restlaufzeit: " .. tostring(v["remaining"]) .. "sec. von " .. tostring(v["duration"]) .. "sec " .. v["name"] .. "\n")
  GUI["Timer"..k]:setValue(v["remaining"], v["duration"] , v["name"])
end


--------------------------------------------
--- Tabs-Element
-------------------------------------------

menu = menu or {
  tabs = {"Schwafel","Laber","Volk","Gilde", "Gruppe", "Sag", "Rede"},
--  color1 = "rgb(0,0,70)",
--  color2 = "rgb(0,0,50)",
  color1 = "red",
  color2 = "white",
  width = "10%",
  height = "40%",
}
menu.current = menu.current or menu.tabs[1]


menu.container = Geyser.Container:new({
  name = "menu.back",
  x = "3%", y = "3%",
  width = "94%",
  height = "94%",
},GUI.Box2)

menu.header = Geyser.HBox:new({
  name = "menu.header",
  x = 0, y = 0,
  width = "100%",
  height = "10%",
},menu.container)


menu.footer = Geyser.Label:new({
  name = "menu.footer",
  x = 0, y = "10%",
  width = "100%",
  height = "90%",
},menu.container)


--  background-color: ]]..menu.color1..[[;
--  background-color: rgb(20,0,20);
menu.footer:setStyleSheet([[
  background-color:black;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
]])

menu.center = Geyser.Label:new({
  name = "menu.center",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
},menu.footer)

--  background-color: ]]..menu.color2..[[;
--  background-color: rgb(20,0,20);
menu.center:setStyleSheet([[
  background-color: rgb(255,255,255);
  border-radius: 10px;
  margin: 5px;
]])

for k,v in pairs(menu.tabs) do

menu[v.."tab"] = Geyser.Label:new({
    name = "menu."..v.."tab",
  },menu.header)

--    background-color: ]]..menu.color1..[[;
menu[v.."tab"]:setStyleSheet([[
    background-color: rgb(20,0,20);
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    margin-right: 1px;
    margin-left: 1px;
  ]])

menu[v.."tab"]:echo("<center>"..v)


menu[v.."tab"]:setClickCallback("menu.click",v)


menu[v] = Geyser.Label:new({
    name = "menu."..v,
    x = 0, y = 0,
    width = "100%",
    height = "100%",
  },menu.footer)

  menu[v]:setStyleSheet([[
    background-color: ]]..menu.color1..[[;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
  ]])

menu[v.."center"] = Geyser.Label:new({
    name = "menu."..v.."center",
    x = 0, y = 0,
    width = "100%",
    height = "100%",
  },menu[v])

  menu[v.."center"]:setStyleSheet([[
    background-color: ]]..menu.color2..[[;
    border-radius: 10px;
    margin: 5px;
  ]])


 menu[v]:hide()
end


function menu.click(tab)
  menu[menu.current]:hide()
  menu.current = tab
  menu[menu.current]:show()
end



-------------------------------------------------------------
--- Top-Menü
-------------------------------------------------------------


 tConfig = {}
 
-- tConfig.iMainBorderLeft = 10
-- tConfig.iMainBorderTop = 128
-- tConfig.iMainBorderRight = 0 
-- tConfig.iMainBorderBottom = 64
-- tConfig.iMainWidth, tConfig.iMainHeight = getMainWindowSize()
	
 tConfig.MainColorText = "#ffffff"
 tConfig.MainLabelBackground = "#303030"
 tConfig.MainColorBackground = "#000000"
 tConfig.MainColorBorder = "#999999"
 tConfig.MainColorHover = "#505050"


---------------------------- Standard CSS fuer die Label etc -----------------------------------
LabelCSS = CSSMan.new([[
	background-color:]]..tConfig.MainLabelBackground..[[;
	border-width: 1px;
	border-color: ]]..tConfig.MainColorBorder..[[;
	margin: 2px; 
	border-style: solid;
	border-radius: 7;
	padding: 3px;
]])

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


-- InitTopMenuBar = function()
	TopMenuBar = Geyser.Label:new({
		name = "TopMenuBar", 
		x = 0, 
		y = 0 ,
		width = "100%", 
		height = "100%",
	},GUI.Header)
	TopMenuBar:setStyleSheet(LabelCSS:getCSS())

	local tDir = "attrdir(getMudletHomeDir()..[[/../../modules/Spiele/]])"
	
	TopMenuSpiele = Geyser.Label:new({ 
		name = "TopMenuSpiele", 
		x = 10, 
		y = 4, 
		width = "10%",
		height = "80%",
		nestable = true
	},TopMenuBar)

	TopMenuSpiele:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
	TopMenuSpiele:echo([[<p style="font-size:16px"><b><font color="white">Spiele]])
--	TopMenuSpiel = {}
--	for i = 1,#tDir do
--		TopMenuSpiel[i] = TopMenuSpiele:addChild({
--			name = "TopMenuSpiel"..i,
--			height = 30,
--			width = 100, 
--			flyOut=true,
--			layoutDir="BV", 
--			message=tDir[i]
--		})
--		TopMenuSpiel[i]:setStyleSheet(LabelCSS:getCSS())
--		setLabelClickCallback( "TopMenuSpiel"..i, "ClickTopMenuCallback",tDir[i],"Spiele")
--	end --for

	tDir = "attrdir(getMudletHomeDir()..[[/../../modules/Raetsel/]])"
	TopMenuRaetsel= Geyser.Label:new({ 
		name = "TopMenuRaetsel", 
		x = 110, 
		y = 4, 
		width = "10%",
		height = "80%",
		nestable = true
	},TopMenuBar)
	TopMenuRaetsel:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
	TopMenuRaetsel:echo([[<p style="font-size:16px"><b><font color="white">Notizen]])
--	TopMenuQuest = {}
--	for i = 1,#tDir do
--		TopMenuQuest[i] = TopMenuRaetsel:addChild({
--			name = "TopMenuQuest"..i,
--			height = 30,
--			width = 100, 
--			flyOut=true,
--			layoutDir="BV", 
--			message=tDir[i]
--		})
--		TopMenuQuest[i]:setStyleSheet(LabelCSS:getCSS())
--		setLabelClickCallback( "TopMenuQuest"..i, "ClickTopMenuCallback",tDir[i],"Raetsel")
--	end -- for

	TopMenuGebiete= Geyser.Label:new({ 
		name = "TopMenuGebiete", 
		x = 210, 
		y = 4, 
		width = "12%",
		height = "80%",
		nestable = true
	},TopMenuBar)
	TopMenuGebiete:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
	TopMenuGebiete:echo([[<p style="font-size:16px"><b><font color="white">Wege/Orte]])
--	TopMenuGebiet = {}
--	tDir = "attrdir(getMudletHomeDir()..[[/../../modules/Metzelgebiete/]])"
--	for i = 1,#tDir do
--		TopMenuGebiet[i] = TopMenuGebiete:addChild({
--			name = "TopMenuGebiet"..i,
--			height = 30,
--			width = 70, 
--			flyOut=true,
--			layoutDir="BV", 
--			message=tDir[i]
--		})
--		TopMenuGebiet[i]:setStyleSheet(LabelCSS:getCSS())
--		setLabelClickCallback( "TopMenuGebiet"..i, "ClickTopMenuCallback",tDir[i],"Metzelgebiete")
--	end -- for

	TopMenuLocations= Geyser.Label:new({ 
		name = "TopMenuLocations", 
		x = 340, 
		y = 4, 
		width = "14%",
		height = "80%",
		nestable = true
	},TopMenuBar)
	TopMenuLocations:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
	TopMenuLocations:echo([[<p style="font-size:16px"><b><font color="white">YourMenuHere]])
--	for i = 1,#tRoom.tLocations do
--		TopMenuLocation = {}
--		local loc,hash = rex.match( tRoom.tLocations[i], [[(.*)/([A-z0-9]+)]] )
--		TopMenuLocation[i] = TopMenuLocations:addChild({
--			name = "TopMenuLocation"..i,
--			height = 30,
--			width = 100, 
--			flyOut=true,
--			layoutDir="BV", 
--			message=loc
--		})
--		TopMenuLocation[i]:setStyleSheet(LabelCSS:getCSS())
--		setLabelClickCallback( "TopMenuLocation"..i, "ClickTopMenuLocation",hash)
--	end--for

	TopMenuOptions= Geyser.Label:new({ 
		name = "TopMenuOptions", 
		x = "94%", 
		y = 2 , 
		width = 35,
		height = 35,
	},TopMenuBar)
	TopMenuOptions:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
	TopMenuOptions:echo([[<p style="font-size:22px"><b><font color="white">&#9881;]])
	setLabelClickCallback( "TopMenuOptions", "ClickTopMenuPreferences")
--	TopMenuPrefs= Geyser.Label:new({ 
--		name = "TopMenuPrefs", 
--		x = 850, 
--		y = 38, 
--		width = 200,
--		height = 300
--	})
--	TopMenuPrefs:setStyleSheet(LabelCSS:getCSS())
--
--	TopMenuPrefs1 = Geyser.Label:new({ name = "TopMenuPrefs1", x = 6, y = 6 ,width = "98%" , height = 30},TopMenuPrefs)
--	TopMenuPrefs1:setStyleSheet([[
--		background-color: ]]..tConfig.MainLabelBackground..[[;
--		margin: 5px;
--		qproperty-wordWrap: true;
--	]])
--	setLabelClickCallback( "TopMenuPrefs1", "ClickTopMenuPref","bAutoMove","Automatisches Klettern / Schwimmen angeschaltet","Automatisches Klettern / Schwimmen ausgeschaltet" )
--
--	TopMenuPrefs2 = Geyser.Label:new({ 
--		name = "TopMenuPrefs2", 
--		x = 6, 
--		y = 30,
--		width = "98%",
--		height = 30
--	},TopMenuPrefs)
--	TopMenuPrefs2:setStyleSheet([[
--		background-color: ]]..tConfig.MainLabelBackground..[[;
--		margin: 5px;
--		qproperty-wordWrap: true;
--	]])
--	setLabelClickCallback( "TopMenuPrefs2", "ClickTopMenuPref","bAutoSchwimmen","Permanentes Schwimmen angeschaltet","Permanentes Schwimmen ausgeschaltet" )
--
--	TopMenuPrefs3 = Geyser.Label:new({ 
--		name = "TopMenuPrefs3", 
--		x = 6, 
--		y = 54,
--		width = "98%", 
--		height = 30
--	},TopMenuPrefs)
--	TopMenuPrefs3:setStyleSheet([[
--		background-color: ]]..tConfig.MainLabelBackground..[[; 
--		margin: 5px;
--		qproperty-wordWrap: true;
--	]])
--	setLabelClickCallback( "TopMenuPrefs3", "ClickTopMenuPref","bAutoOpfer","Automatisches Opfersetzen angeschaltet","Automatisches Opfersetzen ausgeschaltet" )
--
--	TopMenuPrefs4 = Geyser.Label:new({ 
--		name = "TopMenuPrefs4", 
--		x = 6, 
--		y = 78,
--		width = "98%", 
--		height = 30
--	},TopMenuPrefs)
--	TopMenuPrefs4:setStyleSheet([[
--		background-color: ]]..tConfig.MainLabelBackground..[[;
--		margin: 5px;
--		qproperty-wordWrap: true;
--	]])
--	setLabelClickCallback( "TopMenuPrefs4", "ClickTopMenuPref","bAutoSchild","Automatisches Schild erneuern angeschaltet","Automatisches Schild erneuern ausgeschaltet" )
--
--	TopMenuPrefs5 = Geyser.Label:new({ 
--		name = "TopMenuPrefs5", 
--		x = 6, 
--		y = 102,
--		width = "98%", 
--		height = 30
--	},TopMenuPrefs)
--	TopMenuPrefs5:setStyleSheet([[
--		background-color: ]]..tConfig.MainLabelBackground..[[; 
--		margin: 5px;
--		qproperty-wordWrap: true;
--	]])
--	setLabelClickCallback( "TopMenuPrefs5", "ClickTopMenuPref","bSprachausgabe","Sprachausgabe eingeschaltet","Sprachausgabe ausgeschaltet" )
--
--	TopMenuPrefs6 = Geyser.Label:new({ 
--		name = "TopMenuPrefs6", 
--		x = 6, 
--		y = 125,
--		width = "98%", 
--		height = 30
--	},TopMenuPrefs)
--	TopMenuPrefs6:setStyleSheet([[
--		background-color: ]]..tConfig.MainLabelBackground..[[; 
--		margin: 5px;
--		qproperty-wordWrap: true;
--	]])
--	setLabelClickCallback( "TopMenuPrefs6", "ClickTopMenuPref","bZweitieCheck","Zweiticheck eingeschaltet","Zweitiecheck ausgeschaltet" )
--
--	hideWindow("TopMenuPrefs")
--	hideWindow("TopMenuPrefs1")
--	hideWindow("TopMenuPrefs2")
--	hideWindow("TopMenuPrefs3")
--	hideWindow("TopMenuPrefs4")
--	hideWindow("TopMenuPrefs5")
--	hideWindow("TopMenuPrefs6")
-- end

