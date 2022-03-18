Write-Output "Installing WINUX..."
Invoke-WebRequest "https://github.com/Tyler887/winux/releases/latest/linux.exe" -OutFile $env:UserProfile"\AppData\Roaming\Winux\linux.exe"
[Environment]::SetEnvironmentVariable
     ("PATH", "$env:PATH;$env:UserProfile\AppData\Roaming\Winux", [System.EnvironmentVariableTarget]::User)
Write-Output "WINUX has been installed! To verify, run: winux --version yes"
