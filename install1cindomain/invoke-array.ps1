$computers = Get-Content C:\script\computers.txt;
foreach ($comp in $computers)
{
    echo "Устанавливаем Политику исполнения $comp"
    Invoke-Command -ComputerName $comp -ScriptBlock {Set-ExecutionPolicy RemoteSigned -force}
    echo "копируем 1с на $COMP"
    Copy-Item "P:\Папка обмена\admin\1c\8.3.7.1917" "\\$comp\C$" -recurse -force
    echo "копируем скрипт"
    Copy-Item "C:\script\install.ps1" "\\$comp\C$\"
    echo "выполняем скрипт на $comp"
    Invoke-Command -ComputerName $comp -ScriptBlock {powershell -file "C:\install.ps1"}
    echo "удаляем скрипт $comp"
    Remove-Item "\\$comp\C$\install.ps1"
   }