#UserRights

Blake Drumm provides a collection of PowerShell scripts, published on January 5, 2022, designed to efficiently manage User Rights Assignments either remotely or locally. These scripts, available in the [SCOM-Scripts-and-SQL](https://github.com/blakedrumm/SCOM-Scripts-and-SQL/tree/master) GitHub repository, allow administrators to add, remove, and check user rights on Windows environments.

##Add Users
###Example 1

Add User Right “Allow log on locally” for current user:

```
.\Set-UserRights.ps1 -AddRight -UserRight SeInteractiveLogonRight
```

###Example 2

Add User Right “Log on as a service” for CONTOSO\User:

```
.\Set-UserRights.ps1 -AddRight -Username CONTOSO\User -UserRight SeServiceLogonRight
```

###Example 3

Add User Right “Log on as a batch job” for CONTOSO\User:

```
.\Set-UserRights.ps1 -AddRight -Username CONTOSO\User -UserRight SeBatchLogonRight
```

###Example 4

Add User Right “Log on as a batch job” for user SID S-1-5-11:

```
.\Set-UserRights.ps1 -AddRight -Username S-1-5-11 -UserRight SeBatchLogonRight
```

##Add Multiple Users / Rights / Computers

###Example 5

Add User Right “Log on as a service” and “Log on as a batch job” for CONTOSO\User1 and CONTOSO\User2 and run on, local machine and SQL.contoso.com:

```
.\Set-UserRights.ps1 -AddRight -UserRight SeServiceLogonRight, SeBatchLogonRight -ComputerName "$env:COMPUTERNAME", "SQL.contoso.com" -UserName "CONTOSO\User1", "CONTOSO\User2"
```

 

##Remove Users
###Example 1

Remove User Right “Allow log on locally” for current user:

```
.\Set-UserRights.ps1 -RemoveRight -UserRight SeInteractiveLogonRight
```

###Example 2

Remove User Right “Log on as a service” for CONTOSO\User:

```
.\Set-UserRights.ps1 -RemoveRight -Username CONTOSO\User -UserRight SeServiceLogonRight
```

###Example 3

Remove User Right “Log on as a batch job” for CONTOSO\User:

```
.\Set-UserRights.ps1 -RemoveRight -Username CONTOSO\User -UserRight SeBatchLogonRight
```

###Example 4

Remove User Right “Log on as a batch job” for user SID S-1-5-11:

```
.\Set-UserRights.ps1 -RemoveRight -Username S-1-5-11 -UserRight SeBatchLogonRight
```

##Remove Multiple Users / Rights / Computers

###Example 5

Remove User Right “Log on as a service” and “Log on as a batch job” for CONTOSO\User1 and CONTOSO\User2 and run on, local machine and SQL.contoso.com:

```
.\Set-UserRights.ps1 -RemoveRight -UserRight SeServiceLogonRight, SeBatchLogonRight -ComputerName "$env:COMPUTERNAME", "SQL.contoso.com" -UserName "CONTOSO\User1", "CONTOSO\User2"
```

##Check User Rights

###Local Computer

Get Local User Account Rights and output to text in console:

```
.\Get-UserRights.ps1
```
```
.\Get-UserRights.ps1 -UserName DOMAIN\Username
```

###Remote Computer

Get Remote SQL Server User Account Rights:

```
.\Get-UserRights.ps1 -ComputerName SQL.contoso.com
```

Get Local Machine and SQL Server User Account Rights:

```
.\Get-UserRights.ps1 -ComputerName "$env:COMPUTERNAME", "SQL.contoso.com"
```

###Output Types

Output Local User Rights on Local Machine as CSV in ‘C:\Temp’:

```
.\Get-UserRights.ps1 -FileOutputPath C:\Temp -FileOutputType CSV
```

Output to Text in ‘C:\Temp’:

```
.\Get-UserRights.ps1 -FileOutputPath C:\Temp -FileOutputType Text
```

```
.\Get-UserRights.ps1 -FileOutputPath C:\Temp
```

PassThru object to allow manipulation / filtering:

```
.\Get-UserRights.ps1 -ComputerName SQL.contoso.com -UserName DOMAIN\SQLUser -PassThru | Where-Object {$_.Privilege -match 'SeInteractiveLogonRight'}
```

```
.\Get-UserRights.ps1 -PassThru | Where-Object {$_.Privilege -match 'SeServiceLogonRight'}
```