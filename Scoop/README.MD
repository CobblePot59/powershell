# Scoop
A command-line installer for Windows

## Quickstart
Open a PowerShell terminal (version 5.1 or later) and from the PS C:\> prompt, run:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

## What does Scoop do?
Scoop installs programs you know and love, from the command line with a minimal amount of friction. It:
- Eliminates permission popup windows
- Hides GUI wizard-style installers
- Prevents PATH pollution from installing lots of programs
- Avoids unexpected side-effects from installing and uninstalling programs
- Finds and installs dependencies automatically
- Performs all the extra setup steps itself to get a working program

Scoop downloads and manages packages in a portable way, keeping them neatly isolated in ~\scoop. It won't install files outside its home, and you can place a Scoop installation wherever you like.
```
> dir ~\scoop

    Directory: C:\Users\User\scoop

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
da---          02-04-2022    16:06                apps
d----          30-03-2022    13:22                buckets
d----          02-04-2022    16:06                cache
da---          30-03-2022    21:32                persist
da---          02-04-2022    16:06                shims
d----          20-02-2022    01:22                workspace
```
