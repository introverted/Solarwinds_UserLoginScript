:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::	Checks if login script exists and builds the script if it does not exist.
::
::	
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO OFF


::::::::::::::::::::: MAIN ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::  Checks if Login script exists then calls to create it
IF EXIST "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" (
IF NOT EXIST "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\login.bat" (
CALL :LOAD_LOGIN_SCRIPT
))

:: Call individual login scripts. Comment out if not needed. 
CALL :LOAD_KING
CALL :LOAD_ELLIOTT 
GOTO :EOF


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Builds Login script in place
:LOAD_LOGIN_SCRIPT
SET FILEPATH="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\login.bat"
ECHO NET USE T: \\192.168.5.194 > %FILEPATH%
ECHO NET USE S: \\192.168.5.195 >> %FILEPATH%
ECHO NET USE U: \\192.168.5.196 >> %FILEPATH%
GOTO :EOF


:::::::::  Builds individual / per user scripts :::::::::::::::::::::::::::::::::::::::

::  only loads on King's profile
:LOAD_KING
SET USER=king
IF EXIST "C:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" (
IF NOT EXIST "C:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\USRLOGIN.BAT" (
ECHO NET USE Z: \\192.168.5.194 > "C:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\USRLOGIN.BAT"
))
GOTO :EOF

::  only loads on Elliott's profile
:LOAD_ELLIOTT
SET USER=elliott
IF EXIST "C:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" (
IF NOT EXIST "C:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\USRLOGIN.BAT" (
ECHO NET USE V: \\192.168.5.194 > "C:\Users\%USER%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\USRLOGIN.BAT"
))
GOTO :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:END