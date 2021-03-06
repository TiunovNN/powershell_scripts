$exclude="Администратор","admin"
$OutPath="\\192.168.122.1\backuping\Пароли.csv"
$results=@()
$LocalGroup =[ADSI]"WinNT://Localhost/Пользователи удаленного рабочего стола"
$UserNames = @($LocalGroup.psbase.Invoke("Members"))
$UsersList=$UserNames | foreach {$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
foreach ($user in $UsersList)
{
    if($exclude -NotContains $user)   
    {
        $UserObject=[ADSI]"WinNT://Localhost/$user"
        do{
            $Error.Clear()
            get-random -count 8 -input (48..57 + 65..90 + 97..122) | % -begin { $pass = $null } -process {$pass += [char]$_}
            $UserObject.SetPassword($pass)
        } while($Error)
        $details = @{  
                Логин = $user                    
                Пароль = $pass      
        }                           
        $results += New-Object PSObject -Property $details  
    }
   
    
}
echo $results
$results | export-csv -Path $OutPath -NoTypeInformation -UseCulture -Encoding UTF8