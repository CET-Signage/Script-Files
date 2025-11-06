param($State)

#Set Player Window State
[xml]$myXML = Get-Content "C:\Users\Public\Documents\Four Winds Interactive\Signage\Profiles\(default)\ProfileSettings.xml"
$myXML.ProfileSettings.PlayerWindowState = $State
$myXML.Save("C:\Users\Public\Documents\Four Winds Interactive\Signage\Profiles\(default)\ProfileSettings.xml")

Start-Sleep -Seconds 1

#Restart Player Machine
Restart-Computer