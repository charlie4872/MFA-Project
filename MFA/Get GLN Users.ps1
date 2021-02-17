<<<<<<< HEAD
(get-aduser -filter * -searchbase "DC=ga,DC=local") | Select-Object SamAccountName, Userprincipalname, Distinguishedname | export-csv .\GLN_Users.csv
=======
(get-aduser -filter * -searchbase "DC=ga,DC=local") | Select-Object SamAccountName, Userprincipalname, Distinguishedname | export-csv .\All_GLN_Users.csv
>>>>>>> parent of 8d8be07 (Update Get GLN Users.ps1)
