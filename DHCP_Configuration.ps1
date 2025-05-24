# DHCP_Config.ps1

# Install DHCP Server Role
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Authorize DHCP Server in AD
Add-DhcpServerInDC -DnsName "dc01.homedc.pvt" -IPAddress "192.168.200.20"

# Create DHCP Scope
Add-DhcpServerv4Scope -Name "Home Lab Scope" -StartRange 192.168.200.100 -EndRange 192.168.200.200 -SubnetMask 255.255.255.0 -State Active

# Configure Scope Options (Gateway and DNS)
Set-DhcpServerv4OptionValue -ScopeId 192.168.200.0 `
    -DnsServer 192.168.200.20 `
    -Router 192.168.200.1 `
    -DnsDomain "homedc.pvt"

# (Optional) Exclude static IP range
Add-DhcpServerv4ExclusionRange -ScopeId 192.168.200.0 -StartRange 192.168.200.190 -EndRange 192.168.200.200

# (Optional) DHCP Reservation Example
# Replace MAC address below with actual client MAC
# Add-DhcpServerv4Reservation -ScopeId 192.168.200.0 -IPAddress 192.168.200.111 -ClientId "00-11-22-33-44-55" -Description "Win11 Client"

Write-Host "✅ DHCP configuration completed successfully."
