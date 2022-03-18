Write-Output "Installing WINUX..."
$WINUX_URL = "https://github.com/Tyler887/winux/releases/download/v1.0/linux.exe"
Invoke-WebRequest $WINUX_URL -OutFile $env:UserProfile"\AppData\Roaming\Winux\linux.exe"
[Environment]::SetEnvironmentVariable
     ("PATH", "$env:PATH;$env:UserProfile\AppData\Roaming\Winux", [System.EnvironmentVariableTarget]::User)
Write-Output "WINUX has been installed! To verify, run: linux --version yes"
