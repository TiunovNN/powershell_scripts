#Путь к программе TrueCrypt, по умолчанию находится там
$TrueCrypt="c:\Program Files\TrueCrypt\TrueCrypt.exe"
#Пароль на контейнер
$Password=""
#Расположение контейнера
$PathContainer=""
#Этот блок не трогать, используется для резервных копий
$Hour=(Get-Date).hour
if (($hour -eq 22) -or ($hour -eq 23)-or ($hour -eq 21)-or ($hour -eq 0))
{
    exit
}
#------------------------------------------------------

#Если контейнер не активирован, запускается активация
#Проверка диска контейнера
$check = Test-Path -path "p:\"
if (!$check)
   { 
        &$TrueCrypt /q /v /lp $PathContainer /p $Password
   }
start-sleep -second 15
#Проверка общей папки на контейнере, при отсутствии расшаривается.
$ShareName="Shared"
$SharePath="P:\DB\shared"
$check = Test-Path -path "\\localhost\Shared"
if (!$check)
   {
        net share $ShareName=$Share "/GRANT:Все,CHANGE"
   }
