# Avalet

> **ACHTUNG: Dieses Projekt ist noch *pre-alpha*! Es gibt hier also vielleicht schon was zu sehen, aber nichts davon funktioniert. Auch wenn der Text was anderes behauptet. Wenn das Modul was gescheites macht, steht das hier auch. (Bzw. das hier steht hier dann nicht mehr.)**

> **NOCHMAL ACHTUNG: Wer Texte für Timer zuliefern möchte kann das auch in einem Dropbox-Paper machen. Nämlich hier: [Schildzauber, Auren und andere Timer in Avalon](https://paper.dropbox.com/doc/Schilde-Auren-und-andere-Timer-in-Avalon--AwzQroKtD73zHn6jNa2GIFiWAQ-1yKShCfqPZ6b21iU5vWO4). Dort ist auch nochmal beschrieben, was genau ich brauche.**
> **Aber ich nehme das auch per Mudmail (Rofhessa), Mail (rofhessa@gmx-topmail.de), PasteBin, Brieftaube oder wie auch immer entgegen. Hauptsache, die originale Formatierung bleibt erhalten.**

Avalet ist ein Mudlet-Module für das [MUD Avalon](https://avalon.mud.de/). Für ein bisschen (mehr) Farbe und ein bisschen Klicki-Bunti.

Avalet bietet in erster Linie:
- Einen nicht zu übersehenden Überblick über TP, ZP, AP und Mana!
- Eine Anzeige von Schildzaubern, Auren und anderen Timern! Mit einem *fancy!* Fortschrittsbalken! ;)
- Eine Karte (und einen Mapper)! *(coming soon)*
- Viel mehr *bling-bling* als Plain-Avalon!
- Noch vieles mehr! *(coming soon)*
- Und noch mehr! *(coming soon)*

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |  "Wenn so heisser Scheiss jetzt schon verschenkt      |
            |   wird, kann ich den Laden ja bald zumachen!"         |_
            |                           Zwoniman ueber Avalet       | |
            \_______________________________________________________\_/

```

## Letzter Screenshot

So sieht Avalet grade aus.

![letzter Screenshot](latest_screenshot.png)

## Was Avalet sein soll

Avalet ist für Mudlet-Benutzer gedacht, die sich nicht selbst in die Programmierung so einer Oberfläche einarbeiten, aber trotzdem ein bisschen mehr Komfort wollen.

Außerdem bietet Avalet die Möglichkeit, eigene Erweiterungen mit einzubinden. Also mit Menüpunkt in der Oberfläche, Karteikartenreiter etc.

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |  "Mit Avalet haette ich es in 30 Tagen geschafft!"    |_
            |                         Phileas Fogg ueber Avalet     | |
            \_______________________________________________________\_/

```

## Was Avalet NICHT sein soll

Avalet ist kein Ersatz für das Soundpack oder für die Arbeit von Ban. Wenn du eine Sprachausgabe benutzt, dann ist dir mit diesen beiden Werkzeugen (und mit MUSHclient) derzeit sicher besser geholfen.

Avalet ist auch nicht gedacht, um mühsam erworbenes "Geheim"-Wissen unter das Avalon-Volk zu bringen oder um meine Script-Sammlung zu teilen. Irgendwelche Geheimnisse werden hier nicht aufgedeckt. (Aber es gibt ja die Möglichkeit, Sub-Module hinzuzufügen. Wenn du also *deine* Script-Sammlung gern mit *mir* teilen möchtest - *email me*! :) )

## Installation

Das eigentliche Modul besteht aus der Datei Avalet.mpackage. Die speicherst du bei dir irgendwo ab.

Dann legst du dir am besten ein sauberes (also neues) Profil in Mudlet an. Und *entfernst* als erstes in den `Preferences` auf dem Reiter `General` und in der Rubrik `Game protocols` den Haken bei `Enable GMCP`. Ava*lon* sendet per ATCP stattdessen, und mit eingeschaltetem GMCP funktioniert Ava*let* nicht.

Anschließend importierst du dann mit dem **Modul-Manager** das vorhin gespeicherte Modul (Avalet.mpackage) in dein Profil. 

Danach sollte alles funktionieren.

Für eine **Aktualisierung** einfach die neuere Version downloaden und die alte damit überschreiben. Anschließend Mudlet neu starten.

(Die Datei Avalet.zip ist - abgesehen vom Namen - identisch mit der .mpackage-Datei, die kannst du also auch nehmen. Aber .mpackage ist der Standard.)

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |     "Suuuuperschnelle Lieferung! Dafuer gibt es       |
            |      ein extra <3 von mir!"                           |_
            |                         Lorielle ueber Avalet         | |
            \_______________________________________________________\_/

```
## Mitmachen?

Wenn du Lust hast, in dieses Projekt auch ein bisschen Zeit zu investieren, freue ich mich natürlich. Ich würde mich zum Beispiel über Bug-Hinweise und Feature-Vorschläge freuen! Du kannst auch die Werkzeuge verwenden, die Github so bereit stellt. Also einen Patch einreichen beispielsweise oder *Issues* melden oder so. Wenn Du mehr machen möchtest, kannst Du später auch *Collaborator* werden, aber im Moment gibt es dafür noch nicht die nötige Struktur.

**Besonders freuen würde ich mich aber über Mitarbeit in zwei Bereichen. Und zwar einmal im Bereich "Benutzbarkeit mit Screenreader" und besonders auch im Bereich "Design".** Darin bin ich nämlich absoluter Anfänger. Wenn du dich da einbringen willst, sprich mich bitte an und lass uns einen Weg finden.

Avalon ist im Moment als "Avalon-GUI für jedermensch" gedacht. Die Funktionalität soll entsprechend sein. Also: sinnvolle Unterstützung auch (und grade) für Anfänger. Aber kein *scripting* für Fortgeschrittene bitte. Wofür ihr das Plugin-System nutzt müsst ihr selber wissen.

**Beachte bitte, dass Avalet unter einer sehr freien Lizenz steht. Das würde Deinen Beitrag dann einschließen.**

Du kannst mich auch in Avalon kontaktieren, da heiße ich Rofhessa.

## Installation für Entwickler

Wenn du Code beisteuern möchtest, dann wäre im Moment das einfachste, wenn Du einfach bei dir im Mudlet entwickelst, den Code etc. in eine .xml-Datei exportierst und mir schickst. Und ich bau das dann ein. Bequemer für mich ist natürlich, wenn du dieses Projekt downloadest, die Ergänzungen direkt machst und es mir als *pull request* schickst. Da ich darauf verzichtet habe, im Mudlet-Editor selbst zu entwickeln, ist dieser Weg aber etwas komplizierter, als er sein müsste. Und zwar geht das so:

Du lädst das ganze Projekt in dein Arbeitsverzeichnis runter, und lädst die Avalet.zip-Datei als Modul in ein sauberes Mudlet-Profil. Das speicherst du dann. Wenn Du jetzt den Script-Editor von Mudlet öffnest, wirst du darin zwar das Modul sehen, aber nur sehr wenig Code. Denn Mudlet zeigt dir nur die "Avalet.xml" und die Trigger etc., die Avalet per Lua-Code erzeugt. Du kannst jetzt aber mit einem externen Editor die Dateien im Projekt bearbeiten. Wenn du das gemacht hast, packst du den Inhalt des Avale-Ordners in eine ZIP-Datei. Das machst du am besten so, dass die von dir als Modul geladene Datei Avalet.zip dabei überschrieben wird. Dann kannst du Mudlet einfach neu starten, das gespeicherte Profil laden und hast die Änderungen vor dir. (Das Modul wird bei jedem Neustart neu aus dem .zip- bzw. .mpackage-Archiv geladen.) Beim Erstellen der Zip-Datei hilft dir auch die Batch-Datei im Projekt - jedenfalls wenn du ein Windows-System hast.

Ich hoffe, dass ich noch Wege finde, das ein bisschen leichter zu machen. Aber jetzt läuft es erstmal so.

## Shownotes

Es gäbe Avalet nicht ohne Twrx! Und wenn ich hier immer nur "ich" schreibe, dann liegt das daran, dass er so schlau ist, mich die ganze Tipperei erledigen zu lassen. Aber er hat alle meine doofen Fragen beantwortet, Code-Beispiele geliefert, Ideen eingebracht und meinen zusammengestümperten Spagetti-Code mit eleganten Lösungen für all meine Probleme aufgewertet. Also egal, wie ihr Avalet findet - beschwert euch bei Twrx. ;)

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |   "Ich bin Groot!"                                    |_
            |                            Groot ueber Avalet         | |
            \_______________________________________________________\_/

```
