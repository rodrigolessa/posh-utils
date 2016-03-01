# Tentativa ignorar as políticas locais
#Set-ExecutionPolicy RemoteSigned
Set-executionpolicy -scope CurrentUser -executionPolicy Undefined

# Instala��o do Web Deploy, forma de publicar um projeto .Net
# http://www.iis.net/downloads/microsoft/web-deploy

# Importando m�dulos para ter acesso ao recursos do IIS
Import-Module WebAdministration;


Write-Host "";
Write-Host "Seja bem-vindo" -nonewline;
Write-Host " Rodrigo " -foregroundcolor red -nonewline;
Write-Host "!";


###############################################################################################
# Selecionar qual o diret�rio f�sico das aplica��es

# TODO: Change drive letter - WorkingCopy
$physicalPath = "D:\Projetos_web\Copias_trabalho\";

Write-Host "";

$useDefaultPhysicalPath = Read-Host "Usar o DIRET�RIO padr�o? ($physicalPath) [S] Sim ou [N] N�o";

if(!($useDefaultPhysicalPath.ToString().ToLower() -eq "sim" -or $useDefaultPhysicalPath.ToString().ToLower() -eq "s"))
{
	Write-Host "";
	$physicalPath = Read-Host "Informe o diret�rio f�sico que gostaria de criar a aplica��o";
}

Write-Host "";

$userName = Read-Host "Informe o nome do USU�RIO";

$separadorFisico = "\";
$fullPhysicalPath = "$physicalPath$userName\";

Write-Host "";
Write-Host "Endere�o f�sico do projeto [$fullPhysicalPath]";

# Se N�O existir cria a raiz do diret�rio f�sico
if((Test-Path $fullPhysicalPath) -eq 0)
{
	New-Item -ItemType directory -Path $fullPhysicalPath;
}


###############################################################################################
# SVN - checkout de todos os diret�rios das aplica��es

# Aplica��es e versões em Urano (SVN)
#Apol 			- http://urano:405/svn/Apol/trunk/Apol
#Apolcli		- http://urano:405/svn/Apol/trunk/apolcli
#WebServices 	- http://urano:405/svn/Apol/trunk/WebServices
#Estatisticas	- ? (criar script para build) * siteld/trunk/LDSoft.Webseek
#Intranet		- ? (criar script para build) * Intranet/trunk/LDSoft.Intranet
#Portal_webseek - http://urano:405/svn/Intranet/trunk/Portal_webseek
#Siteld 		- http://urano:405/svn/siteld/trunk/Siteld
#Webseek 		- http://urano:405/svn/siteld/trunk/webseek
#WSeekJuris 	- http://urano:405/svn/siteld/trunk/WSeekJuris

# TODO: Alterar URL dos repositorios do SVN
$svnBasePath = "http://urano:405/svn/";
# TODO: Alterar letra do drive ou caminho de instala��o do TortoiseSVN
$svnExePath = "C:\Program Files\TortoiseSVN\bin\SVN.exe";

# Verifica se o SVN client est� instalado
if ((test-path "HKLM:\Software\TortoiseSVN") -eq $false) {
	Write-Host "";
	Write-Host -foregroundColor Red "Erro: O Tortoise, Cliente SVN, não est� instalado.";
	return;
}

# TODO: Verificar caso de todos os endere�os, o SVN � case sensitive
$appsApol 		= "Apol", "Apolcli", "WebServices";
$appsIntranet 	= "Portal_webseek", "LDSoft.Intranet";
$appsSiteld 	= "Siteld", "webseek", "WSeekJuris";	#, "LDSoft.Webseek";

$svnRepository = "Apol/"
$svnBranch = "trunk/";

# Checkout Apol
foreach ($app in $appsApol)
{
	# Comando para download do Trunk das aplica��es para a c�pia de trabalho
	#& $SVNExe checkout -r 23 $SVNURL $CheckOutLocation
	& $svnExePath checkout $svnBasePath$svnRepository$svnBranch$app $fullPhysicalPath$app;
}

$svnRepository = "Intranet/"

# Checkout Intranet
foreach ($app in $appsIntranet)
{
	& $svnExePath checkout $svnBasePath$svnRepository$svnBranch$app $fullPhysicalPath$app;
}

$svnRepository = "siteld/"

# Checkout SiteLD
foreach ($app in $appsSiteld)
{
	& $svnExePath checkout $svnBasePath$svnRepository$svnBranch$app $fullPhysicalPath$app;
}

Write-Host "";

# Pausa para download do c�digo fonte das aplica��es
$endCheckout = Read-Host "Continue quando o checkout das aplicacoes terminar! [Enter] Para prosseguir";


###############################################################################################
# TODO: Executar scripts de deploy para sites dotNet
#if((Test-Path $fullPhysicalPath) -eq 0)

Write-Host "";

# TODO: Pause para publica��o de sites
$endCheckout = Read-Host "Continue quando a publicacao dos sites estiver concluida! [Enter] Para prosseguir";


###############################################################################################
# Selecionar qual o diret�rio virtual no IIS

Write-Host "";

# Verifica se � Developer ou Tester
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

# Criando novo SITE com o nome do usu�rio
if((Test-Path $appPath) -eq 0)
{
	#New-WebSite -Name $siteName -Port $appPort -HostHeader $siteName -PhysicalPath $fullPhysicalPath;
    New-WebSite -Name $siteName -Port $appPort -PhysicalPath $fullPhysicalPath;
}


###############################################################################################
# Criando aplica��es no Servidor IIS de Netuno

# Atributos das aplica��es
# * - Cria o site com redund�ncia
# @ - Cria o site com pool pr�prio com dotNet 4.0
# ! - Converte somente para aplica��o o subsite do site anterior
# | - Converte para aplica��o com o endere�o do site anterior

# Definindo lista de aplica��es #$apps = "Apol*", "ViewPDF!", "Utilitario!", "captcha|", "Apolcli", "Estatisticas@", "Intranet@", "Portal_webseek", "Siteld", "Webseek*", "WebServices@", "wsCartas@!", "wsProcessos@!", "WSeekJuris*";
$apps = "Apol*", "Apolcli", "Estatisticas@", "Intranet@", "Portal_webseek", "Siteld", "Webseek*", "WebServices@", "WSeekJuris*";

# Cria um POOL com o nome do site/usu�rio, na vers�o 2.0 do framework dotNet
if((Test-Path IIS:\AppPools\$siteName) -eq 0)
{
	New-WebAppPool -Name $siteName -Force;
	Set-ItemProperty IIS:\AppPools\$siteName managedRuntimeVersion v2.0;
}

# TODO: Trocar o pool do site pelo novo criado

# TODO: Executar o comando migrate para corrigir aplica��o do IIS6 para IIS7 (afeta todos os arquivos de configura��o)
#appcmd migrate config "$siteName/"
#%systemroot%\system32\inetsrv\appcmd.exe migrate config "$siteName/"

foreach ($appName in $apps)
{
	Write-Host " ";

	# Identificando atributos das aplica��es
	$carryOver = $appName -match "\*";
	$selfPool = $appName -match "@";

	# Removendo atributos das aplica��es
	$appName = $appName -replace "\*", "";
	$appName = $appName -replace "@", "";
	$appName = $appName -replace "!", "";
	$appName = $appName -replace "\|", "";

	# POOL
	$deadPool = $siteName;

	# Se N�O existir um Pool com o nome da aplica��o, cria!, somente para aplica��es .Net
	if((Test-Path IIS:\AppPools\$appName) -eq 0 -and $selfPool -eq $true)
	{
	    New-WebAppPool -Name $appName -Force;
	    Set-ItemProperty IIS:\AppPools\$appName managedRuntimeVersion v4.0;
	}

	if($selfPool -eq $true)
	{
		$deadPool = $appName;
	}

	# FOLDERS
	# Se N�O existir cria o diret�rio f�sico
	#if((Test-Path $fullPhysicalPath$appName) -eq 0)
	#{
	#	New-Item -ItemType directory -Path $fullPhysicalPath$appName;
	#}

	# APPLICATIONS
	# Se N�O existir cria o diret�rio f�sico e virtual, se existir o f�sico, converte para aplica��o
	if((Test-Path $appPath$appName) -eq 0 -and (Get-WebApplication -Name $appPath$appName) -eq $null)
	{
		# Cria o diret�rio f�sico, sem utilidade no momento
		New-Item -ItemType directory -Path $fullPhysicalPath$appName;
	    New-WebApplication -Name $appName -ApplicationPool $deadPool -Site $siteName -PhysicalPath $fullPhysicalPath$appName;
	}
	elseif((Get-WebApplication -Name $appPath$appName) -eq $null -and (Test-Path $appPath$appName) -eq $true)
	{
	    ConvertTo-WebApplication -ApplicationPool $deadPool $appPath$appName;
	}
	else
	{
	    Write-Host "$appName j� existe!" -foregroundcolor red;
	}

	# Cria REDUND�NCIA para os sites selecionados
	if($carryOver -eq $true)
	{
		for ($i=1; $i -le 10; $i++)
		{
			if((Test-Path $appPath$appName$i) -eq 0 -and (Get-WebApplication -Name $appPath$appName$i) -eq $null)
			{
			    New-WebApplication -Name $appName$i -ApplicationPool $deadPool -Site $siteName -PhysicalPath $fullPhysicalPath$appName;
			}
		}
	}
}


###############################################################################################
# Criando sub-dom�nios

# Cria uma aplica��o para o CAPTCHA no endere�o f�sico do Apol
$apolFolder = "Apol";
$captchaFolder = "captcha";
if((Test-Path $appPath$apolFolder) -eq $true -and (Get-WebApplication -Name $appPath$captchaFolder) -eq $null)
{
	New-WebApplication -Name $captchaFolder -ApplicationPool $siteName -Site $siteName -PhysicalPath $fullPhysicalPath$apolFolder;
}

# Criar site para Apol SENHA na mesma pasta do Apol
$apolSenhaFolder = "apol_senha";
if((Test-Path $appPath$apolFolder) -eq $true -and (Get-WebApplication -Name $appPath$apolSenhaFolder) -eq $null)
{
	New-WebApplication -Name $apolSenhaFolder -ApplicationPool $siteName -Site $siteName -PhysicalPath $fullPhysicalPath$apolFolder;
}

# Cria uma aplica��o para o View PDF
$viewPDFFolder = "ViewPDF";
if((Get-WebApplication -Name $appPath$viewPDFFolder) -eq $null -and (Test-Path $appPath$apolFolder$separadorFisico$viewPDFFolder) -eq $true)
{
	New-WebApplication -Name $viewPDFFolder -ApplicationPool $siteName -Site $siteName -PhysicalPath $fullPhysicalPath$apolFolder$separadorFisico$viewPDFFolder;
}

# Cria uma aplica��o para Utilit�rios
$utilitarioFolder = "utilitarios";
if((Get-WebApplication -Name $appPath$utilitarioFolder) -eq $null -and (Test-Path $appPath$apolFolder$separadorFisico$utilitarioFolder) -eq $true)
{
	New-WebApplication -Name $utilitarioFolder -ApplicationPool $siteName -Site $siteName -PhysicalPath $fullPhysicalPath$apolFolder$separadorFisico$utilitarioFolder;
}

# Cria uma aplica��o para Utilit�rios da SNAP - ISIS Service
$servicoIsisFolder = "\ServicoIsis";
if((Get-WebApplication -Name $appPath$utilitarioFolder$servicoIsisFolder) -eq $null -and (Test-Path $appPath$utilitarioFolder$servicoIsisFolder) -eq $true)
{
	ConvertTo-WebApplication -ApplicationPool $siteName $appPath$utilitarioFolder$servicoIsisFolder;
}

# Criar site para o merge de arquivo RTF - D:\Projetos_web\Copias_trabalho\Rodrigo\Apol\merge_rtf_apol
$mergeRTFApolFolder = "merge_rtf_apol";
if((Get-WebApplication -Name $appPath$mergeRTFApolFolder) -eq $null -and (Test-Path $appPath$apolFolder$separadorFisico$mergeRTFApolFolder) -eq $true)
{
	New-WebApplication -Name $mergeRTFApolFolder -ApplicationPool $siteName -Site $siteName -PhysicalPath $fullPhysicalPath$apolFolder$separadorFisico$mergeRTFApolFolder;
}

# TODO: Verificar necessidade do site comunicação - D:\Projetos_web\Copias_trabalho\Rodrigo\Apol\utilitarios\Comunicacao

# Cria uma aplica��o para os Servi�os de Cartas do Apol
$webServicesFolder = "WebServices";
$wsCartasFolder = "\wsCartas";
if((Get-WebApplication -Name $appPath$webServicesFolder$wsCartasFolder) -eq $null -and (Test-Path $appPath$webServicesFolder$wsCartasFolder) -eq $true)
{
	if((Test-Path IIS:\AppPools\$webServicesFolder) -eq $true)
	{
		ConvertTo-WebApplication -ApplicationPool $webServicesFolder $appPath$webServicesFolder$wsCartasFolder;
	}
}

# Cria uma aplica��o para os Servi�os de Inclus�o e Altera��o de Processos do Apol
$wsProcessosFolder = "\wsProcessos";
if((Get-WebApplication -Name $appPath$webServicesFolder$wsProcessosFolder) -eq $null -and (Test-Path $appPath$webServicesFolder$wsProcessosFolder) -eq $true)
{
	if((Test-Path IIS:\AppPools\$webServicesFolder) -eq $true)
	{
		ConvertTo-WebApplication -ApplicationPool $webServicesFolder $appPath$webServicesFolder$wsProcessosFolder;
	}
}


###############################################################################################
# Desconsiderar testes
#New-WebApplication "TesteWebApp" -Site "Dev_rodrigo" -ApplicationPool "Temp" -PhysicalPath "D:\Projetos_web\Copias_trabalho\Rodrigo\Temp"
#New-WebApplication "TesteWebApp" -Site "Default Web Site" -ApplicationPool "RodrigoLessa" -PhysicalPath "C:\Temp\TesteWebApp"

# Agora executa um teste no site
#$ie=New-Object -com internetexplorer.application;
#$ie.visible=$true;
#$ie.Navigate("http://localhost:$appPort/");

Write-Host " ";
Write-Host " Fim do processo! ";