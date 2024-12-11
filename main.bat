@echo off
title KexT by Koush

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

echo.
set /p extChoice=Enter the file extension you want to explore: 

:: Validate input
set "chosenExt="
for /f "tokens=2 delims==" %%v in ('set ext[%extChoice%] 2^>nul') do set "chosenExt=%%v"
if not defined chosenExt (
    echo Invalid choice for file extension.
    goto end
)

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

echo.
set /p fileChoice=Enter the number for the file to open: 

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
echo	 ___  __    _______      ___    ___ _________   
echo	l\  \l\  \  \ \  ___ \    l\  \  /  /l\___   ___\ 
echo	\ \  \/  /l\ \ \   __/l   \ \  \/  / ll___ \  \_l 
echo	 \ \   ___  \ \ \  \_l/__  \ \    / /     \ \  \  
echo	  \ \  \\ \  \ \ \  \_l\ \  /     \/       \ \  \ 
echo	   \ \__\\ \__\ \ \_______\/  /\   \        \ \__\
echo	    \l__l \l__l  \l_______/__/ /\ __\         \l__l
echo	                           l__l/ \l__l                                        
echo.
