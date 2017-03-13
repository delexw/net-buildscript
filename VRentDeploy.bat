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
@rem take the web site offline prior to deployment new content
msdeploy.exe -verb:sync -source:recycleApp -dest:recycleApp=%1,recycleMode="UnloadAppDomain",computerName=%2,userName=%3,password=%4