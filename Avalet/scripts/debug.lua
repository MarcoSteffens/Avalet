feedTriggers("\nDu laesst einen fuerchterlichen Urschrei von Dir. Es scheint so, als bla\n")

table.insert(timerStrings, {["name"]="Kampfbeschwoerung", ["start"]="Du wirst von einer heiligen Aura umgeben\\.",["stop"]="Deine heilige Aura loest sich auf\\.", ["duration"]="600"})

feedTriggers("\nDu laesst einen fuerchterlichen Urschrei von Dir. Es scheint so, als bla\n")
feedTriggers("\nDie roetlichen Manawolken loesen sich auf.\n")

feedTriggers("\nDu wirst von einer heiligen Aura umgeben.\n")
feedTriggers("\nDeine heilige Aura loest sich auf.\n")




"^Das Ankh auf (Deiner|Deinem|den)([a-z ,]*)([A-z]+) beginnt\, schwach zu leuchten\."
lua feedTriggers("\nDas Ankh auf Deinem magischen Quitscheentchen beginnt, schwach zu leuchten.\n")

"Dein* verliert * magische Kraft."
lua feedTriggers("\nDein magisches Quitscheentchen verliert seine magische Kraft.\n")

table.insert(timerStrings, {["name"]="Segen", ["start"]="^(Das Ankh auf (Deiner|Deinem|den)([a-z ,]*)([A-z]+)beginnt\, schwach zu leuchten\.)", ["stop"]="Dein* verliert * magische Kraft.", ["duration"]="600"})

lua sendATCP("ava_req_update")

lua atcp
