# Step 1: Define URLs and file paths
$latestVCURL = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$installerPath = "$env:TEMP\vc_redist.x64.exe"

# Step 2: Download the latest Visual C++ Redistributable
Invoke-WebRequest -Uri $latestVCURL -OutFile $installerPath

# Step 3: Install the latest version silently
Start-Process -FilePath $installerPath -ArgumentList "/install", "/quiet", "/norestart" -Wait

# Step 4: Uninstall an older version (example: 2015 version)
Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -like "Microsoft Visual C++ 2015*" -and $_.Name -notlike "*2022*"
} | ForEach-Object {
    $_.Uninstall()

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature" -Value 1

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature" -Value 1 

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "EnableSecuritySignature" -Value 1 

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "RequireSecuritySignature" -Value 1 

Set-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Control\LSA" -Name "RestrictAnonymous" -Value 1

Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "EnableSecuritySignature"

Get-ItemProperty-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "RequireSecuritySignature"

Get-ItemProperty-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "EnableSecuritySignature"

Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "RequireSecuritySignature"

Get-ItemProperty-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Control\LSA" -Name "RestrictAnonymous"
