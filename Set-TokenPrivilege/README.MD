# Set-TokenPrivilege

One thing you sometimes run into when it comes to some management tasks is the concept of ‘Token Privileges’. Now these aren’t just privileges that Windows gives you to make you feel better - those are Token Compliments. Token Privileges are aspects of the things your user account can do, but you often don’t need that power enabled by default. For example, anybody can restart a computer, but windows doesn’t enable that privilege by default:

```
[C:\Users\leeholm]
PS:112 > whoami /priv

PRIVILEGES INFORMATION
----------------------

Privilege Name                Description                          State
============================= ==================================== ========
SeShutdownPrivilege           Shut down the system                 Disabled
SeChangeNotifyPrivilege       Bypass traverse checking             Enabled
SeUndockPrivilege             Remove computer from docking station Disabled
SeIncreaseWorkingSetPrivilege Increase a process working set       Disabled
```

When you try to run a command without a privilege enabled, you’ll usually get an ‘Access is Denied’ error. This doesn’t mean that you can’t do it -  just that you need to enable the privilege before doing it. However, if you’ve found this post, you probably know all of this :) PowerShell doesn’t ship a cmdlet to adjust token privileges by default, but Add-Type makes it very reasonable.

**Set-TokenPrivilege.ps1**, is a script developed by **Lee Holmes**, a specialist in precision computing, software design, and development, on September 24, 2010.

**Activate a Privilege**
To enable SeDebugPrivilege:

iex (iwr -Uri "https://github.com/CobblePot59/powershell/raw/master/Set-TokenPrivilege/Set-TokenPrivilege.ps1" -UseBasicParsing).Content; Set-TokenPrivilege.ps1 -Privilege SeDebugPrivilege

**Disable a Privilege**
To disable SeDebugPrivilege:

iex (iwr -Uri "https://github.com/CobblePot59/powershell/raw/master/Set-TokenPrivilege/Set-TokenPrivilege.ps1" -UseBasicParsing).Content; Set-TokenPrivilege.ps1 -Privilege SeDebugPrivilege -Disable

**Target Another Process**
To adjust the privilege for a specific process by its ID:

iex (iwr -Uri "https://github.com/CobblePot59/powershell/raw/master/Set-TokenPrivilege/Set-TokenPrivilege.ps1" -UseBasicParsing).Content; Set-TokenPrivilege.ps1 -Privilege SeDebugPrivilege -ProcessId 1234