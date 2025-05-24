# DNS_Config.ps1

# Install DNS Server Role
Install-WindowsFeature -Name DNS -IncludeManagementTools

# Create Forward Lookup Zone
Add-DnsServerPrimaryZone -Name "homedc.pvt" -ZoneFile "homedc.pvt.dns" -DynamicUpdate Secure

# Create Reverse Lookup Zone for 192.168.200.0/24
Add-DnsServerPrimaryZone -NetworkId "200.168.192" -ZoneFile "200.168.192.in-addr.arpa.dns" -ZoneType Primary -DynamicUpdate Secure

# Add A record for DC
Add-DnsServerResourceRecordA -Name "dc01" -ZoneName "homedc.pvt" -IPv4Address "192.168.200.20"

# Add PTR record for DC
Add-DnsServerResourceRecordPTR -Name "20" -ZoneName "200.168.192.in-addr.arpa" -PtrDomainName "dc01.homedc.pvt"

Write-Host "✅ DNS configuration completed successfully."
