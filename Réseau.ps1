Write-Output ""
Write-Output ""

$NomMachine = $env:COMPUTERNAME
Write-Output "Nom de la machine: $NomMachine"

Write-Output ""
$Interfaces = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

if ($Interfaces) {
    Write-Output "Informations Réseau :"

    foreach ($Interface in $Interfaces) {
        $AdresseIP = $Interface.IPAddress | Where-Object { $_ -match '\d+.\d+.\d+.\d+' }
        $AdresseMAC = $Interface.MACAddress
        
       
        Write-Output "Interface: $($Interface.Description)"
        Write-Output "Adresse IP : $($AdresseIP -join ', 1')"
        Write-Output "Adresse MAC: $AdresseMAC"
        Write-Output ""
    }
} else {
    Write-Output "Aucune interface réseau active détectée."
}
Pause