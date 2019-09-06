@echo off

@set scriptPath=%~dp0%run_trx_report.ps1
@set htmlReportPath=%~dp0%Reports\index.html

rem echo %htmlReportPath%
rem echo "& '%scriptPath%'"

PowerShell -NoProfile -ExecutionPolicy Bypass -noexit -Command "& '%scriptPath%'"

rem START htmlReportPath

rem @PAUSE