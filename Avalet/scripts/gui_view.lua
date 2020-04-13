-------------------------------------------------------------------------------
-- GUI-View
-- 
-- Hier wird die eigentliche Oberfläche erzeugt, also die Fenster-Elemente und
-- das Stylesheet-Geraffel.
-- Die Daten für die Oberfläche kommen aus der Datei gui.lua, wo sozusagen
-- Model und Control zusammengefasst sind.
-- 
-- Dieses Script, also das Layout, basierte ursprünglich mal auf einem Template
-- vom User Akaya aus dem mudlet.org-Forum, das ich hier gefunden habe:
-- https://forums.mudlet.org/viewtopic.php?t=4098
-- Teile davon sind vermutlich noch enthalten.
-- Es enthält außerdem "CSSMan" von Vadi aus dem gleichen Forum:
-- https://forums.mudlet.org/viewtopic.php?f=6&t=3502&p=17268&hilit=CSSMan#p17264
--
-- Autor ansonsten: Marco Steffens
--------------------------------------------------------------------------------

-- TODO: hier die Werte rausziehen, die zentral einstellbar (zum Beispiel auch durch
-- den Spieler irgendwann mal...) sein sollen

local tConfig = {}

tConfig.GaugeFrontColorTimer = "purple"
tConfig.GaugeFrontColorTP = "darkred"
tConfig.GaugeFrontColorAP = "goldenrod"
tConfig.GaugeFrontColorZP = "blue"
tConfig.GaugeFrontColorMana = "green"
tConfig.MiniConsoleCenterFontSize = 9
tConfig.MiniConsoleTabsFontSize = 9


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
GUI.tabElement = {}

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

-- CSS Tab-Element ---------------------------------------------

GUI.tabElement.FooterCSS = CSSMan.new([[
	background-color: rgb(20,0,20);
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
]])

-- Each window actually has two labels. One for the light blue background, and another for the dark blue center. This will create that dark blue center. 
GUI.tabElement.CenterCSS = CSSMan.new([[
	background-color: rgba(0,0,0,100);
	border-radius: 10px;
	margin: 5px;
]])

-- Now we create the windows that appear when each tab is clicked. Each window has two labels, one atop the other. The first, which we'll create here, has rounded edges on its bottom. 
GUI.tabElement.AtopCSS = CSSMan.new([[
	background-color: rgb(20,0,20);
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
]])

-- The second label serves as the window's center and has rounded edges on all sides. And a margin of 5px from it's parent, the label we just created. When adding stuff to your windows, this is the label you'll want to use. menu.<tabname>center
GUI.tabElement.CenterTabCSS = CSSMan.new([[
	background-color: rgba(0,0,0,100);
	border-radius: 10px;
	margin: 5px;
]])

-- Hier werden die Tabs und die Seiten dazu erzeugt.
-- Erzeugt einen Tab für jeden Eintrag in der Menu-Liste
-- Stylesheet für jeden Tab
--background-color: ]]..menu.color1..[[;
--background-color: rgb(20,0,20);
GUI.MenuTabCSS = CSSMan.new([[
	background-color: rgb(20,0,20);
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	margin-right: 1px;
	margin-left: 1px;
]])



-- CSS Top Menu ------------------------------------------------

--	border-width: 1px;
--	border-color: white;
--	margin: 2px; 
--	border-style: solid;
--	border-radius: 7;
--	padding: 3px;
-- 	qproperty-alignment: 'AlignTop';
GUI.MenuLabelCSS = CSSMan.new([[
	background-color: rgba(0,0,0,100);
	font-weight: bold;
	font-size: 16pt;
	color: white;
]])
--GUI.TopMenuOptions:echo([[<p style="font-size:22px"><b><font color="white">&#9881;]])

-- CSS Gauges --------------------------------------------------

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
	padding: 5px;
	font-weight: bold;
]])

--	background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #78bd33, stop: 0.1 #6ebd20, stop: 0.49 #4c9900, stop: 0.5 #387000, stop: 1 #4c9900);
GUI.GaugeTimerTextCSS = CSSMan.new([[
	font-weight: bold;
	padding: 50px;
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
-- Deshalb geht das hier mit dem weißen Rahmen nicht. Lösung ist, hier noch ein Label
-- zu nehmen, dort dann den Container drin, und in dem dann die Gauges.
GUI.Box5a = Geyser.Label:new({
	name = "GUI.Box5a",
	x = "0%", y = "50%",
	width = "100%",
	height = "35%",
}, GUI.Left)
GUI.Box5a:setStyleSheet(GUI.BoxCSS:getCSS())
GUI.Box5 = Geyser.Container:new({
	name = "GUI.Box5",
	x = "2%", y = "0%",
	width = "98%",
	height = "100%",
}, GUI.Box5a)
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
GUI.infobox = Geyser.MiniConsole:new({
  name="Infobox",
  x="3%", y="3%",
  width = "94%",
  height = "94%",
  autoWrap = true,
  color = "black",
  scrollBar = false,
  fontSize = tConfig.MiniConsoleCenterFontSize,
}, GUI.Box1)
GUI.infobox:setColor("black") -- give it a nice black background
GUI.infobox:setFont("Bitstream Vera Sans Mono")
setWindowWrap("Infobox", 60)
clearWindow("Infobox")
GUI.infobox:echo(GUIModel.infobox)



--------------------------------------------
--- Tabs-Element rechts unten
-------------------------------------------

--GUI.tabElement = {}
-- Container, der alles andere enthält. Container sind unsichtbar, deshalb kein Stylesheet
GUI.tabElement.Container = Geyser.Container:new({
  name = "GUI.tabElement.Container",
  x = "3%", y = "3%",
  width = "94%",
  height = "94%",
}, GUI.Box2)



function GUI.tabElement.createContainter()
	GUI.tabElement.Container = nil
	GUI.tabElement.Container = Geyser.Container:new({
	  name = "GUI.tabElement.Container",
	  x = "3%", y = "3%",
	  width = "94%",
	  height = "94%",
	}, GUI.Box2)
end

-- die Kopfzeile des Tab-Elements, also da wo die Tabs sind
GUI.tabElement.Header = Geyser.HBox:new({
  name = "GUI.tabElement.Header",
  x = 0, y = 0,
  width = "100%",
  height = "10%",
}, GUI.tabElement.Container)


function GUI.tabElement.createHeader()
	GUI.tabElement.Header = nil
	-- die Kopfzeile des Tab-Elements, also da wo die Tabs sind
	GUI.tabElement.Header = Geyser.HBox:new({
	  name = "GUI.tabElement.Header",
	  x = 0, y = 0,
	  width = "100%",
	  height = "10%",
	}, GUI.tabElement.Container)
end

-- Der Körper des Tab-Elements, also da wo der Inhalt steht.
-- Der Container für jeden TAb-Inhalt
GUI.tabElement.Footer = Geyser.Label:new({
  name = "GUI.tabElement.Footer",
  x = 0, y = "10%",
  width = "100%",
  height = "90%",
}, GUI.tabElement.Container)
GUI.tabElement.Footer:setStyleSheet(GUI.tabElement.FooterCSS:getCSS())


function GUI.tabElement.createFooter()
	GUI.tabElement.Footer = nil
	-- Der Körper des Tab-Elements, also da wo der Inhalt steht.
	-- Der Container für jeden TAb-Inhalt
	GUI.tabElement.Footer = Geyser.Label:new({
	  name = "GUI.tabElement.Footer",
	  x = 0, y = "10%",
	  width = "100%",
	  height = "90%",
	}, GUI.tabElement.Container)
	GUI.tabElement.Footer:setStyleSheet(GUI.tabElement.FooterCSS:getCSS())
end

-- Each window actually has two labels. One for the light blue background,
-- and another for the dark blue center. This will create that dark blue center. 
GUI.tabElement.Center = Geyser.Label:new({
  name = "GUI.tabElement.Center",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
}, GUI.tabElement.Footer)
GUI.tabElement.Center:setStyleSheet(GUI.tabElement.CenterCSS:getCSS())

function GUI.tabElement.createCenter()
	GUI.tabElement.Center = nil
	GUI.tabElement.Center = Geyser.Label:new({
	  name = "GUI.tabElement.Center",
	  x = 0, y = 0,
	  width = "100%",
	  height = "100%",
	}, GUI.tabElement.Footer)
	GUI.tabElement.Center:setStyleSheet(GUI.tabElement.CenterCSS:getCSS())
end


function GUI.tabElement.removeTab(arg)
	if arg ~= nil then
		--GUI.tabElement.createContainter()
		--GUI.tabElement.createHeader()
		--GUI.tabElement.createFooter()
		--GUI.tabElement.createCenter()
		--GUI.tabElement.createTabs()
		--"GUI.tabElement.tabs."..arg.."tab":hide()
		--"GUI.tabElement.tabs."..arg:hide()
		--"GUI.tabElement.tabs."..arg.."console":hide()
	end
end

-- Hier werden die Tabs und die Seiten dazu erzeugt.
GUI.tabElement.tabs = {}
function GUI.tabElement.createTabs()

	for k, v in pairs(GUIModel.tabElement.tabs) do
	
		if GUI.tabElement.tabs[v.."tab"] == nil then

			-- Erzeugt einen Tab für jeden Eintrag in der Menu-Liste
			GUI.tabElement.tabs[v.."tab"] = Geyser.Label:new({
				name = "GUI.tabElement.tabs."..v.."tab",
			  }, GUI.tabElement.Header)
			GUI.tabElement.tabs[v.."tab"]:setFontSize(11)	  
			GUI.tabElement.tabs[v.."tab"]:setStyleSheet(GUI.MenuTabCSS:getCSS())
			GUI.tabElement.tabs[v.."tab"]:echo("<center>"..v)

			-- We need our tabs to do stuff when clicked, so we'll assign it a callback function, GUI.tabElement.tabs.click, which we'll create later on. Our tab name is the argument. 
			GUI.tabElement.tabs[v.."tab"]:setClickCallback("GUI.tabElement.tabs.click", v)

			-- Now we create the windows that appear when each tab is clicked. Each window has two labels, one atop the other. The first, which we'll create here, has rounded edges on its bottom. 
			GUI.tabElement.tabs[v] = Geyser.Label:new({
				name = "GUI.tabElement.tabs."..v,
				x = 0, y = 0,
				width = "100%",
				height = "100%",
			  }, GUI.tabElement.Footer)
			GUI.tabElement.tabs[v]:setStyleSheet(GUI.tabElement.AtopCSS:getCSS())
			-- The second label serves as the window's center and has rounded edges on all sides. And a margin of 5px from it's parent, the label we just created. When adding stuff to your windows, this is the label you'll want to use. GUI.tabElement.tabs.<tabname>center
			GUI.tabElement.tabs[v.."center"] = Geyser.Label:new({
				name = "GUI.tabElement.tabs."..v.."center",
				x = 0, y = 0,
				width = "100%",
				height = "100%",
			  }, GUI.tabElement.tabs[v])
			GUI.tabElement.tabs[v.."center"]:setStyleSheet(GUI.tabElement.CenterTabCSS:getCSS())

			--------
			-- Inhalte der Tabs
			-- Alle Tabs enthalten eine Mini-Console.
			-- Bei den Kanal-Tabs wird dort die Ausgabe der entsprechenden Kanäle gesammelt angezeigt.
			-- Bei anderen Tabs gibt es andere Inhalte.
			-- Jede Minikonsole ist ansprechbar über ... ???
			GUI.tabElement.tabs[v.."console"] = Geyser.MiniConsole:new({
				name=string.title(v),
				x="2%", y="2%",
				width = "96%",
				height = "96%",
				autoWrap = true,
				color = "black",
				scrollBar = false,
				fontSize = tConfig.MiniConsoleCenterFontSize,
			}, GUI.tabElement.tabs[v.."center"])
			debugc("<magenta>Consolen-Name: "..string.title(v).."\n")
			setWindowWrap(string.title(v), 60)
			--GUI.infobox:setColor("black") -- give it a nice black background
			--GUI.infobox:setColor("black") -- give it a nice black background
			--GUI.infobox:setFont("Bitstream Vera Sans Mono")
			--clearWindow("GUI.tabElement.tabs." .. v .. "console")
		--	GUI.tabElement.tabs[v.."console"]:echo(GUIModel.tabElement["chat"..v])
			GUI.tabElement.tabs[v.."console"]:echo(v)

			-- Finally, we hide all the windows and end the for loop.
			GUI.tabElement.tabs[v]:hide()

		end -- if nil
	end  -- for
end --function GUI.tabElement.createTabs
GUI.tabElement.createTabs()
raiseEvent("RefreshTabElement", GUIModel.tabElement.currentTab)
GUI.tabElement.tabs[GUIModel.tabElement.currentTab]:show()

-- The last step is to create our callback function for when a tab is clicked.
-- This will hide that tab that is stored in menu.current, set menu.current to
-- the clicked tab, and then show the menu.current tab. 
function GUI.tabElement.tabs.click(tab)
	-- Das hier funktioniert nur, wenn die Tab-Beschriftung dem Channel
	-- entspricht, also dem Namen der Datei, in die die Inhalte des
	-- Tabs vorher geschrieben wurden. Minus dem .txt
	GUI.tabElement.tabs[GUIModel.tabElement.currentTab]:hide()
	GUIModel.tabElement.currentTab = tab
	--refreshTabElement(tab)
--	echo("TAB: " .. tab .. "\n")
	raiseEvent("RefreshTabElement", tab)
	GUI.tabElement.tabs[GUIModel.tabElement.currentTab]:show()
end

-------------------------------------------------------------
--- Top-Menü
-- Menü-Label dürfen nicht in einem Container sein, deshalb sind die 
-- Top-Level-Einträge direkt auf der Oberfläche positioniert.
-------------------------------------------------------------
--GUI.MenuLabelCSS
--TopMenuOptions[i]:setStyleSheet(GUI.MenuLabelCSS:getCSS())

function GUItopMenucreateMenu()
	d = 0
	for k, v in ipairs(GUIModel.TopMenuEntries) do

		GUI["TopMenu"..v[1]] = Geyser.Label:new({ 
			name = "TopMenu"..v[1], 
			x = tostring(17+d*10).."%", 
			y = "1.5%" , 
			width = 200,
			height = 35,
			nestable = true,
		})
		GUI["TopMenu"..v[1]]:setStyleSheet(GUI.MenuLabelCSS:getCSS())
		GUI["TopMenu"..v[1]]:setFontSize(12)
		GUI["TopMenu"..v[1]]:echo(v[1])
		--GUI["TopMenu"..v[1]]:echo([[<p style="font-size:22px"><b><font color="white">]]..v[1])
		--setLabelClickCallback( "TopMenuOptions", "ClickTopMenuPreferences")
		--setLabelClickCallback(labelName, luaFunctionName, [any arguments])
		local subMenuEntries = {}
		for k2, v2 in ipairs(v[2]) do
			-- erstmal sortierte table der sub-entries bauen
			table.insert(subMenuEntries, v2[2], {v2[1], v2[3], v2[4], v2[5]}) -- tabelle, position, {name, message, luafunct, args}
		end
		for k3, v3 in ipairs(subMenuEntries) do
			GUI["TopMenu"..v[1]..v3[1]] = GUI["TopMenu"..v[1]]:addChild({
				name = "TopMenu"..v[1]..v3[1],
				height = 50,
				width = 100, 
				flyOut=true,
				layoutDir="BV", 
				message=v3[2]
			})
			GUI["TopMenu"..v[1]..v3[1]]:setStyleSheet(GUI.MenuLabelCSS:getCSS())
			--TopMenuOptions[i]:setStyleSheet(LabelCSS:getCSS())
			--setLabelClickCallback( "TopMenuOptions"..i, "ClickTopMenuCallback","tDir[i]","bla bla")
			--setLabelClickCallback(labelName, luaFunctionName, [any arguments])
		end

		--if v[5] then
		--	for i=1,#v[5] do
		--		echo ("arg["..i.."] = "..v[5][i].."\n")
		--	end
		--end
		d = d+1
	end
end --function GUI.topMenu.createMenu()
GUItopMenucreateMenu()

-------------------------
-- Menü "Options"
-------------------------
-- wird hier extra hinzugefügt.
-- Menü-Label dürfen nicht in einem Container sein, deshalb sind die Top-Level-Einträge direkt auf der Oberfläche positioniert.
GUI.TopMenuOptions= Geyser.Label:new({ 
	name = "TopMenuOptions", 
	x = "62%", 
	y = "1.5%" , 
	width = 35,
	height = 30,
	nestable = true,
})
GUI.TopMenuOptions:setStyleSheet(GUI.MenuLabelCSS:getCSS())
GUI.TopMenuOptions:setFontSize(12)
GUI.TopMenuOptions:echo([[&#9881;]])
--GUI.TopMenuOptions:echo([[<p style="font-size:22px"><b><font color="white">&#9881;]])
--setLabelClickCallback( "TopMenuOptions", "ClickTopMenuPreferences")
--setLabelClickCallback(labelName, luaFunctionName, [any arguments])

i = 1
GUI.TopMenuOptions[i] = GUI.TopMenuOptions:addChild({
	name = "TopMenuOptions"..i,
	height = 50,
	width = 100, 
	flyOut=true,
	layoutDir="BV", 
	message="comming soon"
})
GUI.TopMenuOptions[i]:setStyleSheet(GUI.MenuLabelCSS:getCSS())
--setLabelClickCallback( "TopMenuOptions"..i, "ClickTopMenuCallback","tDir[i]","bla bla")
--setLabelClickCallback(labelName, luaFunctionName, [any arguments])

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
-- Hier werden (derzeit) 9 Gauge-Elemente für die Timer erzeugt und positioniert.
-- in der Funktion "recreateTimer" werden die Timer dann alle unsichtbar und
-- nur die benötigten werden wieder sichtbar und mit Werten beschrieben.
-- Eigentlich war geplant, die Timer dynamischer zu gestalten, so dass es auch
-- mehr als neun werden könnten. (Der Rest sollte dann etwas zusammen rücken.)
-- Aber es scheint nicht möglich zu sein, einmal erzeugte Gauge-Elemente wieder
-- zu löschen. (Auf nil setzen wirkt jedenfalls nicht.) Deshalb die statische
-- Lösung und das unsichtbar machen.
---------------------------------------------------------------------------

for k = 1, 9, 1 do
	GUI["Timer"..k] = Geyser.Gauge:new({
		name = "GUI.Timer"..k,
		x = "4%", y = (100-(k*10)-5).."%",
		width="90%", height="9%",
		orientation = "goofy",
	}, GUI.Box5)
	GUI["Timer"..k].back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
	GUI.GaugeFrontCSS:set("background-color", tConfig.GaugeFrontColorTimer)
	GUI["Timer"..k].front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
	GUI["Timer"..k]:setValue(600, 600, "")
end

recreateTimer()



-----------------------------------
-- Gauges für TP, AP, ZP und Mana
-----------------------------------

GUI.Health = Geyser.Gauge:new({
	name = "GUI.Health",
	x = "2%", y = "0%",
	width="30%", height="75%",
	orientation="vertical",
}, GUI.Box7)
GUI.Health.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color", tConfig.GaugeFrontColorTP)
GUI.Health.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Health.text:setStyleSheet(GUI.GaugeTextCSS:getCSS())
GUI.Health:setValue(100,100,[[<b><center>TP</center></b>]])

GUI.Endurance = Geyser.Gauge:new({
	name = "GUI.Endurance",
	x = "35%", y = "0%",
	width="30%", height="75%",
	orientation="vertical",
}, GUI.Box7)
GUI.Endurance.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color", tConfig.GaugeFrontColorAP)
GUI.Endurance.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Endurance.text:setStyleSheet(GUI.GaugeTextCSS:getCSS())
GUI.Endurance:setValue(100,100,[[<b><center>AP</center></b>]])


GUI.Spellpoints = Geyser.Gauge:new({
	name = "GUI.Spellpoints",
	x = "68%", y = "0%",
	width="30%", height="75%",
	orientation="vertical",
}, GUI.Box7)
GUI.Spellpoints.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color", tConfig.GaugeFrontColorZP)
GUI.Spellpoints.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Spellpoints.text:setStyleSheet(GUI.GaugeTextCSS:getCSS())
GUI.Spellpoints:setValue(100,100, [[<b><center>ZP</center></b>]])

GUI.Mana = Geyser.Gauge:new({
	name = "GUI.Mana",
	x = "2%", y = "78%",
	width="96%", height="20%",
}, GUI.Box7)
GUI.Mana.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color", tConfig.GaugeFrontColorMana)
GUI.Mana.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Mana:setValue(9999,9999, [[<b><center>Mana</center></b>]])

-----------------------------------------------------------------------------


