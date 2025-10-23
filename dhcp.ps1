
# Étendue DHCP
Add-DhcpServerv4Scope -Name "LAN_EntrepriseXYZ" `
-StartRange 192.168.147.200 `
-EndRange 192.168.147.220 `
-SubnetMask 255.255.255.0 `
-State Active

# Options DHCP
Set-DhcpServerv4OptionValue -ScopeId 192.168.147.0 `
-DnsServer 192.168.147.10 `
-DnsDomain "entrepriseXY.fr" `
-Router 192.168.147.1


# Réservation d’un poste administratif
Add-DhcpServerv4Reservation -ScopeId 192.168.147.0 `
-IPAddress 192.168.147.205 `
-ClientId "00-1A-2B-3C-4D-5E" `
-Description "Poste administratif" `
-Name "PC_Admin"

# Vérifications
Get-DhcpServerv4Scope
Get-DhcpServerv4OptionValue -ScopeId 192.168.147.0
Get-DhcpServerv4Reservation -ScopeId 192.168.147.0
