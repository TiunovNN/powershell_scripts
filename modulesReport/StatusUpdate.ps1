$Status=Get-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" -name "AUOptions"

Switch ($Status.auOptions)
    {
        1 {$State="Не проверять наличие обновлений"}
        2 {$State="Искать обновления, но решения о скачивании и установке принимается мной"}
        3 {$State="Скачивать обновления, но решение об установке принимается мной"}
        4 {$State="<h3><font color=red>Устанавливать обновления автоматически</font></h3>"}
        default {$State="Неизвестный параметр"}
    }
$result="<h3>Параметры обновления</h3><br>"+$State
echo $result