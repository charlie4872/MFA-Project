$Result=@()
# Read and Iterate CSV file
Import-Csv '.\userlist.csv' | ForEach-Object {
# Read UserPrincipalName field from CSV row
$upn = $_."UserPrincipalName"
$user = Get-MsolUser -UserPrincipalName $upn -ErrorAction SilentlyContinue
$mfaStatus = $user.StrongAuthenticationRequirements.State 
$methodTypes = $user.StrongAuthenticationMethods 
  
if ($user -ne $null -and ($mfaStatus -ne $null -or $methodTypes -ne $null))
{
if($mfaStatus -eq $null)
{ 
$mfaStatus='Enabled (Conditional Access)'
}
$authMethods = $methodTypes.MethodType
$defaultAuthMethod = ($methodTypes | Where{$_.IsDefault -eq "True"}).MethodType 
$verifyEmail = $user.StrongAuthenticationUserDetails.Email 
$phoneNumber = $user.StrongAuthenticationUserDetails.PhoneNumber
$alternativePhoneNumber = $user.StrongAuthenticationUserDetails.AlternativePhoneNumber
}
Else
{
$mfaStatus = "Disabled"
if($user -eq $null)
{ 
$mfaStatus='User not found'
}
$defaultAuthMethod = $null
$verifyEmail = $null
$phoneNumber = $null
$alternativePhoneNumber = $null
}
     
$Result += New-Object PSObject -property @{ 
UserName = $user.DisplayName
UserPrincipalName = $user.UserPrincipalName
MFAStatus = $mfaStatus
AuthenticationMethods = $authMethods
DefaultAuthMethod = $defaultAuthMethod
MFAEmail = $verifyEmail
PhoneNumber = $phoneNumber
AlternativePhoneNumber = $alternativePhoneNumber
}
}
$Result | Export-CSV ".\O365-Users-MFA-Details.csv" -NoTypeInformation -Encoding UTF8