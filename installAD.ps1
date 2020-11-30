$forestmode = read-host "Entrer le numéro pour le forest mode"
$DomainMode = read-host "Entrer le numéri pour le domain mode"
$domainname = read-host "Entre le nom de domaine"
$netbiosname = read-host "entrer le netbios name"
$DatabasePath = read-host "Entrer le chemin pour la Base"
$LogPath = read-host "Entrer le chemin pour les journaux"
$sysvolPath = read-host "Entrer le chemin pour le sysvol"

function installWindowsFeature ()
{
    install-windowsfeature AD-Domain-Services
}

function createforest ()
{
    install-ADDSForest `
    -ForestMode $forestmode `
    -DomainMode $DomainMode `
    -DomainName $domainname `
    -DomainNetbiosName $netbiosname `
    -installDns:$true `
    -CreateDnsDelegation:$false `
    -DatabasePath $DatabasePath ` #Cérer un dossier BDD dans B:
    -LogPath $LogPath ` # Idem que BDD mais pour logs
    -sysvolpath $sysvolPath `
    -norebootoncompletion:$false ` #Fait un reboot
    -force:$true #Force l'application
}

function menu {

    write-host = "Merci de selectionner votre choix"
    write-host = "1 : Installer les Windows feature ADDS"
    write-host = "2 : Créer une forêt"
    write-host = "Q : Quitter"
    $choix=Read-Host "Votre choix?"

switch ($choix)
{
   1{installWindowsFeature;menu}
   2{createforest;menu}
   Q{Exit}
   default {menu} 
}
}
menu