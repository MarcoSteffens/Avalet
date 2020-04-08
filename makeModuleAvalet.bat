@echo off
del .\Avalet.zip
del .\Avalet.mpackage
.\7z.exe a -r .\Avalet.zip .\Avalet\* -x!makeModule.bat -x!7z.exe -x!.* -x!*_.lua -x!*o-matic* -x!AvaletDebugModule
copy .\Avalet.zip Avalet.mpackage
exit;
