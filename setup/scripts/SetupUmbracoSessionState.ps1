$path = $args[0];
$server = $args[1];
$database = $args[2]
$user = $args[3];
$password = $args[4];

function UpdateSessionState($configurationFile, $connectionString)
{
    [xml]$xml = get-content $configurationFile;

	$entry = $xml.configuration."system.web".sessionState
    $entry.mode = "SQLServer"
    $entry.sqlConnectionString = $connectionString
    $entry.cookieless = "false"
    $entry.timeout = "20"
	$entry.SetAttribute("allowCustomSqlDatabase", "true")
    $entry.RemoveAttribute("stateConnectionString")
    $xml.Save($configurationFile);
}

Write-Output ""
Write-Output "Updating Umbraco's web.config..."

$configurationFile = "$path\web.config";
$connectionString = "Server=tcp:$server.database.windows.net;Database=$database;User ID=$user@$server;Password=$password";

UpdateSessionState $configurationFile $connectionString;

Write-Output "Done!"
Write-Output ""