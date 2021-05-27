## Get a list of printers on a remote computer
Get-Printer | Select-Object Name, ComputerName, Type, DriverName, Shared, Published | Out-GridView

Get-Printer -ComputerName WMA408190 | Select-Object Name, ComputerName, Type, DriverName, Shared, Published | Out-GridView

HKCU:\Printers\Connections

# “Class Driver” in their names, which indicates they are v4 drivers, 


## Get Printer Driver info
Get-PrinterDriver -ComputerName WMA408190 | Out-GridView



Note: The major difference between a Type 3 and a Type 4 driver is. Type 4 can facilitate print service management because standard end-users can install them without administrative rights. Otherwise, adjustments can be made using Group Policy.
