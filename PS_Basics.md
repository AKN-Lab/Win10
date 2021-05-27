Usefull Pipes
| Out-GridView



Gal 	Aliases 	 
gal s* 	 
Gal *sv 

set-location C:\ 	 	 

dir 	 	 

start-transcript 	 	Start allways with “start-transcript” to log everything!! 

get-command -noun  	service 	 

Get-help 	-example, -online 	 

Get-alias 	cls 	 

Get-process 	Get-Process -name MicrosoftEdge | select-object 	 
	 
Get-history


## REMOTE
#Powershell

Remote

Target PC:
 - winrm quickconfig
	or
 - Enable-PSRemoting -force


Configuring WinRM for PowerShell Remoting

	get-service winrm

	Enable-PSRemoting

if it is in workgroup
	
	Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any

	Test-WSMan server1


Running Remote Commands with PowerShell Remoting

	Enter-PSSession Server1

	Exit-PSSession




Using Invoke-Command to Run PowerShell Scripts Remotely

	Invoke-Command -ScriptBlock {Restart-Service spooler} -ComputerName server1
	Invoke-Command -ScriptBlock {cmd /c sc query wuauserv} -ComputerName WMA403971
	
	$cred = Get-Credential
	
	Invoke-Command -FilePath c:\ps\tune.ps1 -ComputerName server1,server2,server3 -Credential $cred
	
	Invoke-command -comp (get-content c:\ps\servers.txt) -filepath c:\ps\tune.ps1
	
	dism.exe /Online /Get-Intl
	
	https://theitbros.com/run-powershell-script-on-remote-computer/
	
	
	$cred = Get-Credential axusr\aakilnada
	
	$dc1 = New-PSSession -ComputerName WMA403971 -Credential $cred
	
	Enter-PSSession -Session $dc1
	
	gwmi win32_bios
	
	gwmi sysdriver get /value|find "CnxtHdAudService"
	
	exit
	
	Get-PSSession | Remove-PSSession
	

Invoke-Command -ScriptBlock {cmd /c sfc /scannow} -ComputerName PC1001

