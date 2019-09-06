# Tentativa ignorar as politicas locais
#Set-ExecutionPolicy RemoteSigned
set-executionpolicy -scope CurrentUser -executionPolicy Undefined

# Importando mÃ³dulos para ter acesso ao recursos do IIS
#Import-Module WebAdministration;

Write-Host ""

# Write-Host " Rodrigo " -foregroundcolor red -backgroundcolor yellow -nonewline

Write-Host "Seja bem-vindo" -nonewline
Write-Host " Rodrigo" -foregroundcolor red -nonewline
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


###############################################################################################
# Abrir sistemas mais utilizados :

# Open Microsoft DotNet IDE
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe")

# Open SQL Management
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\Ssms.exe")

# Runs Sublime Teste using the Static Start method and opens a Apol folder
#[Diagnostics.Process]::Start("C:\Program Files\Sublime Text 3\sublime_text.exe","X:\Apol")

# Runs Sublime Teste using the Static Start method and opens a WEBSEEK folder
#[Diagnostics.Process]::Start("C:\Program Files\Sublime Text 3\sublime_text.exe","X:\Webseek")

# Open Google Browser
[Diagnostics.Process]::Start("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "https://ldsoftdesenv.visualstudio.com/")

# Open IceScrum
#[Diagnostics.Process]::Start("http://netuno:8080/icescrum/p/WSESTATIST#sprintPlan")

# Run default e-mail application
#[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE")

# Run default instant message application
#[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office\Root\Office16\lync.exe")

#start-process myfile.txt -workingdirectory "C:\PS-Test" -verb Print


###############################################################################################
# TODO: Open enderecos internos mais utilizados
# Agora executa um teste no site
#$ie=New-Object -com internetexplorer.application;
#$ie.visible=$true;
#$ie.Navigate("http://localhost:$appPort/");

# TODO: Set Netuno:101 Apol on IE Browser, login and open reconnect.asp

# Ativar Application Launcher
#[Diagnostics.Process]::Start("D:\Ferramentas\Executor64bitTestBuild\Executor.exe")

# Run timesheet on Excel
#[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office 15\root\office15\EXCEL.EXE", "C:\Users\RLessa\Desktop\ponto201601.xlsx")

# Pastas de trabalho
$startinfo = new-object System.Diagnostics.ProcessStartInfo 
$startinfo.FileName = "explorer.exe"
$startinfo.WorkingDirectory = 'X:\Apol'

[System.Diagnostics.Process]::Start($startinfo)


###############################################################################################
# Atalhos

Set-Alias sublime "C:\Program Files\Sublime Text 3\sublime_text.exe"

function go-projetos
{
	set-location X:\Apol
}


###############################################################################################
# SVN - checkout de todos os diretorios das aplicacoes

# Selecionar qual o diretorio fisico das aplicacoes

$physicalPath = "D:\Projetos_web\Copias_trabalho\";

# TODO: Alterar letra do drive ou caminho de instalacao do TortoiseSVN
$svnExePath = "C:\Program Files\TortoiseSVN\bin\SVN.exe";

# Verifica se o SVN client estah instalado
if ((test-path "HKLM:\Software\TortoiseSVN") -eq $false) {
	Write-Host "";
	Write-Host -foregroundColor Red "Erro: O Tortoise, Cliente SVN, nao estah instalado.";
	return;
}


###############################################################################################
#& $svnExePath checkout $svnBasePath$svnRepository$svnBranch$app $fullPhysicalPath$app;

Write-Host " ";
Write-Host " Fim do processo! ";

go-projetos

# TODO: Manter aberta a janela de script powerShell
# -noexit
#PAUSE