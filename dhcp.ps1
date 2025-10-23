
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

# Vérifications
Get-DhcpServerv4Scope
Get-DhcpServerv4OptionValue -ScopeId 192.168.147.0
Get-DhcpServerv4Reservation -ScopeId 192.168.147.0
