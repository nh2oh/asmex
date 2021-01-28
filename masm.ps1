$ml_path = "C:\'Program Files (x86)'\'Microsoft Visual Studio'\2019\Professional\VC\Tools\MSVC\14.28.29333\bin\Hostx64\x64\ml64.exe"
$command = "$ml_path $args"
#echo "MASM ARGS:  $args"
#echo "MASM CMD:  $command"

invoke-expression $command