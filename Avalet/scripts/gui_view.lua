-------------------------------------------------------------------------------
-- GUI-View
-- 
-- Hier wird die eigentliche Oberfläche erzeugt, also die Fenster-Elemente und
-- das Stylesheet-Geraffel.
-- Die Daten für die Oberfläche kommen aus der Datei gui.lua, wo sozusagen
-- Model und Control zusammengefasst sind.
-- 
-- Dieses Script basierte ursprünglich mal auf einem Template von Akaya aus dem 
-- mudlet.org-Forum, das ich hier gefunden habe:
-- https://forums.mudlet.org/viewtopic.php?t=4098
-- Teile davon sind vermutlich noch enthalten.
-- Es enthält außerdem (immer noch) Arbeiten von Vadi aus dem gleichen Forum:
-- https://forums.mudlet.org/viewtopic.php?f=6&t=3502&p=17268&hilit=CSSMan#p17264
--
-- Autor ansonsten: Marco Steffens
--------------------------------------------------------------------------------


----------------------------------------
-- CSSMan von Vadi
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
-- CSS
----------------------------------------

-- CSS Backgrounds

GUI.BackgroundCSS = CSSMan.new([[
  background-color: rgb(20,0,20);
]])

-- CSS Boxes

GUI.BoxCSS = CSSMan.new([[
  background-color: rgba(0,0,0,100);
  border-style: solid;
  border-width: 1px;
  border-radius: 10px;
  border-color: white;
  font: TypeWriter;
  margin: 10px;
]])

-- CSS Gauges

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

----------------------------------------
-- Set Borders
-- Hier wird die Einteilung des Fensters vorgenommen. Der Hauptbereich, in dem das
-- eigentliche MUD stattfindet, befindet sich in der Mitte. Die umgebenden Bereiche
-- werden relativ zur Fenstergröße bestimmt.
----------------------------------------

local w,h = getMainWindowSize()
setBorderLeft(w*0.16)
setBorderTop(h*0.07)
setBorderBottom(h*0.0)
setBorderRight(w*0.35)

----------------------------------------
-- Create Background
-- Hier werden die Teilbereiche des GUI belegt, die durch die "Borders" von Hauptfenster
-- abgetrennt sind. Und zwar ganz grob, also lediglich "links", "rechts", "oben" und evlt.
-- irgendwann auch "unten". Eine weitere Unterteilung der groben Bereiche findet dann
-- später durch "Boxes" statt. 
-- Und eine Ausnahme davon ist das Top-Element, aber das ist dort auch dokumentiert.
----------------------------------------

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

-- Im GUI.Top-Bereich wird das _Menü_ angezeigt. Dieses Menü besteht aus Label-Elementen,
-- und diese Elemente dürfen NICHT in einem Container sein. Also nicht, wenn sie als
-- Menü (mit Untermenü) verwendet werden. Während also in allen anderen Bereichen des
-- GUI diese "Background-Label" hier als Container angelegt sind, die die anderen
-- Elemente dieser Bereiche enthalten, ist dieses Top-Element hier eigentlich unnötig. 
-- Derzeit brauche ich es aber als Design-Element, da ich die einzelnen Teile des GUI
-- mit einer weißen Umrandung versehen habe. Daher existiert dieses Element trotzdem,
-- und daher ist ihm ein anderer Stylesheet zugeordnet als den anderen "Backgrounds".
-- Nämlich das Stylesheet mit der Umrandung. Und die Menü-Label-Elemente werden dann
-- einfach obendrauf (statt innen drin) plaziert.
GUI.Top = Geyser.Label:new({
  name = "GUI.Top",
  x = "15%", y = "0%",
  width = "50%",
  height = "7%",
--  nestable = true,
})
--GUI.Top:setStyleSheet(GUI.BackgroundCSS:getCSS())
GUI.Top:setStyleSheet(GUI.BoxCSS:getCSS())

-- Das Bottom-Element ist etwa so plaziert wie das Top-Element. Nur eben unten. ich könnte
-- mir vorstellen, da vielleicht klickbare Elemente anzuzeigen, also vielleicht einen klick-
-- baren Kompass, mit dem man dann auch laufen kann. Oder vielleicht kann man da auch Infos
-- anzeigen, die im aktuellen Kontext des Spielers sehr wichtig sind. Sowas wie ob er grade
-- in einem Kampf ist oder blockiert wird durch einen Zauber oder so. Man könnte dort auch
-- Kurzwahl"tasten" anzeigen, also "Alias" auf Tasten (oder vielleicht auch überhaupt Alias).
-- Deshalb lass ich das Element mal hier drin und kommentiere es nur aus.
--GUI.Bottom = Geyser.Label:new({
--  name = "GUI.Bottom",
--  x = "25%", y = "90%",
--  width = "50%",
--  height = "10%",
--})
--GUI.Bottom:setStyleSheet(GUI.BackgroundCSS:getCSS())


----------------------------------------
-- Boxes
-- Die Boxen definieren die entgültige Unterteilung der Oberfläche. Es gibt also eine Boxen
-- für die Elemente, die TP, ZP, AP und Mana anzeigen. (Links unten.) Eine weitere für die 
-- Timer links in der Mitte. Eine weitere für das Karten-Widget links oben. Eine für die
-- Charakterinformationen rechts oben. Und eine für das Tab-Element rechts unten.
-- Im Bereich oben in der Mitte gibt es keine Box. Der Grund ist oben bei den Backgrounds 
-- dokumentiert.
-- Die Boxen haben hauptsächlich den Zweck, einen (derzeit weißen) Rahmen um die Bereiche 
-- anzeigen zu können. Ansonsten sind sie Container für weitere Elemente, die die dort
-- sichtbaren Informationen anzeigen.
----------------------------------------

-- Box1 ist das Element rechts oben, in dem die Charakterinformationen ausgegeben werden.
GUI.Box1 = Geyser.Label:new({
	name = "GUI.Box1",
	x = 0, y = 0,
	width = "100%",
	height = "50%",
}, GUI.Right)
GUI.Box1:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box1:echo("<center>GUI.Box1")


-- Box2: In diesem Bereich wird das Tabulatoren-Element rechts unten angezeigt.
GUI.Box2 = Geyser.Label:new({
	name = "GUI.Box2",
	x = 0, y = "50%",
	width = "100%",-- 50%
	height = "50%",
}, GUI.Right)
GUI.Box2:setStyleSheet(GUI.BoxCSS:getCSS())


-- Box4 enthält das Mapper-Element, also das Karten-Widget links oben
GUI.Box4 = Geyser.Label:new({
	name = "GUI.Box4",
	x = "0%", y = "0%",
	width = "100%",
	height = "50%",
}, GUI.Left)
GUI.Box4:setStyleSheet(GUI.BoxCSS:getCSS())
--GUI.Box4:echo("<center>GUI.Box4")

-- Box5 enthält die Fortschrittsbalken, mit denen die Timer angezeigt werden. Links in 
-- der Mitte. Box5 ist kein Label-Element, sondern ein Container, und die sind unsichtbar(?)
-- Deshalb geht das hier mit dem weißen Rahmen nicht. Lösung wäre, hier noch ein Label
-- zu nehmen, dort dann den Container drin, und in dem dann die Gauges. Das ist ein TODO.
GUI.Box5 = Geyser.Container:new({
	name = "GUI.Box5",
	x = "0%", y = "50%",
	width = "100%",
	height = "35%",
}, GUI.Left)
--GUI.Box5:setStyleSheet(GUI.BoxCSS:getCSS())


-- Box7 enthält die Fortschrittsbalken, mit denen TP, AP, ZP und Mana angezeigt werden. Links
-- unten. Box7 ist auch kein Label-Element, sondern ein Container, deshalb gilt auch hier,
-- was oben bei Box5 dokumentiert ist. Auch ein TODO.
GUI.Box7 = Geyser.Container:new({
	name = "GUI.Box7",
	x = "0%", y = "85%",
	width = "100%",
	height = "15%",
}, GUI.Left)
--GUI.Box7:setStyleSheet(GUI.BoxCSS:getCSS())

-----------------------------------------------------
-- Charakter-Informationen rechts oben
-----------------------------------------------------

GUI.Spielstand = Geyser.MiniConsole:new({
  name="Spielstand",
  x="3%", y="3%",
  width = "94%",
  height = "94%",
  --autoWrap = true,
  color = "black",
  scrollBar = false,
  fontSize = 11,
}, GUI.Box1)
GUI.Spielstand:setColor("black") -- give it a nice black background
GUI.Spielstand:setFont("Bitstream Vera Sans Mono")
clearWindow("Spielstand")
GUI.Spielstand:echo(textInfobox)


--------------------------------------------
--- Tabs-Element rechts unten
-------------------------------------------

-- Container, der alles andere enthält. Container sind unsichtbar, deshalb kein Stylesheet
menu.container = Geyser.Container:new({
  name = "menu.back",
  x = "3%", y = "3%",
  width = "94%",
  height = "94%",
}, GUI.Box2)

-- die Kopfzeile des Tab-Elements, also da wo die Tabs sind
menu.header = Geyser.HBox:new({
  name = "menu.header",
  x = 0, y = 0,
  width = "100%",
  height = "10%",
},menu.container)

-- Der Körper des Tab-Elements, also da wo der Inhalt steht.
-- Der Container für jeden TAb-Inhalt
menu.footer = Geyser.Label:new({
  name = "menu.footer",
  x = 0, y = "10%",
  width = "100%",
  height = "90%",
}, menu.container)

--  background-color:black;
--  background-color: ]]..menu.color1..[[;
--  background-color: rgb(20,0,20);
menu.footer:setStyleSheet([[
  background-color: ]]..menu.color1..[[;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
]])

-- Each window actually has two labels. One for the light blue background, and another for the dark blue center. This will create that dark blue center. 
menu.center = Geyser.Label:new({
  name = "menu.center",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
}, menu.footer)
--  background-color: rgb(20,0,20);
--  background-color: rgb(255,255,255);
menu.center:setStyleSheet([[
  background-color: ]]..menu.color2..[[;
  border-radius: 10px;
  margin: 5px;
]])

-- Hier werden die Tabs und die Seiten dazu erzeugt.
for k,v in pairs(menu.tabs) do

	-- Erzeugt einen Tab für jeden Eintrag in der Menu-Liste
	menu[v.."tab"] = Geyser.Label:new({
		name = "menu."..v.."tab",
	  },menu.header)
	-- Stylesheet für jeden Tab
	--background-color: ]]..menu.color1..[[;
	--background-color: rgb(20,0,20);
	menu[v.."tab"]:setStyleSheet([[
		background-color: ]]..menu.color1..[[;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		margin-right: 1px;
		margin-left: 1px;
	  ]])
	-- Beschriftung für jeden Tab
	menu[v.."tab"]:echo("<center>"..v)

	-- We need our tabs to do stuff when clicked, so we'll assign it a callback function, menu.click, which we'll create later on. Our tab name is the argument. 
	menu[v.."tab"]:setClickCallback("menu.click",v)

	-- Now we create the windows that appear when each tab is clicked. Each window has two labels, one atop the other. The first, which we'll create here, has rounded edges on its bottom. 
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
	-- The second label serves as the window's center and has rounded edges on all sides. And a margin of 5px from it's parent, the label we just created. When adding stuff to your windows, this is the label you'll want to use. menu.<tabname>center
	menu[v.."center"] = Geyser.Label:new({
		name = "menu."..v.."center",
		x = 0, y = 0,
		width = "100%",
		height = "100%",
	  },menu[v])
--	echo("menu."..tostring(v).."center\n")

	  menu[v.."center"]:setStyleSheet([[
		background-color: ]]..menu.color2..[[;
		border-radius: 10px;
		margin: 5px;
	  ]])
	  
	--------
	-- Inhalte der Tabs
	-- Alle Tabs enthalten eine Mini-Console.
	-- Bei den Kanal-Tabs wird dort die Ausgabe der entsprechenden Kanäle gesammelt angezeigt.
	-- Bei anderen Tabs gibt es andere Inhalte.
	-- Jede Minikonsole ist ansprechbar über ... ???
	menu[v.."console"] = Geyser.MiniConsole:new({
	  name=v,
	  x="2%", y="2%",
	  width = "96%",
	  height = "96%",
	  --autoWrap = true,
	  color = "black",
	  scrollBar = false,
	  fontSize = 11,
	}, menu[v.."center"])
	--GUI.Spielstand:setColor("black") -- give it a nice black background
	--GUI.Spielstand:setFont("Bitstream Vera Sans Mono")
	--clearWindow("menu." .. v .. "console")
	menu[v.."console"]:echo(menu["chat"..v])
	  

	-- Finally, we hide all the windows and end the for loop.
	 menu[v]:hide()
end
menu[menu.current]:show()


-- The last step is to create our callback function for when a tab is clicked. This will hide that tab that is stored in menu.current, set menu.current to the clicked tab, and then show the menu.current tab. 
function menu.click(tab)
  menu[menu.current]:hide()
  menu.current = tab
  menu[menu.current]:show()
end

-------------------------------------------------------------
--- Top-Menü
-- Menü-Label dürfen nicht in einem Container sein, deshalb sind die 
-- Top-Level-Einträge direkt auf der Oberfläche positioniert.
-------------------------------------------------------------


 tConfig = {}

 tConfig.MainColorText = "#ffffff"
 tConfig.MainLabelBackground = "#303030"
 tConfig.MainColorBackground = "#000000"
 tConfig.MainColorBorder = "#999999"
 tConfig.MainColorHover = "#505050"


---------------------------- Standard CSS fuer die Menü-Label etc -----------------------------------
LabelCSS = CSSMan.new([[
	background-color:]]..tConfig.MainLabelBackground..[[;
	border-width: 1px;
	border-color: ]]..tConfig.MainColorBorder..[[;
	margin: 2px; 
	border-style: solid;
	border-radius: 7;
	padding: 3px;
]])

function dummy()
		TopMenuBar = Geyser.Label:new({
			name = "TopMenuBar", 
			x = "2%", 
			y = "2%" ,
			width = "96%", 
			height = "96%",
		}, GUI.Header)
		TopMenuBar:setStyleSheet(LabelCSS:getCSS())

		local tDir = "attrdir(getMudletHomeDir()..[[/../../modules/Spiele/]])"

		TopMenuSpiele = Geyser.Label:new({ 
			name = "TopMenuSpiele", 
			x = 10, 
			y = 4, 
			width = "10%",
			height = "80%",
			nestable = true
		}, TopMenuBar)

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
		}, TopMenuBar)
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
		}, TopMenuBar)
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
		}, TopMenuBar)
		TopMenuLocations:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
		TopMenuLocations:echo([[<p style="font-size:16px"><b><font color="white">YourMenuHere]])
end


-- Menü "Options"
-- wird hier extra hinzugefügt.
-- Menü-Label dürfen nicht in einem Container sein, deshalb sind die Top-Level-Einträge direkt auf der Oberfläche positioniert.

TopMenuOptions= Geyser.Label:new({ 
	name = "TopMenuOptions", 
	x = "62%", 
	y = "1.5%" , 
	width = 35,
	height = 35,
	nestable = true,
})
TopMenuOptions:setStyleSheet([[background-color:  ]]..tConfig.MainLabelBackground..[[;]])
TopMenuOptions:echo([[<p style="font-size:22px"><b><font color="white">&#9881;]])
--setLabelClickCallback( "TopMenuOptions", "ClickTopMenuPreferences")

i = 1
TopMenuOptions[i] = TopMenuOptions:addChild({
	name = "TopMenuOptions"..i,
	height = 50,
	width = 100, 
	flyOut=true,
	layoutDir="BV", 
	message="comming soon"
})
--TopMenuOptions[i]:setStyleSheet(LabelCSS:getCSS())
--setLabelClickCallback( "TopMenuOptions"..i, "ClickTopMenuCallback","tDir[i]","bla bla")

----------------------------------------
-- Mapper (Karte) links oben
----------------------------------------

GUI.Mapper = Geyser.Mapper:new({ 
	name = "Mapper",
	x = "5%", y = "5%", 
	width = "90%", 
	height = "90%"
}, GUI.Box4)

---------------------------------------------------------------------------
-- Gauges für die Timer
---------------------------------------------------------------------------

for k, v in pairs(sortedListOfTimers) do
	GUI["Timer"..k] = Geyser.Gauge:new({
		name = "GUI.Timer"..k,
		x = "4%", y = (100-(k*10)-5).."%",
		width="90%", height="9%",
		orientation = "goofy",
	}, GUI.Box5)
	if v["remaining"] < 30 then
		GUI.GaugeBackCSS:set("background-color","red")
	elseif v["remaining"] < 60 then
		GUI.GaugeBackCSS:set("background-color","yellow")
	end
	GUI["Timer"..k].back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
	GUI.GaugeFrontCSS:set("background-color","purple")
	GUI["Timer"..k].front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
	GUI["Timer"..k]:setValue(v["remaining"], v["duration"] , "<b>" .. v["name"] .. "</b>")
end


-----------------------------------
-- Gauges für TP, AP, ZP und Mana
-----------------------------------

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

GUI.Mana = Geyser.Gauge:new({
  name = "GUI.Mana",
  x = "2%", y = "80%",
  width="96%", height="20%",
},GUI.Box7)
GUI.Mana.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","green")
GUI.Mana.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Mana:setValue(9999,9999)

-----------------------------------------------------------------------------

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
