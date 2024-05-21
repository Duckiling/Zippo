@echo off
color 6
echo """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo "            ,.~\                                                  "
echo "         ,-`    \                                                 "
echo "         \       \                                                "
echo "          \       \                                               "
echo "           \       \                                              "
echo "            \       \                                             "
echo "   _.-------.\       \                                            "
echo "  (o| o o o | \    .-`                                            "
echo " __||o_o_o_o|_ad-``                                               "
echo "|``````````````|' _______     _______     _______        _____    "
echo "|              | /___   / ). |   __  `.  |   __  `.    .`  _  `.  "
echo "|              |    /  / (__)|  |  `\  \ |  |  `\  \  /  /` `\  \ "
echo "|              |   /  /  |  ||  |    )  )|  |    )  )(  (     )  )"
echo "|              |  /  /___|  ||  | __/  / |  | __/  /  \  \___/  / "
echo "|______________| /__________||  ||___.`  |  ||___.`    `._____.`  "
echo "                             |  |        |  |                     "
echo "                             |__|        |__|                     "
echo """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

echo Zippo - By Duckiling
echo.
echo Please put all passlists into the "Passlists" folder
echo.
echo You can also now drag and drop your archives!

set "zippath=C:\Program Files\7-Zip"

if not exist "%zippath%" (
	echo 7zip was not found!
	echo If you have it installed but in a different path, please edit this batch file and replace the path with your own.
	pause
	exit
)

set /p "file=Archive: "

rem Remove surrounding quotes if they exist
REM THANK GOD FOR CHATGPT AGAIN BRUH :SOB: OTHERWISE I WOULDNT KNOW HOW TO PASS ONLY ONE SET OF QUOTATION MARKS
set "file=%file:"=%"

if not exist "%file%" (
    echo Archive not found/invalid!
    pause
    exit
)

REM THANK GOD FOR CHATGPT OTHERWISE I COULDNT DO THE WHOLE FOLDER THING
set "folder_path=Passlists"
for %%f in ("%folder_path%\*.txt") do (
    for /f "delims=" %%a in ('type "%%f"') do (
        set pass=%%a
        call :attempt
    )
)
echo No password found. Maybe try to add more passlists?
pause
exit

:attempt
"%zippath%\7z.exe" x -p"%pass%" "%file%" -o"Successful" -y >nul 2>&1
echo Attempting: %pass%
if /I %errorlevel% EQU 0 (
	echo Password Found: %pass%
	pause
	exit
)