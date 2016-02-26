# Tentativa ignorar as políticas locais
#Set-ExecutionPolicy RemoteSigned
Set-executionpolicy -scope CurrentUser -executionPolicy Undefined

# Importando módulos para ter acesso ao recursos do IIS
Import-Module WebAdministration

Write-Host ""
Write-Host "Seja bem-vindo" -nonewline
Write-Host " Rodrigo " -foregroundcolor red -nonewline
Write-Host "!"

###############################################################################################
# Selecionar qual o diretório físico das aplicações

#$physicalPath = "D:\Projetos_web\Copias_trabalho\";
$physicalPath = "C:\Temp\";

$useDefaultPhysicalPath = Read-Host "Usar o diretorio padrao? ($physicalPath) [S] Sim ou [N] Nao";

if(!($useDefaultPhysicalPath.ToString().ToLower() -eq "sim" -or $useDefaultPhysicalPath.ToString().ToLower() -eq "s"))
{
   $physicalPath = Read-Host "Informe o diretorio fisico que gostaria de criar a aplicacao";
}

$userName = Read-Host "Informe o nome do Usuario";

$fullPhysicalPath = "$physicalPath$userName\"

# Se não existir cria a raiz do diretório físico
if((Test-Path $fullPhysicalPath) -eq 0)
{
	New-Item -ItemType directory -Path $fullPhysicalPath;
}

###############################################################################################
# Selecionar qual o diretório virtual no IIS

#$siteName = Read-Host "Informe o web site que deseja criar as aplicacoes";

# Verifica se é Developer ou Tester
$userType = Read-Host "Qual o tipo do usuario? [D] Desenvolvedor ou [T] Tester";

if($userType.ToString().ToLower() eq "d")
{
   $siteName = "Dev_$userName";
} else {
	$siteName = "Test_$userName";
}

#$appPath = "IIS:\Sites\Default Web Site\";
$appPath = "IIS:\Sites\$siteName\";

IIS:\>New-WebSite -Name TestSite -Port 80 -HostHeader TestSite -PhysicalPath "$env:systemdrive\inetpub\testsite"

# Criando lista de aplicações
#$apps = New-Object System.Collections.ArrayList
#$apps.AddRange("Apol", "Apolcli", "Estatisticas", "Intranet", "Portal_webseek", "Siteld", "Webseek", "WebServices", "WSeekJuris")
$apps = "Apol", "Apolcli", "Estatisticas", "Intranet", "Portal_webseek", "Siteld", "Webseek", "WebServices", "WSeekJuris"

# Aplicações e versões em Urano (SVN)
#Apol - http://urano:405/svn/Apol/trunk/Apol
#Apolcli - http://urano:405/svn/apol/trunk/apolcli
#Estatisticas - ? (criar script para build)
#Intranet - ? (criar script para build)
#Portal_webseek - http://urano:405/svn/Intranet/trunk/Portal_webseek
#Siteld - http://urano:405/svn/siteld/trunk/Siteld
#Webseek - http://urano:405/svn/siteld/trunk/webseek
#WebServices - http://urano:405/svn/Apol/trunk/WebServices
#WSeekJuris - http://urano:405/svn/siteld/trunk/WSeekJuris

###############################################################################################
# Criando aplicações no Servidor

foreach ($appName in $apps)
{
	# Se não existir um Pool com o nome da aplicação, cria!
	if((Test-Path IIS:\AppPools\$appName) -eq 0)
	{
	    New-WebAppPool -Name $appName -Force;
	}

	# Se não existir cria o diretório físico e virtual, se existir o físico, converte para aplicação
	if((Test-Path $appPath$appName) -eq 0 -and (Get-WebApplication -Name $appName) -eq $null)
	{
	    New-Item -ItemType directory -Path $fullPhysicalPath$appName;
	    New-WebApplication -Name $appName -ApplicationPool $appName -Site $siteName -PhysicalPath $fullPhysicalPath$appName;
	}
	elseif((Get-WebApplication -Name $appName) -eq $null -and (Test-Path $appPath$appName) -eq $true)
	{
	    ConvertTo-WebApplication -ApplicationPool $appName $appPath$appName;
	}
	else
	{
	    echo "$appName já existe!";
	}
}

# Desconsiderar testes
#New-WebApplication "TesteWebApp" -Site "Dev_rodrigo" -ApplicationPool "Temp" -PhysicalPath "D:\Projetos_web\Copias_trabalho\Rodrigo\Temp"
#New-WebApplication "TesteWebApp" -Site "Default Web Site" -ApplicationPool "RodrigoLessa" -PhysicalPath "C:\Temp\TesteWebApp"

# Agora executa um teste no site
#$ie=New-Object -com internetexplorer.application
#$ie.visible = $true
#$ie.Navigate(“http://localhost:80/”)

Write-Host " Fim do processo! " -nonewline