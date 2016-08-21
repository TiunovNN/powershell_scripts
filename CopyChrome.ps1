$InProfilesPathsArr = "\AppData\Local\Google\Chrome\User Data\Default\*”
#пути в профилях для копирования
$DestPath = "E:\temp\userdata"
#путь куда копирует
$Profiles = Get-ChildItem (Get-ItemProperty -path “HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList”).ProfilesDirectory -Exclude “Администратор”, "Администратор.office", “Administrator”, “Setup”, “Public”, “All Users”, “Default User”
#извлекли из реестра местоположение профилей, сформировали список

ForEach ($Profile in $Profiles) {
ForEach ($Path in $InProfilesPathsArr) {
$DestinationPath=$destPath+"\"+$Profile.Name
New-Item -itemtype directory -Path $DestinationPath
Copy-Item $Profile$Path -Destination $destinationPath  -Recurse -Force -ErrorAction SilentlyContinue 
}
}