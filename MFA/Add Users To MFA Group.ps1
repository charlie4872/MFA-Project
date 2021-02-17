#Add list of users (samaccountname) in a .csv file to a specified AD Group. Use column A with header of USERNAME and then the samaccount
#names listed below that.

Import-Module ActiveDirectory 
Import-Csv -Path "C:\scripts\OFFICE365\MFA Scripts\STP_MFA.csv" | ForEach-Object {Add-ADGroupMember -Identity 'Microsoft Users MFA GA - O365' -Members $_.'username'}