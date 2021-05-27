#OS Info
## OS - Get OS Info
Get-CimInstance win32_operatingsystem # like organization, buildnumber, registereduser, serialnumber, version

## OS - Get Build Number
(Get-CimInstance -ClassName Win32_OperatingSystem -Namespace root/cimv2).BuildNumber
	
    #oder
	
(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name CurrentBuild).CurrentBuild
	
## Get last boot time
Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime
	

# Get running service status
get-service bits, wuauserv

## Get language settings
Get-WinUserLanguageList






# https://theitbros.com/get-service-powershell/#:~:text=Use%20PowerShell%20to%20Check%20Service,address%20as%20a%20computer%20name.
