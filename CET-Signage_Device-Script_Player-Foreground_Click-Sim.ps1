function Invoke-MouseClick {
    param(
        [Parameter(Mandatory)]
        [int]$X,

        [Parameter(Mandatory)]
        [int]$Y
    )

    Add-Type @"
using System;
using System.Runtime.InteropServices;

public static class Mouse {
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);

    [DllImport("user32.dll")]
    public static extern void mouse_event(
        uint dwFlags,
        uint dx,
        uint dy,
        uint dwData,
        UIntPtr dwExtraInfo);

    public const uint MOUSEEVENTF_LEFTDOWN = 0x0002;
    public const uint MOUSEEVENTF_LEFTUP   = 0x0004;
}
"@

    [Mouse]::SetCursorPos($X, $Y) | Out-Null
    Start-Sleep -Milliseconds 100

    [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTDOWN, 0, 0, 0, [UIntPtr]::Zero)
    [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTUP,   0, 0, 0, [UIntPtr]::Zero)
}

function Invoke-CoordinateClicks {
    param(
        [Parameter(Mandatory)]
        [array]$Coordinates,

        [int]$DelayMilliseconds = 500
    )

    foreach ($coord in $Coordinates) {
        Invoke-MouseClick -X $coord.X -Y $coord.Y
        Start-Sleep -Milliseconds $DelayMilliseconds
    }
}

$Point = @{ X = 500; Y = 50 }
Start-Sleep -Milliseconds 500
Invoke-CoordinateClicks -Coordinates @($Point)