#\\vsrv-sccm\osdeploy$\Prod\Images\Upgrades
#\\vsrv-library\OS\MS Windows 10 ENT x64 EN\1803

https://docs.microsoft.com/en-us/powershell/module/dism/?view=win10-ps

cd C:\esd\new
cd C:\image\Win10ent64de\sources
cd C:\image\Mounted-WIM
cd "C:\Users\akilan.nadarajah\OneDrive - Halter AG\sccm\Win10ent64en\sources"
cd "C:\Users\akilan.nadarajah\OneDrive - Halter AG\sccm\Mounted-WIM"
cd C:\image\Win10ent64en_only\sources
cd "C:\image\1709 DE"

cd "C:\image\1709 DE\sources"
cd "C:\image\Win101813orig\sources"


dism /Get-WimInfo /WimFile:install.wim


dism /export-image /SourceImageFile:install.esd /SourceIndex:3 /DestinationImageFile:install.wim /Compress:max /CheckIntegrity



Remove-WindowsImage -ImagePath "c:\esd\install.wim" -Index 2 -CheckIntegrity

Export-WindowsImage -SourceImagePath c:\esd\install.wim -SourceIndex 1 -DestinationImagePath c:\esd\new\install.wim -DestinationName "Exported Image"

Save-WindowsImage -Path "c:\esd"


#mouunt image
Dism /Mount-Image /ImageFile:C:\esd\new\install.wim /Name:"Windows 10 1803 en-us" /MountDir:C:\esd\new\offline



#----

#Mounting the WIM file
dism.exe /Mount-WIM /WimFile:"install.wim" /index:1 /MountDir:"C:\image\Mounted-WIM"


#Adding Windows Update Packages to the mounted WIM file
dism.exe /image:"C:\image\Mounted-WIM" /Add-Package /PackagePath:"C:\image\patch1803"




#Dismount the WIM file and Commit Changes

dism.exe /Unmount-wim /mountdir:"C:\image\Mounted-WIM" /commit

dism /cleanup-wim


#--------------------------------------#
#Dism Language pack
#--------------------------------------#

#Dism Language pack ant set as default

Dism /Get-ImageInfo /ImageFile:C:\image\Win10ent64de\sources\install.wim

#Dism /Mount-Image /ImageFile:C:\image\Win10ent64de\sources\install.wim /Name:"Windows 10 1803 en-us" /MountDir:C:\image\offline #not working!! name wrong?


#fr
Dism /Mount-Image /ImageFile:C:\image\Win10ent64fr\sources\install.wim /Index:1 /MountDir:C:\image\offline

#en
Dism /Mount-Image /ImageFile:C:\image\Win10ent64en\sources\install.wim /Index:1 /MountDir:C:\image\offline

#de
Dism /Mount-Image /ImageFile:C:\image\Win10ent64de\sources\install.wim /Index:1 /MountDir:C:\image\offline

#en_only
Dism /Mount-Image /ImageFile:C:\image\Win10ent64en_only\sources\install.wim /Index:1 /MountDir:C:\image\offline

#1709 de
Dism /Mount-Image /ImageFile:"C:\image\1709 DE\sources\install.wim" /Index:3 /MountDir:C:\image\offline

#add lang pack
Dism /Image:C:\image\offline /ScratchDir:C:\Scratch /Add-Package /PackagePath:"C:\image\lang\Microsoft-Windows-Client-Language-Pack_x64_de-de.cab" 
Dism /Image:C:\image\offline /ScratchDir:C:\Scratch /Add-Package /PackagePath:"C:\image\lang\Microsoft-Windows-Client-Language-Pack_x64_fr-fr.cab"

#remove
Dism /Image:C:\image\offline /ScratchDir:C:\Scratch /Remove-Package /PackagePath:"C:\image\lang\Microsoft-Windows-Client-Language-Pack_x64_fr-fr.cab"

#set default lang
Dism /Image:C:\image\offline /Set-SKUIntlDefaults:de-de

Dism /Image:C:\image\offline /Set-SKUIntlDefaults:fr-fr

Dism /Image:C:\image\offline /Set-SKUIntlDefaults:en-us


Dism /Unmount-Image /MountDir:C:\image\offline /discard #/Commit

Dism /Image:C:\image\offline /Get-Intl

-----


cd "C:\image\Win101813orig\sources"
dism /Get-WimInfo /WimFile:install.wim
Dism /Mount-Image /ImageFile:C:\image\Win101813orig\sources\install.wim /Index:3 /MountDir:C:\image\offline

#Adding Windows Update Packages to the mounted WIM file
dism.exe /image:"C:\image\offline" /Add-Package /PackagePath:"C:\image\patch1803"

Dism /Unmount-Image /MountDir:C:\image\offline /Commit
