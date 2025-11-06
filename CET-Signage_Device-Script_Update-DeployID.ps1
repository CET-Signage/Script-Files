param($DeploymentID)

[xml]$myXML = Get-Content "C:\Users\Public\Documents\Four Winds Interactive\Signage\Channels\(default)\DeploymentSettings.xml"
$myXML.DeploymentSettings.IdRaw = $DeploymentID
$myXML.DeploymentSettings.IdExpanded = $DeploymentID
$myXML.Save("C:\Users\Public\Documents\Four Winds Interactive\Signage\Channels\(default)\DeploymentSettings.xml")