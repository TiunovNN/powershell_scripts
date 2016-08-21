$computers = Get-Content F:\111.txt;
foreach ($comp in $computers)
{
    Invoke-Command -ComputerName $comp -ScriptBlock {Set-ExecutionPolicy RemoteSigned -force}
    Copy-Item "P:\Папка обмена\admin\1с\8.3.7.1917" "\\$comp\C$" -recurse
    Invoke-Command -ComputerName $comp -FilePath "P:\Папка обмена\admin\1с\install.ps1"
}