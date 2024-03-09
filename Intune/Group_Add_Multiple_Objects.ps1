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
# This script will let you add a list devices enrolled
# in intune using only thier serial numbers to security
# groups, using MSGraph powerShell.
####################################################
#Connect MS GRAPH Powershell SDK
Connect-MgGraph
#import device Managment Graph module
Import-Module Microsoft.Graph.DeviceManagement
#import directory managment module
Import-Module Microsoft.Graph.Identity.DirectoryManagement
#import Group Graph module
Import-Module Microsoft.Graph.Groups
#Define the group ID which objects will be added to
$GroupID = "0a90251a-bd9e-430d-86e5-88eb04c5d24b"
$Groupdetails = (Get-MgGroup -GroupId $GroupId).DisplayName

$DeviceList = Import-Csv "C:\Users\oas\Downloads\DeviceList.csv"
ForEach ($SerialNumber in $DeviceList.SN) {
	$DeviceIntuneIDlist = Get-MgDeviceManagementManagedDevice -Filter "serialNumber eq '$SerialNumber'" -Property "id" 
	ForEach ($DeviceIntuneID in $DeviceIntuneIDlist.Id) {
    		$EntraDeviceIDlist = Get-MgDevice -CountVariable CountVar -Search deviceId:$DeviceIntuneID -Property "Id"  -ConsistencyLevel eventual
        	ForEach ($DeviceEntraID in $EntraDeviceIDlist.Id)
				{
        			New-MgGroupMember -GroupId $GroupsID -DirectoryObjectId $DeviceEntraID
				}
				Write-Host "Serial Number=$SerialNumber DeviceIntuneID=$DeviceIntuneID  DeviceEntraID=$DeviceEntraID added $Groupdetails" -ForegroundColor green
	}
}