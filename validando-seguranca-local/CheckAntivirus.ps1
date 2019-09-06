$Computer = "localhost"

[system.Version]$OSVersion = (Get-WmiObject win32_operatingsystem -computername $Computer).version

$AntiVirusProduct = Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct -ComputerName $Computer -ErrorAction Stop

$productState = $AntiVirusProduct.productState

$hex = [convert]::ToString($productState[0], 16).PadLeft(6,'0')

$WSC_SECURITY_PROVIDER = $hex.Substring(0,2)
$WSC_SECURITY_PRODUCT_STATE = $hex.Substring(2,2)
$WSC_SECURITY_SIGNATURE_STATUS = $hex.Substring(4,2)

#n ot used yet
$SECURITY_PROVIDER = switch ($WSC_SECURITY_PROVIDER)
{
    0  {"NONE"}
    1  {"FIREWALL"}
    2  {"AUTOUPDATE_SETTINGS"}
    4  {"ANTIVIRUS"}
    8  {"ANTISPYWARE"}
    16 {"INTERNET_SETTINGS"}
    32 {"USER_ACCOUNT_CONTROL"}
    64 {"SERVICE"}
    default {"UNKNOWN"}
}


$RealTimeProtectionStatus = switch ($WSC_SECURITY_PRODUCT_STATE)
{
    "00" {"OFF"} 
    "01" {"EXPIRED"}
    "10" {"ON"}
    "11" {"SNOOZED"}
    default {"UNKNOWN"}
}

$DefinitionStatus = switch ($WSC_SECURITY_SIGNATURE_STATUS)
{
    "00" {"UP_TO_DATE"}
    "10" {"OUT_OF_DATE"}
    default {"UNKNOWN"}
}  

#Write-Output $AntiVirusProduct.__Server 
#Write-Output $AntiVirusProduct.displayName
#Write-Output $AntiVirusProduct.pathToSignedProductExe

# Output PSCustom Object
$AV = $Null
$AV = New-Object -TypeName PSObject -ErrorAction Stop -Property @{
             
    ComputerName = $AntiVirusProduct.__Server;
    Name = $AntiVirusProduct.displayName;
    ProductExecutable = $AntiVirusProduct.pathToSignedProductExe;
    DefinitionStatus = $DefinitionStatus;
    RealTimeProtectionStatus = $RealTimeProtectionStatus;
    ProductState = $productState;
                
} | Select-Object ComputerName,Name,ProductExecutable,DefinitionStatus,RealTimeProtectionStatus,ProductState  
                
Write-Output $AV 

<#
$computerList = "localhost", "localhost"
$filter = "antivirus"

$results = @()
foreach($computerName in $computerList) {

    $hive = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $computerName)
    $regPathList = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
                   "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

    foreach($regPath in $regPathList) {
        if($key = $hive.OpenSubKey($regPath)) {
            if($subkeyNames = $key.GetSubKeyNames()) {
                foreach($subkeyName in $subkeyNames) {
                    $productKey = $key.OpenSubKey($subkeyName)
                    $productName = $productKey.GetValue("DisplayName")
                    $productVersion = $productKey.GetValue("DisplayVersion")
                    $productComments = $productKey.GetValue("Comments")
                    if(($productName -match $filter) -or ($productComments -match $filter)) {
                        $resultObj = [PSCustomObject]@{
                            Host = $computerName
                            Product = $productName
                            Version = $productVersion
                            Comments = $productComments
                        }
                        $results += $resultObj
                    }
                }
            }
        }
        $key.Close()
    }
}

$results | ft -au
#>