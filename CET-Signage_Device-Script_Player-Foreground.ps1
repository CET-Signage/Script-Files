$sig = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
Add-Type -MemberDefinition $sig -name NativeMethods -namespace Win32
add-type -AssemblyName microsoft.VisualBasic
add-type -AssemblyName System.Windows.Forms

$CP = @(Get-Process "signage")[0].MainWindowHandle

[Win32.NativeMethods]::ShowWindowAsync($CP, 11)
[Win32.NativeMethods]::ShowWindowAsync($CP, 3)

Start-Sleep -Seconds 0.5

# TESTING EDITS

[Microsoft.VisualBasic.Interaction]::AppActivate("Content Player")
