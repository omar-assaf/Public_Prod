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
# Get all Users
$Users = Get-ChildItem -Path "$($ENV:SystemDrive)\Users"

# Process all the Users
$Users | ForEach-Object {
Write-Host "Process user: $($_.Name)" -ForegroundColor Yellow

#Locate installation folder
$TeamsAppData = "$($ENV:SystemDrive)\Users\$($_.Name)\AppData\Local\Microsoft\Teams"

If (Test-Path "$($TeamsAppData)\Update.exe") 
{
Stop-Process -name teams -force
Start-Process "$TeamsAppData\Update.exe" -ArgumentList "--uninstall -s" -PassThru -Wait
Remove-Item $TeamsAppData -force -Recurse
Remove-Item "C:\Users\$($_.Name)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Microsoft Teams.lnk" -Force
}
Else
{
Write-Warning  "Teams installation not found for user $($_.Name)"
}
}