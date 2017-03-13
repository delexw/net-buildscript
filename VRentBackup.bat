@rem if user does not set MsDeployPath environment variable, we will try to retrieve it from registry.
if "%MSDeployPath%" == "" (
for /F "usebackq tokens=1,2,*" %%h  in (`reg query "HKLM\SOFTWARE\Microsoft\IIS Extensions\MSDeploy" /s  ^| findstr -i "InstallPath"`) do (
if /I "%%h" == "InstallPath" ( 
if /I "%%i" == "REG_SZ" ( 
if not "%%j" == "" ( 
if "%%~dpj" == "%%j" ( 
set MSDeployPath=%%j
))))))

cd /D %MSDeployPath%
@rem try to create an app if no app is under website, the physical folder will not be crearted for the app 
msdeploy -verb:sync -source:createapp=%1 -dest:auto,computerName=%3,userName=%4,password=%5
@rem archive the webapp in iis to the destination folder
msdeploy -verb:sync -source:apphostconfig=%1,computerName=%3,userName=%4,password=%5 -dest:package=%2