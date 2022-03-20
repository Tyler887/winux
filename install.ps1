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

If ( Test-Path $env:UserProfile"\AppData\Roaming\Winux" ) {
   Write-Error "A folder called 'Winux' in your AppData roaming subfolder seems to exist. (WINUX may already be installed.)`nPlease delete the folder in order to install WINUX. uninstall-winux.ps1 may help you if you do not know how to uninstall WINUX." -ErrorAction Stop
}
if ( Get-Command linux -ErrorAction SilentlyContinue ) {
   Write-Warning "Another program conflicts with the 'linux' command. Please delete any files in a folder added to the PATH called 'linux.exe' before installing." -WarningAction Inquire
}
if ( Get-Command winux -ErrorAction SilentlyContinue ) {
   Write-Warning "Another program conflicts with the 'winux' command. Please delete any files in a folder added to the PATH called 'winux.exe' before installing." -WarningAction Inquire
}

Write-Host "Installing WINUX..."
$WINUX_URL = "https://github.com/Tyler887/winux/releases/latest/download/linux.exe"
$WINUXUPDATER_URL = "https://raw.githubusercontent.com/Tyler887/winux/main/upgrade.ps1"
$WINUXUNINSTALLER_URL = "https://github.com/Tyler887/winux/raw/main/uninstall.ps1"
New-Item -Path $env:UserProfile"\AppData\Roaming" -Name "Winux" -ItemType "directory"
Write-Host "Downloading WINUX..."
Invoke-WebRequest $WINUX_URL -OutFile $env:UserProfile"\AppData\Roaming\Winux\linux.exe"
Write-Host "Downloading WINUX again to create the 'winux' command as an alias to 'linux'..."
Invoke-WebRequest $WINUX_URL -OutFile $env:UserProfile"\AppData\Roaming\Winux\winux.exe"
Write-Host "Downloading update script..."
Invoke-WebRequest $WINUXUPDATER_URL -OutFile $env:UserProfile"\update-winux.ps1"
Write-Host "Downloading uninstall script..."
Invoke-WebRequest $WINUXUNINSTALLER_URL -OutFile $env:UserProfile"\uninstall-winux.ps1"
Add-EnvPath $env:UserProfile"\AppData\Roaming\Winux" "User"
Write-Host "WINUX has been installed! " -f Green -NoNewline
Write-Host "To verify, run: linux --version yes"
