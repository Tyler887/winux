# Winux (`linux.exe`)

Winux is a Linux® environment for Windows<sup>TM</sup>.

## Install

Installation of Winux is usally done using this in PowerShell:

```powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://github.com/Tyler887/winux/raw/main/install.ps1')
```

Another way is to use [CPPM](https://github.com/Tyler887/CPPM) or add the [Scoop](https://scoop.sh) bucket:

```batch
powershell -c "Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')"
scoop install git
scoop bucket add winux https://github.com/Tyler887/winux-scoop.git
scoop install winux/winux
```

You can uninstall Winux as well by opening `uninstall-winux.ps1` or upgrade it by opening `update-winux.ps1`.

### :warning: Misidentification of being a Win32 trojan

Winux might be detected as a virus, called `Trojan:Win32/Wactac.b!ml`. If this appears in Windows Security, then uninstall Winux, then try installing it again. If you still find the same issue, install using Scoop.
