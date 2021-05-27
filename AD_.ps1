	
#rename a computer
Add-Computer -DomainName techsys.local -ComputerName CVBIR19748 -newname NewTARGETCOMPUTER

#Get Group Membesrship from an account
Get-ADPrincipalGroupMembership <username> | select name
