#Узнаем дату - 7 день, так как это отчет за сутки
$today = (Get-Date) - (New-Timespan -day 7)
#Получаем ошибки из системного журнала
$errors = Get-EventLog System -EntryType Error | `
Select-object -Property TimeWritten,Source,Message |`
Where-object -Filter {$_.TimeWritten -ge $today}

$result=$errors |convertTo-Html -PreContent "<h3>Журнал ошибок</h3>" -fragment -as Table

echo $result