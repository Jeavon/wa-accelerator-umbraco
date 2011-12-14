$path = $args[0];

function GenerateKey($length, $bytes)
{
    $buff = new-object "System.Byte[]" $bytes
    (new-object System.Security.Cryptography.RNGCryptoServiceProvider).GetBytes($buff)
    $sb = new-object System.Text.StringBuilder($length)
    for($i = 0; ($i -lt $buff.Length); $i++)
    {
        $sb = $sb.AppendFormat("{0:X2}", $buff[$i])
    }
    
    return $sb.ToString()
}

function ConfigureMachineKey($configurationFile)
{
    [xml]$xml = get-content $configurationFile;

    $appendChild = $false;
    $machineKey = $xml.configuration."system.web".machineKey;
    if ($machineKey -eq $null) 
    { 
        $machineKey = $xml.CreateElement("machineKey") 
        $appendChild = $true;
    }
    
    $validationKey = GenerateKey 128 64
    $decryptionKey = GenerateKey 64 32
	$machineKey.SetAttribute("validationKey", $validationKey)
	$machineKey.SetAttribute("decryptionKey", $decryptionKey)
	$machineKey.SetAttribute("validation", "SHA1")
	$machineKey.SetAttribute("decryption", "AES")
    
	if ($appendChild) { $xml.configuration."system.web".AppendChild($machineKey) }
    
    $xml.Save($configurationFile);
}

Write-Output ""
Write-Output "Updating Umbraco's web.config..."

$configurationFile = "$path\web.config";

ConfigureMachineKey $configurationFile;

Write-Output "Done!"
Write-Output ""