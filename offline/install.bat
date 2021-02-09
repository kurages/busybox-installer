@echo off

echo Welcome busybox offline installer

set instdir=%USERPROFILE%\.local\bin
md %instdir% > nul 2>&1
echo installing...

if "%PROCESSOR_ARCHITECTURE%" equ "x86" (
  set file=%CD%\busybox\x86
) else (
  set file=%CD%\busybox\amd
)
copy /Y /B %file%\busybox.exe %instdir% > nul

pushd %instdir%
busybox --install . > nul 2>&1
popd
echo install success!


:RESTART
set /p yn_check="add Path (y/n)"
IF %yn_check:Y=Y%==Y (
  PowerShell -ExecutionPolicy RemoteSigned .\pathadder.ps1 %instdir% > nul 2>&1
  echo add Path success!
) ELSE IF %yn_check:N=N%==N  (
  rem --- n(N)を入力した際の処理
) ELSE (
  GOTO RESTART
)

pause