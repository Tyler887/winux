if ( Test-Path "$env:userprofile\AppData\Roaming\Winux" ) {} else {
  Write-Host "Error:" -NoNewline -f red
  Write-Host " You need to install Winux before running this .NET registration script."
  return
}
#  show .NET SDK logo
Write-Host "      " -NoNewline
Write-Host "['''''''']" -b magenta
Write-Host "      " -NoNewline
Write-Host "[  .NET  ]" -b magenta
Write-Host "      " -NoNewline
Write-Host "[.....sdk]" -b magenta
Write-Host "  Winux Registration"
Write-Host "-----------------------"
Write-Host "This script registers Winux as a .NET app so you can run it simply by typing:"
Write-Host "                                                           " -b gray
Write-Host "   dotnet winux                                            " -b gray -f yellow
Write-Host "                                                           " -b gray
Write-Host "Copying Winux to directory..."
Copy-Item "$env:userprofile\AppData\Roaming\Winux\linux.exe" -Destination "$env:userprofile\AppData\Roaming\Winux\dotnet-winux.exe"
Write-Host "Done!"
