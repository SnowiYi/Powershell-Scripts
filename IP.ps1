Clear-Host
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Relaunching with administrator privileges..."
    Start-Process powershell.exe -Verb RunAs -ArgumentList $PSCommandPath
    exit
}

Clear-Host
Write-Host "Select a network adapter:"
Write-Host ""

Get-NetAdapter | ForEach-Object { Write-Host "$($_.InterfaceIndex): $($_.Name)" }

$adapterIndex = Read-Host "Enter the Interface ID"

Clear-Host
Write-Host ""
Write-Host ""

$AdresseIP =  Get-NetIPAddress -InterfaceIndex $adapterIndex -AddressFamily IPv4 | Select-Object -ExpandProperty IPAddress
Write-Host "Your Old IP is: $AdresseIP"

$newIP = Read-Host "Enter the new IP"

Remove-NetIPAddress -InterfaceIndex $adapterIndex -IPAddress $AdresseIP -Confirm:$false

$subnet = Read-Host "Enter the Subnet Mask"

New-NetIPAddress -InterfaceIndex $adapterIndex -IPAddress $newIP -PrefixLength $subnet

clear-Host
Write-Host ""
Write-Host ""
Write-Host "IP changed successfully from $AdresseIP to $newIP with subnetmask: $subnet."
pause