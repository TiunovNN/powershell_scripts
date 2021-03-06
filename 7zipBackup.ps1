#Папка резервных копий
$BackupPath="D:\backup"
#Промежуточный каталог
$TempPath="E:\"
#Название контейнера
#Папка контейнера
$SourcePath=New-Object 'object[]' 1
$SourcePath[0]=@{"path"="E:\temp"; "name"="temp"}
#Количество дней содержания копии
$CountDay=21
#Проверка доступности каталога резервных копий
$Check=Test-Path $BackupPath
$7zipPath="C:\Program Files\7-Zip\7z.exe"
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
#создание новой резервной копии
$source=$Null
$Destination=$BackupPath
$Destination+="`\"+(Get-Date).ToString("d.MM.yyyy")
New-Item -Path $Destination -ItemType "directory"
foreach ($_ in $SourcePath)
    { 
    $err=$Null
    $dest=$TempPath+"`\"+$_.name+".7z"
    #$err+= &$7zipPath a -ssw -mx2 $dest $_.path | Out-String
    $err1=$null
    $Err=$Err -split "`n"
    foreach ($Line in $err)
        {
        if (-Not $Line.StartsWith("Compressing"))
            {
            $Err1+=$Line
            }
        }
    #Copy-Item -path $dest -Destination $Destination -force -recurse
    remove-item $dest -force
    $text="Резервная копия "+$_.name+" успешно завершена"
    eventcreate /l "application" /t success /so "Backup" /id 810 /d "$text"
    eventcreate /l "application" /t success /so "Backup" /id 810 /d "$Err1"
    }
