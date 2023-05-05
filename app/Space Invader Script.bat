@ECHO OFF

choice /C SDLQ /T 50 /D Q /M "What shield? [S]pace Invader | [D]emotle | Demotle[L] | Q]uit" /N
if %ERRORLEVEL% EQU 1 set shield=space_invader& set board=adafruit_feather_nrf52840& set volume=FTHR840BOOT
if %ERRORLEVEL% EQU 2 set shield=demotle& set board=nice_nano_v2& set volume=NICENANO
if %ERRORLEVEL% EQU 3 goto end

@REM set shield=space_invader& set board=adafruit_feather_nrf52840& set volume=FTHR840BOOT

choice /C YNFQ /T 5 /D Y /M "Build firmware? [Y]es | [N]o | [F]ast Build (probably won't work) | [Q]uit" /N
if %ERRORLEVEL% EQU 1 goto pristineBuild
if %ERRORLEVEL% EQU 2 goto flashKeeb
if %ERRORLEVEL% EQU 3 goto buildFirmware
if %ERRORLEVEL% EQU 4 goto end

:buildFirmware
cd %USERPROFILE%\Documents\GitHub\zmk\app
west build
if %ERRORLEVEL% EQU 0 goto copyFirmware
if %ERRORLEVEL% neq 0 goto pristineBuild

:pristineBuild
west build -p -b adafruit_feather_nrf52840 -- -DSHIELD=space_invader
if %ERRORLEVEL% EQU 0 goto copyFirmware
if %ERRORLEVEL% neq 0 goto hold

:copyFirmware
cd %USERPROFILE%\Documents\GitHub\zmk\app\backup_firmware
echo.
if exist zmk.uf2.bk5 del zmk.uf2.bk5
if exist zmk.uf2.bk4 rename zmk.uf2.bk4 zmk.uf2.bk5
if exist zmk.uf2.bk3 rename zmk.uf2.bk3 zmk.uf2.bk4
if exist zmk.uf2.bk2 rename zmk.uf2.bk2 zmk.uf2.bk3
if exist zmk.uf2.bk1 rename zmk.uf2.bk1 zmk.uf2.bk2
if exist zmk.uf2 rename zmk.uf2 zmk.uf2.bk1
cd ..\..
copy /y build\zephyr\zmk.uf2 backup_firmware\%shield%\zmk.uf2
goto flashKeeb

:flashKeeb
Set "Drv="
For /F Skip^=1 %%A In (
    'WMIC LogicalDisk Where "VolumeName='FTHR840BOOT'" Get DeviceID 2^>NUL'
)Do For /F Tokens^=* %%B In ("%%A")Do Set "Drv=%%B"
If Not Defined Drv goto dfuPrompt
@REM Echo Your Drive Letter is %Drv%
@REM Timeout 3 >NUL
copy %USERPROFILE%\Documents\GitHub\zmk\app\build\zephyr\zmk.uf2 %Drv%
if %ERRORLEVEL% EQU 0 goto end
if %ERRORLEVEL% neq 0 goto dfuPrompt

:dfuPrompt
powershell "[console]::beep(700,300)"
powershell "[console]::beep(700,300)"

echo.
choice /C ONA /T 5 /D A /M "Put Space Invader in DFU mode. [O]kay | [N]o | [A]lready there" /N
if %ERRORLEVEL% EQU 3 goto flashKeeb
if %ERRORLEVEL% EQU 2 goto end
timeout 5 /nobreak
if %ERRORLEVEL% EQU 1 goto flashKeeb

:hold
echo.
choice /C RX /M "Well that didn't work. [R]estart or e[X]it?" /N
if %ERRORLEVEL% EQU 1 goto buildFirmware
if %ERRORLEVEL% EQU 2 goto end

:end
