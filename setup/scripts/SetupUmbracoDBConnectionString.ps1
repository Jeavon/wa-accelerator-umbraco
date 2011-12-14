$path = $args[0];
$server = $args[1];
$database = $args[2];
$user = $args[3];
$password = $args[4];

function UpdateConfigurationString($configurationFile, $connectionString, $settingKey)
{
    [xml]$xml = get-content $configurationFile;

	$entry = $xml.configuration.appSettings.add | Where-Object { $_.key -match $settingKey }
	$entry.value = $connectionString 

    $xml.Save($configurationFile);
}

Write-Output ""
Write-Output "Updating Umbraco's web.config..."

$settingKey = "umbracoDbDSN"
$configurationFile = "$path\web.config";
$connectionString = "Server=tcp:$server.database.windows.net;Database=$database;User ID=$user@$server;Password=$password";

UpdateConfigurationString $configurationFile $connectionString $settingKey;

Write-Output "Done!"
Write-Output ""