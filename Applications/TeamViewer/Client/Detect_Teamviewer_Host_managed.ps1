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
#Announce the path of OCB TV installation
$Path = "HKLM:\SOFTWARE\WOW6432Node\TeamViewer"

#Get the value of the key that identify MSFOCB auto Teamviewer assignment
$Version = Get-ItemPropertyValue -Path $Path -Name "Version"
$Assigned = Get-ItemPropertyValue -Path $Path -Name "Device_Auto_Assigned_To_Account"

if(($Version -like "* HC") -and ($Assigned -eq "1"))
{
Write-Host "Client Installed"
exit 0
}
else
{
Write-Host "Non-Standard Teamviewer Client"
exit 1
}