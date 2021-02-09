@echo off

echo Welcome busybox installer

set instdir=%USERPROFILE%\.local\bin
md %USERPROFILE%\.local > nul 2>&1
md %instdir% > nul 2>&1
echo downloading...
echo a few minutes

if "%PROCESSOR_ARCHITECTURE%" equ "x86" (
  set dl=https://frippery.org/files/busybox/busybox.exe
) else (
  set dl=https://frippery.org/files/busybox/busybox64.exe
)
bitsadmin /transfer download %dl% %instdir%\busybox.exe > nul
echo download success!

echo installing...
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
  rem
) ELSE (
  GOTO RESTART
)

pause