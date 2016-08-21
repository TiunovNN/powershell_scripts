$computers = Get-Content C:\script\computers.txt;
foreach ($comp in $computers)
{
    echo "Ищем папку с дистрибутивом на $comp"
    $test1 = Test-Path "\\$comp\C$\8.3.7.1917"
    if ($test1)
    {
        echo "Удаляем папку с дистрибутивом на $comp"
        Remove-Item "\\$comp\C$\8.3.7.1917" -recurse -force
    }
    echo "Ищем log-file на $comp"
    $test1 = Test-Path "\\$comp\C$\111.log"
    if ($test1)
    {
        echo "Удаляем log-file"
        Remove-Item "\\$comp\C$\111.log" -force
    }
    echo "Ищем install.ps $comp"
    $test1 = Test-Path "\\$comp\C$\install.ps1"
    if ($test1)
    {
        echo "Удаляем install.ps1"
        Remove-Item "\\$comp\C$\install.ps1" -force
    }
   }