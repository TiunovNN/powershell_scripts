#Папка резервных копий
$BackupPath="\\192.168.100.4\e\backup"
#Название контейнера
$containerName="111.tc"
#Папка контейнера
$ContainerPath="C:\Container"
#Количество дней содержания копии
$CountDay=14
#Проверка доступности каталога резервных копий
$Check=Test-Path $BackupPath
if (!$Check)
{
    eventcreate /l "application" /t error /so "Backup" /id 811 /d "Нет доступа к диску резервных копий" 
    exit
}
#Поиск и удаление старых копий

$ArrayName=@(Get-ChildItem $BackupPath)
if ($ArrayName.length -ne 0)
{
$RDate=(Get-Date).adddays(-$CountDay)
[DateTime[]]$ArrayDate=$Null
foreach ($Name in $arrayName)
{
    $ArrayDate+=[datetime]::ParseExact($Name,”d.MM.yyyy”,$null)
}
foreach ($DateCreate in $ArrayDate)
{
    if ($DateCreate -le $RDate)
    {
    $RemovePath=$BackupPath+"`\"+$dateCreate.ToString("d.MM.yyyy")
    Remove-Item $RemovePath -recurse
    }
}
}
#проверка контейнера и деактивация при необходимости
$check=Test-Path  "P:"
$TrueCrypt="c:\Program Files\TrueCrypt\TrueCrypt.exe"
if ($check)
   { 
        &$TrueCrypt /lp /f /d /q
   }
Start-sleep -second 3
#создание новой резервной копии
$source=$ContainerPath+"`\"+$ContainerName
$Destination=$BackupPath+"`\"+(Get-Date).ToString("d.MM.yyyy")
New-Item -Path $Destination -ItemType "directory"
$destination+="`\"+$ContainerName
$err=$Null
Copy-Item -Path $Source -Destination $destination -ErrorVariable +Err
if (!($?))
{
    eventcreate /l "application" /t Error /so "Backup" /id 812 /d "$Err"
}
else
{
    eventcreate /l "application" /t success /so "Backup" /id 810 /d "Резервная копия успешно создана"
}
