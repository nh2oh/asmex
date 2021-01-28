$link_path = "C:\'Program Files (x86)'\'Microsoft Visual Studio'\2019\Professional\VC\Tools\MSVC\14.28.29333\bin\Hostx64\x64\link.exe"
$command = "$link_path $args"
#echo $command
invoke-expression $command