(get-aduser -filter * -searchbase "DC=ga,DC=local") | Select-Object SamAccountName, Userprincipalname, Distinguishedname | export-csv .\GLN_Users.csv
