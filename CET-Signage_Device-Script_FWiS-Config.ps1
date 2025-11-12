[xml]$DeployXML = Get-Content "C:\Users\Public\Documents\Four Winds Interactive\Signage\Channels\(default)\DeploymentSettings.xml"
$DeployXML.DeploymentSettings.ConnectionProperties.Hostname = "https://us-ded.fwicloud.com/microsoft-sv/"
$DeployXML.DeploymentSettings.ConnectionProperties.Username = "Microsoft\dedsvcmicrosoft"
$DeployXML.DeploymentSettings.ConnectionProperties.ExtendedProperties = "NEqlHS4lZUpEbaTF8xqY0gvbo5F6zs5aX18oC4mxTEE="
$DeployXML.Save("C:\Users\Public\Documents\Four Winds Interactive\Signage\Channels\(default)\DeploymentSettings.xml")

[xml]$DeviceXML = Get-Content "C:\Users\Public\Documents\Four Winds Interactive\Signage\DeviceSettings.xml"
$DeviceXML.DeviceSettings.FwiServicesConnectionProperties.Hostname = "https://us-ded.fwicloud.com/microsoft-sv/"
$DeviceXML.DeviceSettings.FwiServicesConnectionProperties.Username = "Microsoft\dedsvcmicrosoft"
$DeviceXML.DeviceSettings.FwiServicesConnectionProperties.ExtendedProperties = "NEqlHS4lZUpEbaTF8xqY0gvbo5F6zs5aX18oC4mxTEE="
$DeviceXML.Save("C:\Users\Public\Documents\Four Winds Interactive\Signage\DeviceSettings.xml")