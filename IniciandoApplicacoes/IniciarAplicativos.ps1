set-executionpolicy -scope CurrentUser -executionPolicy Undefined

Write-Host ""
Write-Host "MMMMMMMMMMMMMMMMMMMMM.                             MMMMMMMMMMMMMMMMMMMMM"
Write-Host " 'MMMMMMMMMMMMMMMMMMMM           M\  /M           MMMMMMMMMMMMMMMMMMMM'"
Write-Host "   'MMMMMMMMMMMMMMMMMMM          MMMMMM          MMMMMMMMMMMMMMMMMMM'"
Write-Host "     MMMMMMMMMMMMMMMMMMM-_______MMMMMMMM_______-MMMMMMMMMMMMMMMMMMM"
Write-Host "      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
Write-Host "      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
Write-Host "      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
Write-Host "     .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM."
Write-Host "    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
Write-Host "                   'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'"
Write-Host "                          'MMMMMMMMMMMMMMMMMM'"
Write-Host "                              'MMMMMMMMMM'"
Write-Host "                                 MMMMMM"
Write-Host "                                  MMMM"
Write-Host "                                   MM"
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

# Runs Sublime Teste using the Static Start method and opens a Apol folder
[Diagnostics.Process]::Start("C:\Program Files\Sublime Text 2\sublime_text.exe","N:\Apol")

# Open Microsoft DotNet IDE
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe")

# Open SQL Management
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft SQL Server\100\Tools\Binn\VSShell\Common7\IDE\Ssms.exe")

# Open Google Browser
[Diagnostics.Process]::Start("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")

# TODO: Open endereços internos mais utilizados

# Run default e-mail application
[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office 15\root\office15\OUTLOOK.EXE")

# Run timesheet on Excel
[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office 15\root\office15\EXCEL.EXE", "C:\Users\RLessa\Desktop\Controle201507.xlsx")

# TODO: Set Netuno:101 Apol on IE Browser, login and open reconnect.asp

# TODO: Manter aberta a janela de script powerShell

#"D:\Ferramentas\Executor64bitTestBuild\Executor.exe"

Write-Host ""

PAUSE