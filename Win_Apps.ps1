# List all Applications 32bit
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

# List all Applications 64bit
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

# Export it to a txt file
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize > C:\temp\InstalledPrograms-PS.txt

#Compare installe software from two computers
Compare-Object -ReferenceObject (Get-Content C:\Users\Lori\Documents\PCapps.txt) -DifferenceObject (Get-Content C:\Users\Lori\Documents\LAPTOPapps.txt)


#Get installed application
Get-WmiObject -Class Win32_Product
Get-WmiObject -Class Win32_Product | Where-Object {$_.Vendor -Match "Trend Micro"} | Select-Object Vendor, Name
Get-WmiObject win32_product | where {$_.version -like '12.0.6612.1000'} | select name, version

Get-CimInstance win32_product
Get-CimInstance win32_product | Select-Object Name, PackageName, InstallDate | Out-GridView


Get-WmiObject Win32_Product -ComputerName $computer

Get-CimInstance Win32_Product -ComputerName $computer | Where-Object {$_.Vendor -contains $vendor}


<#
Gathering Installed Software Using PowerShell

From <https://mcpmag.com/articles/2017/07/27/gathering-installed-software-using-powershell.aspx> 

Get-WmiObject is no longer supported in PowerShell 7, let’s use Get-CimInstance instead since it’s part of the .Net core.

How To Find If A Software Installed on Any Remote Computers

Aus <https://www.nextofwindows.com/how-to-find-if-a-software-installed-on-any-remote-computers

#>