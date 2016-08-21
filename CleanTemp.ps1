$OtherCleanPathsArr = “C:\Temp\*”, “C:\Windows\Temp\*”, “C:\swsetup”
#системные пути для очистки
$InProfilesCleanPathsArr = "\AppData\Roaming\Bitrix\*","\AppData\Local\Google\Chrome\User Data\Default\Cache\*",“\AppData\Local\Temp\*”, “\AppData\Local\*.auc”, "\AppData\Local\Google\Chrome\User Data\Default\Cache\*", “\AppData\Local\Microsoft\Terminal Server Client\Cache\*”, “\AppData\Local\Microsoft\Windows\Temporary Internet Files\*”, “\AppData\Local\Microsoft\Windows\WER\ReportQueue\*”, “\AppData\Local\Microsoft\Windows\Explorer\*”
#пути в профилях для очистки
$Profiles = Get-ChildItem (Get-ItemProperty -path “HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList”).ProfilesDirectory -Exclude “Administrator”, “Setup”, “Public”, “All Users”, “Default User”
#извлекли из реестра местоположение профилей, сформировали список

ForEach ($Path in $OtherCleanPathsArr) {
Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue 
}
ForEach ($Profile in $Profiles) {
ForEach ($Path in $InProfilesCleanPathsArr) {
Remove-Item -Path $Profile$Path -Recurse -Force -ErrorAction SilentlyContinue 
}
}