$storageAccount = $args[0];
$storageAccountKey = $args[1];

function UpdateConfigurationSetting($configurationFile, $connectionString, $settingKey)
{
    [xml]$xml = get-content $configurationFile;

	$entry = $xml.ServiceConfiguration.Role.ConfigurationSettings.Setting | Where-Object { $_.name -match $settingKey }
	$entry.value = $connectionString 

    $xml.Save($configurationFile);
}

Write-Output ""
Write-Output "Updating UmbracoAccelerator ServiceConfiguration.cscfg..."

$storageAccount = $storageAccount.ToLower();
$settingKey = "DataConnectionString";
$configurationFile = "./../code/UmbracoAccelerator/ServiceConfiguration.cscfg";
$connectionString = "DefaultEndpointsProtocol=https;AccountName=$storageAccount;AccountKey=$storageAccountKey";

UpdateConfigurationSetting $configurationFile $connectionString $settingKey;

Write-Output "Done!"
Write-Output ""