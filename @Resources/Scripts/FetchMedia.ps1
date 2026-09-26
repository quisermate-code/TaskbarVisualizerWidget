Add-Type -AssemblyName System.Runtime.WindowsRuntime
$asTaskGeneric = [System.WindowsRuntimeSystemExtensions].GetMethods() |
    Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' }

# BUG FIX: Added 3-second timeout so a hung session can't block Rainmeter's RunCommand thread
function Await($op, $type) {
    $t = $asTaskGeneric.MakeGenericMethod($type).Invoke($null, @($op))
    if (-not $t.Wait(3000)) { throw 'Timeout waiting for WinRT async operation' }
    return $t.Result
}
try {
    [Windows.Media.Control.GlobalSystemMediaTransportControlsSessionManager, Windows.Media.Control, ContentType = WindowsRuntime] | Out-Null
    $mgr = Await ([Windows.Media.Control.GlobalSystemMediaTransportControlsSessionManager]::RequestAsync()) ([Windows.Media.Control.GlobalSystemMediaTransportControlsSessionManager])
    $session = $mgr.GetCurrentSession()
    if ($session) {
        $props = Await ($session.TryGetMediaPropertiesAsync()) ([Windows.Media.Control.GlobalSystemMediaTransportControlsSessionMediaProperties])
        $title = $props.Title
        $artist = $props.Artist
        if (-not $title)  { $title  = 'No Track Title' }
        if (-not $artist) { $artist = 'Windows Media'  }
        # Sanitize: strip chars that break Rainmeter's INI parser and key-value format
        $title  = $title  -replace '[\r\n\[\]=;#]', ' '
        $artist = $artist -replace '[\r\n\[\]=;#]', ' '
        $content = "[Variables]`r`nSMTCTitle=$title`r`nSMTCArtist=$artist`r`nSMTCActive=1`r`n"
        [System.IO.File]::WriteAllText("$PSScriptRoot\..\MediaInfo.inc", $content)
    } else {
        $content = "[Variables]`r`nSMTCTitle=No Media Playing`r`nSMTCArtist=YouTube / Windows Audio`r`nSMTCActive=0`r`n"
        [System.IO.File]::WriteAllText("$PSScriptRoot\..\MediaInfo.inc", $content)
    }
} catch {
    $content = "[Variables]`r`nSMTCTitle=No Media Playing`r`nSMTCArtist=YouTube / Windows Audio`r`nSMTCActive=0`r`n"
    [System.IO.File]::WriteAllText("$PSScriptRoot\..\MediaInfo.inc", $content)
}
