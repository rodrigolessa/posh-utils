# Tentativa ignorar as políticas locais
#Set-ExecutionPolicy RemoteSigned
Set-executionpolicy -scope CurrentUser -executionPolicy Undefined

# Importando módulos para ter acesso ao recursos do IIS
Import-Module WebAdministration;


Write-Host "";
Write-Host "Seja bem-vindo" -nonewline;
Write-Host " Rodrigo " -foregroundcolor red -nonewline;
Write-Host "!";


###############################################################################################
# Selecionar qual o diretório físico das aplicações

# TODO: Change drive letter
$physicalPath = "C:\Projetos_web\Copias_trabalho\";

Write-Host "";

$useDefaultPhysicalPath = Read-Host "Usar o DIRETORIO padrao? ($physicalPath) [S] Sim ou [N] Nao";

if(!($useDefaultPhysicalPath.ToString().ToLower() -eq "sim" -or $useDefaultPhysicalPath.ToString().ToLower() -eq "s"))
{
	Write-Host "";
	$physicalPath = Read-Host "Informe o diretorio fisico que gostaria de criar a aplicacao";
}

Write-Host "";

$userName = Read-Host "Informe o nome do USUARIO:";

$fullPhysicalPath = "$physicalPath$userName\";

# Se NÃO existir cria a raiz do diretório físico
if((Test-Path $fullPhysicalPath) -eq 0)
{
	New-Item -ItemType directory -Path $fullPhysicalPath;
}


###############################################################################################
# Selecionar qual o diretório virtual no IIS

Write-Host "";

# Verifica se é Developer ou Tester
$userType = Read-Host "Qual o TIPO do usuario? [D] Desenvolvedor ou [T] Tester";

if(!($userType.ToString().ToLower() -eq "d"))
{
	$siteName = "Test_$userName";
} else {
	$siteName = "Dev_$userName";
}

#$appPath = "IIS:\Sites\Default Web Site\";
$appPath = "IIS:\Sites\$siteName\";

Write-Host "";

$appPort = Read-Host "Informe uma PORTA para o site do usuario";

# Criando novo SITE com o nome do usuário
if((Test-Path $appPath) -eq 0)
{
	New-WebSite -Name $siteName -Port $appPort -HostHeader $siteName -PhysicalPath $fullPhysicalPath;
}

# Aplicações e versões em Urano (SVN)
#Apol 			- http://urano:405/svn/Apol/trunk/Apol
#Apolcli		- http://urano:405/svn/Apol/trunk/apolcli
#WebServices 	- http://urano:405/svn/Apol/trunk/WebServices
#Estatisticas	- ? (criar script para build)
#Intranet		- ? (criar script para build)
#Portal_webseek - http://urano:405/svn/Intranet/trunk/Portal_webseek
#Siteld 		- http://urano:405/svn/siteld/trunk/Siteld
#Webseek 		- http://urano:405/svn/siteld/trunk/webseek
#WSeekJuris 	- http://urano:405/svn/siteld/trunk/WSeekJuris


###############################################################################################
# Criando aplicações no Servidor IIS de Netuno

# Definindo lista de aplicações
# * - Cria o site com redundância
# @ - Cria o site com pool próprio com dotNet 4.0
# ! - Converte somente para aplicação o subsite do site anterior
# | - Converte para aplicação com o endereço do site anterior
$apps = "Apol*", "!ViewPDF", "!Utilitario", "|captcha", "Apolcli", "Estatisticas@", "Intranet@", "Portal_webseek", "Siteld", "Webseek*", "WebServices", "!wsCartas", "!wsProcessos", "WSeekJuris*";

# Cria um POOL com o nome do site/usuário
if((Test-Path IIS:\AppPools\$siteName) -eq 0)
{
	New-WebAppPool -Name $siteName -Force;
}

foreach ($appName in $apps)
{
	$carryOver = $appName -match "\*"

	# Removendo atributos das aplicações
	$appName = $appName -replace "*", "";
	$appName = $appName -replace "@", "";
	$appName = $appName -replace "!", "";
	$appName = $appName -replace "|", "";

	# Se NÃO existir um Pool com o nome da aplicação, cria!, somente para aplicações .Net
	if((Test-Path IIS:\AppPools\$appName) -eq 0)
	{
	    New-WebAppPool -Name $appName -Force;
	}

	# Se NÃO existir cria o diretório físico e virtual, se existir o físico, converte para aplicação
	if((Test-Path $appPath$appName) -eq 0 -and (Get-WebApplication -Name $appName) -eq $null)
	{
	    New-Item -ItemType directory -Path $fullPhysicalPath$appName;
	    New-WebApplication -Name $appName -ApplicationPool $siteName -Site $siteName -PhysicalPath $fullPhysicalPath$appName;
	}
	elseif((Get-WebApplication -Name $appName) -eq $null -and (Test-Path $appPath$appName) -eq $true)
	{
	    ConvertTo-WebApplication -ApplicationPool $siteName $appPath$appName;
	}
	else
	{
	    echo "$appName já existe!";
	}

	# Cria redundância para os sites SELECIONADOS
	if($carryOver -eq $true)
	{
		for ($i=1; $i -le 10; $i++)
		{
			if((Test-Path $appPath$appName$i) -eq 0 -and (Get-WebApplication -Name $appName$i) -eq $null)
			{
			    New-WebApplication -Name $appName$i -ApplicationPool $siteName -Site $siteName -PhysicalPath $fullPhysicalPath$appName;
			}
		}
	}
}

# Desconsiderar testes
#New-WebApplication "TesteWebApp" -Site "Dev_rodrigo" -ApplicationPool "Temp" -PhysicalPath "D:\Projetos_web\Copias_trabalho\Rodrigo\Temp"
#New-WebApplication "TesteWebApp" -Site "Default Web Site" -ApplicationPool "RodrigoLessa" -PhysicalPath "C:\Temp\TesteWebApp"

# Agora executa um teste no site
#$ie=New-Object -com internetexplorer.application;
#$ie.visible = $true;
#$ie.Navigate(“http://localhost:$appPort/”);

Write-Host " Fim do processo! " -nonewline;