#création des OU

Import-Module ActiveDirectory

try {
    New-ADOrganizationalUnit -Name "Direction" -Path "DC=entrepriseXY,DC=fr"
    Write-Host "OU Direction créée"
} catch {
    Write-Host "Erreur création OU Direction :" $_.Exception.Message
}

try {
    New-ADOrganizationalUnit -Name "RH" -Path "DC=entrepriseXY,DC=fr"
    Write-Host "OU RH créée"
} catch {
    Write-Host "Erreur création OU RH :" $_.Exception.Message
}

try {
    New-ADOrganizationalUnit -Name "Informatique" -Path "DC=entrepriseXY,DC=fr"
    Write-Host "OU Informatique créée"
} catch {
    Write-Host "Erreur création OU Informatique :" $_.Exception.Message
}

 #création des groupes
 New-ADGroup -Name "RH_Group" -GroupScope Global -Path "OU=RH,DC=entrepriseXY,DC=fr"
 New-ADGroup -Name "IT_Group" -GroupScope Global -Path "OU=Informatique,DC=entrepriseXY,DC=fr"
 New-ADGroup -Name "DR_Group" -GroupScope Global -Path "OU=Direction,DC=entrepriseXY,DC=fr"

 #création des utilisateurs

 New-ADUser -Name "jean dupont" -GivenName "jean" -Surname "dupont" -SamAccountName "jean" -UserPrincipalName "jean@entrepriseXY.fr" -Path "DC=entrepriseXY,DC=fr" -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force) -Enabled $true
New-ADUser -Name "paul garde" -GivenName "paul" -Surname "garde" -SamAccountName "paul" -UserPrincipalName "paul@entrepriseXY.fr" -Path "DC=entrepriseXY,DC=fr" -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force) -Enabled $true
New-ADUser -Name "tom ricard" -GivenName "tom" -Surname "ricard" -SamAccountName "tom" -UserPrincipalName "tom@entrepriseXY.fr" -Path "DC=entrepriseXY,DC=fr" -AccountPassword (ConvertTo-SecureString "P@ssword" -AsPlainText -Force) -Enabled $true

Add-ADGroupMember -Identity "IT_Group" -Members "jean"
Add-ADGroupMember -Identity "RH_Group" -Members "paul"
Add-ADGroupMember -Identity "DR_Group" -Members "tom"

Import-Module ActiveDirectory

# Nom de domaine NetBIOS
$domainNetBIOS = "entrepriseXY"

# Configuration des dossiers, groupes, permissions
$shares = @(
    @{
        Name = "Direction"
        FolderPath = "C:\Partages\Direction"
        ShareName = "Direction_Partage"
        GroupName = "$domainNetBIOS\DR_Group"
        Permissions = "FullControl"
    },
    @{
        Name = "RH"
        FolderPath = "C:\Partages\RH"
        ShareName = "RH_Partage"
        GroupName = "$domainNetBIOS\RH_Group"
        Permissions = "Modify"
    },
    @{
        Name = "Informatique"
        FolderPath = "C:\Partages\Informatique"
        ShareName = "Informatique_Partage"
        GroupName = "$domainNetBIOS\IT_Group"
        Permissions = "Modify"
    }
)

foreach ($share in $shares) {

    # Création du dossier s'il n'existe pas
    if (-Not (Test-Path -Path $share.FolderPath)) {
        New-Item -ItemType Directory -Path $share.FolderPath | Out-Null
        Write-Host "Dossier créé :" $share.FolderPath
    } else {
        Write-Host "Le dossier existe déjà :" $share.FolderPath
    }

    # Création du partage réseau
    $existingShare = Get-SmbShare -Name $share.ShareName -ErrorAction SilentlyContinue
    if ($existingShare) {
        Write-Host "Le partage $($share.ShareName) existe déjà."
    } else {
        New-SmbShare -Name $share.ShareName -Path $share.FolderPath -Description "Partage $($share.Name)" -FullAccess $share.GroupName
        Write-Host "Partage $($share.ShareName) créé avec accès complet pour $($share.GroupName)."
    }

    # Configuration des permissions NTFS
    $acl = Get-Acl -Path $share.FolderPath

    # Suppression des anciennes règles pour ce groupe (évite les doublons)
    $acl.Access | Where-Object { $_.IdentityReference -eq $share.GroupName } | ForEach-Object {
        $acl.RemoveAccessRule($_)
    }

    # Ajout de la règle d'accès
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        $share.GroupName,
        $share.Permissions,
        "ContainerInherit,ObjectInherit",
        "None",
        "Allow"
    )

    $acl.AddAccessRule($accessRule)
    Set-Acl -Path $share.FolderPath -AclObject $acl
    Write-Host "Permissions NTFS ($($share.Permissions)) appliquées pour $($share.GroupName) sur $($share.FolderPath)."
}

Write-Host "Script terminé."
