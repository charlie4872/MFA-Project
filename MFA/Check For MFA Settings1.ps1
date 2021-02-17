$computer = read-host -prompt 'Enter Computername'
$user = read-host -prompt 'Enter Username'
$UserObject = Get-Aduser -identity $user
Write-Host 'This value should be 2'
invoke-command -computer $computer -scriptblock {(New-PSDrive -psprovider registry -Name HKU -Root HKEY_USERS),(Get-ItemProperty "hku:\$($Using:UserObject.SID)\SOFTWARE\Microsoft\Office\15.0\Common\Internet" -Name UseOnlineContent) | findstr UseOnlineContent}