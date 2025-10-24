# Ajout les rôles nécessaires aux Services Bureau à distance : RD Session Host, RD Web Access et RD Connection Broker.
Install-WindowsFeature -Name RDS-RD-Server, RDS-Web-Access, RDS-Connection-Broker -IncludeManagementTools -Restart

#Création du deploiement RDS
New-RDSessionDeployment -ConnectionBroker "WIN-S6D1E9ODFO5.entrepriseXY.fr" -WebAccessServer "WIN-S6D1E9ODFO5.entrepriseXY.fr" -SessionHost "WIN-S6D1E9ODFO5.entrepriseXY.fr"

#Création de la collection de sessions Bureau à distance et attribution du groupe d'utilisateurs
New-RDSessionCollection -CollectionName "Collection_Bureau" -SessionHost "WIN-S6D1E9ODFO5.entrepriseXY.fr" -ConnectionBroker "WIN-S6D1E9ODFO5.entrepriseXY.fr" -CollectionDescription "Collection de sessions Bureau à distance"
Set-RDSessionCollectionConfiguration -CollectionName "Collection_Bureau" -UserGroup "entrepriseXY\Utilisateurs du domaine"

# Ajout des applications RemoteApp à la collection 
New-RDRemoteApp -CollectionName "Collection_Bureau" -DisplayName "Bloc-notes" -FilePath "C:\Windows\System32\notepad.exe"
New-RDRemoteApp -CollectionName "Collection_Bureau" -DisplayName "Calculatrice" -FilePath "C:\Windows\System32\calc.exe"
