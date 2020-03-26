@echo off
del .\AvalonMaster.zip
del .\AvalonMaster.mpackage
.\7z.exe a -r .\AvalonMaster.zip .\AvalonMaster\* -x!makeModule.bat -x!7z.exe -x!.* -x!*_.lua -x!*o-matic*
copy .\AvalonMaster.zip AvalonMaster.mpackage
exit;
