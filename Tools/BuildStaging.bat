echo Should run the script as administrator (right click the file, execute 'Run as administrator')
cd D:\hudson\workspace\VRENT-MSBuild\AutoDeploy
D:
set currentPath=%cd%
cd C:\Windows\Microsoft.NET\Framework64\v4.0.30319
c:
Msbuild %currentPath%\VRentStaging.csproj
pause