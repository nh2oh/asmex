$lib_path = "C:\'Program Files (x86)'\'Windows Kits'\10\Lib\10.0.18362.0\um\x64\"
$ml_path = "C:\'Program Files (x86)'\'Microsoft Visual Studio'\2019\Professional\VC\Tools\MSVC\14.28.29333\bin\Hostx64\x64\ml64.exe"
$filename = $args[0]
$command = "$ml_path $filename -link -SUBSYSTEM:CONSOLE -ENTRY:main -LIBPATH:$lib_path"
#echo "YAY CMD:  $command"
invoke-expression $command
