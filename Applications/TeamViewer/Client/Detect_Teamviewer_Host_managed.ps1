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
# as you give credit to initial script author ;)
####################################################
#Announce the path of OCB TV installation
$Path = "HKLM:\SOFTWARE\TeamViewer"

#Get the value of the key that identify MSFOCB auto Teamviewer assignment
$Version = Get-ItemPropertyValue -Path $Path -Name "Version" -ErrorAction SilentlyContinue
$Assigned = Get-ItemPropertyValue -Path $Path -Name "Device_Auto_Assigned_To_Account" -ErrorAction SilentlyContinue

if(($Version -like "* HC") -and ($Assigned -eq "1"))
{
Write-Host "Teamviewer Host for enterprise is detected and assigned."
exit 0
}
else
{
Write-Host "Non-Standard Teamviewer Host installation detected."
exit 1
}