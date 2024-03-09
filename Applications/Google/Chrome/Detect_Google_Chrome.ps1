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
#
$Chrome64Path = "$Env:ProgramFiles\Google\Chrome\Application\chrome.exe"
$Chrome32Path = "${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
#
# get the product name of the installed version
If(([String](Get-Item -Path $Chrome64Path, $Chrome32Path -ErrorAction SilentlyContinue).VersionInfo.ProductVersion) -ge 113)
{
    Write-Host "Chrome is Installed & Updated"
    Exit 0
    }
    Else 
    {
    Write-Host "Chrome is NOT found or incorrect version"
    Exit 404
}