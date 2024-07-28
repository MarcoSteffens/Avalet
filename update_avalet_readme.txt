Die Versionsnummer von Avalet, die beim Start eines Profils in Mudlet angezeigt wird, wird durch Git hochgezählt. Und zwar immer bei einem commit. 

Verwendet wird diese Versionsnummer aber, wenn mit Hilfe der Batch-Datei neue Archive erzeugt werden. (also zip und mpackage)

Daraus ergibt sich das Problem, dass nach dem Commit erst die neuen Archive erzeugt werden können. Die dann aber nicht im Commit sind. Vor dem push müssen diese neuen Archive dann also noch durch ein weiteres commit hinzugefügt werden.




Die richtigen Schritte sind also:

git status

um zu gucken was sich überhaupt gehändert hat.

git add *

um alle anstehenden Änderungen in die Quellcodeverwaltung zu übernehmen

git commit -m "Kurze Beschreibung der letzten Änderungen"

um einen Erklär-Text zu den aktuellen Änderungen hinzuzufügen, der dann auch auf Git angezeigt wird.

Jetzt die Batch-Datei ausführen und damit die Versions-Nummer aktualisieren und die Archiv-Dateien erzeugen.

dann nochmal

git add *

um die geänderten Dateien hinzuzufügen, und auch wieder

git commit -m "

git push origin DEV

git push https://MarcoSteffens@github.com/MarcoSteffens/Avalet.git/

damit die aktuellen Änderungen hochgeladen werden. (Das funktioniert natürlich nur, wenn man dann auch mein Passwort kennt.)

Dann muss auf Git selbst noch die Differenz vom DEV-Branch zum Master-Branch in den Master-Branch übertragen werden.

Dann muss der DEV-Branch gelöscht werden. Und anschließend neu erzeugt, und zwar als Kopie vom Master-Branch.

Und dann muss lokal wieder

git pull

ausgeführt werden, um den entfernten DEV-Branch und den lokalen DEV-Branch zu synchronisieren.