$computers = Get-Content C:\script\computers.txt;
foreach ($comp in $computers)
{
    echo "Ищем в Program Files на $comp"
    $test1 = Test-Path "\\$comp\C$\Program Files\1cv8\8.3.7.1917\bin"
    if ($test1)
    {
        echo "Копируем backbas.dll в Program Files"
        Copy-Item "D:\8.3.7.1917\backbas.dll" "\\$comp\C$\Program Files\1cv8\8.3.7.1917\bin" -force
    }
    echo "Ищем в Program Files(x86) на $comp"
    $test1 = Test-Path "\\$comp\C$\Program Files (x86)\1cv8\8.3.7.1917\bin\"
    if ($test1)
    {
        echo "Копируем backbas.dll в Program Files (x86)"
        Copy-Item "D:\8.3.7.1917\backbas.dll" "\\$comp\C$\Program Files (x86)\1cv8\8.3.7.1917\bin\" -force
    }
   }