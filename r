
$wifi=@()
#Visualisation des réseaux bloqués
$cmd0=netsh wlan show blockednetworks
#Liste des SSID
$cmd1=netsh wlan show profiles
ForEach($row1 in $cmd1)
{
    #Récupération des ssids par expression régulière
    If($row1 -match 'Profil Tous les utilisateurs[^:]+:.(.+)$')
    {
        $ssid=$Matches[1]
        $cmd2=netsh wlan show profiles $ssid key=clear
        ForEach($row2 in $cmd2)
        {
            #Récupération des clés par expression régulière
            If($row2 -match 'Contenu de la c[^:]+:.(.+)$')
            {
                $key=$Matches[1]
                #Stockage des ssids et des clés dans un tableau
                $wifi+=[PSCustomObject]@{ssid=$ssid;key=$key}
            }
        }
    }
}
$wifi | format-table