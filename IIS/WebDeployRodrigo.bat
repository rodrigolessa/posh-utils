REM msbuild LDSoft.Intranet.sln /p:DeployOnBuild=true /p:PublishProfile=Rodrigo
REM "C:\Program Files\IIS\Microsoft Web Deploy V3\msdeploy.exe" LDSoft.Intranet.sln /p:DeployOnBuild=true /p:PublishProfile=Rodrigo
"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" "C:\Projetos_web_teste\IntranetTrunk\LDSoft.Intranet\LDSoft.Intranet\LDSoft.Intranet.sln"
REM /p:Configuration=Debug
REM /p:DeployOnBuild=true /p:PublishProfile=Rodrigo
pause