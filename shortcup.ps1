$arr=Get-ChildItem -path "f:\" *.lnk -recurse -force
$shell = New-Object -COM WScript.Shell
foreach ($link in $arr)
    {
    $shortcut = $shell.CreateShortcut($link.FullName)  ## Open the lnk
    #$shortcut.TargetPath=$shortcut.TargetPath -replace '\\\\ts2\\','\\\\proton\\'  ## Make changes
    if ($shortcut.TargetPath -like "\\proton*")
        {
        $text=$shortcut.FullName + "`t" +$shortcut.TargetPath
        echo $text
        }
    #$shortcut.Description = "Our new link"  ## This is the "Comment" field
    #$shortcut.Save()  ## Save
    }