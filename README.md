# Winux (`linux.exe`)

Winux is a Linux® environment for Windows<sup>TM</sup>.

I'm tired of VMs, because they are really slow. I'm also stuck on Windows and can't get those Unix
programs. Well, I got sick of it and made this Linux backwards compatibility frontend for Windows.

![Demo](18-27-41.gif)

## Requirements

* Windows 10 Linux Subsystem (note that Windows 11 is based on Windows 10 and `wslfetch` will state that it's running on Windows 10 Linux Subsystem) 

## Install

An easy way to install Winux is to use PowerShell, which does not require any additional software:

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

Winux might be detected as a virus, called Wactac (`Trojan:Win32/Wactac.B!ml`). If this appears in Windows Security, then uninstall Winux,
and try installing it again. If you still find the same issue, install using Scoop.

## Run without installing

To run Winux without installing it (also called a "live run"), run this in PowerShell:

```powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://github.com/Tyler887/winux/raw/main/live.ps1')
```

## BASH examples

*:information_source: If noted, an example must be run in the standalone BASH and cannot be run in the default Winux shell.*

### Install APT packages

*:warning: Only works in standalone Bash. When you hit `bash`, ensure you're in sudomode.*

```bash
sudomode # enter sudomode
bash # in sudomode
apt update # in sudomode
apt install git python ruby golang make # in sudomode
go version # without sudomode
python --version # without sudomode
ruby --version # without sudomode
git version # without sudomode
```
