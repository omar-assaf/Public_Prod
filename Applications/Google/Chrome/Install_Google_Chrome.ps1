#  _____                                    _____ 
# ( ___ )                                  ( ___ )
#  |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | 
#  |   | ░█▀▀░█▀█░█▀▄░█▀▀░░░█░░░█▀█░█▀█░█▀▄ |   | 
#  |   | ░█░░░█░█░█░█░█▀▀░░░█░░░█░█░█▀█░█░█ |   | 
#  |   | ░▀▀▀░▀▀▀░▀▀░░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀▀░ |   | 
#  |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| 
# (_____)                                  (_____)
#
####################################################
#	X: omar_assaf
#    Omar Assaf
# You can distribute or re-use in any way, as long 
# as you give credit to initial script author ;)
####################################################
# Script to force cleaning of chrome before install
# Also it forces 64 bit over 32
####################################################
# Define variables for clarity and flexibility
$chrome32Path = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
$chrome64Path = "C:\Program Files\Google\Chrome\Application\chrome.exe"

# Check if 32-bit Chrome is installed
if (Test-Path $chrome32Path) {
    Write-Host "Found 32-bit Chrome. Uninstalling..."
    # Uninstall 32-bit Chrome gracefully
    try {
        $Chrome = Get-WmiObject  Win32_Product | Where-Object {$_.Name -like '*Chrome*' }
        foreach ($Product in $Chrome) { 
            $Product.Uninstall() 
            } 
        Write-Output "Google Chrome successfully uninstalled" 
        if ($? -ne 0) {
            Write-Warning "Failed to uninstall 32-bit Chrome gracefully. Using PowerShell Uninstall-Program cmdlet."
        }
    } catch {
        Write-Warning "Error uninstalling 32-bit Chrome: $($_.Exception.Message)"
    }
}
# Check if 64-bit Chrome is installed
if (!(Test-Path $chrome64Path)) {
Write-Host "Installing 64-bit Chrome..."
# Initiate Chrome 64-bit installation
try {
    New-Item -Path "C:\ProgramData\MSF\Logs" -ItemType Directory -Force > $null
    $mstPath = "$PSScriptRoot\OCB_Chrome.mst"
    $msiPath = "$PSScriptRoot\OCB_Chrome.msi"
    $arguments = "TRANSFORMS=$mstPath /qn /norestart /quiet /L*V C:\ProgramData\MSF\Logs\installation_Chrome.log"
    $SetupChrome = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$msiPath`" $arguments" -PassThru -NoNewWindow -Wait -ErrorAction SilentlyContinue
    If ($SetupChrome.ExitCode -ine 0) {
        Write-Error "Installation failed with a customized chrome package"
    }
}
    catch {
    Write-Error "Error installing 64-bit Chrome: $($_.Exception.Message)"
    }
}
 else {
    Write-Host "64-bit Chrome already installed."
}