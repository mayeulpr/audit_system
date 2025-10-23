

Add-DnsServerPrimaryZone -Name "entrepriseXY.fr" -ReplicationScope "Domain"
Add-DnsServerResourceRecordA -Name "srv-dc1" -ZoneName "entrepriseXY.fr" -IPv4Address "192.168.147.10"
Set-DnsServerForwarder -IPAddress 8.8.8.8,8.8.4.4
