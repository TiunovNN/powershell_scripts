#Проверяем файл
$test = Test-Path "\\ts2\logs\1.png"
#если файла нет выполняем
if (-Not $test)
{
    #выключаем компьютер
    Stop-Computer -Force
}