#Узнаем дату - 21 день, так как это отчет за сутки
$today = (Get-Date) - (New-Timespan -day 21)
#Получаем информацию о бекапах из системного журнала
$Backup = Get-EventLog "application" -source "Backup" | `
Select-object -Property TimeWritten,Source,Message |`
Where-object -Filter {$_.TimeWritten -ge $today}

$result=$Backup |convertTo-Html -PreContent "<h3>Резервное копирование скриптом</h3>" -fragment -as table

echo $result