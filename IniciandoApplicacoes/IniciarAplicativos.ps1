# Tentativa ignorar as politicas locais
#Set-ExecutionPolicy RemoteSigned
set-executionpolicy -scope CurrentUser -executionPolicy Undefined

# Importando módulos para ter acesso ao recursos do IIS
Import-Module WebAdministration;

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

# Abrir sistemas mais utilizados :

# Open Microsoft DotNet IDE
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe")

# Open SQL Management
[Diagnostics.Process]::Start("C:\Program Files (x86)\Microsoft SQL Server\100\Tools\Binn\VSShell\Common7\IDE\Ssms.exe")

# Open Google Browser
[Diagnostics.Process]::Start("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")

#start-process myfile.txt -workingdirectory "C:\PS-Test" -verb Print


# TODO: Open endereços internos mais utilizados
# Agora executa um teste no site
#$ie=New-Object -com internetexplorer.application;
#$ie.visible=$true;
#$ie.Navigate("http://localhost:$appPort/");


# Run default e-mail application
[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office 15\root\office15\OUTLOOK.EXE")

# Runs Sublime Teste using the Static Start method and opens a Apol folder
[Diagnostics.Process]::Start("C:\Program Files\Sublime Text 2\sublime_text.exe","N:\Apol")

# Runs Sublime Teste using the Static Start method and opens a Apol folder
[Diagnostics.Process]::Start("C:\Program Files\Sublime Text 2\sublime_text.exe","N:\Webseek")

# TODO: Set Netuno:101 Apol on IE Browser, login and open reconnect.asp

# Ativar Application Launcher
#[Diagnostics.Process]::Start("D:\Ferramentas\Executor64bitTestBuild\Executor.exe")

# Run timesheet on Excel
[Diagnostics.Process]::Start("C:\Program Files\Microsoft Office 15\root\office15\EXCEL.EXE", "C:\Users\RLessa\Desktop\ponto201601.xlsx")

###############################################################################################
# SVN - checkout de todos os diretórios das aplicações

# Selecionar qual o diretório físico das aplicações

$physicalPath = "D:\Projetos_web\Copias_trabalho\";

# TODO: Alterar letra do drive ou caminho de instalacao do TortoiseSVN
$svnExePath = "C:\Program Files\TortoiseSVN\bin\SVN.exe";

# Verifica se o SVN client está instalado
if ((test-path "HKLM:\Software\TortoiseSVN") -eq $false) {
	Write-Host "";
	Write-Host -foregroundColor Red "Erro: O Tortoise, Cliente SVN, nÃ£o está instalado.";
	return;
}

#& $svnExePath checkout $svnBasePath$svnRepository$svnBranch$app $fullPhysicalPath$app;



Write-Host " ";
Write-Host " Fim do processo! ";


# TODO: Manter aberta a janela de script powerShell
# -noexit
#PAUSE