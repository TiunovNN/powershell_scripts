$Path = 'C:\8.3.7.1917'
C:\windows\system32\msiexec.exe /i "$path\1CEnterprise 8.msi" /L*V "C:\111.log" /qn TRANSFORMS="$path\adminstallrelogon.mst;$path\1049.mst" DESIGNERALLCLIENTS=1 THICKCLIENT=1 THINCLIENTFILE=1 THINCLIENT=1 WEBSERVEREXT=0 SERVER=0 CONFREPOSSERVER=0 CONVERTER77=0 SERVERCLIENT=0 LANGUAGES=RU
$test1 = Test-Path "C:\Program Files (x86)\1cv8\8.3.7.1917\bin"
$test2 = Test-Path "C:\Program Files\1cv8\8.3.7.1917\bin"
if ($test1)
{
    Copy-Item "$Path\backbas.dll" "C:\Program Files (x86)\1cv8\8.3.7.1917\bin\" -force
}
if ($test2)
{
    Copy-Item "$Path\backbas.dll" "C:\Program Files\1cv8\8.3.7.1917\bin\" -force
}