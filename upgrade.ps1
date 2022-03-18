Write-Output "Upgrading WINUX..."
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
Remove-EnvPath $env:UserProfile"\AppData\Roaming\Winux" "User"
Remove-Item -Path $env:UserProfile"\AppData\Roaming\Winux" -Force -Recurse
function Add-EnvPath {
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
        if ($persistedPaths -notcontains $Path) {
            $persistedPaths = $persistedPaths + $Path | where { $_ }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -notcontains $Path) {
        $envPaths = $envPaths + $Path | where { $_ }
        $env:Path = $envPaths -join ';'
    }
}
$WINUX_URL = "https://github.com/Tyler887/winux/releases/latest/download/linux.exe"
New-Item -Path $env:UserProfile"\AppData\Roaming" -Name "Winux" -ItemType "directory"
Invoke-WebRequest $WINUX_URL -OutFile $env:UserProfile"\AppData\Roaming\Winux\linux.exe"
Invoke-WebRequest $WINUX_URL -OutFile $env:UserProfile"\AppData\Roaming\Winux\winux.exe"
Add-EnvPath $env:UserProfile"\AppData\Roaming\Winux" "User"
Write-Output "WINUX has been upgraded! To verify, run: linux --version yes"
