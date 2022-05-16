@echo off
del .\Avalet.zip
del .\Avalet.mpackage
REM git describe master --tags > Avalet/version && date /t >> Avalet/version
git describe DEV --tags > Avalet/version && date /t >> Avalet/version
.\7z.exe a -r .\Avalet.zip .\Avalet\* -x!makeModule.bat -x!7z.exe -x!.* -x!*_.lua -x!*o-matic* -x!AvaletDebugModule -x!AvalonUI -x!Test -x!imgs_unbenutzt
copy .\Avalet.zip Avalet.mpackage
exit;
