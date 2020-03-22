@echo off
del .\AvalonMaster.zip
del .\AvalonMaster.mpackage
REM "C:\Program Files\7-Zip\7z.exe" a -r AvalonMaster.zip * -x!*.bat -x!*.exe
.\7z.exe a -r .\AvalonMaster.zip .\AvalonMaster\* -x!makeModule.bat -x!7z.exe -x!.*
copy .\AvalonMaster.zip AvalonMaster.mpackage
REM ren .\AvalonMaster.zip AvalonMaster.mpackage
exit;

REM C:\Program Files\7-Zip