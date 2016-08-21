#Название группп
$group=Get-ADGroup "Пользователи удаленного рабочего стола"
#Список пользователей для исключения
$exclude="Администратор","admin"
#путь для выгрузки файла
$OutPath="\\192.168.122.1\backuping\Пароли.csv"
$names = Get-ADUser -Filter {MemberOf -recursivematch $group.DistinguishedName}
$results=@()
foreach ($name in $names)
{
    if($name.Enabled -and $name.SamAccountName -notin $exclude)
    {
        
        do{
        $Error.Clear()
        get-random -count 8 -input (48..57 + 65..90 + 97..122) | % -begin { $pass = $null } -process {$pass += [char]$_}
        $passSecure=ConvertTo-SecureString -AsPlainText -String $pass -Force
        $check=Set-ADAccountPassword $name.SamAccountName -NewPassword $passSecure -Reset
        } while($Error)
        $details = @{  
                Имя = $name.Name 
                Логин = $name.SamAccountName                    
                Пароль = $pass      
        }                           
        $results += New-Object PSObject -Property $details  
 
    }
}
echo $results
$results | export-csv -Path $OutPath -NoTypeInformation -UseCulture -Encoding UTF8