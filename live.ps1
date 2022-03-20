Invoke-WebRequest "https://raw.githubusercontent.com/Tyler887/winux/v1.0/winux.py" -OutFile $env:UserProfile"\WinuxScript.py"
Invoke-Expression -Command "python "$env:UserProfile"\WinuxScript.py"
Remove-Item $env:UserProfile"\WinuxScript.py"
