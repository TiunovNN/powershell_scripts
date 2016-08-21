#проверяем свободное место на дисках
$HD=Get-WmiObject -Class win32_volume -computer "localhost" | Select-object `
-property Name,Label,FreeSpace,Capacity | `
Where-Object –Filter {$_.Name -notlike "\\*" -and $_.Capacity -ne $Null}

foreach ($cycle in $HD)
{
    $Cycle.FreeSpace = [math]::round($cycle.Freespace/1GB,2)
    $Cycle.Capacity = [math]::round($cycle.Capacity/1GB,2)  

}

echo $HD | convertTo-html -PreContent "<H3>Диски</h3>" -Fragment -As Table