#Powershell v4
##Requires -RunAsAdministrator

$who=New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$RunAsAdmin=$who.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($RunAsAdmin -eq $False)
{
	Write-Host "Please launch as Administrator"
	Start-Sleep -s 3
	exit
}
else
{
	$name=Read-Host -Prompt "Server Name: "
	$ip=Read-Host -Prompt "Server ip: "
	$dns=$ip + " " + $name

	Add-Content -Path C:\Windows\System32\drivers\etc\hosts -Value $dns
	#Set-NetConnectionProfile -Name "*" -NetworkCategory Private
	winrm quickconfig
	set-item wsman:\localhost\Client\TrustedHosts -value "$name"
	cmdkey.exe /add:$name /user:Administrator /pass
}
