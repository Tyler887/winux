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
Function Test-CommandExists

{

 Param ($command)

 $oldPreference = $ErrorActionPreference

 $ErrorActionPreference = ‘stop’

 try {if(Get-Command $command){“$command exists”}}

 Catch {“$command does not exist”}

 Finally {$ErrorActionPreference=$oldPreference}

} #end function test-CommandExists
if ( Test-CommandExists "linux" -eq "linux exists" ) {
   Write-Warning "WINUX is already installed. A conflict may appear."
}
Write-Output "Installing WINUX..."
$WINUX_URL = "https://github.com/Tyler887/winux/releases/latest/download/linux.exe"
$WINUXUPDATER_URL = "https://raw.githubusercontent.com/Tyler887/winux/main/upgrade.ps1"
$WINUXUNINSTALLER_URL = "https://github.com/Tyler887/winux/raw/main/uninstall.ps1"
New-Item -Path $env:UserProfile"\AppData\Roaming" -Name "Winux" -ItemType "directory"
Invoke-WebRequest $WINUX_URL -OutFile $env:UserProfile"\AppData\Roaming\Winux\linux.exe"
Invoke-WebRequest $WINUX_URL -OutFile $env:UserProfile"\AppData\Roaming\Winux\winux.exe"
Invoke-WebRequest $WINUXUPDATER_URL -OutFile $env:UserProfile"\update-winux.ps1"
Invoke-WebRequest $WINUXUNINSTALLER_URL -OutFile $env:UserProfile"\uninstall-winux.ps1"
Add-EnvPath $env:UserProfile"\AppData\Roaming\Winux" "User"
Write-Output "WINUX has been installed! To verify, run: linux --version yes"
