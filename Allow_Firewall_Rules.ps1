# Disable all inbound rules first
Get-NetFirewallRule -Direction Inbound | Set-NetFirewallRule -Enabled False

# Define list of essential rule DisplayNames to enable
$rulesToEnable = @(
    "DHCP Server v4 (UDP-In)",
    "DHCP Server (RPCSS-In)",
    "File and Printer Sharing (NB-Session-In)",
    "File and Printer Sharing over SMBDirect (iWARP-In)",
    "Virtual Machine Monitoring (Echo Request - ICMPv4-In)",
    "Netlogon Service Authz (RPC)",
    "Kerberos Key Distribution Center - PCR (UDP-In)",
    "Active Directory Domain Controller -  Echo Request (ICMPv6-In)",
    "Core Networking Diagnostics - ICMP Echo Request (ICMPv6-Out)",
    # Remote Desktop rules - uncomment if RDP is needed
    #"Remote Desktop - User Mode (UDP-In)",
    #"Remote Desktop - (TCP-WSS-In)",
    # Windows Remote Management - uncomment if needed
    #"Windows Remote Management (HTTP-In)"
)

# Enable only those rules
foreach ($ruleName in $rulesToEnable) {
    Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue | Set-NetFirewallRule -Enabled True
}

Write-Output "Firewall rules updated: All inbound disabled except the essentials."
