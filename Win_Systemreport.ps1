
#$CollectDir = "$env:USERPROFILE\Desktop\SYSTEMREPORT"
$CollectDir = "C:\temp\SYSTEMREPORT"
$DumpPath = "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl"

Function Get-DumpSettings([String]$Path)
{
    #Check that crash dump is enabled
    $crash = [int](Get-ItemProperty -Path $Path).CrashDumpEnabled
    If( $crash -ge 1 )
    {
        $dump = [String](Get-ItemProperty -Path $Path).MinidumpDir
        If($dump.Contains('%'))
        {
            "Enviroment variable detected, expanding..."
            $dump = $ExecutionContext.InvokeCommand.ExpandString($dump)
        }
        $dump
    } Else
    {
        #Prompt to enable crash dumps
        Write-Host "Crash Dump is not enabled" -ForegroundColor Red
        $input = Read-Host "Enable Small Memory Dump (Recommended)? [Y/N]"
        If($input.ToString().ToLower() -eq "y")
        {
            "Enabling Crash Dumps"
            Set-ItemProperty -Path $DumpPath -Name "CrashDumpEnabled" -Value 3
            "Run again when you have another BSOD"
            Exit
        } Else
        { Exit }
    }
}

Function Create-Archive([String]$DumpLocation)
{
    If(Test-Path -Path $CollectDir)
    {
        Remove-Item -Path $CollectDir -Force -Recurse
    }
 
    #Gather system information for troubleshooting
    New-Item -Path $CollectDir -ItemType Directory
    msinfo32 /nfo $CollectDir\MSINFO32.nfo
    Get-Content "C:\Windows\System32\drivers\etc\hosts" > $CollectDir\Hosts.txt
    Get-WindowsDriver -Online -All > $CollectDir\DriverList.txt
    dxdiag /t $CollectDir\Dxdiag.txt
    systeminfo > $CollectDir\SystemInfo.txt
    Get-EventLog -LogName Application -Newest 50 | FT -AutoSize | Out-String -Width 500 > $CollectDir\EventApplication.log
    Get-EventLog -LogName System -Newest 50 | FT -Wrap -AutoSize > $CollectDir\EventSystem.log
    Get-WindowsUpdateLog -LogPath $CollectDir\WindowsUpdate.Log

    #Copy DMP files to collection directory
    $DumpLocation
    If(Test-Path -Path $DumpLocation)
    {
        $dmp = Get-ChildItem -Path $DumpLocation -Filter "*.dmp"
        ForEach ($d In $dmp)
        {
            $d.FullName
            Copy-Item -Path $d.FullName -Force -Destination $CollectDir
        }
    }

    #Create Archive
    Add-Type -Assembly "system.io.compression.filesystem"
    $zip = "$CollectDir.zip"
    If(Test-Path -Path $zip) { Remove-Item -Path $zip -Force }
    [io.compression.zipfile]::CreateFromDirectory($CollectDir,$zip)
}

$dumpdir = Get-DumpSettings -Path $DumpPath
Create-Archive -DumpLocation $dumpdir