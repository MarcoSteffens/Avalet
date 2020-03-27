



	tConfig.iMainBorderLeft = 10
	tConfig.iMainBorderTop = 128
	tConfig.iMainBorderRight = 0 
	tConfig.iMainBorderBottom = 64
	tConfig.iMainWidth, tConfig.iMainHeight = getMainWindowSize()
	
	tConfig.MainColorText = "#ffffff"
	tConfig.MainLabelBackground = "#303030"
	tConfig.MainColorBackground = "#000000"
	tConfig.MainColorBorder = "#999999"
	tConfig.MainColorHover = "#505050"

	-- Bereich links neben dem Hauptfenster
	setBorderLeft(tConfig.iMainBorderLeft)

	-- Bereich ueber dem Hauptfenster
	setBorderTop(tConfig.iMainBorderTop)

	-- Bereich unter dem Haupffenster
	setBorderBottom(tConfig.iMainBorderBottom)

	--Bereich Rechts vom Hauptfenster
	setBorderRight(tConfig.iMainBorderRight)



---------------------------- Standard CSS fuer die Label etc -----------------------------------
	LabelCSS = CSSMan.new([[background-color:]]..tConfig.MainLabelBackground..[[;border-width: 1px;border-color: ]]..tConfig.MainColorBorder..[[;margin: 2px; border-style: solid;border-radius: 7;padding: 3px;]])


	fMapperInit()
	fChannelInit()


	--timer fuer Schild Aura und Waffenbuff initalisieren

	iSchildStopWatch = iSchildStopWatch or createStopWatch()
	iAuraStopWatch = iAuraStopWatch or createStopWatch()
	iWaffenBuffStopWatch = iWaffenBuffStopWatch or createStopWatch()
	tPlayer.bWaffenBuff = false
	tPlayer.bSchild = false
	tPlayer.bAura = false

	--loadMap(getMudletHomeDir().."/../../map/map.dat")


	--------------------------  Hier werden die Farben fuer Menu, Scrollbar etc gesetzt -------------
	
	setAppStyleSheet([[
  QMainWindow {
     background: ]]..tConfig.MainColorBackground..[[;
  }
  QToolBar {
     background: ]]..tConfig.MainLabelBackground..[[;
  }
  QToolButton {
     background: ]]..tConfig.MainLabelBackground..[[;
     border-style: solid;
     border-width: 1px;
     border-color: ]]..tConfig.MainColorBorder..[[;
     border-radius: 10px;
     font-family: BitstreamVeraSansMono;
     color: white;
     margin: 3px;
     font-size: 10pt;
  }
  QToolButton:hover { background-color: ]]..tConfig.MainColorHover..[[;}
  QToolButton:focus { background-color: grey;}

  QTreeView {
     background: ]]..tConfig.MainLabelBackground..[[;
     color: white;
  }

  QMenuBar{ background-color: ]]..tConfig.MainColorBackground..[[;}

  QMenuBar::item{ background-color: ]]..tConfig.MainColorBackground..[[;}

  QDockWidget::title {
     background: ]]..tConfig.MainColorBorder..[[;
  }
  QStatusBar {
     background: ]]..tConfig.MainColorBorder..[[;
  }
  QScrollBar:vertical {
     background: ]]..tConfig.MainColorBackground..[[;
     width: 15px;
     margin: 22px 0 22px 0;
  }
  QScrollBar::handle:vertical {
     background-color: ]]..tConfig.MainColorBackground..[[;
     min-height: 20px;
     border-width: 2px;
     border-style: solid;
     border-color: ]]..tConfig.MainColorBorder..[[;
     border-radius: 7px;
  }
  QScrollBar::add-line:vertical {
   background-color: ]]..tConfig.MainColorBackground..[[;
   border-width: 2px;
   border-style: solid;
   border-color: ]]..tConfig.MainColorBorder..[[;
   border-bottom-left-radius: 7px;
   border-bottom-right-radius: 7px;
        height: 15px;
        subcontrol-position: bottom;
        subcontrol-origin: margin;
  }
  QScrollBar::sub-line:vertical {
   background-color: ]]..tConfig.MainColorBackground..[[;
   border-width: 2px;
   border-style: solid;
   border-color: ]]..tConfig.MainColorBorder..[[;
   border-top-left-radius: 7px;
   border-top-right-radius: 7px;
        height: 15px;
        subcontrol-position: top;
        subcontrol-origin: margin;
  }
  QScrollBar::up-arrow:vertical, QScrollBar::down-arrow:vertical {
     background: white;
     width: 4px;
     height: 3px;
  }
  QScrollBar::add-page:vertical, QScrollBar::sub-page:vertical {
     background: none;
  }
]])
	
	

end -- function


-- Script: onResize
onResize = function()
	tConfig = tConfig or {}
	tConfig.iMainWidth, tConfig.iMainHeight = getMainWindowSize()
	--InitTopBox()
	--InitBottomBox()
	--echo("Resize! "..tConfig.iMainWidth.." x "..tConfig.iMainHeight.."\n")
	if  tConfig.iMainWidth-1 >= 1600 then
		 -- Fullscreen
		 tConfig.iMainBorderLeft = 320
		 tConfig.iMainBorderTop = 40
		 tConfig.iMainBorderRight = 750 
		 tConfig.iMainBorderBottom = 0
		 showWindow("ChatConBox")
		 showWindow("tMapperContainer")
	else
		-- Skriptmode
		tConfig.iMainBorderLeft = 10
		tConfig.iMainBorderTop = 128
		tConfig.iMainBorderRight = 0
		tConfig.iMainBorderBottom = 64
		hideWindow("ChatConBox")
		hideWindow("tMapperContainer")
	end
	enableTimer("OnResizeTimer")
end

-- EventHandler: sysWindowResizeEvent

