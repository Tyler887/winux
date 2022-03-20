$WinuxIsRunning = Get-Process linux -ErrorAction SilentlyContinue
$WinuxStubIsRunning = Get-Process winux -ErrorAction SilentlyContinue

function Remove-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -contains $Path) {
            $persistedPaths = $persistedPaths | where { $_ -and $_ -ne $Path }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -contains $Path) {
        $envPaths = $envPaths | where { $_ -and $_ -ne $Path }
        $env:Path = $envPaths -join ';'
    }
}
Write-Output "Stopping all WINUX shells to prevent an error..."
if ( $WinuxIsRunning ) { Stop-Process -Name "linux" }
if ( $WinuxStubIsRunning ) { Stop-Process -Name "winux" }
Write-Output "Uninstalling WINUX..."
Remove-EnvPath $env:UserProfile"\AppData\Roaming\Winux" "User"
Remove-Item -Path $env:UserProfile"\AppData\Roaming\Winux" -Force -Recurse
Remove-Item -Path $env:UserProfile"\update-winux.ps1" -Force
Remove-Item -Path $env:UserProfile"\uninstall-winux.ps1" -Force
