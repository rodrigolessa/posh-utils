#Tentativa ignorar as politicas locais
Set-executionpolicy -scope CurrentUser -executionPolicy Undefined

Write-Host "";
Write-Host "Seja bem-vindo " -nonewline;
Write-Host $env:UserName -foregroundcolor red -nonewline;
Write-Host "!";

$separadorFisico = "\";
$testFolder = "TestResults";
$reportFolder = "Reports";
$reportHtml = "index.html";

#Move to current script folder
#cmd /c cd $PSScriptRoot
Set-Location $PSScriptRoot

# Se NÃO existir cria a raiz do diretório físico
#if((Test-Path $PSScriptRoot$separadorFisico$reportPath) -eq 0)
#{
	#New-Item -ItemType directory -Path $PSScriptRoot$separadorFisico$reportPath;
#}

#TODO: Build entire application/solution or only testes project and your's dependencies

#%SYSTEMROOT%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe LDSoft.AlgoritmoColidiah.sln /p:Configuration=Debug /p:Platform="Any CPU" /t:rebuild

$m = "%SYSTEMROOT%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
$s = "$PSScriptRoot\LDSoft.AlgoritmoColidiah.sln"
$p = "/t:LDSoft.AlgoritmoColidiah.Test /m"
$c = "/p:Configuration=Debug /p:Platform=""Any CPU"""
$r = "/t:rebuild /p:BuildProjectReferences=false"

#cmd /c "$m $s $p $c $r"

#TODO: Adicionar o vstest ao path do windows
#C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe

Remove-Item –path $PSScriptRoot$separadorFisico$testFolder\* -include *.trx

#Remove-Item –path $PSScriptRoot$separadorFisico$reportFolder\* -include *.html
Remove-Item –path $PSScriptRoot$separadorFisico$testFolder\* -include *.html

$resulttests = vstest.console.exe $PSScriptRoot\LDSoft.AlgoritmoColidiah.Test\bin\Debug\LDSoft.AlgoritmoColidiah.Test.dll /logger:trx

#$resultindex = $resulttests.LastIndexOf("Results File:")
#$resultTotalIndex = $resulttests.LastIndexOf("Total tests:")
#$resultlength = $resulttests.length
#if ($resultindex > 0)
#{
    #$resultName = $resulttests.substring($resultindex, $resultlength - $resultindex).trim()
    #$resultName = $resulttests.substring($resultindex, $resultTotalIndex)

    #Write-Host $resultName
#}

$Dir = get-childitem $PSScriptRoot$separadorFisico$testFolder -recurse
#$Dir  | get-member #File info
$List = $Dir | where {$_.extension -eq ".trx"}
#$List | format-table name

$arquivoTrx = $List | Select-Object -first 1

#Write-Host $arquivoTrx

$trxer = "$PSScriptRoot\Trxer\TrxerConsole.exe"

cmd /c $trxer $PSScriptRoot$separadorFisico$testFolder$separadorFisico$arquivoTrx