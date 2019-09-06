$fullPathIncFileName = $MyInvocation.MyCommand.Definition
$currentScriptName = $MyInvocation.MyCommand.Name
$currentExecutingPath = $fullPathIncFileName.Replace($currentScriptName, "")

$xslt = New-Object System.Xml.Xsl.XslCompiledTransform
$xslt.Load($currentExecutingPath + "dupReport.xsl")
$xslt.Transform($currentExecutingPath + "dupReport.xml", $currentExecutingPath + "dupReport.html")