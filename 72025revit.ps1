# SMB Fix
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -Value 1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature" -Value 1 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "EnableSecuritySignature" -Value 1 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "RequireSecuritySignature" -Value 1 

# Null Session Fix
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymous" -Value 1

# Set both values to 1 (DWORD)
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\HTTP\Parameters" -Name "EnableHttp2Tls" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\HTTP\Parameters" -Name "EnableHttp2Cleartext -Value 1 -PropertyType DWord -Force

# Check if creating/value setting worked
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Paramaters\EnabledSecuritySignature"
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Paramaters\RequireSecuritySignature"
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Paramaters\EnabledSecuritySignature"
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Paramaters\RequireSecuritySignature"
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\RestrictAnonymous"
Get-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\HTTP\Parameters\EnableHttp2Tls"
Get-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\HTTP\Parameters\EnableHttp2Cleartext"

# Install CPP Redis
# Variables for latest version download and temp dlownload location
$latestVCURL = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$installerPath = "$env:TEMP\vc_redist.x64.exe"

# Download command
Invoke-WebRequest -Uri $latestVCURL -OutFile $installerPath

# Install command
Start-Process -FilePath $installerPath -ArgumentList "/install", "/quiet", "/norestart" -Wait

# Remove all DotNet installs
winget list "Microsoft .NET Desktop Runtime"
winget uninstall "Microsoft .NET Desktop Runtime"
# winget uninstall "Microsoft .NET Desktop Runtime 8"

# Install DotNet 9
winget install Microsoft.DotNet.DesktopRuntime.9
