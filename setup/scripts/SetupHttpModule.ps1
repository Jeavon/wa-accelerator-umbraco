$path = $args[0];

function ConfigureCustomHttpModule($configurationFile, $name, $type)
{
    [xml]$xml = get-content $configurationFile;
	$mustappend = $false;
	$removeentry = $xml.configuration."system.webServer".modules.remove | Where-Object { $_.name -match $name }
	
	if ($removeentry -eq $null)
	{
		$removeentry = $xml.CreateElement("remove");
		$removeentry.SetAttribute("name", $name)
		$xml.configuration."system.webServer".modules.AppendChild($removeentry);
		$mustappend = $true;
	}
	
	$addentry = $xml.configuration."system.webServer".modules.add | Where-Object { $_.name -match $name }
	
	if ($addentry -eq $null)
	{
		$addentry = $xml.CreateElement("add");	
		$mustappend = $true;
	}
	
	$addentry.SetAttribute("name", $name);
	$addentry.SetAttribute("type", $type);
	
	if ($mustappend) { $xml.configuration."system.webServer".modules.AppendChild($addentry); }
	
    $xml.Save($configurationFile);
}

Write-Output ""
Write-Output "Updating Umbraco's web.config..."

$configurationFile = "$path\web.config";
$name = "PackageInstallationModule" 
$type =  "Microsoft.Samples.AcceleratorsHttpModules.PackageInstallationModule"

ConfigureCustomHttpModule $configurationFile $name $type;
Copy-Item ".\httpmodules\AcceleratorsHttpModules.dll" "$path\bin\" -force

Write-Output "Done!"
Write-Output ""