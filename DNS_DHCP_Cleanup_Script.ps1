# ================================
# DNS + DHCP Cleanup Script
# ================================

# Run PowerShell as Administrator

Write-Host "Removing DNS and DHCP components..." -ForegroundColor Yellow

# 1. Stop Services
Stop-Service -Name DNS -Force -ErrorAction SilentlyContinue
Stop-Service -Name DHCPServer -Force -ErrorAction SilentlyContinue

# 2. Remove DNS Zones
Get-DnsServerZone | ForEach-Object {
    Remove-DnsServerZone -Name $_.ZoneName -Force
}

# 3. Uninstall DHCP Server Role
Uninstall-WindowsFeature -Name 'DHCP' -IncludeManagementTools -Remove

# 4. Uninstall DNS Server Role
Uninstall-WindowsFeature -Name 'DNS' -IncludeManagementTools -Remove

# 5. Delete DHCP Config Folder (Careful: irreversible)
Remove-Item -Recurse -Force -Path "C:\Windows\System32\dhcp"

# 6. Clear Event Logs related to DNS and DHCP
Clear-EventLog -LogName 'DNS Server', 'DHCPServer'

Write-Host "Cleanup complete. Please restart the system before fresh installation." -ForegroundColor Green
