#SMB and Null Session correction
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -Value 1

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature" -Value 1 

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "EnableSecuritySignature" -Value 1 

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "RequireSecuritySignature" -Value 1 

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymous" -Value 1

#Install 14.44 CPP Redis
$latestVCURL = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$installerPath = "$env:TEMP\vc_redist.x64.exe"

Invoke-WebRequest -Uri $latestVCURL -OutFile $installerPath

Start-Process -FilePath $installerPath -ArgumentList "/install", "/quiet", "/norestart" -Wait

# Birthday attack
Disable-TlsCipherSuite -Name 'TLS_RSA_WITH_3DES_EDE_CBC_SHA'

# 3D Viewer remover
Get-appxprovisionedpackage –online | where-object {$_.packagename –like “*Microsoft.Microsoft3DViewer*”} | Remove-AppxProvisionedPackage -online
