add-type -AssemblyName microsoft.VisualBasic
add-type -AssemblyName System.Windows.Forms

[Microsoft.VisualBasic.Interaction]::AppActivate("Content Player")

start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{ESC}")

start-sleep -Seconds 1

[System.Windows.Forms.SendKeys]::SendWait("% ")

start-sleep -Seconds 1

[System.Windows.Forms.SendKeys]::SendWait("x")