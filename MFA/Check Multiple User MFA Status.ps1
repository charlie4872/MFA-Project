$users = get-content c:\temp\users.txt
$results = foreach ($user in $users){
Get-MsolUser -UserPrincipalName $user | select DisplayName,UserPrincipalName,@{N="MFA Status"; E={ if( $_.StrongAuthenticationRequirements.State -ne $null){ $_.StrongAuthenticationRequirements.State} else { "Disabled"}}}}
$results | export-csv -path c:\temp\MFA_Enforcement.csv -NoTypeInformation