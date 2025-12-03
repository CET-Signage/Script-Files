# This script minimizes Content Player

# Load dll and define method
$sig = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
Add-Type -MemberDefinition $sig -name NativeMethods -namespace Win32

# Find the process ID for the content player
$hwnd = @(Get-Process "signage")[0].MainWindowHandle

# Minimize Content Player
[Win32.NativeMethods]::ShowWindowAsync($hwnd, 11)