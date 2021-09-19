# Avalet

> Derzeit hab ich weder Interesse an Avalon noch an Avalet. Gut vorbereitete *pull requests* bearbeite ich aber durchaus noch. 

Avalet ist ein Module für den Mud-Client [Mudlet](https://www.mudlet.org/) und das [MUD Avalon](https://avalon.mud.de/). Für ein bisschen mehr Farbe, ein bisschen mehr Übersicht und ein bisschen mehr Klicki-Bunti.

![aktueller Screenshot](latest_screenshot.png) 

Avalet bietet in erster Linie:
- Laufen mit dem Ziffernblock! ([Tastaturbelegung](https://github.com/MarcoSteffens/Avalet/wiki/Tastaturbelegung-f%C3%BCr-den-Ziffernblock))
  - Automatisches klettern und schwimmen!
  - Und "spaehen" mit dem Fernrohr durch gleichzeitiges drücken von 'STRG' und der entsprechenden Richtungstaste! (Fernrohr muss natürlich im Invenar sein.)
- Einen nicht zu übersehende Anzeige von TP, AP, ZP und Mana!
- Eine Anzeige von Schildzaubern, Auren und anderen Timern! Mit *fancy* *Rückschritts*balken! ;)
- Eine übersichtliche Anzeige der wesentlichen Kommunikationskanäle!
- Eine dauerhafte Anzeige einiger wichtiger (und einiger nicht so wichtiger) Charakter-Informationen!
- Anzeigen bzw. Zähler für EP, Session-EP, Bonusstunden-EP!
- Eine temporäre Anzeige von Informationen wie dem Spielstand, dem Inventar und den Gruppeninformationen!
- Eine schicke Darstellung von "ruebersicht" der Runenschmiede!
- Eine Ausleitung der Ingame-Karte!
- Eine Uhr und einen Kalender!
- Viel mehr *bling-bling* als Plain-Avalon!
- Noch viel mehr mehr! *(coming soon)*
- Und noch mehr! *(coming soon)*

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |  "Wenn so heisser Scheiss jetzt schon verschenkt      |
            |   wird, kann ich den Laden ja bald zumachen!"         |_
            |                               Zwoniman ueber Avalet   | |
            \_______________________________________________________\_/

```

>### Zum selber machen: MyAvalon, das DIY-Modul
>
>Du hast schon entdeckt, dass viele Aufgaben in Avalon sich durch Trigger sehr erleichtern lassen? Du hast schon ein paar Alias definiert und vielleicht sogar die ersten kleinen Skripte geschrieben? Du möchtest all dies auch bei deinen Zweities verwenden, und nicht jedesmal neu anlegen müssen? Und vor allem: Du möchtest gern zu Avalet wechseln, aber Deine ganzen Trigger, Timer etc. mitnehmen?
>
>Dann gibt es hier das **MyAvalon**-Modul für Dich! Dieses Modul kannst Du benutzen, um eigene Trigger, Timer etc. in Mudlet zu bauen (oder sie einfach per Drag&Drop hineinziehen). Anschließend kannst Du sie in verschiedenen Profilen (also mit verschiedenen Charakteren) benutzen. Das Modul ist praktisch leer, aber wenn Du Dich nicht selber damit beschäftigen möchtest, dann nimmt es Dir die Arbeit ab, selber so ein Modul zu erstellen. Wie Du das **MyAvalon**-Modul verwenden kannst, habe ich [hier im Wiki](https://github.com/MarcoSteffens/Avalet/wiki/Das-MyAvalon-Modul) etwas ausführlicher beschrieben.

## Was Avalet ist

Avalet ist für Mudlet-Benutzer gedacht, die sich nicht selbst in die Programmierung so einer Oberfläche einarbeiten, aber trotzdem ein bisschen mehr Komfort wollen.

## Was Avalet NICHT ist

Avalet ist kein Ersatz für [das Soundpack](http://www.avalon-soundpack.de) oder für die Arbeit von Ban. Wenn du eine Sprachausgabe benutzt, dann ist dir mit diesen beiden Werkzeugen (und mit MUSHclient) derzeit sicher besser geholfen.

Avalet ist auch nicht gedacht, um mühsam erworbenes "Geheim"-Wissen unter das Avalon-Volk zu bringen oder um meine Script-Sammlung zu teilen. Irgendwelche Geheimnisse werden hier nicht aufgedeckt.

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |  "Mit Avalet haette ich es in 30 Tagen geschafft!"    |_
            |                           Phileas Fogg ueber Avalet   | |
            \_______________________________________________________\_/

```
## Bekannte größere Einschränkungen von Avalet derzeit:

- Die Oberfläche skaliert nicht richtig, wenn man die Fenstergröße ändert. Umfangreicheres Problem - bis auf weiteres ist Avalet leider eine Vollbild-Anwendung.

## Installation

Das eigentliche Modul besteht aus der Datei `Avalet.mpackage`. Die speicherst du bei dir irgendwo ab.

Dann legst du dir am besten ein sauberes (also neues) Profil in Mudlet an. Und *entfernst* als erstes in den `Preferences` auf dem Reiter `General` und in der Rubrik `Game protocols` den Haken bei `Enable GMCP`. Ava*lon* sendet per ATCP statt per GMCP, und mit eingeschaltetem GMCP funktioniert Ava*let* nicht.

Anschließend importierst du dann mit dem **Modul-Manager** das vorhin gespeicherte Modul (`Avalet.mpackage`) in dein Profil. Avalet funktioniert nur als Modul, nicht als Paket!

Danach sollte alles funktionieren.

(Die Datei Avalet.zip ist - abgesehen vom Namen - identisch mit der .mpackage-Datei, die kannst du also auch nehmen. Aber .mpackage ist der Standard.)

## Update

Für eine **Aktualisierung** einfach die neuere Version der Datei `Avalet.mpackage` (oder `Avalet.zip`) downloaden und die alte damit überschreiben. **Anschließend Mudlet neu starten.**

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |     "Suuuuperschnelle Lieferung! Dafuer gibt es       |
            |      ein extra <3 von mir!"                           |_
            |                               Lorielle ueber Avalet   | |
            \_______________________________________________________\_/

```

### Bekannte Fehlerquellen bei der Installation

- Avalet MUSS als MODUL mit dem MODUL-Manager installiert sein. NICHT als Paket mit dem Paket-Manager.
- Im Modul-Manager auf KEINEN Fall das Häkchen bei "Synchronisieren" setzen! Praktisch alles kann dann passieren.
- Nach der Installation AUSLOGGEN mit "schlafe ein" oder "einschlafen", außerdem Mudlet einmal richtig SCHLIESSEN und NEU STARTEN.
- Das Häkchen bei "Enable GMCP" ENTFERNEN. ("Settings", Tab "General", Abschnitt "Game protocols")

Alles gemacht? Alles nochmal überprüft? Trotzdem ein Problem? Sprich mich an! Am besten in Avalon, aber per Mail geht auch.

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |   "Wie konnte ich nur jemals ohne Timer spielen?!"    |_
            |                               Rofhessa ueber Avalet   | |
            \_______________________________________________________\_/

```

## Mitmachen?

Wenn du Lust hast, dich direkt an diesem Projekt zu beteiligen, gibt es da verschiedene Möglichkeiten. Am einfachsten geht das wohl per *pull request*, jedenfalls bei kleineren Beiträgen. Wenn du dir einen umfangreicheren Beitrag vorstellst, dann meldest du dich am besten und wir besprechen, wie das gehen kann. Du kannst mich zum Beispiel per Email erreichen (rofhessa@gmx-topmail.de).

**Beachte bitte, dass Avalet unter einer sehr freien Lizenz steht. Das würde Deinen Beitrag dann einschließen.**

Avalet ist als "Avalon-GUI für jedermensch" gedacht. Die Funktionalität soll entsprechend sein. Also: sinnvolle Unterstützung auch (und grade) für Anfänger. Aber keine Automation für Fortgeschrittene bitte.

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |   "Ich bin Groot!"                                    |_
            |                                  Groot ueber Avalet   | |
            \_______________________________________________________\_/

```
