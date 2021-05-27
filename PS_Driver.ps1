#Powershell
Get-WindowsDriver -online | Out-GridView

Get-WmiObject Win32_PnPSignedDriver| select DeviceName, DriverVersion, Manufacturer
# You can also filter a specific driver name using the following command:

# Get Driver - Devicename, DriverVersion, Manufacturer 
	Get-WmiObject Win32_PnPSignedDriver| select DeviceName, DriverVersion, Manufacturer | where {$_.DeviceName -like "*conex*"}

# Get Driver name and Hardware ID
	Get-WmiObject Win32_PNPEntity | Select Name, DeviceID | where {$_.DeviceName -like "*conex*"}

## Find a specific driver
	Get-WmiObject Win32_PNPEntity | Where-Object{$_.Name -Match "audio"} | Select Name, DeviceID | format-list
	

Remove the Driver package

	$oemfiles = Get-ChildItem c:\windows\inf\oem*.inf
	foreach($file in $oemfiles){
		if(get-content $file | select-string -pattern 'CHDRT64.sys' -SimpleMatch)
		{PnPUtil /Delete-Driver $file.name /force }
	}

# find all audio devices
	Get-CimInstance win32_sounddevice | fl *
	
## find the driver
	gwmi win32_systemdriver | ? caption -match ‘conexant’ | fl * 
	
### get driver file info
	$path = (gwmi win32_systemdriver | ? caption -match ‘conexant’).pathname
	
	$path
	
#### get version info
	(Get-Item $path).versioninfo
	
	(Get-Item $path).versioninfo | fl *
# _____________________________________________________________________________
# test

Get-WmiObject Win32_PNPEntity | Where-Object{$_.ConfigManagerErrorCode -ne 0} | Select Name, DeviceID

get check WMI -Class
get-wmiobject -query "select * from Win32_PNPEntity Where deviceid Like '%HDAUDIO\FUNC_01&VEN_14F1&DEV_2008&SUBSYS_17AA224E&REV_1001\4&11c50461&0&0001%'"


select * from Win32_PNPEntity Where deviceid Like "HDAUDIO\\FUNC_01&VEN_14F1&DEV_2008&SUBSYS_17AA224E&REV_1001\\4&11c50461&0&0001"

select * from Win32_SoundDevice Where deviceid Like "HDAUDIO\\FUNC_01&VEN_14F1&DEV_2008&SUBSYS_17AA224E&REV_1001\\4&11c50461&0&0001"

select * from Win32_SoundDevice Where deviceid Like "%FUNC_01&%"


Get-WmiObject -query "select * from Win32_SoundDevice Where deviceid Like "%HDAUDIO\FUNC_01&VEN_14F1&DEV_2008&SUBSYS_17AA224E&REV_1001\4&11c50461&0&0001%"" -ComputerName WMA403971
