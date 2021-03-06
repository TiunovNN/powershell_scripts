#Путь к программе TrueCrypt, по умолчанию находится там
$TrueCrypt="c:\Program Files\TrueCrypt\TrueCrypt.exe"
#Пароль на контейнер
$Password="Qwerty123"
#Расположение контейнера
$PathContainer="D:\111.tc"

#Этот блок не трогать, используется для резервных копий
$Hour=(Get-Date).hour
if (($hour -eq 22) -or ($hour -eq 23)-or ($hour -eq 21)-or ($hour -eq 0))
{
    exit
}
#------------------------------------------------------


#Проверка диска контейнера
$check = Test-Path -path "p:\"
if ($check)
   {
   eventcreate /l "application" /t warning /so "Container" /id 1 /d "Контейнер уже активирован"
   exit
   }
else
   { 
        &$TrueCrypt /q /v /lp $PathContainer /p $Password| out-null  
   }
   start-sleep -seconds 3
$check = Test-Path -path "p:\"
if ($check)
    {  
    eventcreate /l "application" /t information /so "Container" /id 7 /d "Активация контейнера успешно произведена"
    }
else
    {
    eventcreate /l "application" /t error /so "Container" /id 2 /d "Произошла ошибка при активации"
    }    