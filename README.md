# Avalet

> **Mit dem Update auf Version 0.9-beta hat sich äußerlich hoffentlich wenig verändert - unter der Oberfläche aber viel. Ich hab natürlich getestet und hoffe, dass ich keine weiteren Fehler eingebaut habe. Falls es aber doch Probleme gibt, schreib mir bitte. (Beispielsweise an Rofhessa in Avalon.) Und für alle Fälle gibt es [hier](https://github.com/MarcoSteffens/Avalet/releases/download/v0.8-beta/Avalet.mpackage) die letzte Version (0.8-beta) weiterhin zum Download.**

Avalet ist ein Mudlet-Module für das [MUD Avalon](https://avalon.mud.de/). Für ein bisschen (mehr) Farbe und ein bisschen Klicki-Bunti. 

Avalet bietet in erster Linie:
- Laufen mit dem [Ziffernblock](https://github.com/MarcoSteffens/Avalet/wiki/Tastaturbelegung-f%C3%BCr-den-Ziffernblock)!
- Einen nicht zu übersehenden Überblick über TP, ZP, AP und Mana!
- Eine Anzeige von Schildzaubern, Auren und anderen Timern! Mit *fancy* *Rückschritts*balken! ;)
- Eine Karte (und einen Mapper)! *(coming soon)*
- Viel mehr *bling-bling* als Plain-Avalon!
- Noch vieles mehr! *(coming soon)*
- Und noch mehr! *(coming soon)*

Eine Installationsanleitung findest du weiter unten auf dieser Seite.

Außerdem gibt es hier ein **MyAvalon**-Modul. Dieses Modul kannst Du benutzen, um eigene Trigger, Timer etc. in Mudlet zu bauen, und sie in verschiedenen Profilen, also mit verschiedenen Charakteren zu benutzen. Das Modul ist praktisch leer, aber wenn Du Dich nicht selber damit beschäftigen möchtest, dann nimmt es Dir die Arbeit ab, selber ein Modul zu erstellen. Wie Du das **MyAvalon**-Modul verwenden kannst, habe ich [hier im Wiki](https://github.com/MarcoSteffens/Avalet/wiki/Das-MyAvalon-Modul) etwas ausführlicher beschrieben.

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

So sieht Avalet grade aus:

![aktueller Screenshot](latest_screenshot.png)

## Was Avalet ist

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

## Was Avalet NICHT ist

Avalet ist kein Ersatz für das Soundpack oder für die Arbeit von Ban. Wenn du eine Sprachausgabe benutzt, dann ist dir mit diesen beiden Werkzeugen (und mit MUSHclient) derzeit sicher besser geholfen.

Avalet ist auch nicht gedacht, um mühsam erworbenes "Geheim"-Wissen unter das Avalon-Volk zu bringen oder um meine Script-Sammlung zu teilen. Irgendwelche Geheimnisse werden hier nicht aufgedeckt. (Aber es gibt ja die Möglichkeit, Sub-Module hinzuzufügen. Wenn du also *deine* Script-Sammlung gern mit *mir* teilen möchtest - *email me*! :) )

## Bekannte größere Einschränkungen von Avalet derzeit:

- Die Oberfläche skaliert nicht richtig, wenn man die Fenstergröße ändert. Umfangreicheres Problem - bis auf weiteres ist Avalet leider eine Vollbild-Anwendung.


## Installation

Das eigentliche Modul besteht aus der Datei Avalet.mpackage. Die speicherst du bei dir irgendwo ab.

Dann legst du dir am besten ein sauberes (also neues) Profil in Mudlet an. Und *entfernst* als erstes in den `Preferences` auf dem Reiter `General` und in der Rubrik `Game protocols` den Haken bei `Enable GMCP`. Ava*lon* sendet per ATCP stattdessen, und mit eingeschaltetem GMCP funktioniert Ava*let* nicht.

Anschließend importierst du dann mit dem **Modul-Manager** das vorhin gespeicherte Modul (`Avalet.mpackage`) in dein Profil. 

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

Ich freue mich über jede Form von Rückmeldung per "rede" oder Mudmail (Rofhessa), Mail (rofhessa@gmx-topmail.de), Brieftaube oder wie auch immer. Wenn du Lob loswerden willst, (konstruktive) Kritik, Hinweise, Ideen, Bugmeldungen, Featurewünsche oder wenn du einfach nur mal "Hallo" sagen willst, bin ich dein Mensch. Du kannst auch hier auf der Seite einen "*Issue*" eintragen, wenn du magst.

Wenn du Lust hast, dich direkt an diesem Projekt zu beteiligen, freue ich mich natürlich auch. Wenn du dir schon selber in Mudlet etwas gebaut hast, was dir in Avalet fehlt, dann könntest du es einfach in eine Kopie des ```MyAvalon```-Moduls einbauen und mir schicken. Wenn du kannst, kannst du auch die Funktionen von Github benutzen und einen *pull request* schicken. Später kannst du vielleicht auch *Collaborator* werden, aber im Moment gibt es dafür noch nicht die nötige Struktur.

**Besonders freuen würde ich mich über Unterstützung beim Design.** Das ist etwas, was ich praktisch überhaupt nicht kann. Wenn du dich da einbringen willst, sprich mich bitte an und lass uns einen Weg finden.

**Beachte bitte, dass Avalet unter einer sehr freien Lizenz steht. Das würde Deinen Beitrag dann einschließen.**

Avalon ist im Moment als "Avalon-GUI für jedermensch" gedacht. Die Funktionalität soll entsprechend sein. Also: sinnvolle Unterstützung auch (und grade) für Anfänger. Aber kein *scripting* für Fortgeschrittene bitte. Wofür du das Plugin-System nutzt, musst du selber wissen.

```
            __________________________________________________________
           /                                                        / \
           |                                                        | |
           \________________________________________________________\_/
            |                                                       |
            |   "Wie konnte ich nur jemals ohne Timer spielen!?"    |_
            |                                Rofhessa ueber Avalet  | |
            \_______________________________________________________\_/

```
## Shownotes

Es gäbe Avalet nicht ohne Twrx! Und wenn ich hier immer nur "ich" schreibe, dann liegt das daran, dass er so schlau ist, mich die ganze Tipperei erledigen zu lassen. Aber er hat alle meine doofen Fragen beantwortet, Code-Beispiele geliefert und mich überhaupt erst dazu gebracht, dass ich mich mit Mudlet beschäftigt habe. Also: wenn ihr Avalet doof findet - beschwert euch bei Twrx. ;)

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
