#создаем объект почта
$mail = New-Object System.Net.Mail.MailMessage
#описываем заголовок
$mail.From = New-Object System.Net.Mail.MailAddress(“username@mail.ru“)
$mail.To.Add(“usernae@mail.ru“)
$mail.Subject = $env:computername
$mail.Body= New-Object System.Net.Mail.MailMessage
$mail.IsBodyHtml=$True
$mail.BodyEncoding=[System.Text.Encoding]::UTF8
$message = ""
$pwdModules=Split-Path $MyInvocation.MyCommand.Path
$pwdModules+="\modulesReport"
$progs= Get-ChildItem $pwdModules
foreach ($Prog in $progs)
    {

    $message+=&$Prog.FullName | Out-String
    $message+="<br><br>"
    }

$mail.Body = $Message


#создаем почтовый запрос
$smtp = New-Object System.Net.Mail.SmtpClient(“smtp.mail.ru“)
$smtp.Credentials = New-Object System.Net.NetworkCredential(“username@mail.ru“, “password“)
$SSLEnable=$True
$smtp.EnableSsl=$SSLEnable
#отправляем письмо
$smtp.Send($mail)
