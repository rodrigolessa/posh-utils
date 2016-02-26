set-executionpolicy -scope CurrentUser -executionPolicy Undefined

Write-Host ""

Write-Host "Seja bem-vindo" -nonewline
Write-Host " Rodrigo " -foregroundcolor red -backgroundcolor yellow -nonewline
Write-Host "!"

Write-Host ""

Write-Host "Aguarde enquanto inicio suas aplicacoes..."

# TODO: Importar módulos
#Import-Module PsGet
#Import-Module PSReadLine
#Import-Module posh-git

# Referências para comandos do start-process
# https://technet.microsoft.com/en-us/library/hh849848.aspx
# http://ss64.com/ps/start-process.html

# Runs Sublime Teste using the Static Start method and opens a Apol folder
[Diagnostics.Process]::Start("C:\Program Files\Sublime Text 2\sublime_text.exe","N:\Apol")

# Open Microsoft DotNet IDE
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe")

# Open SQL Management
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft SQL Server\100\Tools\Binn\VSShell\Common7\IDE\Ssms.exe")

# Open Google Browser
[Diagnostics.Process]::Start("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")

#start-process myfile.txt -workingdirectory "C:\PS-Test" -verb Print

# TODO: Open endereços internos mais utilizados

# Run default e-mail application
[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office 15\root\office15\OUTLOOK.EXE")

# TODO: Set Netuno:101 Apol on IE Browser, login and open reconnect.asp

# Ativar Application Launcher
[Diagnostics.Process]::Start("D:\Ferramentas\Executor64bitTestBuild\Executor.exe")

# Run timesheet on Excel
[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office 15\root\office15\EXCEL.EXE", "C:\Users\RLessa\Desktop\Controle2015v2.xlsx")

Write-Host ""

# TODO: Manter aberta a janela de script powerShell
# -noexit
#PAUSE