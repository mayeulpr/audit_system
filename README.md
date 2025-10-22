# audit_system
$Date = Get-Date -Format "dd/MM/yyyy HH:mm"
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$OS = (Get-ComputerInfo).OsName
$CPU = (Get-WmiObject Win32_Processor).Name
$RAM = (Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB







$Rapport = @"
===== RAPPORT SYSTEME =====
Machine : $ComputerName
Utilisateur : $User
OS : $OS
Processeur : $CPU
RAM (Go) : $([math]::Round($RAM,2))
Date : $Date
===========================
"@
$Rapport | Out-File "./exports/system_info.txt" -Encoding UTF8
