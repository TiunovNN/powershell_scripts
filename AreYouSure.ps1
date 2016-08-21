$title = "Перезагрузка сервера"
$message = "Вы уверены сто хотите перезагрузить сервер TS2?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "Да", `
    "Совершит перезагрузку сервера."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "Нет", `
    "Просто закроет сообщение."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 {Stop-computer Server01.contoso.com}
        1 {exit}
    }
