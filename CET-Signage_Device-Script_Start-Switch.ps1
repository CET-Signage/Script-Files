#This script minimizes Content Player and opens the Windows start menu

#Import DLL for window control functions
$sig = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
Add-Type -MemberDefinition $sig -name NativeMethods -namespace Win32

#Find process ID for the Content Player application
$hwnd = @(Get-Process "signage")[0].MainWindowHandle

# Minimize the Content Player window
[Win32.NativeMethods]::ShowWindowAsync($hwnd, 11)

#Execute CTRL-ESC hotkey to invoke the start menu
(New-Object -ComObject "wscript.shell").SendKeys("^{ESC}")