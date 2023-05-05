$wifi=@()

$cmd1=netsh wlan show profiles
ForEach($row1 in $cmd1)
{
   
    If($row1 -match 'Profil Tous les utilisateurs[^:]+:.(.+)$')
    {
        $ssid=$Matches[1]
        $cmd2=netsh wlan show profiles $ssid key=clear
        ForEach($row2 in $cmd2)
        {
            
            If($row2 -match 'Contenu de la c[^:]+:.(.+)$')
            {
                $key=$Matches[1]
               
                $wifi+=[PSCustomObject]@{ssid=$ssid;key=$key}
            }
        }
    }
}
$wifi | Format-Table ssid, key -AutoSize
exit
