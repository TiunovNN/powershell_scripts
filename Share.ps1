
$check = Test-Path -path "\\localhost\P"
if (!$check)
   {
        net share P="P:\" "/GRANT:Все,CHANGE"
   }
