@echo off
if "x%2"=="x" (
    echo Usage: testsign ^<DriverDir^> ^<CertFile^>
    exit /b 0
)
set "PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86;"
for /f "tokens=*" %%i in ('dir /a-d /s /b "%1\*.sys"') do (
    signtool sign /f "%2" /fd SHA256 "%%~i"
)
inf2cat /driver:"%1" /os:10_X64,Server10_X64
for /f "tokens=*" %%i in ('dir /a-d /s /b "%1\*.cat"') do (
    signtool sign /f "%2" /fd SHA256 "%%~i"
)
