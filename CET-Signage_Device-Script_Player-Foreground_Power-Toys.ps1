#v0.5
function Bring-WindowToFocus {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProcessName
    )
 
    # Define Windows API functions (if not already defined)
    if (-not ([System.Management.Automation.PSTypeName]'User32').Type) {
        Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        public class User32 {
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool SetForegroundWindow(IntPtr hWnd);
 
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        }
"@ -ErrorAction Stop
    }
 
    $SW_RESTORE = 9  # Constant to restore minimized windows
 
    # Get the process(es)
    $processes = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
 
    if (-not $processes) {
        Write-Error "No running process found with name: $ProcessName"
        return
    }
 
    # Filter processes with visible windows
    $targetProcesses = $processes | Where-Object MainWindowHandle -ne 0
 
    if (-not $targetProcesses) {
        Write-Error "No visible windows found for process: $ProcessName"
        return
    }
 

    # Focus the first visible window (customize this to target specific instances)
    $targetProcess = $targetProcesses | Select-Object -First 1
    $hwnd = $targetProcess.MainWindowHandle
 
    # Restore and focus the window
    [User32]::ShowWindow($hwnd, $SW_RESTORE) | Out-Null
    $success = [User32]::SetForegroundWindow($hwnd)
 
    if ($success) {
        Write-Host "Successfully focused window for '$ProcessName' (ID: $($targetProcess.Id))"
    } else {
        Write-Warning "Failed to focus window for '$ProcessName'. It may be blocked by UAC or another application."
    }
}


function Set-WindowStyle {
param(
    [Parameter()]
    [ValidateSet('FORCEMINIMIZE', 'HIDE', 'MAXIMIZE', 'MINIMIZE', 'RESTORE', 
                 'SHOW', 'SHOWDEFAULT', 'SHOWMAXIMIZED', 'SHOWMINIMIZED', 
                 'SHOWMINNOACTIVE', 'SHOWNA', 'SHOWNOACTIVATE', 'SHOWNORMAL')]
    $Style = 'SHOW',
    [Parameter()]
    $MainWindowHandle = (Get-Process -Id $pid).MainWindowHandle
)
    $WindowStates = @{
        FORCEMINIMIZE   = 11; HIDE            = 0
        MAXIMIZE        = 3;  MINIMIZE        = 6
        RESTORE         = 9;  SHOW            = 5
        SHOWDEFAULT     = 10; SHOWMAXIMIZED   = 3
        SHOWMINIMIZED   = 2;  SHOWMINNOACTIVE = 7
        SHOWNA          = 8;  SHOWNOACTIVATE  = 4
        SHOWNORMAL      = 1
    }
    Write-Verbose ("Set Window Style {1} on handle {0}" -f $MainWindowHandle, $($WindowStates[$style]))

    $Win32ShowWindowAsync = Add-Type –memberDefinition @” 
    [DllImport("user32.dll")] 
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
“@ -name “Win32ShowWindowAsync” -namespace Win32Functions –passThru

    $Win32ShowWindowAsync::ShowWindowAsync($MainWindowHandle, $WindowStates[$Style]) | Out-Null
}


# Load the System.Windows.Forms assembly
Add-Type -AssemblyName System.Windows.Forms
  
# Define the text to be typed
#$textToType = '{*LCONTROL}{*LWIN}T'
  
# Start Content Player
#Start-Process "C:\Program Files\Four Winds Interactive\Content Player\signage.exe" -WindowStyle Maximized
  
# Wait for Content Player to open
Start-Sleep -Seconds 7
Bring-WindowToFocus signage  
# Get the Content Player window
$signagewindow = Get-Process -Name signage | Select-Object -First 1
  
if ($signagewindow) {
     #Type the text into Notepad
    [System.Windows.Forms.SendKeys]::SendWait("^+'")
    (Get-Process -Name signage).MainWindowHandle | foreach { Set-WindowStyle MAXIMIZE $_ }
}
else {
    Write-Host "Content Player is not running or could not be found."
}
