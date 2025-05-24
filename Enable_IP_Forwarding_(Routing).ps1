# Enable IP Routing in Registry
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name IPEnableRouter -Value 1

# Restart Routing Service
Restart-Service RemoteAccess
