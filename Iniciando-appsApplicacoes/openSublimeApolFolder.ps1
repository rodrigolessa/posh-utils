Write-Host "Seja bem-vindo Rodrigo!"
Write-Host ""

Write-Host "Aguarde enquanto inicio suas aplicações..."

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

PAUSE