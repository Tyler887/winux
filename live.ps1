if ( ! Get-Command "python3" -ErrorAction SilentlyContinue ) {
   Write-Error "Python 3 is required to run live." -ErrorAction Stop
}
Invoke-WebRequest "https://raw.githubusercontent.com/Tyler887/winux/v1.0/winux.py" -OutFile $env:UserProfile"\WinuxScript.py"
Invoke-Expression "python -m pip install colorama questionary"
Invoke-Expression -Command "python $env:UserProfile\WinuxScript.py"
Remove-Item $env:UserProfile"\WinuxScript.py"
