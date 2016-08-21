#Узнаем дату - 21 день, так как это отчет за сутки
$today = (Get-Date) - (New-Timespan -day 21)
#Получаем информацию о бекапах из системного журнала
$Backup =  Get-WinEvent "Microsoft-Windows-Backup" | `
Select-object -Property TimeCreated,Message |`
Where-object -Filter {$_.TimeCreated -ge $today}

$result=$Backup |convertTo-Html -PreContent "<h3>Резервное копирование Windows</h3>" -fragment -as table

echo $result