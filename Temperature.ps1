# ===========================================================================
# 
# COMMENT: 
# 0 degrees C = K -273.15 therefore 2732 figure for $Celcius
# Designed for physical systems with MSAcpi_ThermalZoneTemperature
#
# ===========================================================================
 
$celsius = 2732
Write-Host `n
[string]$Comp = "localhost"
 
try{
$Temp = (gwmi MSAcpi_ThermalZoneTemperature -Namespace root\WMI -Comp $Comp -ea stop).CurrentTemperature
[int]$cel = ($Temp - $celsius)/10
[int]$fah = ($Temp/10 - 273.15) *1.8 + 32
Write-Host `n
Write-Host "$Comp System Temp: $cel Celsius | $fah Fahrenheit".ToUpper()
Write-Host `n
Clear-Variable cel -Force
Clear-Variable fah -Force
}
Catch{
write-host "`nattention: $Comp BIOS does not support CPU temp monitoring`n".ToUpper() -fore Yellow
}