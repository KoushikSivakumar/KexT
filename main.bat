@echo off
title KTexT by Koush

chcp 65001 >nul
cd files
color 5
:start
call :banner

setlocal enabledelayedexpansion

echo Unique file extensions in the folder:
set /a extCount=1
for %%f in (*) do (
    set "ext=%%~xf"
    set "found=0"
    for /f "tokens=2 delims==" %%e in ('set ext[ 2^>nul') do (
        if /i "%%e"=="!ext!" set "found=1"
    )
    if "!found!"=="0" (
        echo !extCount!: !ext!
        set "ext[!extCount!]=!ext!"
        set /a extCount+=1
    )
)

:: Step 2: Get user input for file extension
echo.
set /p extChoice=Enter the file extension you want to explore: 

:: Validate input
set "chosenExt="
for /f "tokens=2 delims==" %%v in ('set ext[%extChoice%] 2^>nul') do set "chosenExt=%%v"
if not defined chosenExt (
    echo Invalid choice for file extension.
    goto end
)

:: Step 3: List all files with the chosen extension
echo.
echo Files with the extension %chosenExt%:
set /a fileCount=1
for %%f in (*%chosenExt%) do (
    echo !fileCount!: %%~nxf
    set "file[!fileCount!]=%%f"
    set /a fileCount+=1
)

if !fileCount! EQU 1 (
    echo No files found with the extension %chosenExt%.
    goto end
)

:: Step 4: Get user input for the file to open
echo.
set /p fileChoice=Enter the number for the file to open: 

:: Open the selected file
set "chosenFile="
for /f "tokens=2 delims==" %%v in ('set file[%fileChoice%] 2^>nul') do set "chosenFile=%%v"
if not defined chosenFile (
    echo Invalid choice for file.
    goto end
)
start "" "!chosenFile!"

:end
pause

:banner
echo.
echo.
echo	 ___  __    _________  _______      ___    ___ _________   
echo	l\  \l\  \ l\___   ___\\  ___ \    l\  \  /  /l\___   ___\ 
echo	\ \  \/  /l\l___ \  \_\ \   __/l   \ \  \/  / ll___ \  \_l 
echo	 \ \   ___  \   \ \  \ \ \  \_l/__  \ \    / /     \ \  \  
echo	  \ \  \\ \  \   \ \  \ \ \  \_l\ \  /     \/       \ \  \ 
echo	   \ \__\\ \__\   \ \__\ \ \_______\/  /\   \        \ \__\
echo	    \l__l \l__l    \l__l  \l_______/__/ /\ __\        \l__l
echo	                                   l__l/ \l__l                                        
echo.