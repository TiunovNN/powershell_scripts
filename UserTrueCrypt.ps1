#Путь к программе TrueCrypt, по умолчанию находится там
$TrueCrypt="c:\Program Files\TrueCrypt\TrueCrypt.exe"
#Пароль на контейнер
#Расположение контейнера
$PathContainer="D:\111.tc"
#Если контейнер не активирован, запускается активация
#Проверка диска контейнера
$check = Test-Path -path "p:\"
if ($check)
   {
   eventcreate /l "application" /t warning /so "Container" /id 1 /d "Контейнер уже активирован"
   exit
   }
else
   { 
        &$TrueCrypt /q /v /lp $PathContainer | out-null  
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