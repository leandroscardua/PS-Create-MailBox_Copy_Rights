Import-Module ActiveDirectory

write-output "Create a user on Exchange and make a sync with AD "

$srcPname = Read-Host "Please Enter a Email (ex: leandros@paradox.com) "
$srcAlias = Read-Host "Please Enter a Login name ( ex: leandros ) "
$srcName = Read-Host "Please Enter a Full Name ( ex: Leandro Scardua ) " 
$srcFname = Read-Host "Please Enter a First name ( ex: Leandro )  " 
$srcLname = Read-Host "Please Enter a Last name  ( ex: Scardua ) " 
$srcPassword = Read-Host "Please Enter a Password" 

New-RemoteMailbox -UserPrincipalName "$srcPname" -Alias "$srcAlias" -Name "$srcName" -FirstName "$srcFname" -LastName "$srcLname" -OnPremisesOrganizationalUnit "Users" -Password (ConvertTo-SecureString "$srcPassword" -AsPlainText -Force) -ResetPasswordOnNextLogon $false

write-output "" 

write-output "This script allows to copy a user's group and copy it to other user, the script collect information from the member of tab."

write-output ""
 
$srcUser = Read-Host "Please Enter the login of the source user (ex: leandros ) " 
$destUser = Read-Host "Please Enter the login of the Destination user (ex: leandros)  " 

foreach ($group in (Get-ADUser -Identity $srcUser -Properties MemberOf).MemberOf) {   Add-ADGroupMember -Identity $group -Members $destUser; }

write-output "" 

write-output "Finished successfully " 