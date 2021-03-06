$countErrors=0
$LogFile="D:\ICSLog.txt"
$FailPacket=25
for ($i=1;$i -le 25; $i++)
{
    if (test-Connection -ComputerName "www.google.com" -Count 2 -Quiet) { $countErrors++
    $FailPacket--
    }
}

$Log=Get-Date -format "dd MMMM yyyy HH:mm"
$Log+=" Потеряно пакетов=$FailPacket"
$Log | Out-File $LogFile -Append
If ($countErrors -eq 0)
{

$External1="WAN"
$External2="WAN2"
$File="D:\conf.txt"
$ExternalWorkName=Get-Content $File
if ($ExternalWorkName -eq $External1) {$ExternalNeedName=$External2}
else {$ExternalNeedName=$External1}
      
#Включить или отключить ICS на заданном интерфейсе
Function Set-ConnectionSharing($netint,$type)
{
	switch($netint)
	{
		#Отключить ICS
		{$_.SharingEnabled -eq $true -and $Disable} {$_.DisableSharing();break}
		{$_.SharingEnabled -eq $true} {"Internet Connection Sharing is enabled";break}
		#Включить ICS
		{$_.SharingEnabled -eq $false} {$_.EnableSharing($type);break}
		default {"Interface not found" }
	}
}      

#SHARINGCONNECTIONTYPE - для внешнего интерфейса
New-Variable -Name public -Value 0 -Option Constant
#SHARINGCONNECTIONTYPE - для внутреннего интерфейса
New-Variable -Name private -Value 1 -Option Constant
#Счетчик
New-Variable -Name index -Value 1
#Создаем ComObject типа HNetCfg.HNetShare.1
$hnet = New-Object -ComObject HNetCfg.HNetShare.1
#Отображает список доступных интерфейсов
$netint = @()
    foreach ($i in $hnet.EnumEveryConnection)
    {
        $netconprop = $hnet.NetConnectionProps($i)
        $inetconf = $hnet.INetSharingConfigurationForINetConnection($i)
        $netint += New-Object PsObject -Property @{
                Index = $index
                Guid = $netconprop.Guid
                Name = $netconprop.Name
                DeviceName = $netconprop.DeviceName
                Status = $netconprop.Status
                MediaType = $netconprop.MediaType
                Characteristics = $netconprop.Characteristics
                SharingEnabled = $inetconf.SharingEnabled
                SharingConnectionType = $inetconf.SharingConnectionType
                InternetFirewallEnabled = $inetconf.InternetFirewallEnabled
                }
        if ($ExternalNeedName -eq $netconprop.Name) {$ExternalNeedIndex=$index}
        if ($ExternalWorkName -eq $netconprop.Name) {$ExternalWorkIndex=$index}
        $index++
    }
    $netint

netsh interface set interface name=$ExternalNeedName admin=ENABLED
netsh interface set interface name=$ExternalWorkName admin=DISABLED

    #Получаем список всех доступных интерфейсов и присваиваем переменной
     $netint = $hnet.EnumEveryConnection | foreach {$hnet.INetSharingConfigurationForINetConnection($_)}
        Set-ConnectionSharing $netint[$ExternalNeedIndex-1] $public

remove-Variable -Name index
$ExternalNeedName | Out-File $File
}