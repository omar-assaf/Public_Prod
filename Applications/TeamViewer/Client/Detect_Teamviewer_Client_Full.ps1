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
# Define variables for TV Full installation
# Those registery keys are only available for the FULL version
$TVC = "HKLM:\SOFTWARE\Classes\.tvc"
$TVS = "HKLM:\SOFTWARE\Classes\.tvs"
$Path = 'HKLM:\SOFTWARE\WOW6432Node\TeamViewer'

#Get the value of the key that identify MSFOCB auto Teamviewer assignment
$Assigned = (Get-ItemProperty -Path $Path).Device_Auto_Assigned_To_Account

# Test if those three keys exist, if they do that means Teamviewer Full is installed
# and the Teamviewer version is assigned to MSFOCB account
if ((Test-Path -Path $TVC ) -and (Test-Path -Path $TVS ) -and ($Assigned -eq "1" )) 
    {
    Write-Output "TeamViewer Full & proper version is installed"
    Exit 0
    }
else {
    Write-Output "TeamViewer is not installed"
    exit 1
    }
# End of detection script