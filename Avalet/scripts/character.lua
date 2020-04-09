----------------------------------------
-- Character-Objekt für Charakter-Daten
-- 
-- Hier werden die Charakter-Daten gehalten und hier gibt es dann auch
-- die Funktionen zum aktualisieren, auslesen, speichern, laden... etc.
----------------------------------------

--	tPlayer = tPlayer or {}
--	tPlayer.name = tPlayer.name or "Name"
--	tPlayer.vollname = tPlayer.vollname or "Vollname"
--	tPlayer.gilde = tPlayer.gilde or "Keine"
--	tPlayer.level = tPlayer.level or "S1"
--	tPlayer.stufe = tPlayer.stufe or 1
--	tPlayer.levelstufen = tPlayer.levelstufen or 1
--	tPlayer.alter = tPlayer.alter or 1
--	tPlayer.eph = tPlayer.eph or 1
--	tPlayer.epheute = tPlayer.epheute or 1
--	tPlayer.eptl = tPlayer.eptl or 1
--	tPlayer.ep = tPlayer.ep or 1
--	tPlayer.tp = tPlayer.tp or 1
--	tPlayer.maxtp = tPlayer.maxtp or 1
--	tPlayer.difftp = tPlayer.difftp or 0
--	tPlayer.mp = tPlayer.mp or 1
--	tPlayer.maxmp = tPlayer.maxmp or 9999
--	tPlayer.diffmp = tPlayer.diffmp or 0
--	tPlayer.ap = tPlayer.ap or 1
--	tPlayer.maxap = tPlayer.maxap or 1
--	tPlayer.diffap = tPlayer.diffap or 0
--	tPlayer.sp = tPlayer.sp or 1
--	tPlayer.maxsp = tPlayer.maxsp or 1
--	tPlayer.diffsp = tPlayer.diffsp or 0
--	tPlayer.zuenfte = tPlayer.zuenfte or "Keine"
--	tPlayer.gruppe = tPlayer.gruppe or "Keine"
--	tPlayer.hoehe = tPlayer.hoehe or "Keine"
--	tPlayer.hunger = tPlayer.hunger or "Keiner"
--	tPlayer.bDurst = tPlayer.bDurst or false
--	tPlayer.durst = tPlayer.durst or "Keiner"
--	tPlayer.gesinnung = tPlayer.gesinnung or "Keine"
												
--	tPlayer.staerke = tPlayer.staerke or 1
--	tPlayer.ausdauer = tPlayer.ausdauer or 1
--	tPlayer.geschicklichkeit = tPlayer.ausdauer or 1
--	tPlayer.intelligenz = tPlayer.intelligenz or 1
--	tPlayer.weisheit = tPlayer.weisheit or 1
--	tPlayer.aura = tPlayer.aura or 1
--	tPlayer.schnelligkeit = tPlayer.schnelligkeit or 1
--	tPlayer.vitalitaet = tPlayer.vitalitaet or 1
--	tPlayer.konzentration = tPlayer.konzentration or 1

--	tPlayer.flucht = tPlayer.flucht or 1
--	tPlayer.raetselp = tPlayer.raetselp or 1
--	tPlayer.raetselpmax = tPlayer.raetselpmax or 1
--	tPlayer.angriff = tPlayer.angriff or "nil"
--	tPlayer.spielp = tPlayer.spielp or 1
--	tPlayer.spielpmax = tPlayer.spielpmax or 1
--	tPlayer.gegenangriff = tPlayer.gegenangriff or "nil"
--	tPlayer.lp = tPlayer.lp or 1
--	tPlayer.verteidigung = tPlayer.verteidigung or "nil"
--	tPlayer.epheute = tPlayer.epheute or 1
--	tPlayer.kampfmodus = tPlayer.kampfmodus or "nil"

--	tPlayer.sOpfer = tPlayer.sOpfer or ""
--	tPlayer.bSchild = tPlayer.bSchild or false
--	tPlayer.sLastMoveDirection = tPlayer.sLastMoveDirection or ""

--	tPlayer.tSpieleSolved = tPlayer.tSpieleSolved or {}
--	tPlayer.tRaetselSolved = tPlayer.tRaetselSolved or {}
--	tPlayer.tSitemsSolved = tPlayer.tSitemsSolved or {}
--	tPlayer.tSkillsLearned = tPlayer.tSkillsLearned or {}
--	tPlayer.tSkillsSolved = tPlayer.tSkillsSolved or {}			
 
--	tPlayer.levelep = {
--		"1","101","592","1097","1686","2368","3220","4268","5126","6208",
--		"7899","8301","9623","11182","12842","14814","17623","19367","22967","25012",
--		"28330","32823","36167","40766","46556","52320","58258","65141","73176","81897",
--		"91785","102748","114998","128919","143982","160874","179766","200855","224364","251500",
--		"279807","312469","348653","389152","434233","484703","540623","604589","673406","750590",
--		"837077","933578","1041267","1161075","1294883","1445197","1609946","1795373","2002000","2232057",
--		"2488509","2776205","3094532","3448713","3847000","4286000","4780364","5328000","5940000","6623651",
--		"7431829","8231293","9179050","10229265","11404503","12711652","14170920","15803350","17611375","19632993",
--		"21886846","24398471","27201277","30320000","33830000","37275000","42005075","46826194","52200000","58193000",
--		"64980000","71150000","80614492","89944851","100132086","111597210","121924300","136942005","152484923","172459403",
--		"189063350","210522040","234416292","261022541","290753008","323898851","360823320","401957178","447780296","498827250",
--		"555568850","618764807","689149304","767540037","854847716","952086644","1060386500"
--	}

local avaletCharacterFile = "AvaletCharacter.json"


Character = {}
setmetatable(Character, {
  __index=function(cls, key)
    return getmetatable(cls)[key]
  end,
  __call=function(cls, ...)
    return getmetatable(cls).new(...)
  end,
  new=function()
    local self=setmetatable({}, getmetatable(Character))
	self.name = ""			-- ATCP: AvalonName
	self.vollername = ""	-- ATCP: AvalonVollName
	self.alter = ""			-- ATCP: AvalonAlter
	self.gilde = ""			-- ATCP: AvalonGilde
	self.zuenfte = ""		-- ATCP: AvalonZuenfte
	self.ep = ""			-- ATCP: AvalonEP
	self.level = ""			-- ATCP: AvalonLevel
	self.gesinnung = ""		-- ATCP: AvalonGesinnung
	self.portfolio = ""		-- ATCP: AvalonPortfolio
	self.hunger = ""		-- ATCP: AvalonHunger
	self.durst = ""			-- ATCP: AvalonDurst
	--
	self.hoehe = ""			-- ATCP: AvalonHoehe
	self.flucht = ""		-- ATCP: AvalonFlucht
	self.schutz = ""		-- ATCP: AvalonSchutz
	self.gruppenname = ""	-- ATCP: AvalonGruppe
	self.zaubern = 0		-- ATCP: AvalonZaubern
	self.kampf = 0			-- ATCP: AvalonKampf
	self.angegriffen = ""	-- ATCP: AvalonAngegriffen
	self.getoetet = ""		-- ATCP: AvalonGetoetet
	self.gruppeGetoetet = ""-- ATCP: AvalonGruppeGetoetet
	self.allyGetoetet = ""	-- ATCP: AvalonAllyGetoetet
	--
    self.stats = {}
    self.stats.tp = 0		-- ATCP: AvalonTP
    self.stats.tp_max = 0	-- ATCP: AvalonMAXTP
    self.stats.ap = 0		-- ATCP: AvalonAP
    self.stats.ap_max = 0	-- ATCP: AvalonMAXAP
    self.stats.zp = 0		-- ATCP: AvalonSP
    self.stats.zp_max = 0	-- ATCP: AvalonMAXSP
    self.stats.mp = 0		-- ATCP: AvalonMP
    self.stats.mp_max = 0	-- ATCP: AvalonMAXMP
	--
	self.inventarRein = ""	-- ATCP: AvalonInventarRein
	self.inventarRaus = ""	-- ATCP: AvalonInventarRaus
	self.behaelterRein = ""	-- ATCP: AvalonBehaelterRein
	self.behaelterRaus = ""	-- ATCP: AvalonBehaelterRaus
	self.gefuehrt = ""		-- ATCP: AvalonGefuehrt
	self.gesenkt = ""		-- ATCP: AvalonGesenkt
	self.angezogen = ""		-- ATCP: AvalonAngezogen
	self.ausgezogen = ""	-- ATCP: AvalonAusgezogen
	--
	self.lastMove = ""
--
--    self.stats.staerke = 0
--    self.stats.intelligenz = 0
--    self.stats.schnelligkeit = 0
--    self.stats.ausdauer = 0
--    self.stats.weisheit = 0
--    self.stats.vitalitaet = 0
--    self.stats.geschicklichkeit = 0
--    self.stats.aura = 0
--    self.stats.konzentration = 0
--    self.raetselpunkte = 0
--    self.spielepunkte = 0
--    self.lernpunkte = 0
--    self.flucht = 0
--    self.angriff = ""
--    self.gegenangriff = ""
--    self.verteidigung = ""
--    self.kampfmodus = ""
--    self.fertigkeiten ={}
    return self
  end,
  __tostring=function(v)
    return string.format()
  end,
  __writeToFS=function()
	file = io.open (getMudletHomeDir() .. "/" .. avaletCharacterFile, "w")
	file:write(yajl.to_string(self))
	file:flush()
	file:close()
	return true
  end,
  __readFromFS=function()
		file = io.open (getMudletHomeDir() .. "/" .. avaletCharacterFile, "r")
		self = yajl.to_value(file:read())
		file:close()  
		return true
  end,
})

player = Character()